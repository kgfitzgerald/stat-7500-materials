*Week 2 Practice Problems - SOLUTIONS;

*Problem 1;

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

proc contents data = mydata;
run;

*Problem 2;

data class; *new dataset to create in workspace;
    set sashelp.class; *dataset SAS has access to in sashelp library;
run;

data teenagers; *new dataset to create in workspace;
	set class; *dataset SAS already has access to;
	where age > 12 AND age < 20; *subsets to keep teenagers only;
run;

*part b - create subset for female teenagers only;
data female_teens;
	set teenagers; 
	where Sex = 'F';
run;

*Problem 3;
data mydata;
retain Time With Place Subject Length_of_meeting; *keeps order of variables (optional);
length Place $ 32 Subject $ 32 Length_of_meeting $ 32; *avoids truncation;
input Time $ With $ Place $ Subject $ Length_of_Meeting $ ;*semi-colon was missing;
datalines; *moved to its own line;
11:00 Sally Room30 PersonnelReview 45minutes
1:00 Jim JimsOffice BrakeDesign 30minutes
3:00 Nancy Lab TestResults 30minutes
;
run;

*create library called datahome that points to my data folder inside STAT 7500 F25;
libname datahome '/home/u64289425/sasuser.v94/STAT 7500 F25/data';

*export to permanent SAS dataset (saves as .sas7bdat file extension);
data datahome.sas1data; *create new sas1data inside datahome library;
	set mydata; *set it equal to data SAS already has access to in workspace;
run;

*read in from SAS library;
data sas1data; *create new dataset called sas1data in current workspace;
	set datahome.sas1data; *read it from sas1data file SAS has access to in datahome library;
run;

*Problem 4;
*read in club.xlsx file;
PROC IMPORT DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club.xlsx" 
     OUT = club 
     DBMS= xlsx 
     REPLACE;
     SHEET="SHEET1"; *not needed since only one sheet;
     *GETNAMES=YES; 
RUN;

proc print data=club;
run;

*export club data to new file called club_export.xlsx;
PROC EXPORT
	data=club
	dbms=xlsx
	outfile="/home/u64289425/sasuser.v94/STAT 7500 F25/data/club_export.xlsx"
	replace;
run;

*Problem 5;
*read in club.csv;
PROC IMPORT DATAFILE = "/home/u64289425/sasuser.v94/STAT 7500 F25/data/club.csv" 
     OUT = club2 
     DBMS= csv 
     REPLACE;
RUN;

*print First Name variable only;
proc print data = club2;
var "First Name"n; *copy/pasting quotations causes issues sometimes - if you're getting an error, delete and re-type manually;
run;

