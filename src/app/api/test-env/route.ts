import { NextRequest, NextResponse } from 'next/server';

export async function GET(_request: NextRequest) {
  const hasApiKey = !!process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY;
  const apiKeyLength = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY?.length || 0;
  const apiKeyValue = process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY 
    ? `${process.env.NEXT_PUBLIC_GOOGLE_PLACES_API_KEY.substring(0, 5)}...` 
    : '';

  const allEnvVars = Object.keys(process.env).sort();
  const apiUrl = 'https://maps.googleapis.com/maps/api/place/textsearch/json';

  return NextResponse.json({
    hasApiKey,
    apiKeyLength,
    apiKeyValue,
    allEnvVars,
    apiUrl
  });
}
