#!/bin/bash
#set up date
curr_date=`date +%d-%m-%Y`
#curr_date=17-09-2018
echo The date is: $curr_date

#set up company name
echo Enter the company abbreviation used previously:
read company
#set the type of extraction you are running
#open = open extraction, data = base extraction
echo Enter open or data:
read extOption

#set file path
filepath=/mnt/ds/newdata/${company}/data/
cd /mnt/ds/newdata/${company}/${extOption}/
echo You are in the following directory:
pwd

#generate the 12 file names
file1=${company}_Account_${curr_date}.csv
file2=${company}_ContactMetrics_AggMeasures_${curr_date}.csv
file3=${company}_DSOPView_${curr_date}.csv
file4=${company}_Opportunity_${curr_date}.csv
file5=${company}_PredictiveAnalysis_${curr_date}.csv
file6=${company}_PricebookEntry_${curr_date}.csv
file7=${company}_Product2_${curr_date}.csv
file8=${company}_RecordType_${curr_date}.csv
file9=${company}_RepMetricsOppScore_${curr_date}.csv
file10=${company}_User_${curr_date}.csv
file11=${company}_UserRole_${curr_date}.csv
file12=${company}_xOFT_${curr_date}.csv

#loop through to check if extraction is finished
for f in $file1 $file2 $file3 $file5 $file6 $file7 $file8 $file9 $file10 $file11 $file12
do
         if [ -e $f ]
         then
                 echo "File $f processed."
         else
                 echo "File $f does not exit yet, extraction not finished!"
         fi
done
