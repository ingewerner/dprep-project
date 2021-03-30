all: analysis data-preparation

.PHONY: all data-preparation analysis

data-preparation:
	$(MAKE) -C src/data-preparation

analysis: data-preparation
<<<<<<< HEAD
	$(MAKE) -C gen/analysis
=======
	$(MAKE) -C src/analysis

wipe:
	$(MAKE) wipe -C src/data-preparation
	$(MAKE) wipe -C src/analysis
>>>>>>> 8f27a42a81f709c0b89912ade8c16e48842036ea
