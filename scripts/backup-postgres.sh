#!/usr/bin/env bash
set -euo pipefail
: "${DATABASE_URL:?DATABASE_URL is not set}"
command -v pg_dump >/dev/null 2>&1 || { echo "pg_dump is required" >&2; exit 1; }
mkdir -p "${BACKUP_DIR:-./backups}"
stamp=$(date +%Y%m%d-%H%M%S)
out="${BACKUP_DIR:-./backups}/private-contact-crm-${stamp}.dump"
pg_dump --format=custom --no-owner --no-acl --file="$out" "$DATABASE_URL"
echo "Backup created: $out"
