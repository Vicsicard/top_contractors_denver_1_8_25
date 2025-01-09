"use client";

import React from 'react';
import { ContractorCard } from './contractor-card';
import { Database } from '@/types/database';

type Contractor = Database['public']['Tables']['contractors']['Row'];

interface ContractorGridProps {
  contractors: Contractor[];
}

export function ContractorGrid({ contractors }: ContractorGridProps) {
  if (!contractors || contractors.length === 0) {
    return (
      <div className="text-center text-gray-600 py-12">
        No contractors found in this area.
      </div>
    );
  }

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {contractors.map((contractor, index) => (
        <ContractorCard key={contractor.id} contractor={contractor} />
      ))}
    </div>
  );
}
