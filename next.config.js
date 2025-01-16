// Load environment variables
require('dotenv').config();

/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    serverActions: {
      allowedOrigins: ["localhost:3000", "*.vercel.app"]
    }
  },
  images: {
    domains: [
      'maps.googleapis.com',
      'maps.gstatic.com',
      'top-contractors-denver.ghost.io',
      'top-contractors-denver-1.ghost.io',
      '6be7e0906f1487fecf0b9cbd301defd6.cdn.bubble.io'
    ],
  },
  typescript: {
    // !! WARN !!
    // Dangerously allow production builds to successfully complete even if
    // your project has type errors.
    // !! WARN !!
    ignoreBuildErrors: true,
  },
  webpack: (config) => {
    // Handle MongoDB driver issue
    config.resolve.alias = {
      ...config.resolve.alias,
      'mongodb-client-encryption': false,
      'aws4': false,
      'kerberos': false,
    }
    return config
  },
  // Add trailingSlash configuration
  trailingSlash: true,
  // Add hostname configuration
  assetPrefix: process.env.NODE_ENV === 'production' ? 'https://www.topcontractorsdenver.com' : '',
  // Force www in production
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'X-Robots-Tag',
            value: 'all',
          },
        ],
      },
    ]
  },
  // Environment variables configuration
  env: {
    GOOGLE_PLACES_API_KEY: process.env.GOOGLE_PLACES_API_KEY,
    MONGODB_URI: process.env.MONGODB_URI,
    MONGODB_DB: process.env.MONGODB_DB,
    NEXT_PUBLIC_DOMAIN: process.env.NEXT_PUBLIC_DOMAIN,
    NEXT_PUBLIC_BUILD_TIME_KEY: 'dummy-key-for-build',
    GHOST_URL: process.env.GHOST_URL,
    GHOST_ORG_CONTENT_API_KEY: process.env.GHOST_ORG_CONTENT_API_KEY
  },
  async rewrites() {
    return [
      {
        source: '/sitemap.xml',
        destination: '/api/sitemap',
      },
      {
        source: '/:path*',
        has: [
          {
            type: 'host',
            value: 'topcontractorsdenver.com',
          },
        ],
        destination: 'https://www.topcontractorsdenver.com/:path*',
      },
    ]
  },
  async redirects() {
    return [
      {
        source: '/search',
        destination: '/search/results',
        permanent: true,
      },
      {
        source: '/:path*',
        has: [
          {
            type: 'host',
            value: 'topcontractorsdenver.com',
          },
        ],
        destination: 'https://www.topcontractorsdenver.com/:path*',
        permanent: true,
      },
    ]
  },
}

module.exports = nextConfig
