import { createClient } from '@/lib/supabase/server'
import { NextRequest } from 'next/server'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const query = searchParams.get('query') || ''
    const category = searchParams.get('category')
    const region = searchParams.get('region')
    const subregion = searchParams.get('subregion')
    const neighborhood = searchParams.get('neighborhood')
    const min_rating = parseFloat(searchParams.get('min_rating') || '0')
    const page = parseInt(searchParams.get('page') || '1')
    const limit = parseInt(searchParams.get('limit') || '10')
    
    const offset = (page - 1) * limit
    
    const supabase = await createClient()
    
    let dbQuery = supabase
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
      .ilike('contractor_name', `%${query}%`)
      .gte('reviews_avg', min_rating)
      
    if (category) {
      dbQuery = dbQuery.eq('categories.slug', category)
    }
    
    if (neighborhood) {
      dbQuery = dbQuery.eq('neighborhoods.slug', neighborhood)
    } else if (subregion) {
      dbQuery = dbQuery.eq('neighborhoods.subregions.slug', subregion)
    } else if (region) {
      dbQuery = dbQuery.eq('neighborhoods.subregions.regions.slug', region)
    }
    
    const { data: contractors, error: dbError, count } = await dbQuery
      .order('reviews_avg', { ascending: false })
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
    console.error('Error in search API:', error);
    return Response.json(
      { error: 'Internal Server Error' },
      { status: 500 }
    )
  }
}
