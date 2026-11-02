import { isValidContactId } from '@/libs/contactId';
import { NextRequest, NextResponse } from 'next/server';
import { getHighlightsByContactId } from '@/libs/highlightsRepository';
import { requireUser } from '@/libs/currentUser';

/**
 * GET /api/highlights/:contactId
 * Returns all highlights for a given contact 
 */
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
    const highlights = await getHighlightsByContactId(contactId);
    return NextResponse.json({ data: highlights });
  } catch (err) {
    console.error(`GET /api/headlines/${contactId} error:`, err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}
