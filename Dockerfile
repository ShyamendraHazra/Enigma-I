# Stage 1: Build the PHP Apache image
FROM php:apache AS php_apache
RUN docker-php-ext-install mysqli
COPY ./src /var/www/html 
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Stage 2: Build the MySQL image
FROM mysql:latest AS mysql
RUN mkdir -p /var/log/mysql /var/lib/mysql && \
    chown -R mysql:mysql /var/log/mysql /var/lib/mysql
COPY ./mysql/mysql.conf/my.cnf /etc/my.cnf

# Stage 3: Build the phpMyAdmin image
FROM phpmyadmin AS phpmyadmin
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Final stage: Combine the images
FROM php_apache

# Copy the MySQL configuration from the mysql stage
COPY --from=mysql /etc/my.cnf /etc/my.cnf

# Copy the phpMyAdmin files from the phpmyadmin stage
COPY --from=phpmyadmin /var/www/html /var/www/html

# Expose the necessary ports
EXPOSE 80 3306

# Start the services
CMD ["sh", "-c", "/usr/sbin/apache2ctl -D FOREGROUND & mysqld_safe & tail -f /dev/null"]