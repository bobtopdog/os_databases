import { NextResponse } from 'next/server';
import { getAllTeams } from '@/libs/teamsRepository';
import { requireUser } from '@/libs/currentUser';

/**
 * GET /api/teams
 * Returns all teams for the team buttons on the home page.
 */
export async function GET() {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  try {
    const teams = await getAllTeams();
    return NextResponse.json({ data: teams });
  } catch (err) {
    console.error('GET /api/teams error:', err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}
