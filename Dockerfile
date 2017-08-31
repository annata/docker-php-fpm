FROM php:7.1-fpm-alpine
COPY php.ini /usr/local/etc/php/conf.d/
ENV PHPREDIS_VERSION="php7"

RUN apk add --update --no-cache \
libmcrypt-dev libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev openldap-dev libxml2 libxml2-dev bzip2 bzip2-dev icu icu-dev gettext-dev libintl \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd gettext bz2 ldap soap opcache mcrypt mysqli pdo_mysql bcmath calendar exif pcntl shmop sysvsem dba sockets wddx xmlrpc zip

RUN cd /tmp && curl -L -o /tmp/redis.tar.gz "https://github.com/phpredis/phpredis/archive/${PHPREDIS_VERSION}.tar.gz" \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && docker-php-source extract \
    && mv /tmp/phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
&& docker-php-source delete