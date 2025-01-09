import Link from 'next/link';
import type { CategoryRecord } from '@/types/database';

interface TradeCardProps {
  trade: CategoryRecord;
  stats?: {
    totalContractors: number;
    avgRating: number;
    totalReviews: number;
  };
}

export function TradeCard({ trade, stats }: TradeCardProps) {
  return (
    <Link
      href={`/trades/${trade.slug}`}
      className="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition-shadow"
    >
      <h2 className="text-xl font-semibold text-gray-900 mb-2">{trade.category_name}</h2>
      {stats && (
        <div className="mt-4 grid grid-cols-3 gap-4 text-sm text-gray-600">
          <div>
            <p className="font-medium">{stats.totalContractors}</p>
            <p>Contractors</p>
          </div>
          <div>
            <p className="font-medium">{stats.avgRating.toFixed(1)}</p>
            <p>Avg Rating</p>
          </div>
          <div>
            <p className="font-medium">{stats.totalReviews}</p>
            <p>Reviews</p>
          </div>
        </div>
      )}
    </Link>
  );
}
