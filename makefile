all: analysis data-preparation

data-preparation:
	$(MAKE) -C src/data-preparation

analysis: data-preparation
	$(MAKE) -C gen/analysis