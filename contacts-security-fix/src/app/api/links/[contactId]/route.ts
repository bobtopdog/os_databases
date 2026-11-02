import { isValidContactId } from '@/libs/contactId';
import { NextRequest, NextResponse } from 'next/server';
import { getLinksByContactId } from '@/libs/linksRepository';
import { requireUser } from '@/libs/currentUser';

/** GET /api/links/:contactId — all links for a contact, with outcome ids */
export async function GET(
  _request: NextRequest,
  { params }: { params: Promise<{ contactId: string }> }
) {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  const { contactId } = await params;
  if (!isValidContactId(contactId)) {
    return NextResponse.json(
      { error: 'Bad Request', message: 'Invalid contact ID.' }, { status: 400 });
  }

  try {
    return NextResponse.json({ data: await getLinksByContactId(contactId) });
  } catch (err) {
    console.error(`GET /api/links/${contactId} error:`, err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 });
  }
}
