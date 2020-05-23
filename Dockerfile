FROM php:7.3-apache
LABEL maintainer "Yujiro Ishii"

ENV COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_HOME=/composer

RUN apt-get update && \
    apt-get install -y git unzip zip && \
    docker-php-ext-install bcmath pdo_mysql && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    composer config -g repos.packagist composer https://packagist.jp
# RUN composer global require hirak/prestissimo

WORKDIR /var/www
COPY src/composer.json /var/www/
COPY src/composer.lock /var/www/
RUN composer install --no-autoloader

COPY src /var/www/
RUN composer dump-autoload
RUN chown -R www-data storage/
RUN mv public/* public/.htaccess  /var/www/html/
RUN cp .env.example .env && php artisan key:generate

COPY docker/apache/apache2.conf /etc/apache2/
