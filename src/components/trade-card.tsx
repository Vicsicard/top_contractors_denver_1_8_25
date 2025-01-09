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

const getCategoryEmoji = (categoryName: string): string => {
  const emojiMap: { [key: string]: string } = {
    'Bathroom Remodelers': '🚽',
    'Decks': '🏡',
    'Electricians': '⚡',
    'Epoxy Garage': '🚗',
    'Fencing': '🏗️',
    'Flooring': '🏢',
    'Home Remodelers': '🏠',
    'HVAC': '❄️',
    'Kitchen Remodelers': '🍳',
    'Landscapers': '🌳',
    'Masonry': '🧱',
    'Painters': '🎨',
    'Plumbers': '🔧',
    'Roofers': '🏠',
    'Siding & Gutters': '🏘️',
    'Windows': '🪟'
  };

  return emojiMap[categoryName] || '🏢';
};

export function TradeCard({ trade, stats }: TradeCardProps) {
  return (
    <Link
      href={`/trades/${trade.slug}`}
      className="block bg-white rounded-xl border-2 border-[#1a4b8c] shadow-sm hover:shadow-lg hover:border-[#3366FF] transition-all duration-300"
    >
      <div className="p-6">
        <div className="flex items-center gap-4 mb-4">
          <div className="w-12 h-12 rounded-lg bg-[#3366FF] bg-opacity-10 flex items-center justify-center text-2xl">
            {getCategoryEmoji(trade.category_name)}
          </div>
          <h2 className="text-xl font-semibold text-gray-900">
            {trade.category_name}
          </h2>
        </div>
        
        {stats && (
          <div className="grid grid-cols-3 gap-4 mt-4 pt-4 border-t border-gray-100">
            <div>
              <p className="text-2xl font-bold text-[#3366FF] mb-1">
                {stats.totalContractors}
              </p>
              <p className="text-sm text-gray-600">Contractors</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-[#3366FF] mb-1">
                {stats.avgRating.toFixed(1)}
              </p>
              <p className="text-sm text-gray-600">Avg Rating</p>
            </div>
            <div>
              <p className="text-2xl font-bold text-[#3366FF] mb-1">
                {stats.totalReviews}
              </p>
              <p className="text-sm text-gray-600">Reviews</p>
            </div>
          </div>
        )}
      </div>
    </Link>
  );
}
