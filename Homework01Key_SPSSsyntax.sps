* Encoding: UTF-8.
* ======================================
* SPSS SYNTAX for HOMEWORK 01
* ANSWER KEY
* ======================================.

* IMPORT the data from EXCEL
* Assume you start with the MANUALLY fixed file
* Dataset_02_fixq2.xlsx
* which removed the 1st empty cell
* [J2] for the "q2" column - it is assumed
* that this column was shifted down by 1 cell.
* NOTE: THIS IS AN ASSUMPTION - THERE
* COULD BE ANOTHER EXPLANATION - CELL J8 WAS
* ALSO EMPTY AND IT IS POSSIBLE THAT IS WHERE
* THE OFFSET OCCURED - WE DON'T KNOW FOR SURE.

GET DATA
  /TYPE=XLSX
  /FILE='C:\MyGithub\N736_Homework01_Key\Dataset_02_fixq2.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=FULL
  /READNAMES=ON
  /DATATYPEMIN PERCENTAGE=95.0
  /HIDDEN IGNORE=YES.
EXECUTE.

* take a look at the summary stats for all of the
* variables - look for missing data, typos, outliers
* and look at histograms.

FREQUENCIES VARIABLES=Age WeightPRE WeightPOST Height SES GenderSTR GenderCoded q1 q2 q3 q4 q5
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* 1,2,3) Let's add the labels and value codes
  and fix the missing values of 9's for q1-q5
  and treat 99 as missing for Age
  and treat the empty blank text for GenderSTR
  as missing.

* Define Variable Properties.
*SubjectID.
VARIABLE LABELS  SubjectID 'Subject ID'.
*Age.
VARIABLE LABELS  Age 'Age'.
MISSING VALUES Age(99).
*WeightPRE.
VARIABLE LABELS  WeightPRE 'Weight (in lbs) Before'.
*WeightPOST.
VARIABLE LABELS  WeightPOST 'Weight (in lbs) After'.
*Height.
VARIABLE LABELS  Height 'Height in Decimal Feet'.
*SES.
VARIABLE LABELS  SES 'Socio Economic Status'.
VALUE LABELS SES
  1 'Low Income'
  2 'Average Income'
  3 'High Income'.
*GenderSTR.
VARIABLE LABELS  GenderSTR 'Gender (entered as free/open text)'.
MISSING VALUES GenderSTR('      ').
VALUE LABELS GenderSTR.
*GenderCoded.
VARIABLE LABELS  GenderCoded 'Gender (recoded using numbers)'.
VALUE LABELS GenderCoded
  1 'Male'
  2 'Female'.
*q1.
VALUE LABELS q1
  1 'none of the time'
  2 'a little of the time'
  3 'some of the time'
  4 'a lot of the time'
  5 'all of the time'.
*q2.
MISSING VALUES q2(9).
VALUE LABELS q2
  1 'none of the time'
  2 'a little of the time'
  3 'some of the time'
  4 'a lot of the time'
  5 'all of the time'.
*q3.
MISSING VALUES q3(9).
VALUE LABELS q3
  1 'none of the time'
  2 'a little of the time'
  3 'some of the time'
  4 'a lot of the time'
  5 'all of the time'.
*q4.
MISSING VALUES q4(9).
VALUE LABELS q4
  1 'none of the time'
  2 'a little of the time'
  3 'some of the time'
  4 'a lot of the time'
  5 'all of the time'.
*q5.
MISSING VALUES q5(9).
VALUE LABELS q5
  1 'none of the time'
  2 'a little of the time'
  3 'some of the time'
  4 'a lot of the time'
  5 'all of the time'.
EXECUTE.

* quick check of the missing data recoding and such;
* look at summary stats and histograms;

FREQUENCIES VARIABLES=Age WeightPRE WeightPOST Height SES GenderSTR GenderCoded q1 q2 q3 q4 q5
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* 4 & 5) Fix the typos, 11 and 40 for q1 and q4.

if q1=11 q1=1.
execute.

if q4=40 q4=4.
execute.

* check these variables again.

FREQUENCIES VARIABLES=q1 q4
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* 6) Fix the WeightPRE values that are < 100
  these are obvious outliers most likely
  due to incorrect units - kg instead of lbs
  we could input exact values or simply use the
  conversation formula for values < 100 lbs - this
  assumes we don't have anyone under 100 lbs
  1 kg = 2.20462 lbs.

if WeightPRE < 100 WeightPRE=WeightPRE * 2.20462.
execute.

* look at WeightPRE again.

FREQUENCIES VARIABLES=WeightPRE
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* 7) fix height typo of 2.6, change to 6.2
  we are assuming that these numbers were accidently
  reversed - but this should be investigated.

if height=2.6 height=6.2.
execute.

* look at Height again.

FREQUENCIES VARIABLES=Height
  /NTILES=4
  /STATISTICS=STDDEV MINIMUM MAXIMUM MEAN
  /HISTOGRAM
  /ORDER=ANALYSIS.

* other issues in the dataset should simply be noted:
* 8. the original gender was captured using open
* (free) text entry so there are many versions - but
* this was corrected using numeric coding in the 
* GenderCoded variable
*
* 9. there is intermittent missing data for several
* variables - these are noted
*
* 10. q3,q4,q5 and all missing for IDs 28, 30, 32 
* - good to note that a section of these items are 
* missing for these 3 subjects - possibly a procedural error.






