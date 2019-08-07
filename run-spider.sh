#!/usr/bin/env bash

set -e

spider=${1:-}
cd supermarket_scrapy
DEST=$SUPERMARKET_DATA_DIR

$PYTHON -m scrapy crawl $spider -o $DEST/$spider.json -t json --logfile=$DEST/$spider.log

