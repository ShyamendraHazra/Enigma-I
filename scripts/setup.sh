#!/bin/bash

projectName=${PWD##*/};

databaseName=$(echo "$projectName" | tr '-' '_');

echo "HOSTNAME=mysql
USERNAME=root
PASSWORD=""
DATABASE=$databaseName" > php.env;

echo "MYSQL_ALLOW_EMPTY_PASSWORD=1
TZ=Asia/Kolkata" > mysql.env;

mkdir -pv logs/mysql
mkdir -pv logs/php-apache
mkdir -pv logs/phpmyadmin
mkdir -pv mysql/DB-backup