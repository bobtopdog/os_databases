import { isValidContactId } from '@/libs/contactId';
import { NextRequest, NextResponse } from 'next/server';
import { getDocumentsByContactId } from '@/libs/documentsRepository';
import { requireUser } from '@/libs/currentUser';

/**
 * GET /api/documents/:contactId
 * Returns metadata for all documents for a contact (no file data).
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
    const documents = await getDocumentsByContactId(contactId);
    return NextResponse.json({ data: documents });
  } catch (err) {
    console.error(`GET /api/documents/${contactId} error:`, err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}
