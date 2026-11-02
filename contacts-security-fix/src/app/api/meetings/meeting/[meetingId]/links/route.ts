import { NextRequest, NextResponse } from 'next/server';
import { addMeetingLink, deleteMeetingLink } from '@/libs/meetingsRepository';
import { requireUser } from '@/libs/currentUser';

function isValidUuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value);
}

/**
 * POST /api/meetings/meeting/:meetingId/links
 * Body: { reference }. Only the meeting's owner can add links.
 */
export async function POST(
  request: NextRequest,
  { params }: { params: Promise<{ meetingId: string }> }
) {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  const { meetingId } = await params;

  if (!isValidUuid(meetingId)) {
    return NextResponse.json(
      { error: 'Bad Request', message: `"${meetingId}" is not a valid meeting ID.` },
      { status: 400 }
    );
  }

  let body: { reference?: string };
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: 'Bad Request', message: 'Invalid JSON body' }, { status: 400 });
  }

  if (!body.reference?.trim()) {
    return NextResponse.json({ error: 'Bad Request', message: 'reference is required.' }, { status: 400 });
  }

  try {
    const link = await addMeetingLink(meetingId, body.reference.trim(), caller.username);
    if (!link) {
      return NextResponse.json(
        { error: 'Not Found', message: 'Meeting not found, or it is not yours.' }, { status: 404 });
    }
    return NextResponse.json({ data: link }, { status: 201 });
  } catch (err) {
    console.error(`POST /api/meetings/meeting/${meetingId}/links error:`, err);
    return NextResponse.json({ error: 'Internal Server Error', message: 'An unexpected error occurred' }, { status: 500 });
  }
}

/**
 * DELETE /api/meetings/meeting/:meetingId/links
 * Body: { meetingLinkId }. Only the meeting's owner can remove links.
 */
export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ meetingId: string }> }
) {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  const { meetingId } = await params;

  if (!isValidUuid(meetingId)) {
    return NextResponse.json({ error: 'Bad Request', message: 'Invalid meeting ID.' }, { status: 400 });
  }

  let body: { meetingLinkId?: string };
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ error: 'Bad Request', message: 'Invalid JSON body' }, { status: 400 });
  }

  if (!body.meetingLinkId || !isValidUuid(body.meetingLinkId)) {
    return NextResponse.json({ error: 'Bad Request', message: 'A valid meetingLinkId is required.' }, { status: 400 });
  }

  try {
    const deleted = await deleteMeetingLink(meetingId, body.meetingLinkId, caller.username);
    if (!deleted) {
      return NextResponse.json(
        { error: 'Not Found', message: 'Meeting link not found, or it is not yours.' },
        { status: 404 }
      );
    }
    return NextResponse.json({ success: true });
  } catch (err) {
    console.error('DELETE meeting link error:', err);
    return NextResponse.json({ error: 'Internal Server Error', message: 'An unexpected error occurred' }, { status: 500 });
  }
}
