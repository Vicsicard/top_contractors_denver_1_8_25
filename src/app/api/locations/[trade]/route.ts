import { NextResponse } from 'next/server';
import { createSupabaseClient } from '@/lib/supabase/client';

function createTradeSlug(str: string): string {
  return decodeURIComponent(str)
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

export async function GET(
  request: Request,
  { params }: { params: { trade: string } }
) {
  const supabase = createSupabaseClient();

  try {
    // Decode URL parameter
    const decodedTrade = decodeURIComponent(params.trade);
    const processedSlug = createTradeSlug(decodedTrade);

    // Get the trade category details
    const { data: categoryData, error: categoryError } = await supabase
      .from('categories')
      .select('*')
      .eq('slug', processedSlug)
      .single();

    if (categoryError) {
      console.error('Error fetching category:', categoryError);
      return NextResponse.json({ error: 'Trade category not found' }, { status: 404 });
    }

    if (!categoryData) {
      return NextResponse.json({ error: 'Trade category not found' }, { status: 404 });
    }

    // Get all regions that have contractors in this trade
    const { data: regions, error: regionsError } = await supabase
      .from('regions')
      .select('*')
      .order('name');

    if (regionsError) {
      console.error('Error fetching regions:', regionsError);
      return NextResponse.json({ error: regionsError.message }, { status: 500 });
    }

    // Format the response
    const response = {
      trade_category: {
        name: categoryData.name,
        slug: categoryData.slug,
        description: categoryData.description
      },
      regions: regions || []
    };

    return NextResponse.json(response);
  } catch (error) {
    console.error('Error in GET handler:', error);
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    );
  }
}
