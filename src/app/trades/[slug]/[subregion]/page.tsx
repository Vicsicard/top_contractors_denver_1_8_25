import { notFound } from 'next/navigation';
import { ContractorList } from '@/components/ContractorList';
import {
  getTradeBySlug,
  getSubregionBySlug,
  getContractorsByTradeAndSubregion
} from '@/utils/database';

export const revalidate = 3600; // Revalidate every hour

interface TradeSubregionPageProps {
  params: {
    slug: string;
    subregion: string;
  };
}

export default async function TradeSubregionPage({ params }: TradeSubregionPageProps) {
  console.log('[SERVER] TradeSubregionPage params:', params);

  const [trade, subregion, contractors] = await Promise.all([
    getTradeBySlug(params.slug),
    getSubregionBySlug(params.subregion),
    getContractorsByTradeAndSubregion(params.slug, params.subregion)
  ]);

  console.log('[SERVER] TradeSubregionPage results:', {
    trade: trade?.category_name,
    subregion: subregion?.subregion_name,
    contractorsFound: contractors?.length || 0
  });

  if (!trade || !subregion) {
    notFound();
  }

  return (
    <main className="container mx-auto px-4 py-8">
      <div className="mb-8">
        <h1 className="text-4xl font-bold mb-2">{trade.category_name}</h1>
        <p className="text-xl text-gray-600">in {subregion.subregion_name}</p>
      </div>

      <ContractorList
        contractors={contractors}
        tradeName={trade.category_name}
        subregionName={subregion.subregion_name}
      />
    </main>
  );
}
