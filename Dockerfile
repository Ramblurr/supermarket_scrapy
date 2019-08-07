FROM python:3.7-slim AS compile

# Install essential packages
# Install prerequisite packages for scrapy
# Install util packages
RUN apt-get update -y \
    && apt-get -y install \
        dumb-init gnupg wget ca-certificates apt-transport-https unzip \
        build-essential libssl-dev libffi-dev libxml2-dev libxslt-dev \
        git nano vim ncdu htop \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN mkdir /project
WORKDIR /project
RUN python -m venv /venv
RUN pip install scrapy selenium
COPY requirements.txt .
RUN /venv/bin/pip install -r requirements.txt


FROM python:3.7-slim AS build

RUN apt-get update -y \
    && apt-get -y install \
        dumb-init gnupg wget ca-certificates unzip \
        git nano vim ncdu htop \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

COPY --from=compile /venv /venv
RUN mkdir /project
WORKDIR /project
RUN groupadd -g 1000 scrapy && useradd -m -u 1000 -g scrapy scrapy
RUN chown -R scrapy /project
USER scrapy
WORKDIR /project
ADD . /project
ENV PYTHON /venv/bin/python3
CMD [ "/bin/bash" ]
