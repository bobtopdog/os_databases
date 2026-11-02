import { NextRequest, NextResponse } from 'next/server';
import { getAllCommunities } from '@/libs/communityPagesRepository';
import { requireUser } from '@/libs/currentUser';

/** GET /api/communities/all?username=xxx — every community, user's own first */
export async function GET(request: NextRequest) {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  const username = caller.username;
  if (!username) {
    return NextResponse.json({ error: 'Bad Request', message: 'username is required.' }, { status: 400 });
  }
  try {
    return NextResponse.json({ data: await getAllCommunities(username) });
  } catch (err) {
    console.error('GET /api/communities/all error:', err);
    return NextResponse.json({ error: 'Internal Server Error', message: 'An unexpected error occurred' }, { status: 500 });
  }
}
