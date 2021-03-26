#Define rules

all: data_sets pre_clean merge
data_sets: ../../datasets/datasets.RData
pre_clean: ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
merge: ../../gen/data-preparation/merging.csv


../../datasets/datasets.RData: download_data.R
	R --vanilla < download_data.R


../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv: ../../datasets/datasets.RData preclean.R
	R --vanilla < preclean.R


../../gen/data-preparation/merging.csv: ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv merging.R
	R --vanilla < merging.R
