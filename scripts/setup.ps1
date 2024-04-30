$projectName = (Get-Item -Path ".\").Name.Replace("-", "_")

@"
HOSTNAME=mysql
USERNAME=root
PASSWORD=""
DATABASE=$projectName
"@ | Set-Content -Path "php.env"

@"
MYSQL_ALLOW_EMPTY_PASSWORD=1
TZ=Asia/Kolkata
"@ | Set-Content -Path "mysql.env"

New-Item -ItemType Directory -Force -Path ".\logs\mysql"
New-Item -ItemType Directory -Force -Path ".\logs\php-apache"
New-Item -ItemType Directory -Force -Path ".\logs\phpmyadmin"
