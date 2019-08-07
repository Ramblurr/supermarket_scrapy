#!/usr/bin/env bash

cd supermarket_scrapy
DEST=${SUPERMARKET_DATA_DIR}

$PYTHON -m scrapy crawl MpreisShop -o ${DEST}/mpreis.json -t json --logfile=${DEST}/mpreis.log

