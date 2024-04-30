. .\php.env
docker exec mysql mysqldump -u root $env:DATABASE > mysql\init\db.sql
docker compose down
Remove-Item -Path ".\mysql\data" -Recurse -Force
Remove-Item -Path ".\logs" -Recurse -Force
Remove-Item -Path ".\*.env"
