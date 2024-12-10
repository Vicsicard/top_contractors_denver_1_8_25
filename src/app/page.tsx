import PlacesSearch from './components/PlacesSearch';

export default function Home() {
  return (
    <main className="container mx-auto">
      <h1 className="text-2xl font-bold my-8">Place Search</h1>
      <PlacesSearch />
    </main>
  );
}
