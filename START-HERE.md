# Private Contact CRM — Start Here

## Local Windows + pgAdmin

1. Connect to PostgreSQL in pgAdmin as `postgres`.
2. Run `setup-01-create-user.sql` once to create/reset the `crm` database user.
3. Run `setup-02-create-database.sql`. If `private_contact_crm` already exists, skip it.
4. Select the `private_contact_crm` database and run `setup-03-grant-schema.sql`.
5. Open PowerShell in this project folder.
6. Run:

```powershell
npm install
npm start
```

7. Keep that PowerShell window running.
8. Open only:

`http://localhost:3000`

Do not use VS Code Live Server for the normal application run.

## Default local Owner

Email: `admin@privatecrm.local`
Password: `Admin@12345`

Change the password immediately from the user menu after first login.

## Live deployment

Use the included `render.yaml` as the deployment blueprint. The hosting provider still needs an account, billing/plan selection and the production Owner password; these are hosting credentials, not source-code changes.

## Expected workflow

Data Entry → Quick Entry → Submit for Owner Review → Owner → Review Queue → Review → Approve & Publish → Contact Directory.

Approval never deletes the contact. A returned record goes back to DRAFT for correction. Archived records are soft-deleted and can be restored by Owner.


Profile route QA fix: contact profile now uses explicit role-safe queries and validates UUID before querying.
