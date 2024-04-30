& .\scripts\setup.ps1
docker compose build
docker compose up -d
& .\scripts\db-restore.ps1
