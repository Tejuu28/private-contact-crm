# Private Contact CRM — Professional V2

A production-oriented private relationship CRM based on the supplied Private Contact CRM requirements and developer handoff specification.

## Included
- Owner Dashboard with relationship-stage analytics
- Secure login and role-aware navigation
- Owner / Data Entry / Restricted Viewer / Manager Viewer roles
- Quick Contact Entry with organization linking
- Owner Review Queue: Approve & Publish or Return for Correction
- Contact Directory with search, status filters and pagination
- Contact Profile with communication channels and follow-ups
- Owner-only interaction timeline and encrypted private notes (AES-256-GCM)
- Follow-up task list and completion workflow
- Users & Roles administration
- Audit Log
- Soft archive/restore endpoints
- Sensitive-contact explicit access checks
- Server-side removal of restricted fields
- Login/API throttling baseline
- PostgreSQL schema + setup scripts
- Render deployment blueprint
- Responsive mobile/tablet/desktop UI

## Role rules
OWNER_ADMIN has full control. DATA_ENTRY can create and submit drafts but cannot browse the directory. RESTRICTED_VIEWER receives approved permitted records only, with private timeline data omitted from the API. MANAGER_VIEWER sees approved directory/dashboard information without private notes.

## Local run
1. PostgreSQL must be running.
2. Run the three `setup-*.sql` files in pgAdmin as described in `START-HERE.md`.
3. Copy `.env.example` to `.env` if custom settings are required.
4. Run `npm install`.
5. Run `npm start`.
6. Open `http://localhost:3000`.

## Production / live deployment
`render.yaml` is included for a managed Node + PostgreSQL deployment. Create the Blueprint in Render and provide the requested production admin password and application origin. The application does not require VS Code Live Server in production.

For production, use a strong unique owner password and keep `JWT_SECRET` generated/secret. Put the application behind HTTPS. Configure backups, retention, monitoring and restore testing before handling real sensitive data.

## Important security note
This is a professional V2 application baseline, not a compliance certification. Before a regulated production launch, complete independent penetration testing, formal 2FA enrollment, password-reset/email delivery, managed key storage/KMS, signed private-file storage, backup/restore drills, retention policy and organization-specific legal/compliance review.
