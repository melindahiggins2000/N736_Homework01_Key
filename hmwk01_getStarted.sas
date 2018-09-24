* change the file location as needed for your system;

PROC IMPORT OUT= WORK.dataset02 
            DATAFILE= "C:\MyGithub\N736Homework01\Dataset_02_fixq2.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

* take a look at the file;

PROC CONTENTS data=dataset02; run;

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

* now that the labels are applied
* let's look at some simple summary tables
* using PROC FREQ;

proc freq data=dataset02;
  tables SES GenderCoded;
  run;

proc freq data=dataset02;
  tables q1 q2 q3 q4 q5;
  run;

* let's also look at the continuous data
* for example age;

proc univariate data=dataset02 plots;
  var age;
  run;

