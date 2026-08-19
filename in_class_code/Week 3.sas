********************************************************
* Week 3.sas						                   *
* Contains code provided in SAS3.pptx - for reference. *
* Created by Katie Fitzgerald on 9/09/25			   *
* Last Modified by Katie Fitzgerald on 9/10/25		   *
********************************************************;

*DATA PREP;
data club;
  input id name $ team $ startwt endwt;
  cards;
  1023 David red 189 165
  1049 Amelia yellow 145 124
  1219 Alan red 210 192
  1246 Ravi yellow 194 .
  1078 Ashley red 127 118
  1221 Jim yellow 220 204
  ;
run;

data club;
set club;
diff = (endwt - startwt);
percent_diff = diff/startwt;
run;

*SLIDE 3;
proc sort data=club;
	by id;
run;

proc print data=club;
  title 'Original Data Set Sorted by ID';
run;

*SLIDE 4;
proc sort data=club;
	by descending percent_diff;
run;

proc print data=club;
  title 'Original Data Set Sorted by percent_diff (descending order)';
run;

*SLIDE 5;
proc sort data=club;
	by team descending percent_diff;
run;

proc print data=club;
  title 'Original Data Set Sorted by Team and then percent_diff (descending order)';
run;

*SLIDE 10;
*data prep;
data Emps;
input First $ Gender $ HireYear;
datalines;
Stacey F 2006
Gloria F 2007
James M 2007
;
run;

data Emps2008;
input First $ Gender $ HireYear;
datalines;
Brett M 2008
Renee F 2008
;
run;

*Append Emps2008 to Emps;
proc append base = Emps data = Emps2008;
run;

proc print data = Emps;
run;

*SLIDE 11;
*data prep;
data EmpsDK;
input First $ Gender $ Country $;
datalines;
Lars M Denmark
Kari F Denmark
Jonas M Denmark
;
run;

*data prep;
data EmpsFR;
input First $ Gender $ Country $;
datalines;
Pierre M France
Sophie F France
;
run;

*concatenate;
data EmpsAll1;
set EmpsDK EmpsFR;
run;

*SLIDE 14;
*data prep;
data EmpsAU;
input First $ Gender $ EmpID;
datalines;
Togar M 121150
Kyle F 121151
Birin M 121152
;
run;

*data prep;
data PhoneH;
input EmpID Phone $25.;
datalines;
121150 +61 (2) 5555-1793
121151 +61 (2) 5555-1849
121152 +61 (2) 5555-1665
;
run;

*merge;
data EmpsAUH;
merge EmpsAU PhoneH;
by EmpID;
run;

*SLIDE 18;
*data prep;
data PhoneHW;
input EmpID Type $ Phone $25.;
datalines;
121150 Home +61 (2) 5555-1793
121150 Work +61 (2) 5555-1794
121151 Home +61 (2) 5555-1849
121151 Work +61 (2) 5555-1850
121152 Home +61 (2) 5555-1665
121152 Work +61 (2) 5555-1666
;
run;

*merge one-to-many;
data EmpsAUH;
merge EmpsAU PhoneHW;
by EmpID;
run;

*SLIDE 20;
*data prep;
data PhoneC;
input EmpID Phone $25.;
datalines;
121150 +61 (2) 5555-1793
121152 +61 (2) 5555-1667
121153 +61 (2) 5555-1348
;
run;

*non-matches merge;
data EmpsAUC;
merge EmpsAU PhoneC;
by EmpID;
run;

*SLIDE 31;
data club2;
  set club;
  diff = endwt - startwt;
  percent_diff = ((endwt - startwt)/startwt)*100;
run; 

proc print data=club2;
  title 'Data Set with New Variables';
run;

*SLIDE 32;
/* The following formats the percent_diff variable to have two decimal places*/
data club2;
  set club;
  diff = endwt - startwt;
  format percent_diff 8.2;
  percent_diff = ((endwt - startwt)/startwt)*100;
run;

proc print data=club2;
  title 'Data Set with New Variables';
run;

*SLIDE 34;
data enrollment;
  input School &$30. student comma6.;
  cards;
  Bryn Mawr College  1,300
  Penn State University  73,476
  Villanova University  7,037
;

proc print data=enrollment;
run;

*SLIDE 35;
data enrollment;
  input School &$30. student comma6.;
  cards;
  Bryn Mawr College  1,300
  Penn State University  73,476
  Villanova University  7,037
;

proc print data=enrollment;
run;

*SLIDE 36;
data hospital;
  input id hospyn $ day month year;
  cards;
  1  no  .  .    .
  2 yes 22  3 2004
  3 yes 17  1 2006
  4 yes 18 10 2005
  5  no  .  .    .
  6 yes  1  6 2007
;
run;
 
proc print data=hospital;
  title 'Print of Hospital Data';
run;

*SLIDE 37;
data hospital2;
  set hospital;
  hosp_date = mdy(month, day, year);
run;
 
proc print data=hospital2;
  title 'Print of Hospital Data with Date';
run;

*SLIDE 38;
data hospital3;
  set hospital2;
  format hosp1 date9. hosp2 date8. hosp3 ddmmyy8. hosp4 ddmmyy9. 
         hosp5 ddmmyy10. hosp6 ddmmyyd10. hosp7 ddmmyyp10. 
         hosp8 worddate.;
  hosp1 = hosp_date;
  hosp2 = hosp_date;
  hosp3 = hosp_date;
  hosp4 = hosp_date;
  hosp5 = hosp_date;
  hosp6 = hosp_date;
  hosp7 = hosp_date;
  hosp8 = hosp_date;
run;

proc print data=hospital3;
  title 'Print of Hospital Data with Date Formats';
run;

*SLIDE 40;
data dates;
 input char_dates $10.;
 cards; 
12/14/2013 
1/1/2001
 ;
run;

data dates;
 set dates;
 format new_date date9.;
 new_date = input( char_dates, MMDDYY10.);
run;

proc print data=dates;
run;

*SLIDE 41;
proc import datafile='/home/u64289425/sasuser.v94/STAT 7500 F25/data/NYCflights2013.csv'
	out=NYCflights
	dbms=csv
	replace;
run;

data NYC_datetime; set NYCflights;
  dates = datepart(time_hour);
  times = timepart(time_hour);
  format dates2 worddate. times2 time8.;
  dates2 = dates;
  times2 = times;
  keep time_hour dates times dates2 times2;
run;

*SLIDE 42;
proc print data=NYC_datetime(obs=10); 

*SLIDE 43;
data NYC_datetime2; set NYC_datetime;
  years = year(dates);
  months = month(dates);
  days = day(dates);
  hours = hour(times);
  minutes = minute(times);
  seconds = second(times);
  keep time_hour years months days hours minutes seconds;
run;

proc print data=NYC_datetime2(obs=10); 
  title 'NYC Flight Dates and Times (first 10 only)';

