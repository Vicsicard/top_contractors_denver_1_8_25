import { CategoryList } from '@/components/CategoryList';
import { getAllTrades } from '@/utils/database';

export const revalidate = 3600; // Revalidate every hour

export default async function HomePage() {
  try {
    const categories = await getAllTrades();

    return (
      <div className="min-h-screen bg-gradient-to-b from-white to-blue-50">
        <header 
          className="relative h-[600px] w-full bg-cover bg-center bg-no-repeat"
          style={{
            backgroundImage: `url('/images/denver sky 4.jpg')`,
            backgroundPosition: 'center 30%'
          }}
        >
          <div className="absolute inset-0 hero-overlay">
            <div className="container mx-auto px-4 h-full flex flex-col justify-center items-center">
              <h1 className="text-6xl font-bold mb-6 text-white drop-shadow-lg text-center">
                Top Contractors Denver
              </h1>
              <p className="text-2xl text-white opacity-90 drop-shadow-md text-center max-w-3xl">
                Connect with verified local contractors for your home improvement needs
              </p>
            </div>
          </div>
        </header>
        
        <main className="container mx-auto px-4 py-12">
          <div className="section-light p-8 -mt-20 relative z-10">
            <CategoryList categories={categories} />
          </div>
          
          <section className="mt-16 text-center">
            <h2 className="text-3xl font-bold text-primary-dark mb-4">
              Why Choose Our Contractors?
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mt-8">
              <div className="p-6 bg-white rounded-xl shadow-md">
                <div className="text-accent-warm text-2xl mb-4">✓</div>
                <h3 className="text-xl font-semibold mb-2">Verified Professionals</h3>
                <p className="text-gray-600">All contractors are thoroughly vetted and licensed</p>
              </div>
              <div className="p-6 bg-white rounded-xl shadow-md">
                <div className="text-accent-warm text-2xl mb-4">★</div>
                <h3 className="text-xl font-semibold mb-2">Quality Service</h3>
                <p className="text-gray-600">Rated and reviewed by local homeowners</p>
              </div>
              <div className="p-6 bg-white rounded-xl shadow-md">
                <div className="text-accent-warm text-2xl mb-4">⚡</div>
                <h3 className="text-xl font-semibold mb-2">Quick Response</h3>
                <p className="text-gray-600">Get quotes from available contractors within 24 hours</p>
              </div>
            </div>
          </section>
        </main>
      </div>
    );
  } catch (error) {
    console.error('Error in HomePage:', error);
    return (
      <div className="min-h-screen flex items-center justify-center bg-red-50">
        <div className="text-center p-8 bg-white rounded-lg shadow-lg">
          <h1 className="text-2xl font-bold text-red-600 mb-4">Something went wrong</h1>
          <p className="text-gray-600">{error instanceof Error ? error.message : 'An unexpected error occurred'}</p>
        </div>
      </div>
    );
  }
}
