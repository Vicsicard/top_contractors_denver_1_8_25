import Link from 'next/link';
import type { CategoryRecord } from '@/types/database';
import { getCategoryIcon } from './trade-icons';

interface TradeCardProps {
  trade: CategoryRecord;
  stats?: {
    totalContractors: number;
    avgRating: number;
    totalReviews: number;
  };
}

export function TradeCard({ trade }: TradeCardProps) {
  const Icon = getCategoryIcon(trade.category_name);
  
  return (
    <Link
      href={`/trades/${trade.slug}`}
      className="group flex flex-col items-center p-6 bg-white rounded-lg hover:shadow-md transition-all duration-300"
    >
      <div className="w-16 h-16 mb-3 rounded-lg bg-[#e8f0fe] group-hover:bg-[#4285f4] flex items-center justify-center transition-colors duration-300">
        <Icon className="w-8 h-8 text-[#4285f4] group-hover:text-white transition-colors duration-300" />
      </div>
      <span className="text-gray-900 font-medium text-sm">
        {trade.category_name}
      </span>
    </Link>
  );
}
