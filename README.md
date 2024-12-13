# Denver Contractors

A Next.js-based web application for finding and connecting with contractors in the Denver area. Built with TypeScript and deployed on Vercel.

## Overview
This project is a web application built with Next.js, TypeScript, and MongoDB, aimed at helping users find contractors in Denver using the Google Places API.

## Features

- 🔍 Smart contractor search with Google Places API integration
- 📍 Location-based filtering for Denver metro area
- 🏢 Featured locations across Denver suburbs
- 🛠️ Popular trades quick-access
- 📱 Responsive, modern design
- ⚡ Fast, server-side rendered pages
- 💾 Efficient MongoDB caching system
- 🔄 Automatic data refresh for outdated entries
- 🎨 Clean, modern UI with Tailwind CSS
- Search for contractors based on user input.
- Display detailed information about contractors, including ratings and reviews.

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Database**: MongoDB 6.11.0
- **API**: Google Places API
- **Icons**: React Icons
- **Deployment**: Vercel
- **Caching**: MongoDB with TTL indexes

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/denver_contractors.git
cd denver_contractors
```

2. Run `npm install` to install dependencies.

3. Create a `.env.local` file with the following environment variables:
   - `GOOGLE_PLACES_API_KEY`
   - `MONGODB_URI`
   - `MONGODB_DB`
   - `NEXT_PUBLIC_BASE_URL`

## Usage

- Run `npm run dev` to start the development server.
- Access the application at `http://localhost:3000`.

## Deployment

- The application is deployed on Vercel. Monitor the deployment for any errors or warnings.

## Next Steps

- Continue to optimize the application and address any remaining issues.

## Project Structure

```
/src
  /app             # Next.js app router pages and layouts
    /components    # App-specific components
    /search       # Search-related pages and components
    /api          # API routes
  /components      # Shared React components
  /utils           # Utility functions
    /googlePlaces.ts   # Google Places API integration
    /mongodb.ts        # MongoDB connection and utilities
  /models          # Data models and schemas
  /types           # TypeScript types
/docs             # Documentation
/public           # Static assets
```

## Features in Detail

### Home Page
- Hero section with prominent search
- Popular trades with icons
- Featured Denver metro locations
- Clean, modern design

### Search Functionality
- Real-time contractor search
- Location-based filtering
- Smart caching system
- Fast response times

### Data Management
- MongoDB caching layer
- Automatic cache invalidation
- Efficient data updates
- Rate limit protection

## API Integration

### Google Places API
- Real-time business search
- Location-based results
- Business details and ratings
- Contact information
- Automatic caching

### MongoDB Integration
- Efficient caching system
- TTL-based cache cleanup
- Connection pooling
- Error handling
- Cache invalidation

## Available Scripts

- `npm run dev` - Start development server on port 3004
- `npm run build` - Build for production
- `npm run start` - Start production server

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
