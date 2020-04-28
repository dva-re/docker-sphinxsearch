FROM debian:stretch-slim
MAINTAINER fastsol

ADD files/* /root/

RUN \
 apt-get update && apt-get install -y --allow-unauthenticated --no-install-recommends sphinxsearch cron locales locales-all && \
 rm -rf /var/www/html/* && apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
 rm -rf /var/cache/debconf/*-old && rm -rf /var/lib/apt/lists/* && rm -rf /usr/share/doc/* && \
 echo 'START=yes' > /etc/default/sphinxsearch && mv /etc/sphinxsearch /etc/sphinxsearch.orig && \
 echo '0 * * * * /usr/bin/indexer --rotate --all' | crontab - && \
 locale-gen ru_RU.UTF-8 && ln -snf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone && \
 chmod +x /root/start.sh

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:ru

EXPOSE 9306
VOLUME ["/data", "/etc/sphinxsearch"]
CMD ["/root/start.sh"]
