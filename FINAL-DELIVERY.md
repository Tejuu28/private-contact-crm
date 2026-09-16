# Private Contact CRM — Final Delivery

## What is included
- Role-based login: Owner Admin, Data Entry, Restricted Viewer, Manager Viewer
- PostgreSQL persistence
- Contact capture, review, approve/publish, activate
- Contact directory with search and relationship status filter
- Contact profile with permission-aware fields
- Owner-only interaction timeline and encrypted private notes
- Follow-ups with due dates, priorities and completion
- Review Queue and return-for-correction workflow
- Soft archive and Owner-only restore area
- Duplicate warning that does not disclose matching contact details
- Owner-only CSV export with audit event
- Owner-only CSV import preview and commit (up to 100 preview rows / 1000 commit rows)
- Users & Roles administration
- Audit Log, including denied endpoint attempts
- Session expiry and password change
- API rate limiting baseline, Helmet, server-side authorization
- Render deployment blueprint and PostgreSQL setup scripts

## Local run
1. Install Node.js LTS and PostgreSQL.
2. Create the `crm` PostgreSQL role/database using the included setup SQL files if not already created.
3. Open PowerShell in this folder.
4. Run `npm install`.
5. Run `npm start`.
6. Open `http://localhost:3000`.

Default local Owner:
- Email: `admin@privatecrm.local`
- Password: `Admin@12345`

Change the password immediately for any real use.

## Database
Database: `private_contact_crm`
Main tables include contacts, contact_channels, organizations, interactions, interaction_private_notes, follow_ups, users, record_access, attachments and audit_events.

## Important production note
This package is a complete demo / V1 application build and is suitable for presenting the implemented workflow. It is **not a compliance certification** and should not be treated as a fully hardened production deployment for highly sensitive personal data until the organization configures and verifies:
- HTTPS/TLS and managed production secrets
- Owner 2FA and a real password-reset/email provider
- Managed encryption keys/KMS rather than deriving note encryption from JWT secret
- Private object storage with signed/time-limited attachment URLs
- Automated encrypted daily backups and a documented restore drill
- Production monitoring, alerts and log retention
- Penetration/security testing and legal/privacy retention/consent review
- Mobile and browser QA at the final hosting environment

Optional integrations such as OCR, WhatsApp, email/calendar and AI are intentionally not enabled in the core V1 build, consistent with the supplied specification.
