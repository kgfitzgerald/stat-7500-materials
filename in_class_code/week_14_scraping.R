# load packages
library(tidyverse)
library(rvest)
library(janitor)

# download 538 college major data
collmaj538_file <- "https://raw.githubusercontent.com/fivethirtyeight/data/master/college-majors/all-ages.csv"
download.file(collmaj538_file, "data/collmaj538.csv")

# Social Security Data
birth_file <- "https://www.ssa.gov/oact/babynames/numberUSbirths.html"

ssa <- birth_file |>
  read_html() |> #read in raw html file
  html_nodes("table") |> #pull tables only
  pluck(1) |> #pull first table only
  html_table()  |> #converts to rectangular data
  clean_names()

#trend in %male over time
#convert columns to numeric
#need % male variable
ssa <- ssa |> 
  #converting to numeric by first removing commas
  mutate(male = as.numeric(str_remove_all(male, ",")),
         female = as.numeric(str_remove_all(female, ",")),
         total = as.numeric(str_remove_all(total, ","))) |> 
  mutate(perc_male = male/total)

ggplot(ssa, aes(x = year_of_birth, y = perc_male)) +
  geom_line()

ggplot(ssa, aes(x = year_of_birth, y = total)) +
  geom_line()


# Wikipedia State Population Data
statepop_file <- "https://simple.wikipedia.org/wiki/List_of_U.S._states_by_population"

statepop <- statepop_file |>
  read_html() |> #read in raw html file
  html_nodes("table") |> #pull tables only
  pluck(1) |> #pull first table only
  html_table()  |> #converts to rectangular data
  clean_names()

pop_totals <- statepop |> 
  slice(57:60) #extract "total" rows at the bottom

statepop <- statepop |> 
  slice(1:56) |> 
  select(3, 4, 9)

names(statepop) <- c("state", "pop2020", "pop_per_electoral2020")

statepop |> 
 mutate(pop2020 = as.numeric(str_remove_all(pop2020, ",")))

statepop <- statepop |> 
  mutate(across(c(pop2020, pop_per_electoral2020),
                ~ as.numeric(str_remove_all(.x, ","))))

saveRDS(statepop, "data/statepop_2020.RDS")

# PSSA Data
pssa_file <- "https://www.education.pa.gov/DataAndReporting/Assessments/Pages/PSSA-Results.aspx"

pssa_file |>
  read_html() |> #read in raw html file
  html_nodes("table") |> 
  html_table()

pssa_ela <- pssa_file |>
  read_html() |> #read in raw html file
  html_nodes("table") |> #pull tables only
  pluck(2) |> #pull first table only
  html_table()  |> #converts to rectangular data
  clean_names()

pssa_math <- pssa_file |>
  read_html() |> #read in raw html file
  html_nodes("table") |> #pull tables only
  pluck(3) |> #pull first table only
  html_table()  |> #converts to rectangular data
  clean_names()

pssa_all <- bind_rows(pssa_ela, pssa_math)

saveRDS(pssa_all, "data/pssa_2025.RDS")

# Reddit example
library(httr)
library(jsonlite)
library(dplyr)
library(tibble)
# Reddit API search for "Villanova"
url <- "https://www.reddit.com/search.json?q=Villanova&limit=100"
res <- GET(url, user_agent("vu-class-app"))
txt <- content(res, as = "text", encoding = "UTF-8")
dat <- fromJSON(txt)
# Extract post data
VU_posts <- dat$data$children$data


# Olympics data

olympics_file <- "https://en.wikipedia.org/wiki/100_metres_at_the_Olympics#Olympic_record_progression"

men <- olympics_file |>
  read_html() |> #read in raw html file
  html_nodes("table") |> 
  html_table() |> 
  pluck(13) |> #extract men's 100m records
  clean_names()

women <- olympics_file |>
  read_html() |> #read in raw html file
  html_nodes("table") |> 
  html_table() |> 
  pluck(14) |> #extract women's 100m records
  clean_names()

all <- bind_rows(.id = "sex", "M" = men, "F" = women)
saveRDS(all, "data/olympics.RDS")
