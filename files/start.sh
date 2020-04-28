#!/bin/bash

source /root/start-utils

if [ ! -e /etc/sphinxsearch/sphinx.conf ]; then
    cp /etc/sphinxsearch.orig/* /etc/sphinxsearch/
fi

chown -R sphinxsearch:root /etc/sphinxsearch

if [ ! -d /data/sphinxdata ]; then
    mkdir /data/sphinxdata
fi
chown -R sphinxsearch:root /data/sphinxdata

service cron start
service sphinxsearch start

wait_signal

echo "Try to exit properly"
service cron stop
service sphinxsearch stop


wait_exit "cron searchd"
