# =======================================
# N736 - HOMEWORK 01 - ANSWER KEY
# =======================================

# Assume you start with the MANUALLY fixed file
# Dataset_02_fixq2.xlsx
# which removed the 1st empty cell
# [J2] for the "q2" column - it is assumed
# that this column was shifted down by 1 cell.
# NOTE: THIS IS AN ASSUMPTION - THERE
# COULD BE ANOTHER EXPLANATION - CELL J8 WAS
# ALSO EMPTY AND IT IS POSSIBLE THAT IS WHERE
# THE OFFSET OCCURED - WE DON'T KNOW FOR SURE

# load tidyverse and readxl packages
library(tidyverse)
library(readxl)

# used read_excel() from the readxl package
# This file shifted all rows up by 1 for column "q2"
dat <- read_excel("Dataset_02_fixq2.xlsx")

# from the notes in class, here is each fixed applied
# using code
#
# 1. MISSING DATA
# Most missing data is identified as an empty cell
# R recognizes these as NA's. The only exception is for
# the "GenderSTR" which is a character class variable
# R actually does recognize this as NA - you can see this
# using the useNA = "ofany" option in the table() function

table(dat$GenderSTR, useNA = "ifany")

# other empty cells are recognized as NA - see the results
# of running the summary() function

summary(dat)

# 2. RECODE MISSING DATA
# It was noted that 9's should also be treated as missing
# now we have to recode these to get R to drop the 
# 9's from future analyses.
# We could recode these in place, but it is a good practice
# to never overwrite your original data, so we'll create
# a new dataset with the recoded variables.

# We can use the ifelse() function to find and replace
# all 9's in the 5 q items with NAs.
dat2 <- dat
dat2$q1 <- ifelse(test = dat$q1 != 9, yes = dat$q1, no = NA)
dat2$q2 <- ifelse(test = dat$q2 != 9, yes = dat$q2, no = NA)
dat2$q3 <- ifelse(test = dat$q3 != 9, yes = dat$q3, no = NA)
dat2$q4 <- ifelse(test = dat$q4 != 9, yes = dat$q4, no = NA)
dat2$q5 <- ifelse(test = dat$q5 != 9, yes = dat$q5, no = NA)

# do a quick recode check - for example q2
# this shows 1 9 and 1 empty cell NA
table(dat$q2, useNA = "ifany")
# this recoded q2 now shows 2 NAs
table(dat2$q2, useNA = "ifany")

# 3. NOTE: there was a 99 for Age. it is possible
# that this is a real Age, but given that the other
# Ages are much younger, there is a chance that 99
# was used as a code for missing
# see a plot of the distribution of ages
# 99 is an obvious outlier
hist(dat$Age)

# use similar recode approach to change 99 to NA for Age
dat2$Age <- ifelse(test = dat$Age != 99, 
                   yes = dat$Age, 
                   no = NA)

# check recode
hist(dat2$Age)

# 4 & 5. Fix the typos, 11 and 40 for q1 and q4
dat2$q1 <- ifelse(test = dat$q1 == 11, 
                  yes = 1, 
                  no = dat$q1)
dat2$q4 <- ifelse(test = dat$q4 == 40, 
                  yes = 4, 
                  no = dat$q4)

# check recode with a barchart
# notice the 11 in the plot
barplot(table(dat$q1))
# now the only values seen are 1-5
barplot(table(dat2$q1))

# 6. Fix the WeightPRE values that are < 100
# these are obvious outliers most likely
# due to incorrect units - kg instead of lbs
# we could input exact values or simply use the
# conversation formula for values < 100 lbs - this
# assumes we don't have anyone under 100 lbs
# 1 kg = 2.20462 lbs

dat2$WeightPRE <- ifelse(test = dat$WeightPRE < 100, 
                         yes = dat$WeightPRE * 2.20462, 
                         no = dat$WeightPRE)

# check recoding
hist(dat$WeightPRE)
hist(dat2$WeightPRE)

# 7. fix height typo of 2.6, change to 6.2
# we are assuming that these numbers were accidently
# reversed - but this should be investigated

dat2$Height <- ifelse(test = dat$Height == 2.6, 
                      yes = 6.2, 
                      no = dat$Height)

# check recoding
hist(dat$Height)
hist(dat2$Height)

# other issues in the dataset should simply be noted:
# 8. the original gender was captured using open
# (free) text entry so there are many versions - but
# this was corrected using numeric coding in the 
# GenderCoded variable
#
# 9. there is intermittent missing data for several
# variables - these are noted
#
# 10. q3,q4,q5 and all missing for IDs 28, 30, 32 - good to note that a section of these items are missing for these 3 subjects - possibly a procedural error
# ============================================