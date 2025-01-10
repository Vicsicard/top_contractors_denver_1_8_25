/** @type {import('next').NextConfig} */
const config = {
  reactStrictMode: true,
  images: {
    domains: [
      'maps.googleapis.com',
      '6be7e0906f1487fecf0b9cbd301defd6.cdn.bubble.io',
      'top-contractors-denver-1.ghost.io'
    ],
  },
};

module.exports = config;
