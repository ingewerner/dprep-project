all: ../../datasets/BLM2020_dataset.csv ../../datasets/BLM2021_dataset.csv ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv ../../gen/data-preparation/merging.csv


../../datasets/BLM2020_dataset.csv ../../datasets/BLM2021_dataset.csv:
	Rscript download_data.R


../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv: ../../datasets/BLM2020_dataset.csv ../../datasets/BLM2021_dataset.csv
	Rscript preclean.R


../../gen/data-preparation/merging.csv : ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
	Rscript merging.R
