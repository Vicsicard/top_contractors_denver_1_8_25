import { createClient } from '@/lib/supabase/server'
import { NextRequest } from 'next/server'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const category_slug = searchParams.get('category')
    const neighborhood_slug = searchParams.get('neighborhood')
    const page = parseInt(searchParams.get('page') || '1')
    const limit = parseInt(searchParams.get('limit') || '10')
    const sort_by = searchParams.get('sort_by') || 'reviews_avg'
    
    const offset = (page - 1) * limit
    
    const supabase = await createClient()
    
    let query = supabase
      .from('contractors')
      .select(`
        *,
        categories!inner(*),
        neighborhoods!inner(
          *,
          subregions!inner(
            *,
            regions!inner(*)
          )
        )
      `)
      
    if (category_slug) {
      query = query.eq('categories.slug', category_slug)
    }
    
    if (neighborhood_slug) {
      query = query.eq('neighborhoods.slug', neighborhood_slug)
    }
    
    const { data: contractors, error: dbError, count } = await query
      .order(sort_by === 'name' ? 'contractor_name' : 'reviews_avg', { ascending: sort_by === 'name' })
      .range(offset, offset + limit - 1)
      
    if (dbError) {
      return Response.json({ error: dbError.message }, { status: 500 })
    }
    
    return Response.json({
      contractors,
      page,
      limit,
      total: count || 0,
      hasMore: (count || 0) > offset + limit
    })
    
  } catch (error) {
    // Log the error for debugging purposes
    console.error('Error in contractors API:', error);
    return Response.json(
      { error: 'Internal Server Error' },
      { status: 500 }
    )
  }
}
