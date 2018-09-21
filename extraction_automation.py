import yaml
import os.path
import datetime
import os
import sys

#set up variables for file paths
curr_date = datetime.datetime.today().strftime('%d-%m-%Y')
underscore = "_"
company = input("Enter the company abbreviation: ")
extraction_type = input("Enter extraction type (open vs data): ")
filetype = ".csv"

#load in the yaml from the company directory
os.chdir('/mnt/ds/newdata/' + company)
with open('predictive_service.yaml') as f:
   yamlData = yaml.load(f)

#identify the tables for extraction
if extraction_type == "open":
   tables_present = yamlData["open_extract"]["tables"].keys()
elif extraction_type == "data":
   tables_present = yamlData["base_extract"]["tables"].keys()
else:
   print('Not a valid extraction type')
   sys.exit()

#format file names
for i in range(len(tables_present)):
   tables_present[i] = company + underscore + tables_present[i] + underscore + curr_date + filetype

#change into the data/open directory based on extraction type
os.chdir('/mnt/ds/newdata/' + company + "/" + extraction_type)

#check if files exist
files_left = []
for i in range(len(tables_present)):
   if not os.path.exists(tables_present[i]):
       files_left.append(tables_present[i])

#output what files haven't processed yet
for i in range(len(files_left)):
   print('File ' + files_left[i] + 'has not finished processing.')

#is extraction finished?
if len(files_left > 0):
   print('File extraction not finished!')
else:
   print('File extraction finished.')
