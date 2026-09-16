# Sir साठी Quick Handover

हा folder Private Contact CRM चा live-deployment handover आहे.

### Project folder
`crm_final/`

### Local run
```powershell
cd crm_final
npm install
npm start
```

Browser:
`http://localhost:3000`

Health:
`http://localhost:3000/api/health`

### Live
Hosting administrator ने PostgreSQL + Node service configure करून `render.yaml` review करावा किंवा manual deployment करावा.

### सर्वात महत्त्वाचे
Production मध्ये:
1. Demo credentials वापरू नयेत.
2. नवीन strong JWT secret वापरावा.
3. HTTPS वापरावा.
4. PostgreSQL backup + restore test करावा.
5. Real sensitive data टाकण्यापूर्वी Production Checklist पूर्ण करावी.

Current package मध्ये application functionality तयार आहे; काही advanced production-security requirements स्वतंत्र hardening म्हणून बाकी आहेत. त्यांची यादी `SIR-LIVE-HANDOVER.md` मध्ये दिली आहे.
