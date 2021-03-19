
all: ../../gen/data-preparation/temp/cleaned2020.csv ../../gen/data-preparation/temp/cleaned2021.csv

../../gen/data-preparation/temp/cleaned2020.csv ../../gen/data-preparation/temp/cleaned2021.csv: ../../datasets/dataset1/BLM2020_Dataset.csv ../../datasets/dataset2/BLM2021_Dataset.csv preclean.R
	Rscript preclean.R