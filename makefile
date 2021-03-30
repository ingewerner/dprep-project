all: analysis data-preparation

.PHONY: all data-preparation analysis

data-preparation:
	$(MAKE) -C src/data-preparation

analysis: data-preparation
	$(MAKE) -C src/analysis

wipe:
	$(MAKE) wipe -C src/data-preparation
	$(MAKE) wipe -C src/analysis

clean:
	rm -f gen/data-preparation gen/merging.csv datasets/BLM2020.csv datasets/BLM2021.csv
