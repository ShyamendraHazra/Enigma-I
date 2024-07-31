FROM php:apache AS php_apache
RUN docker-php-ext-install mysqli
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
COPY php.env /etc/environment

FROM mysql:latest as mysql
COPY ./mysql/mysql.conf /etc/my.cnf.custom
RUN cat /etc/my.cnf.custom/my.cnf > /etc/my.cnf
COPY mysql.env /etc/environment

FROM phpmyadmin AS phpmyadmin
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf