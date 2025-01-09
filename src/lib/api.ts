import { api } from './axios'

// Types
export interface Contractor {
  id: string
  contractor_name: string
  email: string
  phone: string
  description: string
  reviews_avg: number
  slug: string
  categories: Category[]
  neighborhoods: Neighborhood[]
}

export interface Category {
  id: string
  category_name: string
  slug: string
}

export interface Neighborhood {
  id: string
  neighborhood_name: string
  slug: string
  subregions: Subregion[]
}

export interface Subregion {
  id: string
  subregion_name: string
  slug: string
  regions: Region[]
}

export interface Region {
  id: string
  region_name: string
  slug: string
}

export interface ContractorsQueryParams {
  page?: number
  limit?: number
  sort_by?: 'name'
  category?: string
  region?: string
  subregion?: string
  neighborhood?: string
}

// API functions
export const contractorsApi = {
  // Get all contractors with optional filtering
  getContractors: async (params?: ContractorsQueryParams) => {
    const { data } = await api.get<{
      contractors: Contractor[]
      page: number
      limit: number
      total: number
      hasMore: boolean
    }>('/contractors', { params })
    return data
  },

  // Get a single contractor by slug
  getContractor: async (slug: string) => {
    const { data } = await api.get<Contractor>(`/contractors/${slug}`)
    return data
  },

  // Create a new contractor
  createContractor: async (contractor: {
    contractor_name: string
    email: string
    phone: string
    description: string
    categories?: string[]
    neighborhoods?: string[]
  }) => {
    const { data } = await api.post<Contractor>('/contractors', contractor)
    return data
  },

  // Update a contractor
  updateContractor: async (slug: string, contractor: Partial<Contractor>) => {
    const { data } = await api.patch<Contractor>(`/contractors/${slug}`, contractor)
    return data
  },

  // Delete a contractor
  deleteContractor: async (slug: string) => {
    await api.delete(`/contractors/${slug}`)
  },

  // Search contractors
  searchContractors: async (params: {
    query: string
    category?: string
    region?: string
    subregion?: string
    neighborhood?: string
    min_rating?: number
    page?: number
    limit?: number
  }) => {
    const { data } = await api.get<{
      contractors: Contractor[]
      page: number
      limit: number
      total: number
      hasMore: boolean
    }>('/search', { params })
    return data
  },
}

export const categoriesApi = {
  // Get all categories
  getCategories: async () => {
    const { data } = await api.get<{ categories: Category[] }>('/categories')
    return data
  },
}

export const locationsApi = {
  // Get all regions
  getRegions: async () => {
    const { data } = await api.get<{ regions: Region[] }>('/locations')
    return data
  },

  // Get subregions for a region
  getSubregions: async (regionSlug: string) => {
    const { data } = await api.get<{ subregions: Subregion[] }>('/locations', {
      params: { region: regionSlug },
    })
    return data
  },

  // Get neighborhoods for a subregion
  getNeighborhoods: async (subregionSlug: string) => {
    const { data } = await api.get<{ neighborhoods: Neighborhood[] }>('/locations', {
      params: { subregion: subregionSlug },
    })
    return data
  },
}
