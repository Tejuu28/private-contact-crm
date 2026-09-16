# Sir Demo Guide — Private Contact CRM

## 1. Owner
Login as Owner and demonstrate:
- Dashboard
- Quick Contact Entry
- Contact Directory
- Contact Profile
- Add Interaction
- Owner-only Private Note
- Follow-up
- Review Queue
- Users & Roles
- Audit Log
- Archive / Restore
- CSV Export / Import

## 2. Data Entry
Login as a Data Entry user.
- Existing Contact Directory is unavailable.
- Create a new contact.
- Submit it for Owner review.

## 3. Owner review
Return to Owner:
- Open Review Queue.
- Review the submitted contact.
- Approve & Publish.
- Confirm the contact is now approved/published.

## 4. Restricted Viewer
Login as Restricted Viewer.
- Only permitted approved contacts should appear.
- Open an allowed contact.
- Private notes and private timeline data must not be exposed.

## 5. PostgreSQL proof
In pgAdmin, show the `private_contact_crm` database and these tables:
- contacts
- interactions
- interaction_private_notes
- follow_ups
- users
- audit_events

Useful verification queries are included in the project README / can be run from pgAdmin.
