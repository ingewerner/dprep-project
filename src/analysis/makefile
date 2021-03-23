#Analysis 

all: general_analysis anova
general_analysis : ../../src/analysis/analysis.nb.html 
anova: ../../src/analysis/anova.nb.html


../../src/analysis/analysis.nb.html: ../../gen/data-preparation/merging.csv
	Rmd analysis.Rmd

../../src/analysis/anova.nb.html: ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
	Rmd anova.Rmd 
