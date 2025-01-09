'use client';

import type { SubregionRecord } from '@/types/database';
import { SubregionCard } from './subregion-card';

interface SubregionListProps {
  subregions: SubregionRecord[];
  tradeSlug: string;
  tradeName: string;
  stats?: Record<string, {
    totalContractors: number;
    avgRating: number;
  }>;
}

export function SubregionList({ subregions, tradeSlug, tradeName, stats }: SubregionListProps) {
  return (
    <div>
      <h1 className="text-3xl font-bold mb-8">
        Find {tradeName} by Location
      </h1>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {subregions.map((subregion) => (
          <SubregionCard
            key={subregion.id}
            subregion={subregion}
            tradeSlug={tradeSlug}
            stats={stats?.[subregion.slug]}
          />
        ))}
      </div>
    </div>
  );
}
