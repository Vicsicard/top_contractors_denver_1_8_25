import { createClient } from '@/lib/supabase/server'
import { NextRequest } from 'next/server'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const region_slug = searchParams.get('region')
    const subregion_slug = searchParams.get('subregion')
    
    const supabase = await createClient()
    
    if (subregion_slug) {
      // Get neighborhoods for a specific subregion
      const { data: neighborhoods, error: dbError } = await supabase
        .from('neighborhoods')
        .select('*, subregions!inner(*)')
        .eq('subregions.slug', subregion_slug)
        .order('neighborhood_name')
        
      if (dbError) {
        return Response.json({ error: dbError.message }, { status: 500 })
      }
      
      return Response.json({ neighborhoods })
    }
    
    if (region_slug) {
      // Get subregions for a specific region
      const { data: subregions, error: dbError } = await supabase
        .from('subregions')
        .select('*, regions!inner(*)')
        .eq('regions.slug', region_slug)
        .order('subregion_name')
        
      if (dbError) {
        return Response.json({ error: dbError.message }, { status: 500 })
      }
      
      return Response.json({ subregions })
    }
    
    // Get all regions
    const { data: regions, error: dbError } = await supabase
      .from('regions')
      .select('*')
      .order('region_name')
      
    if (dbError) {
      return Response.json({ error: dbError.message }, { status: 500 })
    }
    
    return Response.json({ regions })
    
  } catch (error) {
    // Log the error for debugging purposes
    console.error('Error in locations API:', error);
    return Response.json(
      { error: 'Internal Server Error' },
      { status: 500 }
    )
  }
}
