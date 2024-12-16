'use client';

import type { LayoutProps } from '@/types/next';
import localFont from 'next/font/local';
import Header from './components/Header';
import Footer from './components/Footer';
import LoadingSpinner from './components/LoadingSpinner';
import './globals.css';
import React, { Suspense } from 'react';

const geistSans = localFont({
  src: './fonts/GeistVF.woff',
  variable: '--font-geist-sans',
  weight: '100 900',
} as const);

const geistMono = localFont({
  src: './fonts/GeistMonoVF.woff',
  variable: '--font-geist-mono',
  weight: '100 900',
} as const);

export default function RootLayout({ children }: LayoutProps): React.ReactElement {
  return (
    <html lang="en">
      <body className={`${geistSans.variable} ${geistMono.variable} antialiased min-h-screen flex flex-col`}>
        <Header />
        <Suspense fallback={<LoadingSpinner />}>
          <main className="flex-grow">
            {children}
          </main>
        </Suspense>
        <Footer />
      </body>
    </html>
  );
}
