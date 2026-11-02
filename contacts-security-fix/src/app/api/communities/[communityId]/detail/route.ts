import { NextRequest, NextResponse } from 'next/server';
import { getCommunityDetail } from '@/libs/communityPagesRepository';
import { requireUser } from '@/libs/currentUser';

const UUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

/** GET /api/communities/:communityId/detail?username=xxx */
export async function GET(request: NextRequest, { params }: { params: Promise<{ communityId: string }> }) {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  const { communityId } = await params;
  const username = caller.username;
  if (!UUID.test(communityId)) {
    return NextResponse.json({ error: 'Bad Request', message: 'Invalid community ID.' }, { status: 400 });
  }
  try {
    const detail = await getCommunityDetail(communityId, username);
    if (!detail) return NextResponse.json({ error: 'Not Found', message: 'Community not found.' }, { status: 404 });
    return NextResponse.json({ data: detail });
  } catch (err) {
    console.error('GET community detail error:', err);
    return NextResponse.json({ error: 'Internal Server Error', message: 'An unexpected error occurred' }, { status: 500 });
  }
}
