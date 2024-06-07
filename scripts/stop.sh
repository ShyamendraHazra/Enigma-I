#!/bin/bash
source php.env
cp mysql/db.sql >> mysql/DB-backup/$(date).sql
docker exec mysql mysqldump -u root $DATABASE > mysql/init/db.sql
docker compose down
cd mysql
rm -rf data
cd ..
rm -rf logs
rm ./*.env