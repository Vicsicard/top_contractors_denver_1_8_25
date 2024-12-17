/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    serverActions: {
      allowedOrigins: ["localhost:3000", "*.vercel.app"]
    }
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
  async rewrites() {
    return {
      beforeFiles: [
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
      ],
    }
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
