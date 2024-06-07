#!/bin/bash
source php.env

echo "Taking backup of previous db.sql file."

backup_time=$(date +%Y-%m-%d_%H-%M-%S)

cp mysql/init/db.sql mysql/DB-backup/$backup_time.sql

echo "Completed backup on $backup_time!";

DB_LIST=$(docker exec mysql mysql -u root -e "SHOW DATABASES;" 2>/dev/null)

if [ $? -ne 0 ]; then

    echo "Error: Unable to connect to MySQL or execute command."
    echo "Exiting..."

else

    if echo "$DB_LIST" | grep -qw "$DATABASE"; then

        old_backup_time=$backup_time
        echo -e "Database '$DATABASE' found.\nCreating latest backup."
        docker exec mysql mysqldump -u root $DATABASE > mysql/init/db.sql
        backup_time=$(date +%Y-%m-%d_%H-%M-%S)
        cp mysql/init/db.sql mysql/DB-backup/$backup_time.sql
        echo "Backup created at $backup_time"
        echo "Exiting..."

    else

        echo "Database '$DATABASE' not found. Defaulting to last Backup at $old_backup_time."
        echo "Exiting..."
    fi 

fi

docker compose down

cd mysql

rm -rf data

cd ..

rm -rf logs

rm ./*.env

echo "Done"