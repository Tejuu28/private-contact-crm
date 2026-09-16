param([string]$OutputDir = "./backups")
$ErrorActionPreference = "Stop"
if (-not $env:DATABASE_URL) { throw "DATABASE_URL is not set." }
if (-not (Get-Command pg_dump -ErrorAction SilentlyContinue)) { throw "pg_dump is required. Install PostgreSQL client tools first." }
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$out = Join-Path $OutputDir "private-contact-crm-$stamp.dump"
pg_dump --format=custom --no-owner --no-acl --file=$out $env:DATABASE_URL
Write-Host "Backup created: $out"
