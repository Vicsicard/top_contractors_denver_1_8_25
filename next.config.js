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
      'snappy': false,
    }
    return config
  },
  // Add trailingSlash configuration
  trailingSlash: true,
  async redirects() {
    return [
      {
        source: '/search',
        destination: '/search/results',
        permanent: true,
      },
    ];
  },
  async rewrites() {
    return [
      {
        source: '/search/:keyword/:location',
        destination: '/search/[keyword]/[location]'
      }
    ]
  }
}

module.exports = nextConfig
