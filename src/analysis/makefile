#Analysis 

all: exploration anova
exploration: ../../gen/analysis/output/exploration.html 
anova: ../../src/analysis/anova.html


../../gen/analysis/output/exploration.html: exploration.Rmd ../../gen/data-preparation/merging.csv
	mkdir ../../gen/analysis/
	mkdir ../../gen/analysis/output
	R -e "rmarkdown::render('exploration.Rmd', output_file = '../../gen/analysis/output/exploration.html')"

../../src/analysis/anova.html: anova.Rmd ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
	R -e "rmarkdown::render('anova.Rmd', output_file = '../../gen/analysis/output/anova.html')"


