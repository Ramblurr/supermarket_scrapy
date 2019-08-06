FROM python:3.7

# Install essential packages
RUN apt-get update -y \
    && apt-get -y install \
        dumb-init gnupg wget ca-certificates apt-transport-https \
        ttf-wqy-zenhei unzip \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install Chrome Headless Browser
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -y \
    && apt-get -y install google-chrome-unstable \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install prerequisite packages for scrapy
RUN apt-get update -y
RUN apt-get -y install build-essential libssl-dev libffi-dev libxml2-dev libxslt-dev

# Install chromedriver
ARG CHROME_DRIVER_VERSION=76.0.3809.68
RUN wget -O tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip
RUN unzip tmp/chromedriver_linux64.zip -d tmp \
    && rm tmp/chromedriver_linux64.zip \
    && chmod 755 tmp/chromedriver \
    && mv tmp/chromedriver /usr/bin/chromedriver

# Install util packages
RUN apt-get install -y git nano vim ncdu htop

# Install scrapy & selenium
RUN pip install scrapy selenium

RUN mkdir /project
RUN groupadd -g 1000 scrapy && useradd -m -u 1000 -g scrapy scrapy
RUN chown -R scrapy /project
USER scrapy
WORKDIR /project
ADD . /project
USER root
RUN pip install -r supermarket_scrapy/requirements.txt
USER scrapy
CMD [ "/bin/bash" ]
