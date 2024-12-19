# Denver Contractors Search Platform

## Overview
A comprehensive web application for finding contractors in the Greater Denver area, with precise location-based searching across multiple Colorado cities.

## Features

### Trade Categories
- Plumbing
- Electrical
- HVAC
- Roofing
- Carpentry
- Painting
- Landscaping
- Home Remodeling
- Bathroom Remodeling
- Kitchen Remodeling
- Siding & Gutters
- Masonry
- Decks
- Flooring
- Windows
- Fencing
- Epoxy Garage

### Location-Based Search
- Browse contractors by specific Denver neighborhoods and surrounding areas
- Main location categories:
  - Central Denver Neighborhoods
  - East Denver Neighborhoods
  - Denver Suburbs
  - Boulder & Surrounding Areas
  - Outer Surrounding Cities
- Interactive location cards with hover effects
- Gradient styling for visual hierarchy

### Contractor Information
- Business name and contact details
- Customer reviews and ratings
- Service areas
- Business hours
- Website links
- Specific services offered
- Photos (when available)

### User Interface
- Responsive design optimized for all devices
- Modern gradient styling
- Interactive hover effects
- Easy-to-use navigation
- Clean and professional layout
- Optimized grid layouts for different screen sizes

### Technical Features
- Next.js 13+ with App Router
- TypeScript for type safety
- Google Places API integration
- MongoDB caching system
- Rate limiting with Bottleneck
- SEO optimization
- Dynamic sitemap generation
- Custom domain integration
- Structured data for rich snippets

## Technology Stack
- Next.js 13+
- TypeScript
- Tailwind CSS
- Google Places API

## Getting Started

### Prerequisites
- Node.js (v18+)
- npm or yarn
- Google Places API Key

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. Create a `.env.local` file with your Google Places API key:
   ```
   GOOGLE_PLACES_API_KEY=your_api_key_here
   ```

4. Run the development server:
   ```bash
   npm run dev
   ```

## Current Development Status
- ✅ Location-based search implemented
- 🔨 Ongoing UI/UX improvements
- 🔍 Continuous search functionality refinement

## Contributing
Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
