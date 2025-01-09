import { notFound } from 'next/navigation';
import { SubregionList } from '@/components/SubregionList';
import { getAllSubregions, getTradeBySlug, getTradeStats } from '@/utils/database';

export const revalidate = 3600; // Revalidate every hour

interface TradePageProps {
  params: {
    slug: string;
  };
}

export default async function TradePage({ params }: TradePageProps) {
  const trade = await getTradeBySlug(params.slug);
  if (!trade) {
    notFound();
  }

  const [subregions, tradeStats] = await Promise.all([
    getAllSubregions(),
    getTradeStats(params.slug)
  ]);

  return (
    <main className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-4xl font-bold mb-4">{trade.category_name}</h1>
        <div className="grid grid-cols-3 gap-4 bg-white p-6 rounded-lg shadow">
          <div>
            <p className="text-2xl font-semibold">{tradeStats.totalContractors}</p>
            <p className="text-gray-600">Contractors</p>
          </div>
          <div>
            <p className="text-2xl font-semibold">{tradeStats.avgRating.toFixed(1)}</p>
            <p className="text-gray-600">Avg Rating</p>
          </div>
          <div>
            <p className="text-2xl font-semibold">{tradeStats.totalReviews}</p>
            <p className="text-gray-600">Reviews</p>
          </div>
        </div>
      </div>

      <SubregionList
        subregions={subregions}
        tradeSlug={trade.slug}
        tradeName={trade.category_name}
      />
    </main>
  );
}
