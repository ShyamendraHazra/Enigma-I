#!/bin/bash

source php.env

directory="mysql/init"
filename="db.sql"
retry_interval=5
grace_period=15
echo -e "Waiting for grace period=>$grace_period sec\n"
sleep $grace_period
while true; do
    if [ -e "$directory/$filename" ]; then
        CONTAINER_NAME="mysql"

        if docker ps --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
            if docker cp "$directory/$filename" mysql:/db.sql; then
                if docker exec -i mysql mysql -uroot -e "CREATE DATABASE IF NOT EXISTS \`$DATABASE\`;" &&
                docker exec -i mysql mysql -uroot $DATABASE < "$directory/$filename"; then
                    echo "Database imported successfully."
                    break
                else
                    echo "Error: Failed to import database. Retrying in $retry_interval seconds..."
                    sleep $retry_interval
                fi
            else
                echo "Error: Failed to copy database file to container. Retrying in $retry_interval seconds..."
                sleep $retry_interval
            fi
        else
            echo "Error: MySQL container $CONTAINER_NAME is not running."
            break
        fi
    else
        echo "Error: Database file $filename not found in directory $directory."
        exit 1
    fi
done
