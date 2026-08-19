* Week 5 practice problems;

PROC IMPORT DATAFILE='/home/u64289425/sasuser.v94/STAT 7500 F25/data/HHSTUDY2.xlsx'
	DBMS=XLSX
	OUT=hhs;
	GETNAMES=YES;
RUN;

proc contents data = hhs;
run;

/* a) Create age categories: 40s, 50s, 60s */
data hhs;
	rename 'SYS BP'n = SYS_BP;
	rename 'PHYS ACT'n = PHYS_ACT;
	rename 'POND IDX'n = POND_IDX;
    set hhs;
    if 40 <= age < 50 then agecat = "40s";
    else if 50 <= age < 60 then agecat = "50s";
    else if 60 <= age < 70 then agecat = "60s";
run;

/* b) Verify creation with PROC FREQ + LIST option */
proc freq data=hhs;
    tables agecat / list;
run;

/* c) Create variable comparing SYS_BP to mean/median */
proc means data=hhs noprint;
    var sys_bp;
    output out=sysbp_stats(drop=_TYPE_ _FREQ_) 
        mean=mean_bp 
        median=median_bp;
run;

data hhs;
    set hhs;
    if _n_ = 1 then set sysbp_stats;   /* bring in mean_bp, median_bp */
    if sys_bp < mean_bp and sys_bp < median_bp then bp_status = "below";
    else if sys_bp > mean_bp and sys_bp > median_bp then bp_status = "above";
    else bp_status = "between";
run;


/* d1) Contingency table of smoke by phys_act */
proc tabulate data=hhs;
    class smoke phys_act;
    table smoke, phys_act;
run;

/* d2) Contingency table separately by agecat */
proc tabulate data=hhs;
    class agecat smoke phys_act;
    table agecat, smoke, phys_act;
run;

/* d3) Contingency table of smoke by phys_act 
       showing mean & std of pond_idx */
proc tabulate data=hhs;
    class smoke phys_act;
    var pond_idx;
    table smoke, phys_act*(pond_idx*(mean std));
run;

/* e) Create z-scores of cholesterol standardized within EDUC */
proc means data=hhs noprint nway;
    class educ;
    var chol;
    output out=chol_stats mean=mean_chol std=sd_chol;
run;

proc sort data = chol_stats;
by educ;
run;

proc sort data = hhs;
by educ;
run;

data hhs2;
    merge hhs chol_stats;
    by educ;
    z_chol = (chol - mean_chol) / sd_chol;
run;

/* Histogram of z-scores */
proc sgplot data=hhs2;
    histogram z_chol;
    density z_chol;
run;
