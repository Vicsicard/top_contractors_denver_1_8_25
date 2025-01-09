import { Client } from "@googlemaps/google-maps-services-js";
import { createClient } from '@supabase/supabase-js';
import { NextResponse } from 'next/server';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

const googleMapsClient = new Client({});

export async function GET() {
  try {
    // Test the Google Places API
    const testResult = await googleMapsClient.placeDetails({
      params: {
        place_id: 'ChIJN1t_tDeuEmsRUsoyG83frY4', // Example place ID
        fields: ['name', 'formatted_address'],
        key: process.env.GOOGLE_PLACES_API_KEY!
      }
    });

    // Test Supabase connection
    const { data: categories, error: categoriesError } = await supabase
      .from('categories')
      .select('*');

    if (categoriesError) {
      throw new Error(`Supabase error: ${categoriesError.message}`);
    }

    return NextResponse.json({
      success: true,
      message: 'APIs working correctly',
      googlePlacesTest: testResult.data,
      categories
    });
  } catch (error) {
    console.error('Error:', error);
    return NextResponse.json({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error'
    }, { status: 500 });
  }
}
