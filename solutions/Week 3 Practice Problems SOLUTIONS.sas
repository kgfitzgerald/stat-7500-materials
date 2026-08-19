*Week 3 Practice Problems;

*Problem 1a - repeat mydata from last week;
*define format before applying it in data statement; 
proc format;
  value genderf 1='Female' 
  			     2='Male';
run;

data mydata;
  length name $ 13; *to avoid truncation of Esmerelda;
  input name $ gender age;
  label age = 'Age (in Years)';
  format gender genderf.;
  datalines;
  	Mahesh 2 17
  	MarySue 1 16
  	Emma 1 14
  	Sarit 1 14
  	Ronald 2 16
  	Esmerelda . 17
; *semi-colon must be on its own line;
run; *run was missing;

*print mydata with labels;
proc print data = mydata label;
run;

*Problem 1b;
data mydata2;
  length name $ 13; *to avoid truncation of Esmerelda;
  input name $ gender age;
  label age = 'Age (in Years)';
  format gender genderf.;
  datalines;
  Maya 1 15
  Amit 2 14
  ;
 run;

*Problem 1c;
data students;
set mydata mydata2;
run;

*Problem 1d;
data school;
length name $ 13;
input name $ School $ @@; 
datalines;
Mahesh A Emma A Sarit A Ronald A Maya A MarySue B Esmerelda B Amit B
;

*Problem 1e;
proc sort data = students; by name; run;
proc sort data = school; by name; run;

data studentschool;
merge students school;
by name;
run;

*Problem 2;
data Birthweight;
set sashelp.bweight;
run;

proc contents data = birthweight;
run;

proc print data = birthweight (obs = 10);
run;

data birthweight;
set birthweight;
weight_lbs = weight*0.0022;
MomAge2 = MomAge + 27;
run;

proc means data = birthweight median;
run;

*Problem 3;
PROC IMPORT datafile = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/NYCflights2013.csv"
	 OUT = flights 
     DBMS= csv 
     REPLACE;
RUN;

proc contents data = flights;
run;

data flights;
set flights;
hour2 = hour(time_hour);
run;

proc univariate data=flights;
histogram hour;
run;

proc sort data = flights;
by day descending dep_delay;
run;

proc print data = flights (obs = 10);
var day dep_delay;
run;
