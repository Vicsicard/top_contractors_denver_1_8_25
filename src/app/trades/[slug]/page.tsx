import { notFound } from 'next/navigation';
import { SubregionList } from '@/components/SubregionList';
import { getAllSubregions, getTradeBySlug } from '@/utils/database';

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

  const subregions = await getAllSubregions();

  return (
    <main className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-4xl font-bold mb-4">{trade.category_name}</h1>
      </div>

      <SubregionList
        subregions={subregions}
        tradeSlug={trade.slug}
        tradeName={trade.category_name}
      />
    </main>
  );
}
