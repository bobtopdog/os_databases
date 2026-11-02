import { NextResponse } from 'next/server';
import { getOutcomeTree } from '@/libs/outcomeRepository';
import { requireUser } from '@/libs/currentUser';

/** GET /api/lookups/outcomes — the full outcome → sub-outcome tree */
export async function GET() {
  const caller = await requireUser();
  if ('response' in caller) return caller.response;
  try {
    return NextResponse.json({ data: await getOutcomeTree() });
  } catch (err) {
    console.error('GET /api/lookups/outcomes error:', err);
    return NextResponse.json(
      { error: 'Internal Server Error', message: 'An unexpected error occurred' },
      { status: 500 }
    );
  }
}
