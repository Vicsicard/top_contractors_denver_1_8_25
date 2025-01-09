import Link from 'next/link';
import type { SubregionRecord } from '@/types/database';

interface SubregionCardProps {
  subregion: SubregionRecord;
  tradeSlug: string;
  stats?: {
    totalContractors: number;
    avgRating: number;
  };
}

export function SubregionCard({ subregion, tradeSlug, stats }: SubregionCardProps) {
  return (
    <Link
      href={`/trades/${tradeSlug}/${subregion.slug}`}
      className="block p-6 bg-white rounded-lg shadow hover:shadow-lg transition-shadow"
    >
      <h2 className="text-xl font-semibold text-gray-900 mb-2">{subregion.subregion_name}</h2>
      {stats && (
        <div className="mt-4 grid grid-cols-2 gap-4 text-sm text-gray-600">
          <div>
            <p className="font-medium">{stats.totalContractors}</p>
            <p>Available</p>
          </div>
          <div>
            <p className="font-medium">{stats.avgRating.toFixed(1)}</p>
            <p>Avg Rating</p>
          </div>
        </div>
      )}
    </Link>
  );
}
