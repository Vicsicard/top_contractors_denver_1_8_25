import { CategoryList } from '@/components/CategoryList';
import { getAllTrades } from '@/utils/database';

export const revalidate = 3600; // Revalidate every hour

export default async function HomePage() {
  const categories = await getAllTrades();

  return (
    <div className="min-h-screen bg-[#3366FF]">
      <main className="container mx-auto px-4 py-16">
        <div className="text-center text-white mb-16">
          <h1 className="text-5xl font-bold mb-4">
            Top Contractors Denver
          </h1>
          <p className="text-xl opacity-90">
            Connect with verified contractors for your home improvement needs
          </p>
        </div>

        <div className="mt-16 bg-white rounded-2xl p-8">
          <CategoryList categories={categories} />
        </div>
      </main>
    </div>
  );
}
