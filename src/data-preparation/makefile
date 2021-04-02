#Define rules

all: data_sets pre_clean merge
data_sets: ../../datasets/datasets.RData
pre_clean: ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
merge: ../../gen/data-preparation/merging.csv

DOWN_DATA = ../../datasets
GEN_DATA = ../../gen/data-preparation/temp

$(DOWN_DATA)/datasets.RData: download_data.R
	R --vanilla < download_data.R


$(GEN_DATA)/BLM2020_dataset.csv $(GEN_DATA)/temp/BLM2021_dataset.csv: $(DOWN_DATA)/datasets.RData preclean.R
	R --vanilla < preclean.R


../../gen/data-preparation/merging.csv: $(GEN_DATA)/BLM2020_dataset.csv $(GEN_DATA)/BLM2021_dataset.csv merging.R
	R --vanilla < merging.R
