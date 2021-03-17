

../../gen/data-preparation/temp/tempfile1.csv ../../gen/data-preparation/temp/tempfile2.csv: ../../datasets/dataset1/BLM2020_Dutch_elections16.csv ../../datasets/dataset2/BLM2021_Dutch_elections15.csv preclean.R
	Rscript preclean.R

../../gen/data-preparation/merging.csv: ../../gen/data-preparation/temp/tempfile1.csv ../../gen/data-preparation/temp/tempfile2.csv
	Rscript merging.R
	
../../output/analyzed_data.R: ../../gen/data-preparation/merging.csv
	Rmarkdown analyzed_data.Rdata
