LOCAL_DATA=/home/seed/supermarket/data
DEST=/project/data

build:
	sudo docker-compose build

shell:
	docker run --rm -it -v $(LOCAL_DATA):$(DEST) scraper-base /bin/bash

alnatura:
	sudo docker-compose up alnatura-scraper

mpreis:
	sudo docker-compose up mpreis-scraper
