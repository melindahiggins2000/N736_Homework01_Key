* =================================
  HOMEWORK 01 ANSWER KEY
  ================================= 

  Assume you start with the MANUALLY fixed file
  Dataset_02_fixq2.xlsx
  which removed the 1st empty cell
  [J2] for the "q2" column - it is assumed
  that this column was shifted down by 1 cell.
  NOTE: THIS IS AN ASSUMPTION - THERE
  COULD BE ANOTHER EXPLANATION - CELL J8 WAS
  ALSO EMPTY AND IT IS POSSIBLE THAT IS WHERE
  THE OFFSET OCCURED - WE DON'T KNOW FOR SURE;

* change the file location as needed for your system;

PROC IMPORT OUT= WORK.dataset02 
            DATAFILE= "C:\MyGithub\N736_Homework01_Key\Dataset_02_fixq2.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

* take a look at the file;

PROC CONTENTS data=dataset02; run;

* SAS Code from Getting Started
* using PROC format let's add labels
* for SES, gender and q1-q5 ;

proc format library = work;
   value GenderCodes
      1 = 'Male'  
      2 = 'Female' ;
   value SESCodes
      1 = 'Low Income'
	  2 = 'Average Income'
	  3 = 'High Income';
   value qScaleCodes
      1 = 'None of the time'
	  2 = 'A little of the time'
      3 = 'Some of the time'
      4 = 'A lot of the time'
      5 = 'All of the time';
run;

data work.Dataset02;
  set work.Dataset02;
   format GenderCoded GenderCodes.;
   format SES SESCodes.;
   format q1 qScaleCodes.;
   format q2 qScaleCodes.;
   format q3 qScaleCodes.;
   format q4 qScaleCodes.;
   format q5 qScaleCodes.;
run;

PROC CONTENTS data=dataset02; run;

* from the notes in class, here is each fixed applied
  using code;
 
* 1) MISSING DATA
  It is worth noting that SAS does recognize that
  a blank cell for the character variable GenderSTR
  is recognized as missing - see the results of running
  PROC FREQ for this variable - 1 missing value is listed;

proc freq data=dataset02;
  table GenderSTR;
run;

* to see other missing data PROC UNIVARIATE
  lists the amount of missing data at the bottom of the 
  output results for each variable - for example, let's
  look at the amount of missing data for the five
  questions q1, q2, q3, q4, q5;

proc univariate data=dataset02;
  var q1 q2 q3 q4 q5;
  run;

* PROC MEANS also gives you a quick list
  of the amount of missing for each variable;

proc means data=dataset02;
  var q1 q2 q3 q4 q5;
  run;

* 2) recode the missing data for the 9's
  in the q1-q5 items;

data dataset02a;
  set dataset02;
  if q1=9 then q2=.;
  if q2=9 then q2=.;
  if q3=9 then q2=.;
  if q4=9 then q2=.;
  if q5=9 then q2=.;
run;

* q2 had one 9 so check the dataset before
  the recode and after;

proc freq data=dataset02; table q2; run;

proc freq data=dataset02a; table q2; run;

* 3) Age had one value of 99 which could possibly
  be a real Age, but all the other ages are 
  approximately middle age - the 99 value looks like
  an outlier. We would need to check this individual's
  age, but it is probably a code for missing. Let's
  set the age of 99 to missing;

data dataset02b;
  set dataset02a;
  if age=99 then age=.;
run;

* look at a histogram of age before and after the recode;
* Histogram;
PROC SGPLOT DATA = dataset02a;
 HISTOGRAM Age;
 TITLE "Age BEFORE recoding 99 as missing";
RUN; 
* Histogram;
PROC SGPLOT DATA = dataset02b;
 HISTOGRAM Age;
 TITLE "Age AFTER recoding 99 as missing";
RUN; 

* 4 and 5) Recode the typos of 11 and 40 as 1 and 4
  for q1 and q4;

data dataset02c;
  set dataset02b;
  if q1=11 then q1=1;
  if q4=40 then q4=4;
run;

* check before and after recode
  make vertical barcharts;

proc sgplot data=dataset02b; vbar q1; title "q1 with typo"; run;
proc sgplot data=dataset02c; vbar q1; title "q1 with typo fixed"; run;

proc sgplot data=dataset02b; vbar q4; title "q4 with typo"; run;
proc sgplot data=dataset02c; vbar q4; title "q4 with typo fixed"; run;

* 6) Fix the WeightPRE values that are < 100
  these are obvious outliers most likely
  due to incorrect units - kg instead of lbs
  we could input exact values or simply use the
  conversation formula for values < 100 lbs - this
  assumes we don't have anyone under 100 lbs
  1 kg = 2.20462 lbs;

data dataset02d;
  set dataset02c;
  if WeightPRE < 100 then WeightPRE = WeightPRE * 2.20462;
  run;

* check histogram before and after;

PROC SGPLOT DATA = dataset02c;
 HISTOGRAM WeightPRE;
 TITLE "WeightPRE BEFORE Fixing 2 Values in Wrong Units";
RUN; 
* Histogram;
PROC SGPLOT DATA = dataset02d;
 HISTOGRAM WeightPRE;
 TITLE "WeightPRE AFTER Fixing 2 Values in Wrong Units";
RUN; 

* 7) fix height typo of 2.6, change to 6.2
  we are assuming that these numbers were accidently
  reversed - but this should be investigated;

data dataset02e;
  set dataset02d;
  if height = 2.6 then height = 6.2;
  run;

* check before and after fixing this typo;

PROC SGPLOT DATA = dataset02d;
 HISTOGRAM height;
 TITLE "Height BEFORE Fixing Typo";
RUN; 
* Histogram;
PROC SGPLOT DATA = dataset02e;
 HISTOGRAM height;
 TITLE "Height AFTER Fixing Typo";
RUN; 

* ==================================
  other issues in the dataset should simply be noted:
  8. the original gender was captured using open
  (free) text entry so there are many versions - but
  this was corrected using numeric coding in the 
  GenderCoded variable
 
  9. there is intermittent missing data for several
  variables - these are noted
 
  10. q3,q4,q5 and all missing for IDs 28, 30, 32 - 
  good to note that a section of these items are missing 
  for these 3 subjects - possibly a procedural error
  ========================================;
