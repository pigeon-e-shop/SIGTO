FROM php:8.2-apache
RUN docker-php-ext-install pdo_mysql
WORKDIR /var/www/html/SIGTO
COPY . /var/www/html
RUN a2enmod rewrite
RUN a2enmod headers
