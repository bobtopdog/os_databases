import { isValidContactId } from '@/libs/contactId';
import { NextRequest, NextResponse } from 'next/server';
import { getNotesByContactId } from '@/libs/highlightNotesRepository';
import { requireUser } from '@/libs/currentUser';


/**
 * GET /api/anexnotes/:contactId
 * Returns all notes for a given contact from the notes database, newest first.
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
    const notes = await getNotesByContactId(contactId);
    return NextResponse.json({ data: notes });
  } catch (err) {
    console.error(`GET /api/highlightnotes/${contactId} error:`, err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}
