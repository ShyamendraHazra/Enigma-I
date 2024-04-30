$directory = "mysql\init"
$filename = "db.sql"
$retry_interval = 10
$grace_period = 15

Write-Output "Waiting for grace period => $grace_period sec"
Start-Sleep -Seconds $grace_period

while ($true) {
    if (Test-Path "$directory\$filename") {
        $CONTAINER_NAME = "mysql"

        if ((docker ps --format '{{.Names}}' | Select-String -Pattern "^$CONTAINER_NAME$").Count -gt 0) {
            docker cp "$directory\$filename" mysql:/db.sql
            if ($LastExitCode -eq 0) {
                $databaseContent = Get-Content "$directory\$filename" | Out-String
                $createDBResult = docker exec -i mysql mysql -uroot -e "CREATE DATABASE IF NOT EXISTS $env:DATABASE;" 2>&1
                if ($createDBResult -match "database exists" -or !$createDBResult) {
                    $importDBResult = docker exec -i mysql mysql -uroot "$env:DATABASE" -e $databaseContent 2>&1
                    if (!$importDBResult) {
                        Write-Output "Database imported successfully."
                        break
                    } else {
                        Write-Output "Error: Failed to import database. Retrying in $retry_interval seconds..."
                        Start-Sleep -Seconds $retry_interval
                    }
                } else {
                    Write-Output "Error: $createDBResult. Retrying in $retry_interval seconds..."
                    Start-Sleep -Seconds $retry_interval
                }
            } else {
                Write-Output "Error: Failed to copy database file to container. Retrying in $retry_interval seconds..."
                Start-Sleep -Seconds $retry_interval
            }
        } else {
            Write-Output "Error: MySQL container $CONTAINER_NAME is not running."
            break
        }
    } else {
        Write-Output "Error: Database file $filename not found in directory $directory."
        exit 1
    }
}
