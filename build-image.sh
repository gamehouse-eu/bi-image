#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y

# install packages for the project

# Useful unix tools
apt-get install -y curl wget dos2unix entr less vim apt-utils

# install python
apt-get install -y python3 python3-pip

# needed by yajl-py for better performance on json parsing
apt-get install -y libyajl2 libyajl-dev

# required to unpack RAR packages
apt-get install -y unrar

# required to unpack DMG images for MAC games
apt-get install -y dmg2img p7zip-full

# install packages for MSSQL ODBC drivers
apt-get install -y unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc

# install nodejs for documentation
apt-get install -y nodejs npm

# install google cloud command line tools
curl https://sdk.cloud.google.com | bash > /dev/null 2>&1
ln -s /root/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
ln -s /root/google-cloud-sdk/bin/bq /usr/bin/bq
ln -s /root/google-cloud-sdk/bin/gsutil /usr/bin/gsutil
gcloud config set disable_usage_reporting true

# cloudsql-proxy is used in gcloud only, but it is always installed
# more info: https://cloud.google.com/sql/docs/postgres/sql-proxy
wget -q -O /usr/local/bin/cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64
chmod +x /usr/local/bin/cloud_sql_proxy

# this should be installed separately or yajl-py will fail
apt-get install -y python3-six
apt-get install -y python3-psycopg2
apt-get install -y python3-requests
apt-get install -y python3-rarfile
apt-get install -y python3-ijson
apt-get install -y python3-dateutil
apt-get install -y python3-pyodbc
apt-get install -y python3-cffi
apt-get install -y python3-xlrd
apt-get install -y python3-lxml
apt-get install -y python3-yaml
apt-get install -y python3-kubernetes

pip3 install iso3166 \
             iso4217 \
             yajl-py \
             fastavro \
             envkey \
             pylint \
             ujson==2.0.3 \
             falcon==1.4.1 \
             falcon-cors==1.1.7 \
             uwsgi \
             apache_log_parser

pip3 install google-cloud-storage \
             google-cloud-bigquery

# only for the tests
pip3 install pytest

# clean apt downloaded files from
rm -rf /var/lib/apt/lists/*
