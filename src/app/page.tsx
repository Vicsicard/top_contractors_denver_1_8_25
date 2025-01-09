import { CategoryList } from '@/components/CategoryList';
import { getAllTrades } from '@/utils/database';

export const revalidate = 3600; // Revalidate every hour

export default async function HomePage() {
  const categories = await getAllTrades();

  return (
    <main className="container mx-auto px-4 py-8">
      <h1 className="text-4xl font-bold text-center mb-12">
        Find Top Local Contractors
      </h1>
      <CategoryList categories={categories} />
    </main>
  );
}
