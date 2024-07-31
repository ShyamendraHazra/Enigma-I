FROM php:apache AS php_apache
RUN docker-php-ext-install mysqli
COPY ./src /var/www/html
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf