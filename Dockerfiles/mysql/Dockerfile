FROM mysql:latest as mysql
RUN mkdir -p /var/log/mysql /var/lib/mysql && \
    chown -R enigma_user_one:enigma_user_one /var/log/mysql /var/lib/mysql
COPY ./mysql/mysql.conf/my.cnf /etc/my.cnf