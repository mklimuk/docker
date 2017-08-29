FROM debian:jessie

MAINTAINER Michal Klimuk <michal.klimuk@gmail.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends software-properties-common apt-transport-https wget && \
    echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backport.list && \
    echo 'deb https://packages.icinga.com/debian icinga-jessie main' >/etc/apt/sources.list.d/icinga.list && \
    wget -O - http://packages.icinga.com/icinga.key | apt-key add - && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends \
    icinga2 nagios-plugins && \
    apt-get -y remove software-properties-common apt-transport-https wget && \
    apt-get autoremove && apt-get clean && \
    mkdir /run/icinga2 && chown nagios:nagios /run/icinga2

USER nagios

ENTRYPOINT /etc/init.d/icinga2 foreground
