FROM php:7.3-apache
LABEL maintainer "Yujiro Ishii"

ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_HOME=/composer

RUN apt-get update && \
    apt-get install -y git unzip zip && \
    docker-php-ext-install bcmath pdo_mysql && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    composer config -g repos.packagist composer https://packagist.jp
# RUN composer global require hirak/prestissimo

WORKDIR /opt/board
COPY src/composer.json /opt/board/src/
COPY src/composer.lock /opt/board/src/
RUN cd src && composer install --no-autoloader

COPY . /opt/board
RUN cd src && composer dump-autoload
