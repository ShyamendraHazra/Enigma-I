#!/bin/bash
./scripts/setup.sh
docker compose up -d
./scripts/db-restore.sh