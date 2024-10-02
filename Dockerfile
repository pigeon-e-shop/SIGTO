FROM php:8.2-apache
RUN docker-php-ext-install pdo_mysql
WORKDIR /var/www/html/SIGTO
RUN a2enmod rewrite
