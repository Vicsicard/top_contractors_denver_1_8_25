import { supabase } from './supabase';
import type { CategoryRecord, SubregionRecord, ContractorRecord } from '@/types/database';

export async function getAllTrades(): Promise<CategoryRecord[]> {
  try {
    console.log('Fetching categories from Supabase...');
    const { data: categories, error } = await supabase
      .from('categories')
      .select('*')
      .order('category_name');

    if (error) {
      console.error('Supabase error details:', {
        message: error.message,
        details: error.details,
        hint: error.hint
      });
      throw new Error(`Database error: ${error.message}`);
    }

    if (!categories) {
      console.warn('No categories found in database');
      return [];
    }

    console.log('Successfully fetched categories:', categories);
    return categories;
  } catch (error) {
    console.error('Error in getAllTrades:', error);
    throw new Error('Failed to load categories');
  }
}

export async function getTradeBySlug(slug: string): Promise<CategoryRecord | null> {
  const { data: category, error } = await supabase
    .from('categories')
    .select('*')
    .eq('slug', slug)
    .single();

  if (error) {
    console.error('Error fetching category:', error);
    throw new Error('Failed to load category');
  }

  return category;
}

export async function getAllSubregions(): Promise<SubregionRecord[]> {
  const { data: subregions, error } = await supabase
    .from('subregions')
    .select('*')
    .order('subregion_name');

  if (error) {
    console.error('Error fetching subregions:', error);
    throw new Error('Failed to load subregions');
  }

  return subregions || [];
}

export async function getSubregionBySlug(slug: string): Promise<SubregionRecord | null> {
  const { data: subregion, error } = await supabase
    .from('subregions')
    .select('*')
    .eq('slug', slug)
    .single();

  if (error) {
    console.error('Error fetching subregion:', error);
    throw new Error('Failed to load subregion');
  }

  return subregion;
}

export async function getContractorsByTradeAndSubregion(
  categorySlug: string,
  subregionSlug: string
): Promise<ContractorRecord[]> {
  console.log('[SERVER] Fetching contractors for:', { categorySlug, subregionSlug });

  // First get all categories and subregions to debug
  const { data: allCategories, error: categoriesError } = await supabase
    .from('categories')
    .select('*');
  
  if (categoriesError) {
    console.error('[SERVER] Error fetching categories:', categoriesError);
    return [];
  }

  const { data: allSubregions, error: subregionsError } = await supabase
    .from('subregions')
    .select('*');

  if (subregionsError) {
    console.error('[SERVER] Error fetching subregions:', subregionsError);
    return [];
  }

  console.log('[SERVER] All categories:', allCategories?.map(c => ({ slug: c.slug, id: c.id })));
  console.log('[SERVER] All subregions:', allSubregions?.map(s => ({ slug: s.slug, id: s.id })));

  // First get the category and subregion IDs
  const categoryPromise = supabase
    .from('categories')
    .select('id, slug')
    .eq('slug', categorySlug)
    .single();

  const subregionPromise = supabase
    .from('subregions')
    .select('id, slug')
    .eq('slug', subregionSlug)
    .single();

  const [categoryResult, subregionResult] = await Promise.all([
    categoryPromise,
    subregionPromise
  ]);

  console.log('[SERVER] Category result:', categoryResult);
  console.log('[SERVER] Subregion result:', subregionResult);

  if (categoryResult.error) {
    console.error('[SERVER] Error fetching category:', categoryResult.error);
    return [];
  }

  if (subregionResult.error) {
    console.error('[SERVER] Error fetching subregion:', subregionResult.error);
    return [];
  }

  const category = categoryResult.data;
  const subregion = subregionResult.data;

  if (!category || !subregion) {
    console.error('[SERVER] Category or subregion not found:', { categorySlug, subregionSlug });
    return [];
  }

  console.log('[SERVER] Found IDs:', { categoryId: category.id, subregionId: subregion.id });

  // Then get contractors matching both IDs
  const { data: contractors, error } = await supabase
    .from('contractors')
    .select(`
      *,
      categories(*),
      subregions(*)
    `)
    .eq('category_id', category.id)
    .eq('subregion_id', subregion.id)
    .order('reviews_avg', { ascending: false })
    .limit(10);

  if (error) {
    console.error('[SERVER] Error fetching contractors:', error);
    throw new Error('Failed to load contractors');
  }

  console.log('[SERVER] Found contractors:', contractors?.length || 0);
  if (contractors?.length === 0) {
    console.error('[SERVER] No contractors found for:', { 
      categorySlug, 
      categoryId: category.id,
      subregionSlug,
      subregionId: subregion.id
    });
  }
  return contractors || [];
}

export async function getContractorBySlug(slug: string): Promise<ContractorRecord | null> {
  const { data: contractor, error } = await supabase
    .from('contractors')
    .select(`
      *,
      category:categories(*),
      subregion:subregions(*)
    `)
    .eq('slug', slug)
    .single();

  if (error) {
    console.error('Error fetching contractor:', error);
    throw new Error('Failed to load contractor');
  }

  return contractor;
}
