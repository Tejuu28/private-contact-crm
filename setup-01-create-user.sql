-- Run this in pgAdmin Query Tool while connected as the PostgreSQL administrator.
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'crm') THEN
    CREATE ROLE crm LOGIN PASSWORD 'crm_password';
  ELSE
    ALTER ROLE crm WITH LOGIN PASSWORD 'crm_password';
  END IF;
END $$;
