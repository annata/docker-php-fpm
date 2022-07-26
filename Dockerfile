FROM php:8.1-fpm-alpine
COPY php.ini /usr/local/etc/php/conf.d/

RUN apk add --update --no-cache \
libmcrypt-dev libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev openldap-dev libxml2 libxml2-dev bzip2 bzip2-dev icu icu-dev gettext-dev libintl libzip libzip-dev \
&& docker-php-ext-configure gd --with-freetype --with-jpeg \
&& docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd fileinfo gettext bz2 ldap soap opcache mysqli pdo_mysql bcmath calendar exif pcntl shmop sysvsem dba sockets zip
