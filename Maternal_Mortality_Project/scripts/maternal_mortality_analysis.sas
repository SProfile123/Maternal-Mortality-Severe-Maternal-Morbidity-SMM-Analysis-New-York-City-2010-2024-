

* Step 1: Import the raw dataset (CSV);
PROC IMPORT DATAFILE="Pregnancy-Associated_Mortality.csv"
    OUT=maternal_raw
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

* Step 2: Inspect the dataset;
PROC CONTENTS DATA=maternal_raw; RUN;
PROC PRINT DATA=maternal_raw (OBS=10); RUN;

* Step 3: Data cleaning;
DATA maternal_clean;
    SET maternal_raw;
    * Replace missing deaths with 0;
    IF Deaths = . THEN Deaths = 0;

    * Standardize race/ethnicity categories;
    LENGTH Race_ethnicity_clean $20;
    IF Race_ethnicity = "Black, non-Hispanic" THEN Race_ethnicity_clean = "Black";
    ELSE IF Race_ethnicity = "White, non-Hispanic" THEN Race_ethnicity_clean = "White";
    ELSE IF Race_ethnicity = "Hispanic" THEN Race_ethnicity_clean = "Hispanic";
    ELSE IF Race_ethnicity = "Asian/Pacific Islander" THEN Race_ethnicity_clean = "Asian/PI";
    ELSE Race_ethnicity_clean = "Other/Unknown";
RUN;

* Step 4: Summary statistics;
PROC MEANS DATA=maternal_clean N MEAN SUM;
    CLASS Race_ethnicity_clean Borough;
    VAR Deaths;
RUN;

* Step 5: Trend analysis by year;
PROC SGPLOT DATA=maternal_clean;
    SERIES X=Year Y=Deaths / GROUP=Race_ethnicity_clean;
    TITLE "Maternal Deaths by Race/Ethnicity Over Time";
RUN;

PROC SGPLOT DATA=maternal_clean;
    VBAR Borough / RESPONSE=Deaths GROUP=Race_ethnicity_clean GROUPDISPLAY=STACK;
    TITLE "Maternal Deaths by Borough and Race/Ethnicity";
RUN;


