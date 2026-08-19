********************************************************
* My First SAS Program F25.sas						   *
* This program exposes you all to SAS for the first	   * 
* 	time											   * 
* Created by Michael Posner on 8/27/24				   *
* Last Modified by Katie Fitzgerald on 8/21/25		   *
********************************************************;

* This is my first SAS Program;
* This is also 
a comment, even though it goes
over multiple lines...since there is no semicolon before this one  ;


/* Longer comment
over many lines */

* This is read in incorrectly;
data baddataset;
input age gender;
datalines;
20 M
15 F
12 M
;
run;

* Corrected Code for failing to identify that gender was categorical with "$";

data myfirstdataset;
input age gender $;
datalines;
20 M
15 F
12 M
;
run;  * this run is optional if you run the entire section;

proc freq data = myfirstdataset;
table gender;
run;    * this run is optional if you run the entire section;

* a more minimalist way to type it;
proc freq;   * defaults to most recent dataset;
* without table defaults to all variables;
run;    * this run is optional if you run the entire section;


proc means data = myfirstdataset;
var age;
run;

/*YOUR TURN: EXERCISE 1*/



/*YOUR TURN: EXERCISE 2: Raw data entry*/
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

proc print;
  title 'Data Set of the Club Weight Loss Program';
run;

*YOUR TURN: Exercise 2b. Example of the raw data entry without the period for the missing value;



*Exercise 2c: raw data entry with last names;
data club;
  input id name & $15. team $ startwt endwt;
  cards;
  1023 David Shaw  red 189 165
  1049 Amelia Serrano  yellow 145 124
  1219 Alan Nance  red 210 192
  1246 Ravi Sinha  yellow 194 .
  1078 Ashley McKnight  red 127 118
  1221 Jim Brown  yellow 220 204
  ;
run;

proc print data = club;
  title 'Data Set of the Club Weight Loss Program - Last Name';
run;

*YOUR TURN: EXERCISE 3;



*/ print welcome data, with title;
proc print data=welcome;
  title “Who is the best Professor ever?”;
run;

*/ print, with title & column labels;
proc print data=welcome label;
  title 'Who is the Best Professor ever?';
  label prof='Professor' bestever='Best Ever?';
run;



*Example code: raw data entry with last names with data wrap around;

data club;
  input id name & $ 15. team $ startwt endwt ;
  cards;
  1023 David Shaw
  red 189 165
  1049 Amelia Serrano
  yellow 145 124
  1219 Alan Nance
  red 210 192
  1246 Ravi Sinha
  yellow 194 .
  1078 Ashley McKnight
  red 127 118
  1221 Jim Brown
  yellow 220 204
  ;
run;

proc print data = club;
  title 'Data Set of the Club Weight Loss Program - with data wrap around';
run;


*YOUR TURN: EXERCISE 4, raw data entry with last names and multiple entries on one line ;

data club;
  input id name & $ 15. team $ startwt endwt @@;
  cards;
  1023 David Shaw  red 189 165 1049 Amelia Serrano  yellow 145 124
  1219 Alan Nance  red 210 192 1246 Ravi Sinha  yellow 194 .
  1078 Ashley McKnight  red 127 118 1221 Jim Brown  yellow 220 204
  ;
run;

proc print data = club;
  title 'Data Set of the Club Weight Loss Program - Multiple Entries Same Record';
run;


*Another data Entry example;
data scores;
   input Name : $9. Score1-Score3 Team $&25. Div $;
   datalines;
Smith 12 22 46 "Green Hornets, Atlanta"  AAA 
Mitchel 23 19 25 "High Volts, Portland"  AAA 
Jones 09 17 54 "Vulcans, Las Vegas"  AA 
; 

proc print data=scores noobs; 
run;

* Example of the raw data entry and creating a permanent SAS data set;
libname datahome '/home/u64289425/sasuser.v94/STAT 7500 F25/data';

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

data datahome.permclub;
  set club;
run;



*/ YOUR TURN: EXERCISE 5;

	
	
