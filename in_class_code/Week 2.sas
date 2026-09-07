********************************************************
* Week 2.sas						                   *
* Contains code provided in SAS2.pptx - for reference. *
* Created by Katie Fitzgerald on 8/21/25			   *
* Last Modified by Katie Fitzgerald on 9/2/25		   *
********************************************************;

/*SLIDE 2*/
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

/*SLIDE 5*/
proc contents;
run;

/*SLIDE 8*/
data club;
  length startwt 4 endwt 4;
  format startwt 5.1 endwt 5.1 name $ 15.;
  input id name team $ startwt endwt;
  cards;
  1023 David red 189 165
  1049 Amelia yellow 145 124
  1219 Alan red 210 192
  1246 Ravi yellow 194 .
  1078 Ashley red 127 118
  1221 Jim yellow 220 204
  ;
run;

proc contents;
run;

/*SLIDE 16*/
data club(label="Club Weight Loss Dataset"); 
set club;
  label id         = 'Club Member Identifier'
        team       = 'Weight Loss Team'
	 name       = 'First Name'
	 startwt    = 'Starting Weight (lbs)'
	 endwt      = 'Ending Weight (lbs)';
run;

proc contents data=club;
  title 'After Labels';
run; 

/*SLIDE 18*/
proc print data=club label;
run;

/*SLIDE 20*/
*subsetting data;
data onlyred;
   set club;
   where team='red'; 	*works with if as well;
run;

/*SLIDE 25*/
data demo;
    input birthday mmddyy10.;   /* Informat: read "09/03/2025", colon modifier skips spaces*/
    format birthday date9.;		/* Format: display as 03SEP2025 */
    datalines;
09/03/2025
;
run;

proc print data=demo;
run;

/*SLIDE 26*/
proc format;
  value malefemf 1='Male' 
  			     2='Female';
  value likef 1 = 'strongly dislike' 
  			  2 = 'dislike' 
  			  3 = 'neutral' 
  			  4 = 'like' 
  			  5 = 'strongly like';
run;

data mydata;
    input gender like;
    format gender malefemf. like likef.;  * permanent assignment;
    datalines;
1 5
2 3
1 2
;
run; 

proc print data=mydata;
    format gender malefemf. like likef.;  /* only affects this PROC PRINT */
run;


/*SLIDE 40*/
/*
Code below only works if you have club.xlsx uploaded.
The file is available on the course website.
You should replace the file path to match your server files & folders.
Recall: you can copy the file path for any file by right-clicking and 
selecting "Properties". The file path is listed in the "Location" field
*/
PROC IMPORT DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club.xlsx" 
     OUT = club 
     DBMS= xlsx 
     REPLACE;
     SHEET="SHEET1"; *not needed since only one sheet;
     GETNAMES=YES; 
RUN;

proc print data=club;
run;

/*SLIDE 42*/
/* Option 1 – space delimited file*/
PROC IMPORT  DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club_space.txt" 
     OUT = club
     DBMS= dlm
     REPLACE;
     DELIMITER = '20'x;
RUN;

/* Option 2 – tab delimited file*/
PROC IMPORT  DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club_tab.txt" 
     OUT = club
     DBMS= tab
     REPLACE;
RUN;

/*SLIDE 43*/
/*INCORRECT DELIMITER*/
PROC IMPORT  DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club_space.txt" 
     OUT = club
     DBMS= dlm
     REPLACE;
     DELIMITER = '09'x;
RUN;

/*MISSING DELIMITER*/
*okay in this case b/c assumes space by default;
PROC IMPORT  DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club_space.txt" 
     OUT = club
     DBMS= dlm
     REPLACE;
RUN;

/*MISSING DELIMITER*/
*causes issues in this case b/c club_tab.txt is tab-delimited;
PROC IMPORT  DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club_tab.txt" 
     OUT = club
     DBMS= dlm
     REPLACE;
RUN;


/*SLIDE 48*/
*export data to Excel file;
PROC EXPORT
  data=club
  dbms=xlsx
  outfile="/home/u64289425/sasuser.v94/STAT 7500 F25/data/clubexport.xlsx"
  replace;
run;
*check your data folder to ensure it exported;



