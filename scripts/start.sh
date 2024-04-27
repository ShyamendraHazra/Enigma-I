#!/bin/bash
./scripts/setup.sh
docker compose build
docker compose up -d
./scripts/db-restore.sh
