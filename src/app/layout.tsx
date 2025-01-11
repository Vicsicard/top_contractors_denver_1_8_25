import './globals.css'
import type { Metadata, Viewport } from 'next'
import { Inter } from 'next/font/google'
import { generateOrganizationSchema } from '@/utils/schema'
import { PerformanceMonitor } from '@/components/PerformanceMonitor'
import { Analytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';
import { Navigation } from '@/components/Navigation';
import GoogleAnalytics from '@/components/GoogleAnalytics';

// Optimize font loading
const inter = Inter({
  subsets: ['latin'],
  display: 'swap',
  preload: true,
  fallback: ['system-ui', 'arial']
})

export const metadata: Metadata = {
  metadataBase: new URL('https://topcontractorsdenver.com'),
  title: {
    default: 'Top Denver Contractors | Verified Local Pros for Home Improvement, Remodeling, and Repairs',
    template: '%s | Top Contractors Denver'
  },
  description: 'Discover trusted Denver contractors for home improvement, remodeling, and repairs. Our verified local pros bring your projects to life with quality workmanship and reliable service.',
  alternates: {
    canonical: '/',
  },
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: 'https://topcontractorsdenver.com',
    siteName: 'Top Contractors Denver',
    title: 'Top Denver Contractors | Verified Local Pros for Home Improvement',
    description: 'Discover trusted Denver contractors for home improvement, remodeling, and repairs. Our verified local pros bring your projects to life with quality workmanship and reliable service.',
    images: [
      {
        url: '/images/denver-skyline.jpg',
        width: 1200,
        height: 630,
        alt: 'Denver skyline'
      }
    ]
  },
  twitter: {
    card: 'summary_large_image',
    images: ['/images/denver-skyline.jpg']
  },
  verification: {
    google: 'your-google-verification-code', // Add your Google verification code
  },
  robots: {
    index: true,
    follow: true,
  },
  other: {
    'google-site-verification': 'your-verification-code'
  },
  manifest: '/manifest.json',
  icons: {
    icon: '/favicon.ico',
    apple: '/apple-touch-icon.png'
  }
}

export const viewport: Viewport = {
  width: 'device-width',
  initialScale: 1,
  themeColor: [{ media: '(prefers-color-scheme: light)', color: '#3366FF' }],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" className={inter.className}>
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{
            __html: JSON.stringify(generateOrganizationSchema())
          }}
        />
        {/* Resource hints */}
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link rel="dns-prefetch" href="https://fonts.googleapis.com" />
        
        {/* Preload critical assets */}
        <link rel="preload" href="/images/logo.png" as="image" />
      </head>
      <body className={inter.className}>
        <Navigation />
        <main className="min-h-screen bg-gray-50">
          {children}
        </main>
        <GoogleAnalytics />
        <PerformanceMonitor />
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  )
}
