-- After opening the private_contact_crm database in pgAdmin, run this as postgres/admin.
CREATE EXTENSION IF NOT EXISTS pgcrypto;
GRANT ALL ON SCHEMA public TO crm;
ALTER SCHEMA public OWNER TO crm;
