# Security fix: identity from the session, not the request

## What was wrong

| Problem | Effect | Where |
|---|---|---|
| Writes trusted `username` (or `taggedBy` / `requestingUser`) from the request body, query string or form data | Any signed-in user could create, edit or delete as someone else. The SQL ownership checks compared against the name the caller sent, so they protected nothing | 50 route files: notes, anex notes, meetings, documents, links, PoCs, tags, areas, highlight notes, minister notes and meetings, communities, email groups, profile teams, team details |
| `GET /api/notes/mynotes/[userName]` and `/api/meetings/mymeetings/[userName]` used the name in the URL | Anyone could read anyone's private notes and meetings by changing the URL | 2 routes |
| `GET /api/notes/[contactId]` returned **every user's** private notes for the contact; only the UI hid them | Everyone's private notes were visible in the browser's network tab | route + `notesRepository.getNotesByContactId` |
| Meeting document links had no ownership check at all | Anyone could add or remove links on anyone's meeting | `meetings/meeting/[meetingId]/links` + `meetingsRepository` |
| Most routes didn't check for a session | API calls worked without signing in, unless the middleware blocked `/api` | all routes |

## The fix

- **New `src/libs/currentUser.ts`.** `requireUser()` reads the username from the NextAuth session cookie. The cookie is encrypted and signed with `NEXTAUTH_SECRET`, so it can't be forged. With no session, it returns 401.
- **Every route handler** (except `/api/auth` and the admin routes, which already use `requireAdmin()`) now starts with:
  ```ts
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  ```
- **Identity:** wherever a route took the acting user's name from the request, it now uses `caller.username`. Names of *other* people are still read from the request where that's the point of the call, e.g. `newMemberUsername` when adding someone to a community.
- **`mynotes` / `mymeetings`:** the name in the URL is ignored, so you can only list your own.
- **Contact private notes:** `getNotesByContactId(contactId, username)` filters in SQL (`AND username = $2`).
- **Meeting links:** `addMeetingLink` / `deleteMeetingLink` only succeed on the caller's own meeting, and return 404 otherwise. Signatures changed (the links route is the only caller).
- **About me:** now uses the same helper; the behaviour is unchanged.

**Not changed:** the database, all UI components, and `api.ts`. The client still sends `username` in bodies and URLs; it is simply ignored, so nothing breaks while this rolls out. You can remove those fields from `api.ts` later as a tidy-up.

Verified: type-checked clean (strict) for all API routes and libs. The new SQL was tested against a real Postgres engine: a non-owner adding or deleting a meeting link affects 0 rows, while the owner affects 1, and each user sees only their own private notes.

## Files (86)

Copy `src/` over your project's `src/`. `security-fix.diff` shows every change against the files you sent, so review it first if you've edited any of them since.

⚠️ **`src/app/api/meetings/meeting/[meetingId]/links/route.ts` wasn't in the zip you sent.** I rebuilt it from your earlier upload. Diff it against your current file before replacing.

## Before you deploy, check

1. **Server code calling your own API over HTTP.** A server component that does `fetch('/api/notes/…')` or uses an `api.ts` function sends no cookie, so it now gets a 401. Search your pages:
   ```
   grep -rln "from '@/libs/api'\|from '@/libs/communitiesApi'\|from '@/libs/communityPagesApi'\|from '@/libs/meetingGroupsApi'\|from '@/libs/userProfileApi'\|from '@/libs/ministers/api'" src/app --include=page.tsx
   ```
   For each hit without `'use client'`, call the repository function directly instead (it's the same app), passing the session username from `getServerSession`.
2. **Private notes now really are private.** The contact page's private notes section will show only your own notes. If it ever showed other people's, which was the bug, that stops.
3. **Minister notes:** `GET /api/ministernotes/[memberId]` returns every user's notes for a minister. If minister notes are meant to be private like contact notes, they need the same SQL filter. Tell me and I'll add it.
4. **The middleware matcher.** It doesn't matter for safety any more, since every route checks the session itself.

## Test after deploying (5 minutes, browser dev tools → Console)

```js
// 1. Impersonation: should save under YOUR name, not "someone.else"
await fetch('/api/notes', { method: 'POST', headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ contactId: '<a contact id>', username: 'someone.else', comment: 'test' }) }).then(r => r.json())

// 2. Private notes by URL: should return YOUR notes, whatever name is in the URL
await fetch('/api/notes/mynotes/someone.else').then(r => r.json())

// 3. Signed out (private window, or curl): any API route should give 401
```

## Spotted, not changed

- `areasRepository.deleteArea` deletes `WHERE tag_id = $1`, but the table's key is `area_id`. Unless `contact_areas` really has a `tag_id` column, removing an area currently fails with a 500. It's probably a copy-paste from the tags repository; check and change it to `area_id`.
- `notesRepository.moveNote1` has no ownership check. It appears unused (the routes use `moveNote`), so delete it.
- `src/libs/api copy.ts` is a stray copy; delete it.
