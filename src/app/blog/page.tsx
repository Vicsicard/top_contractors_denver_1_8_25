import { Metadata } from 'next';
import Link from 'next/link';

export const metadata: Metadata = {
    title: 'Contractor Blog - Home Improvement Tips & Guides',
    description: 'Expert advice, tips, and guides for home improvement projects. Find local contractors in Denver, Aurora, Broomfield, and surrounding areas.',
    keywords: 'home improvement blog, contractor tips, Denver contractors, Aurora plumbers, Broomfield remodelers, home renovation guides',
};

export const revalidate = 3600; // Revalidate every hour

export default function BlogPage() {
    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <h1 className="text-4xl font-bold text-gray-900 mb-8">Blog</h1>
            <p className="text-lg text-gray-600 mb-8">
                Our blog is coming soon! We&apos;ll be sharing expert advice, tips, and guides for home improvement projects.
            </p>
            <Link href="/" className="text-blue-600 hover:text-blue-800 font-medium">
                ← Back to Home
            </Link>
        </div>
    );
}
