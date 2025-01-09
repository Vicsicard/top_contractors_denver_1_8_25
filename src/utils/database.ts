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
  const { data: contractors, error } = await supabase
    .from('contractors')
    .select(`
      *,
      categories!inner(*),
      neighborhoods!inner(
        *,
        subregions!inner(*)
      )
    `)
    .eq('categories.slug', categorySlug)
    .eq('neighborhoods.subregions.slug', subregionSlug)
    .limit(10);

  if (error) {
    console.error('Error fetching contractors:', error);
    throw new Error('Failed to load contractors');
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
