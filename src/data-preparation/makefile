#Define rules

all: data_sets pre_clean merge
data_sets: ../../datasets/BLM2020_dataset.csv ../../datasets/BLM2021_dataset.csv
pre_clean: ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
merge: ../../gen/data-preparation/merging.csv


../../datasets/BLM2020_dataset.csv ../../datasets/BLM2021_dataset.csv:
	Rscript download_data.R


../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv: ../../datasets/BLM2020_dataset.csv ../../datasets/BLM2021_dataset.csv
	Rscript preclean.R


../../gen/data-preparation/merging.csv : ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
	Rscript merging.R
