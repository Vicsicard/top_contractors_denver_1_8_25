import {
  ContractorRecord,
  CategoryRecord,
  SubregionRecord
} from '@/types/database';

interface ContractorRelations {
  category: CategoryRecord;
  subregion: SubregionRecord;
}

export function toContractorViewModel(
  record: ContractorRecord,
  relations: ContractorRelations
): ContractorRecord {
  return {
    ...record,
    category_id: relations.category.id,
    subregion_id: relations.subregion.id
  };
}

export function toLocationViewModel(
  contractors: ContractorRecord[],
  trade: string,
  region: string,
  area: string
): { trade: string, region: string, area: string, contractors: ContractorRecord[] } {
  return {
    trade,
    region,
    area,
    contractors
  };
}

export function toRegionViewModel(
  subregions: SubregionRecord[]
): { id: string, name: string, slug: string, contractorCount: number, areas: { id: string, name: string, slug: string, contractorCount: number }[] } {
  return {
    id: '',
    name: '',
    slug: '',
    contractorCount: 0,
    areas: subregions.map(s => ({
      id: s.id,
      name: s.subregion_name,
      slug: s.slug,
      contractorCount: 0
    }))
  };
}

export function toTradeViewModel(
  category: CategoryRecord,
  regions: { id: string, name: string, slug: string, contractorCount: number, areas: { id: string, name: string, slug: string, contractorCount: number }[] }[]
): { id: string, name: string, slug: string, description: string, regions: { id: string, name: string, slug: string, contractorCount: number, areas: { id: string, name: string, slug: string, contractorCount: number }[] }[] } {
  return {
    id: category.id,
    name: category.category_name,
    slug: category.slug,
    description: '',
    regions
  };
}

export function transformContractorData(contractor: ContractorRecord): Partial<ContractorRecord> {
  return {
    id: contractor.id,
    contractor_name: contractor.contractor_name,
    address: contractor.address,
    phone: contractor.phone,
    website: contractor.website,
    reviews_avg: contractor.reviews_avg,
    reviews_count: contractor.reviews_count,
    slug: contractor.slug
  };
}

export function transformCategoryData(category: CategoryRecord): Partial<CategoryRecord> {
  return {
    id: category.id,
    category_name: category.category_name,
    slug: category.slug
  };
}

export function transformSubregionData(subregion: SubregionRecord): Partial<SubregionRecord> {
  return {
    id: subregion.id,
    subregion_name: subregion.subregion_name,
    slug: subregion.slug
  };
}
