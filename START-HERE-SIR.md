# Private Contact CRM — Sir Live Handover

## Project folder
After extracting this ZIP, `package.json` is in the main project folder. No `cd crm_final` step is required.

## Local verification
```powershell
npm install
npm start
```
Open: http://localhost:3000

Do not use VS Code Live Server.

## Production
For LIVE deployment, use the included `render.yaml` or deploy the Node.js/Express application to another production server with PostgreSQL.

Required production settings:
- DATABASE_URL
- JWT_SECRET (strong unique secret)
- DEFAULT_ADMIN_EMAIL
- DEFAULT_ADMIN_PASSWORD (strong unique password)
- APP_ORIGIN (production URL)
- HTTPS/SSL
- persistent/private file storage if attachments are enabled
- automated encrypted database backups and restore testing

## Important
The included default admin credentials are for initial setup only. Change the password immediately after first login. Never use local development PostgreSQL credentials in production.

This application is a production-oriented baseline, not a compliance certification. For real sensitive data, complete organizational security review, 2FA, password-reset email, managed secrets/KMS, private object storage, backup/restore drills and independent security testing before launch.
