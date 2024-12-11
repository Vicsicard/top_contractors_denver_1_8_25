import './globals.css';
import { GeistSans } from 'geist/font/sans';
import { GeistMono } from 'geist/font/mono';
import Header from './components/Header';
import Footer from './components/Footer';
import React from 'react';

const geistSans = GeistSans;
const geistMono = GeistMono;

export const metadata: Metadata = {
  title: "Denver Contractors | Find Trusted Local Contractors",
  description: "Connect with qualified contractors in Denver for your home improvement, renovation, and maintenance needs. Get trusted local service providers in the Denver metro area.",
  keywords: "denver contractors, home improvement denver, renovation contractors denver, local contractors, trusted contractors denver",
  metadataBase: new URL(process.env.VERCEL_URL ? `https://${process.env.VERCEL_URL}` : 'http://localhost:3000'),
  openGraph: {
    title: "Denver Contractors | Find Trusted Local Contractors",
    description: "Connect with qualified contractors in Denver for your home improvement needs",
    locale: "en_US",
    type: "website"
  }
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}): React.ReactElement {
  return (
    <html lang="en">
      <body className={`${geistSans.variable} ${geistMono.variable} antialiased min-h-screen flex flex-col`}>
        <Header />
        <main className="flex-grow">
          {children}
        </main>
        <Footer />
      </body>
    </html>
  );
}
