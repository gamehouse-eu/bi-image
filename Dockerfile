FROM python:3.7

# We need non-free sources to install unrar
RUN echo "deb http://deb.debian.org/debian stretch non-free" >> /etc/apt/sources.list

# Install nodejs (used to compile some documentation)
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update && apt-get upgrade -y

# install google cloud command line tools
RUN curl https://sdk.cloud.google.com | bash > /dev/null 2>&1
RUN ln -s /root/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
RUN ln -s /root/google-cloud-sdk/bin/bq /usr/bin/bq
RUN ln -s /root/google-cloud-sdk/bin/gsutil /usr/bin/gsutil
RUN gcloud config set disable_usage_reporting true

# install packages for the project
RUN apt-get install -y \
  # Useful unix tools \
  dos2unix entr less vim \
  \
  # needed by yajl-py for better performance on json parsing \
  libyajl2 libyajl-dev \
  \
  # required to unpack RAR packages
  unrar \
  # required to unpack DMG images for MAC games
  dmg2img \
  p7zip-full \
  # install packages for MSSQL ODBC drivers \
  unixodbc \
  unixodbc-dev \
  freetds-dev \
  freetds-bin \
  tdsodbc \
  # install nodejs for documentation
  nodejs

# cloudsql-proxy is used in gcloud only, but it is always installed
# more info: https://cloud.google.com/sql/docs/postgres/sql-proxy
RUN wget -q -O /usr/local/bin/cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 \
  && chmod +x /usr/local/bin/cloud_sql_proxy

# this should be installed separately or yajl-py will fail
RUN pip3 install six

RUN pip3 install requests \
                 rarfile \
                 iso3166 \
                 iso4217 \
                 yajl-py \
                 ujson \
                 ijson \
                 python-dateutil \
                 fastavro \
                 cffi \
                 pyodbc \
                 psycopg2 \
                 envkey \
                 pylint \
                 falcon==1.4.1 \
                 falcon-cors==1.1.7 \
                 uwsgi \
                 xlrd \
                 lxml \
                 pyyaml \
                 apache_log_parser

RUN pip3 install google-cloud-storage \
                 google-cloud-bigquery \
                 kubernetes

# only for the tests
RUN pip3 install pytest
