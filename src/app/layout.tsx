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
  metadataBase: new URL('https://www.example.com'),
  title: 'Find Local Contractors | Denver Area',
  description: 'Find and connect with trusted local contractors in the Denver area.',
  openGraph: {
    title: 'Find Local Contractors | Denver Area',
    description: 'Find and connect with trusted local contractors in the Denver area.',
    url: 'https://www.example.com',
    siteName: 'Denver Contractors Directory',
    locale: 'en_US',
    type: 'website',
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Find Local Contractors | Denver Area',
    description: 'Find and connect with trusted local contractors in the Denver area.',
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
      <body>
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
