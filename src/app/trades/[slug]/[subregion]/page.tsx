import { notFound } from 'next/navigation';
import { ContractorList } from '@/components/ContractorList';
import {
  getTradeBySlug,
  getSubregionBySlug,
  getContractorsByTradeAndSubregion,
  getAllTrades,
  getAllSubregions
} from '@/utils/database';

export const revalidate = 3600; // Revalidate every hour

interface TradeSubregionPageProps {
  params: {
    slug: string;
    subregion: string;
  };
}

// This helps Next.js understand our dynamic routes
export async function generateStaticParams() {
  const trades = await getAllTrades();
  const subregions = await getAllSubregions();
  
  const paths = [];
  for (const trade of trades) {
    for (const subregion of subregions) {
      paths.push({
        slug: trade.slug,
        subregion: subregion.slug,
      });
    }
  }
  
  return paths;
}

export default async function TradeSubregionPage({ params }: TradeSubregionPageProps) {
  if (!params?.slug || !params?.subregion) {
    console.error('[SERVER] Missing required params:', params);
    notFound();
  }

  console.log('[SERVER] TradeSubregionPage params:', params);

  try {
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
      console.error('[SERVER] Trade or subregion not found:', params);
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
  } catch (error) {
    console.error('[SERVER] Error in TradeSubregionPage:', error);
    throw error; // This will trigger Next.js error page
  }
}
