'use client';

import React from 'react';
import type { CategoryRecord } from '@/types/database';
import { TradeCard } from './trade-card';

interface CategoryListProps {
  categories: CategoryRecord[];
  stats?: Record<string, {
    totalContractors: number;
    avgRating: number;
    totalReviews: number;
  }>;
}

export function CategoryList({ categories, stats }: CategoryListProps) {
  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold text-center mb-12">
        Find Local Contractors
      </h1>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {categories.map((category) => (
          <TradeCard
            key={category.id}
            trade={category}
            stats={stats?.[category.slug]}
          />
        ))}
      </div>
    </div>
  );
}
