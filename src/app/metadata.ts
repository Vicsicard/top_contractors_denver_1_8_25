import { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Denver Contractors | Find Trusted Local Contractors',
  description: 'Find the best contractors in Denver',
  keywords: "denver contractors, home improvement denver, renovation contractors denver, local contractors, trusted contractors denver",
  metadataBase: new URL(process.env.VERCEL_URL ? `https://${process.env.VERCEL_URL}` : 'http://localhost:3000'),
  openGraph: {
    title: "Denver Contractors | Find Trusted Local Contractors",
    description: "Connect with qualified contractors in Denver for your home improvement needs",
    locale: "en_US",
    type: "website"
  }
};
