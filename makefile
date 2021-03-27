all: data-preparation analysis
data-preparation: gen/data-preparation
analysis: gen/analysis

data-preparation:
	$(MAKE) -C src/data-preparation

analysis: data-preparation
	$(MAKE) -C src/analysis
