CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE TABLE IF NOT EXISTS users (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), email varchar(254) UNIQUE NOT NULL, password_hash text NOT NULL,
 full_name varchar(150) NOT NULL, role_code varchar(30) NOT NULL CHECK(role_code IN ('OWNER_ADMIN','DATA_ENTRY','RESTRICTED_VIEWER','MANAGER_VIEWER')),
 is_active boolean NOT NULL DEFAULT true, two_factor_enabled boolean NOT NULL DEFAULT false, two_factor_secret text, password_reset_token_hash text, password_reset_expires_at timestamptz, created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS organizations (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), name varchar(200) NOT NULL, organization_type varchar(40), industry varchar(80), website_url varchar(500), notes text,
 is_sensitive boolean NOT NULL DEFAULT false, created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS contacts (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), contact_code varchar(30) UNIQUE NOT NULL, title_code varchar(20), first_name varchar(100) NOT NULL, middle_name varchar(100), last_name varchar(100), preferred_name varchar(100), photo_path text,
 organization_id uuid REFERENCES organizations(id), designation varchar(150), department varchar(150), industry_code varchar(50), category varchar(100) NOT NULL, subcategory varchar(100), tags text[] NOT NULL DEFAULT '{}', source_code varchar(50) NOT NULL DEFAULT 'MANUAL', source_detail varchar(250), referred_by_contact_id uuid REFERENCES contacts(id), owner_user_id uuid NOT NULL REFERENCES users(id), visibility_group text, is_sensitive boolean NOT NULL DEFAULT false,
 relationship_status varchar(40) NOT NULL DEFAULT 'NOT_CONTACTED', priority_code varchar(20) NOT NULL DEFAULT 'NORMAL', health_code varchar(20) DEFAULT 'GOOD', first_connected_at timestamptz, last_interaction_at timestamptz, next_follow_up_at timestamptz,
 marketing_consent boolean NOT NULL DEFAULT false, do_not_contact boolean NOT NULL DEFAULT false, do_not_contact_reason varchar(250), lifecycle_status varchar(30) NOT NULL DEFAULT 'DRAFT', created_by uuid NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now(), updated_by uuid REFERENCES users(id), updated_at timestamptz NOT NULL DEFAULT now(), deleted_at timestamptz, row_version integer NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS contact_channels (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), contact_id uuid NOT NULL REFERENCES contacts(id) ON DELETE CASCADE, channel_type varchar(30) NOT NULL, label varchar(50), raw_value varchar(300) NOT NULL, normalized_value varchar(300) NOT NULL, is_primary boolean NOT NULL DEFAULT false, is_verified boolean NOT NULL DEFAULT false, consent_status varchar(20) NOT NULL DEFAULT 'UNKNOWN', created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS record_access (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), contact_id uuid NOT NULL REFERENCES contacts(id) ON DELETE CASCADE, user_id uuid REFERENCES users(id) ON DELETE CASCADE, access_level varchar(20) NOT NULL DEFAULT 'READ', UNIQUE(contact_id,user_id)
);
CREATE TABLE IF NOT EXISTS interactions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), contact_id uuid NOT NULL REFERENCES contacts(id) ON DELETE CASCADE, organization_id uuid REFERENCES organizations(id), occurred_at timestamptz NOT NULL, channel_code varchar(30) NOT NULL, subject varchar(250) NOT NULL, outcome_code varchar(40) NOT NULL, summary varchar(500), relationship_status_after varchar(40), created_by uuid NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now(), row_version integer NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS interaction_private_notes (
 interaction_id uuid PRIMARY KEY REFERENCES interactions(id) ON DELETE CASCADE, encrypted_note text NOT NULL, created_by uuid NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS follow_ups (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), contact_id uuid NOT NULL REFERENCES contacts(id) ON DELETE CASCADE, interaction_id uuid REFERENCES interactions(id), title varchar(180) NOT NULL, description text, due_at timestamptz NOT NULL, remind_at timestamptz, priority_code varchar(20) NOT NULL DEFAULT 'NORMAL', assigned_to uuid NOT NULL REFERENCES users(id), status_code varchar(20) NOT NULL DEFAULT 'OPEN', completed_at timestamptz, completion_note varchar(500), created_by uuid NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS attachments (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), contact_id uuid REFERENCES contacts(id) ON DELETE CASCADE, interaction_id uuid REFERENCES interactions(id) ON DELETE CASCADE, original_name text NOT NULL, storage_path text NOT NULL, mime_type varchar(120), created_by uuid NOT NULL REFERENCES users(id), created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS audit_events (
 id bigserial PRIMARY KEY, actor_user_id uuid REFERENCES users(id), action varchar(80) NOT NULL, resource_type varchar(80), resource_id text, metadata jsonb NOT NULL DEFAULT '{}', ip_address inet, created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_contacts_status ON contacts(relationship_status);
CREATE INDEX IF NOT EXISTS idx_contacts_owner ON contacts(owner_user_id);
CREATE INDEX IF NOT EXISTS idx_contacts_category ON contacts(category);
CREATE INDEX IF NOT EXISTS idx_contacts_next_follow ON contacts(next_follow_up_at);
CREATE INDEX IF NOT EXISTS idx_channels_norm ON contact_channels(normalized_value);
CREATE INDEX IF NOT EXISTS idx_contacts_created ON contacts(created_at);
CREATE INDEX IF NOT EXISTS idx_followups_due ON follow_ups(due_at,status_code);
CREATE INDEX IF NOT EXISTS idx_audit_created ON audit_events(created_at);

-- Read-only duplicate candidates view used by the dashboard. It never exposes private notes.
CREATE OR REPLACE VIEW duplicate_candidates AS
SELECT min(c.id::text)::text AS candidate_key,
       min(c.first_name) AS first_name,
       min(c.last_name) AS last_name,
       min(o.name) AS organization,
       count(*)::int AS duplicate_count
FROM contacts c LEFT JOIN organizations o ON o.id=c.organization_id
WHERE c.deleted_at IS NULL
GROUP BY lower(trim(c.first_name)), lower(trim(coalesce(c.last_name,''))), lower(trim(coalesce(o.name,'')))
HAVING count(*) > 1;
