import { isValidContactId } from '@/libs/contactId';
import { NextRequest, NextResponse } from 'next/server';
import { getNotesByContactId } from '@/libs/notesRepository';
import { requireUser } from '@/libs/currentUser';

/**
 * GET /api/notes/:contactId
 * Returns the signed-in user's OWN private notes for a contact, newest first.
 * Other users' notes are never returned (filtered in SQL).
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
      { error: 'Bad Request', message: `"${contactId}" is not a valid contact ID.` },
      { status: 400 }
    );
  }

  try {
    const notes = await getNotesByContactId(contactId, caller.username);
    return NextResponse.json({ data: notes });
  } catch (err) {
    console.error(`GET /api/notes/${contactId} error:`, err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}
