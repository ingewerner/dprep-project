all: analysis data-preparation

.PHONY: all data-preparation analysis

data-preparation:
	make -C src/data-preparation

analysis: data-preparation
	make -C gen/analysis
	make -C rc/analysis

wipe:
	make wipe -C src/data-preparation
	make wipe -C src/analysis
