import { createClient } from '@/lib/supabase/server'

export async function GET(): Promise<Response> {
  try {
    const supabase = await createClient()
    
    const { data: categories, error: dbError } = await supabase
      .from('categories')
      .select('*')
      .order('category_name')
      
    if (dbError) {
      return Response.json({ error: dbError.message }, { status: 500 })
    }
    
    return Response.json({ categories })
    
  } catch (error) {
    // Log the error for debugging purposes
    console.error('Error in categories API:', error);
    return Response.json(
      { error: 'Internal Server Error' },
      { status: 500 }
    )
  }
}
