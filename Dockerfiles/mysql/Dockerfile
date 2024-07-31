FROM mysql:latest as mysql
COPY ./mysql/mysql.conf /etc/my.cnf.custom
RUN cat /etc/my.cnf.custom/my.cnf > /etc/my.cnf