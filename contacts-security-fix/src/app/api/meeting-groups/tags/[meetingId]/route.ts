import { NextRequest, NextResponse } from 'next/server';
import { getMeetingTags, removeMeetingTag } from '@/libs/meetingGroupsRepository';
import { requireUser } from '@/libs/currentUser';

function isValidUuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value);
}

/**
 * GET /api/meeting-groups/tags/:meetingId
 * Returns all group tags for a contact meeting.
 */
export async function GET(
  _request: NextRequest,
  { params }: { params: Promise<{ meetingId: string }> }
) {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  const { meetingId } = await params;

  if (!isValidUuid(meetingId)) {
    return NextResponse.json(
      { error: 'Bad Request', message: 'Invalid meeting ID.' },
      { status: 400 }
    );
  }

  try {
    const tags = await getMeetingTags(meetingId);
    return NextResponse.json({ data: tags });
  } catch (err) {
    console.error(`GET meeting tags error:`, err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}

/**
 * DELETE /api/meeting-groups/tags/:meetingId
 * Body: { tagId, username }
 * Removes a tag — only the user who created the tag can remove it.
 */
export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ meetingId: string }> }
) {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  await params; // meetingId not needed — tagId identifies the row

  let body: { tagId?: string; username?: string };
  try {
    body = await request.json();
  } catch {
    return NextResponse.json(
      { error: 'Bad Request', message: 'Invalid JSON body' },
      { status: 400 }
    );
  }

  if (!body.tagId || !isValidUuid(body.tagId)) {
    return NextResponse.json(
      { error: 'Bad Request', message: 'A valid tagId is required.' },
      { status: 400 }
    );
  }
  if (!caller.username) {
    return NextResponse.json(
      { error: 'Bad Request', message: 'username is required.' },
      { status: 400 }
    );
  }

  try {
    const removed = await removeMeetingTag(body.tagId, caller.username);
    if (!removed) {
      return NextResponse.json(
        { error: 'Forbidden', message: 'You can only remove tags you created.' },
        { status: 403 }
      );
    }
    return NextResponse.json({ success: true });
  } catch (err) {
    console.error('DELETE meeting tag error:', err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}
