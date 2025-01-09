'use client';

import type { ContractorRecord } from '@/types/database';
import { ContractorCard } from './contractor-card';

interface ContractorListProps {
  contractors: ContractorRecord[];
  tradeName: string;  // This comes from category_name
  subregionName: string;  // This comes from subregion_name
}

export function ContractorList({ contractors, tradeName, subregionName }: ContractorListProps) {
  return (
    <div>
      <h1 className="text-3xl font-bold mb-8">
        Top {tradeName} in {subregionName}
      </h1>
      
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {contractors.map((contractor) => (
          <ContractorCard key={contractor.id} contractor={contractor} />
        ))}
      </div>
      
      {contractors.length === 0 && (
        <p className="text-gray-600 text-center py-8">
          No contractors found in this area. Please try another location.
        </p>
      )}
    </div>
  );
}
