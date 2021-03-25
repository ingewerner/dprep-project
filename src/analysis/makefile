#Analysis 

all: exploration anova
exploration: ../../src/analysis/exploration.html 
anova: ../../src/analysis/anova.html


../../src/analysis/exploration.html: exploration.Rmd ../../gen/data-preparation/merging.csv
	R -e "rmarkdown::render('exploration.Rmd', output_file = '../../gen/analysis/output/exploration.html')"

../../src/analysis/anova.html: anova.Rmd ../../gen/data-preparation/temp/BLM2020_dataset.csv ../../gen/data-preparation/temp/BLM2021_dataset.csv
	R -e "rmarkdown::render('anova.Rmd', output_file = '../../gen/analysis/output/anova.html')"


