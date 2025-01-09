// Database record types that exactly match our Supabase schema
export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      categories: {
        Row: {
          id: string
          category_name: string
          slug: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          category_name: string
          slug: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          category_name?: string
          slug?: string
          created_at?: string
          updated_at?: string
        }
      }
      subregions: {
        Row: {
          id: string
          subregion_name: string
          slug: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          subregion_name: string
          slug: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          subregion_name?: string
          slug?: string
          created_at?: string
          updated_at?: string
        }
      }
      contractors: {
        Row: {
          id: string
          category_id: string
          subregion_id: string
          contractor_name: string
          address: string
          phone: string
          website: string | null
          reviews_avg: number
          reviews_count: number
          slug: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          category_id: string
          subregion_id: string
          contractor_name: string
          address: string
          phone: string
          website?: string | null
          reviews_avg: number
          reviews_count: number
          slug: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          category_id?: string
          subregion_id?: string
          contractor_name?: string
          address?: string
          phone?: string
          website?: string | null
          reviews_avg?: number
          reviews_count?: number
          slug?: string
          created_at?: string
          updated_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
  }
}

// Convenience types
export type CategoryRecord = Database['public']['Tables']['categories']['Row']
export type SubregionRecord = Database['public']['Tables']['subregions']['Row']
export type ContractorRecord = Database['public']['Tables']['contractors']['Row']

// Extended types for joined queries
export interface ContractorWithRelations extends ContractorRecord {
  category: CategoryRecord
  subregion: SubregionRecord
}
