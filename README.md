# Denver Contractors Search

A modern Next.js application designed to help users find and connect with contractors in the Denver area. The application provides a streamlined interface to search for and view detailed information about local contractors.

## Features

- 🔍 Advanced contractor search with trade-specific filters
- 📍 Comprehensive contractor information including:
  - Business name and rating
  - Complete address with location icon
  - Phone number with click-to-call
  - Website links with direct access
  - Star ratings and reviews
- 🎯 Specialized trade categories including:
  - Home Remodeling
  - Bathroom Remodeling
  - Kitchen Remodeling
  - Siding & Gutters
  - And many more!
- 🌐 Powered by Google Places API with MongoDB caching
- 📱 Fully responsive design for all devices
- ⚡ Lightning-fast performance with Next.js
- 🎨 Modern UI with beautiful blue gradients
- 🔄 Smooth transitions and loading states
- 🔒 Secure API handling
- 🔎 SEO optimized with:
  - Dynamic sitemap generation
  - Meta tags and OpenGraph data
  - SEO-friendly URLs
  - Structured data (JSON-LD)
- 🏗️ Consistent contractor pages with:
  - Unified layout and design
  - Emergency service information
  - Clear service descriptions
  - Customized CTA buttons
  - Trade-specific content

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Database**: MongoDB with Prisma ORM
- **Styling**: Tailwind CSS
- **APIs**: 
  - Google Places API
  - Google Places Details API
- **Deployment**: Vercel with custom domain (topcontractorsdenver.com)
- **SEO Tools**:
  - Dynamic sitemap generation
  - Robots.txt configuration
  - Google Search Console integration

## Getting Started

### Prerequisites

- Node.js (v18 or higher)
- npm
- MongoDB Atlas account
- Google Places API key

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/denver_contractors.git
   cd denver_contractors
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Create a `.env.local` file in the root directory:
   ```env
   MONGODB_URI=your_mongodb_connection_string
   MONGODB_DB=topcontractorsdenver
   GOOGLE_PLACES_API_KEY=your_api_key_here
   ```

4. Generate Prisma client:
   ```bash
   npm run generate
   ```

5. Run the development server:
   ```bash
   npm run dev
   ```

6. Open [http://localhost:3004](http://localhost:3004) in your browser.

## Project Structure

```
denver_contractors/
├── prisma/
│   └── schema.prisma      # Database schema
├── src/
│   ├── app/
│   │   ├── (pages)/
│   │   │   └── search/
│   │   ├── api/
│   │   │   └── search/
│   │   ├── contractor/
│   │   │   └── [slug]/   # Dynamic contractor pages
│   │   └── components/
│   ├── utils/
│   │   ├── dataRefresh.ts # Google Places data refresh
│   │   └── seoUtils.ts    # SEO utilities
│   ├── hooks/
│   │   └── useBusinessData.ts
│   └── types/
├── scripts/
│   ├── seed-data.ts      # Database seeding
│   └── test-db.ts        # Database testing
├── public/
│   └── robots.txt        # Search engine configuration
```

## Database Management

The application uses MongoDB with Prisma ORM for data management:
- Automatic data refresh from Google Places API
- Caching to reduce API calls
- Efficient querying with Prisma

## SEO Configuration

The application is optimized for search engines:
1. Dynamic sitemap generation at `/sitemap.xml`
2. SEO-friendly URLs for contractor pages
3. Meta tags and OpenGraph data
4. Structured data for rich snippets
5. Integration with Google Search Console

## Deployment

The application is deployed on Vercel with a custom domain:
- Production URL: https://topcontractorsdenver.com
- Automatic SSL/TLS
- Edge network distribution
- Continuous deployment from main branch

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
