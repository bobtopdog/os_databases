import { NextResponse } from 'next/server';
import { getAllTags } from '@/libs/tagsDdRepository';
import { requireUser } from '@/libs/currentUser';

/**
 * GET /api/teams
 * Returns all teams for the team buttons on the home page.
 */
export async function GET() {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  try {
    const tags = await getAllTags();
    return NextResponse.json({ data: tags });
  } catch (err) {
    console.error('GET /api/tags error:', err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}