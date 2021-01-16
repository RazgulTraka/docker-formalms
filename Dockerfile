FROM debian:stretch-20201209-slim as base
ARG VERSION=2.3.0.2
ARG CHECKSUM=5daa1266c199843f1a9ba41526b0606a053f13391ae03da674480ca0a53b65c2
WORKDIR /
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    unzip=6.0-21+deb9u2 \
    ca-certificates=20200601~deb9u1 \
    wget=1.18-5+deb9u3 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  echo "**** download formalms ****" && \
  wget -O formalms.zip https://sourceforge.net/projects/forma/files/version-2.x/formalms-v${VERSION}.zip/download && \
  echo "${CHECKSUM}  formalms.zip" | sha256sum -c && \
  unzip formalms.zip && \
  rm formalms.zip && \
  cp /formalms/config.dist.php /formalms/config.php

FROM php:5.6-apache
ENV APACHE_DOCUMENT_ROOT /app
WORKDIR /app
COPY --from=base /formalms .
COPY entrypoint.sh .
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    dnsutils=1:9.10.3.dfsg.P4-12.3+deb9u7 \
    iproute2=4.9.0-1+deb9u1 && \
	apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
	docker-php-ext-configure mysqli && \
	docker-php-ext-install mysqli && \
  sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf && \
  sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf && \
  chown www-data:www-data -R /app
VOLUME /app
EXPOSE 80 443
# ENTRYPOINT ["/bin/sh","/app/entrypoint.sh"]
