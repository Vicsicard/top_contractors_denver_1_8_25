'use client';

import React from 'react';
import type { CategoryRecord } from '@/types/database';
import { TradeCard } from './trade-card';

interface CategoryListProps {
  categories: CategoryRecord[];
  stats?: {
    [key: string]: {
      totalContractors: number;
      avgRating: number;
      totalReviews: number;
    };
  };
}

export function CategoryList({ categories, stats }: CategoryListProps) {
  return (
    <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
      {categories.map((category) => (
        <TradeCard
          key={category.id}
          trade={category}
          stats={stats?.[category.slug]}
        />
      ))}
    </div>
  );
}
