********************************************************
* Week 5.sas						                   *
* Contains code provided in SAS3.pptx - for reference. *
* Created by Katie Fitzgerald on 9/23/25			   *
* Last Modified by Katie Fitzgerald on 9/24/25		   *
********************************************************;

*data prep;
data heart;
    set sashelp.heart;
run;

*SLIDE 4;
proc freq data = heart;
table Sex Sex*Smoking_Status;
run;

*SLIDE 5;
proc freq data = heart;
table Sex Sex*Smoking_Status;
run;

*SLIDE 6;
proc format;
    value $smkorder
        'Non-smoker'    = '1. Non-smoker'
        'Light (1-5)'         = '2. Light'
        'Moderate (6-15)'      = '3. Moderate'
        'Heavy (16-25)'         = '4. Heavy'
        'Very Heavy (> 25)'    = '5. Very Heavy';
run;



proc freq data= heart order = formatted;
    tables Smoking_Status / nocum;
    format Smoking_Status $smkorder.;
run;

*SLIDE 7;
proc freq data = heart order = formatted;
table smoking_status / missing;
run;

*SLIDE 9;
proc freq data= heart order = formatted;
    tables Sex*Smoking_Status / list;
run;

proc freq data= heart order = formatted;
    tables Sex*Smoking_Status / crosslist;
run;

*SLIDE 12;
proc means data = heart;
run;

proc means data = heart;
var AgeAtDeath;
run;

*SLIDE 13;
proc means data = heart maxdec = 2;
var AgeAtDeath;
run;

*SLIDE 14;
proc means data=heart nmiss var t probt;
	var AgeAtDeath;
	run;

*SLIDE 16;
proc means data = heart maxdec = 2;
var AgeAtDeath;
class Sex;
run;

*SLIDE 18;
libname mydata '/home/u64289425/sasuser.v94/STAT 7500 F25/data';

data philatemps;
    set mydata.philatemp;
run;

proc univariate data = philatemps;
var high;
run;

*SLIDE 19;
proc univariate data=philatemps;
  var high;
  histogram / normal;
run;

*SLIDE 20;
proc univariate data=philatemps normal;
  var high;
run;

*SLIDE 23;
proc freq data = heart noprint;
	*uncomment next line if you want no missing row(s);
	*where not missing(sex) and not missing(smoking_status);
    tables sex*smoking_status / out=freq_out;
run;

proc print data=freq_out;
run;

*SLIDE 25;
*save format change for future use;
data heart;
set heart;
format Smoking_Status $smkorder.;
run;

proc freq data = heart noprint;
    tables smoking_status / out=freq_out
    outcum;
run;

proc print data=freq_out;
run;

*SLIDE 26;
proc freq data = heart noprint;
    tables smoking_status*sex / out=freq_out
    outpct;
run;

proc print data=freq_out;
run;

*SLIDE 27;
proc means data= heart;
    var height weight;
    output out=means_out
        mean=avg_height avg_weight
        std=sd_height sd_weight;
run;

proc print data = means_out;
run;

*SLIDE 28;
proc freq data = heart;
    tables sex*smoking_status / chisq;
run;

*SLIDE 30;
proc freq data = heart noprint;
    tables sex*smoking_status / chisq;
    output out = chisq_sex_smoking chisq;
run;
proc print data = chisq_sex_smoking;
run;

*SLIDE 40;
proc tabulate data = heart order = formatted;
class smoking_status;
table smoking_status;
run;

*SLIDE 41;
proc tabulate data = heart order = formatted;
class smoking_status;
var systolic; 
table systolic*mean, smoking_status;
run;

*SLIDE 42;
proc tabulate data = heart order = formatted;
class smoking_status;
var systolic; 
table smoking_status, systolic*mean;
run;

*SLIDE 45;
proc tabulate data = heart order = formatted;
class smoking_status sex;
var systolic; 
table sex, systolic*mean, smoking_status;
run;

*SLIDE 46;
proc tabulate data = heart order = formatted;
class smoking_status sex;
var systolic; 
table sex*systolic*mean, smoking_status;
run;

*SLIDE 47;
proc tabulate data = heart order = formatted;
class smoking_status sex;
table sex, smoking_status;
run;

*SLIDE 48;
proc tabulate data = heart order = formatted;
class smoking_status sex;
table sex all, smoking_status;
run;

*SLIDE 49;
proc tabulate data = heart order = formatted;
class smoking_status;
var systolic; 
table systolic*(mean median), smoking_status;
run;

*SLIDE 53;
*data prep;
PROC IMPORT DATAFILE='/home/u64289425/sasuser.v94/STAT 7500 F25/data/HHSTUDY2.xlsx'
	DBMS=XLSX
	OUT=hhs;
	GETNAMES=YES;
RUN;

proc plot data=hhs;
   plot wt * ht;
run;


*SLIDE 54;
proc gplot data=hhs;
   plot wt * ht;
run;
quit;

*SLIDE 56;
proc sgplot data=hhs;
   scatter x=ht y=wt;
run;

*SLIDE 57;
proc sgplot data=hhs;
   scatter x=ht y=wt;
   title "HHS Weight vs. Height";
   yaxis label="Weight";
   xaxis label="Height";
run;

*SLIDE 58;
proc sgplot data=hhs;
   scatter x=ht y=wt / datalabel=id;
   title "HHS Weight vs. Height";
   yaxis label="Weight";
   xaxis label="Height";
run;

*SLIDE 60;
data cars;
set sashelp.cars;
run;

proc sgplot data=cars;
hbox weight / category=origin;
run;

*SLIDE 61;
data class;
set sashelp.class;
run;
proc sgplot data=class;
histogram height;
density height;
density height / 
     type=kernel;
run;

*SLIDE 62;
proc sgplot data=sashelp.cars;
    vbar type / response=msrp stat=mean
                datalabel
                fillattrs=(color=steelblue);
    yaxis label="Average MSRP ($)" grid;
    xaxis label="Car Type";
    title "Average MSRP by Car Type";
run;









