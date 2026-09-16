# Private Contact CRM — Live Handover

## 1. Purpose
This package is the final application handover for live deployment of the Private Contact CRM.

The application uses:
- Node.js + Express
- PostgreSQL
- HTML/CSS/JavaScript frontend
- JWT authentication
- Role-based authorization

## 2. Important
The application is prepared for deployment, but the hosting administrator must configure the production environment, domain, HTTPS, PostgreSQL credentials, secrets, backups and email/storage providers before entering real sensitive business data.

This package is **not a compliance certification** and does not by itself provide a completed security audit or penetration test.

## 3. Recommended live architecture
Browser → HTTPS → Node/Express Web Service → PostgreSQL

For uploaded private files, use private object storage with signed URLs rather than a publicly accessible uploads directory.

## 4. Environment variables
Copy `.env.example` to `.env` for a local/controlled server deployment and set real values.

Minimum production values:
- `DATABASE_URL` — production PostgreSQL connection string
- `JWT_SECRET` — long random production secret; never reuse a demo secret
- `PORT` — hosting platform port or 3000 where applicable
- `APP_ORIGIN` — exact HTTPS domain of the CRM
- production admin credentials/settings as supported by the application

Never commit `.env` to Git.

## 5. PostgreSQL
The included setup SQL files are:
- `setup-01-create-user.sql`
- `setup-02-create-database.sql`
- `setup-03-grant-schema.sql`

For a live server, the hosting administrator should create a dedicated PostgreSQL role/database and use a strong unique password. Do not use the example `crm_password` in production.

The application schema is in `server/schema.sql`.

## 6. Local verification before deployment
From the project root:

```powershell
npm install
npm start
```

Open:

`http://localhost:3000`

Health check:

`http://localhost:3000/api/health`

Expected result includes `ok: true` and a working database connection.

Do not use VS Code Live Server for this application.

## 7. Live deployment on Render
1. Put the project in a private GitHub repository, or use the hosting provider's supported deployment method.
2. Create the Node web service from the repository.
3. Create/connect PostgreSQL.
4. Configure the production environment variables.
5. Set the application start command to `npm start`.
6. Use the production PostgreSQL connection string supplied by the provider.
7. Deploy.
8. Open the generated HTTPS URL.
9. Verify `/api/health`.
10. Change the initial Owner/Admin password immediately.
11. Configure the final custom domain and HTTPS if required.

The included `render.yaml` is provided as deployment configuration, but the Sir/hosting administrator must review environment values, service sizing, database plan, domain and billing before deployment.

## 8. First live security checklist
Before real data is entered:
- Replace all demo/default credentials.
- Generate a unique high-entropy `JWT_SECRET`.
- Confirm HTTPS only.
- Confirm PostgreSQL is not publicly exposed unnecessarily.
- Confirm production CORS/origin settings.
- Confirm backups are enabled.
- Perform a restore test.
- Confirm logs do not expose passwords, tokens or private notes.
- Confirm Owner/Data Entry/Restricted Viewer permissions with separate test accounts.
- Confirm non-owner export is denied.
- Confirm private notes are absent from non-owner API responses.
- Confirm archived records cannot be accessed through normal directory routes.

## 9. Current application functionality
Included in this handover:
- Owner / Data Entry / Restricted Viewer / Manager Viewer roles
- Login and role-based authorization
- Contact creation and review workflow
- Owner approval and publishing
- Contact directory search/status filtering
- Permission-aware contact profile
- Owner-only interactions and private notes
- Follow-ups/tasks
- Review queue
- Archive/restore
- Duplicate warning/check
- Owner CSV export
- Owner CSV import preview/commit
- Users & Roles
- Audit log, including denied access attempts
- Password change
- Session expiry baseline
- Helmet/security headers
- Rate limiting baseline
- PostgreSQL persistence
- Health endpoint
- Render deployment configuration

## 10. Items requiring final production hardening
The source specification contains additional requirements that are not fully implemented in this delivery and should be completed before a high-security production rollout:
- Real 2FA flow for Owner
- Real password-reset email flow/provider
- XLSX/Excel-native import if required instead of CSV
- Full contact merge workflow
- Full geography/country/state/city data model and filters
- Complete attachment-to-contact/interaction persistence and private object storage integration
- Automated encrypted production backups and scheduled restore drills
- Production monitoring/alerting
- Independent security/IDOR/penetration testing
- Legal/privacy/retention/consent review
- Final browser/mobile QA on the production domain

Optional OCR, WhatsApp, email/calendar and AI integrations are not enabled in this first live package.

## 11. Handover rule
Sir should deploy this package only after reviewing the production-hardening items above. For a college/institutional pilot, the current application can be deployed after the environment and credential checks. For sensitive real-world data, complete the listed hardening first.
