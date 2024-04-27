#!/bin/bash
source php.env
docker exec mysql mysqldump -u root $DATABASE > mysql/init/db.sql
docker compose down
cd mysql
rm -rf data
cd ..
rm -rf logs
rm ./*.env