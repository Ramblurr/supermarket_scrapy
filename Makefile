LOCAL_DATA=/home/seed/supermarket/data
DEST=/project/data

build:
	docker build -t scrapy .

shell:
	docker run --rm -it -v $(LOCAL_DATA):$(DEST) scrapy /bin/bash

alnatura:
	cd supermarket_scrapy && scrapy crawl AlnaturaShop -o $(DEST)/alnatura.json -t json --logfile=$(DEST)/alnatura.log

mpreis:
	cd supermarket_scrapy && scrapy crawl mpreisShop -o $(DEST)/mpreis.json -t json --logfile=$(DEST)/mpreis.log
