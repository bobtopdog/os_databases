// SERVER ONLY — the signed-in user, taken from the NextAuth session cookie.
//
// Route handlers must use this for "who is doing this?" and NEVER a
// username from the request body, query string or URL: those are typed by
// the caller and can be anything. The session cookie is encrypted and
// signed with NEXTAUTH_SECRET, so it can't be forged.

import { getServerSession } from 'next-auth';
import { NextResponse } from 'next/server';
import { authOptions } from '@/app/api/auth/[...nextauth]/route';

/** The signed-in user's username, or null when there is no session. */
export async function getCurrentUsername(): Promise<string | null> {
  const session = await getServerSession(authOptions);
  const username = (session?.user as { username?: string } | undefined)?.username?.trim();
  return username || null;
}

/**
 * Use at the top of every route handler:
 *
 *   const caller = await requireUser();
 *   if ('response' in caller) return caller.response;
 *   // caller.username is trustworthy from here on
 */
export async function requireUser(): Promise<{ username: string } | { response: NextResponse }> {
  const username = await getCurrentUsername();
  if (!username) {
    return {
      response: NextResponse.json(
        { error: 'Unauthorized', message: 'Please sign in.' },
        { status: 401 }
      ),
    };
  }
  return { username };
}
