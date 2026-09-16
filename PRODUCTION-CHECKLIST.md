# Production Checklist

| Item | Status | Notes |
|---|---|---|
| HTTPS | Ready for hosting | Enable/verify HTTPS on the production host and custom domain. |
| Hosting | Ready | Render/Docker deployment configuration included. |
| PostgreSQL | Ready | Production `DATABASE_URL` must be supplied by the host/provider. |
| Docker | Ready | Dockerfile and compose configuration included. |
| Render Config | Ready | `render.yaml` includes web service + PostgreSQL. |
| Environment Variables | Ready | `.env.example` documents required production values. Never commit real secrets. |
| Backup | Ready for provider setup | Included `scripts/backup-postgres.ps1` and `.sh`; schedule encrypted backups in the production environment and test restore. |
| Monitoring | Ready | `/api/health` reports application/database health and uptime; connect it to host monitoring/alerts. |
| 2FA | Implemented | Owner TOTP 2FA setup/enable/disable and login challenge are implemented. |
| Password Reset | Implemented | Token-based reset flow with 30-minute expiry and Resend email provider support. Configure `RESEND_API_KEY` and `RESET_FROM_EMAIL`. |

## Production security requirements

- Use HTTPS only.
- Set a long random `JWT_SECRET`.
- Set a strong production Owner password; do not use the local demo password.
- Configure `APP_ORIGIN` to the exact HTTPS application origin.
- Configure Resend API credentials if email password reset is required.
- Configure automated encrypted PostgreSQL backups and perform a restore test before storing real CRM data.
- Keep the GitHub repository private and never commit `.env` or production secrets.
- For sensitive files, use private object storage with restricted access in production rather than relying on local ephemeral disk.
- Perform final browser/mobile QA and security/IDOR testing before accepting real sensitive data.
