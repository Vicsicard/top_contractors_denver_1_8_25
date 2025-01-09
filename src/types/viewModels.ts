// View model types that closely match our database schema while being UI-friendly
export interface ContractorViewModel {
  id: string;
  name: string;           // from contractor_name
  address: string;
  phone: string;
  website: string | null;
  rating: number;         // from reviews_avg
  reviewCount: number;    // from reviews_count
  slug: string;
}

export interface CategoryViewModel {
  id: string;
  name: string;          // from category_name
  slug: string;
  contractors?: ContractorViewModel[];
}

export interface RegionViewModel {
  id: string;
  name: string;         // from region_name
  slug: string;
  subregions?: SubregionViewModel[];
}

export interface SubregionViewModel {
  id: string;
  name: string;        // from subregion_name
  slug: string;
  regionId: string;    // from region_id
  neighborhoods?: NeighborhoodViewModel[];
  contractorCount?: number;
}

export interface NeighborhoodViewModel {
  id: string;
  name: string;       // from neighborhood_name
  slug: string;
  description: string | null;
  subregionId: string; // from subregion_id
  contractors?: ContractorViewModel[];
}

// Page-specific view models
export interface CategoryPageViewModel {
  category: CategoryViewModel;
  regions: RegionViewModel[];
}

export interface RegionPageViewModel {
  category: CategoryViewModel;
  region: RegionViewModel;
  subregions: SubregionViewModel[];
}

export interface SubregionPageViewModel {
  category: CategoryViewModel;
  region: RegionViewModel;
  subregion: SubregionViewModel;
  contractors: ContractorViewModel[];
}
