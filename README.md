# Denver Contractors

A Next.js-based web application for finding and connecting with contractors in the Denver area. Built with TypeScript and deployed on Vercel.

## Features

- 🔍 Contractor search powered by Google Places API (in progress)
- 📍 Location-based filtering for Denver area
- 📱 Responsive design for all devices
- ⚡ Fast, server-side rendered pages
- 🎨 Modern UI with TailwindCSS
- 💾 MongoDB-based caching system
- 🔄 Automatic data refresh for outdated cache entries

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Styling**: TailwindCSS
- **Database**: MongoDB 6.11.0
- **API**: Google Places API v2
- **Deployment**: Vercel
- **Caching**: MongoDB with TTL indexes

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/denver_contractors.git
cd denver_contractors
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
Create a `.env.local` file in the root directory and add:
```env
MONGODB_URI=your_mongodb_uri
MONGODB_DB=top_contractors_denver
NEXT_PUBLIC_GOOGLE_PLACES_API_KEY=your_google_places_api_key
NEXT_PUBLIC_BASE_URL=http://localhost:3000
```

4. Run the development server:
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Project Structure

```
/src
  /app             # Next.js app router pages and layouts
  /components      # Reusable React components
  /utils           # Utility functions and API handlers
    /googlePlaces.ts   # Google Places API integration
    /mongodb.ts        # MongoDB connection and utilities
  /models          # Data models and MongoDB schemas
  /types           # TypeScript type definitions
/docs             # API and implementation documentation
/public           # Static assets
```

## API Integration

### Google Places API (In Progress)
- Real-time search for contractors
- Location-based filtering
- Business details including ratings and contact info
- Automatic caching of results
- Currently debugging integration

### MongoDB Integration
- Caching layer for API responses
- TTL indexes for automatic cache cleanup
- Connection pooling for better performance
- Error handling middleware

## Development Status

### Current Focus
- Debugging Google Places API integration
- Testing API responses
- Monitoring rate limits
- Verifying environment variables

### Known Issues
- Google Places API integration needs debugging
- Mock data still showing instead of real results
- Need to verify environment variables in production

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run start` - Start production server
- `npm run lint` - Run ESLint
- `npm run type-check` - Run TypeScript compiler check

## Environment Variables

```env
MONGODB_URI              # MongoDB connection string
MONGODB_DB              # Database name
NEXT_PUBLIC_GOOGLE_PLACES_API_KEY  # Google Places API key
NEXT_PUBLIC_BASE_URL    # Base URL for the application
```

## Deployment

The application is deployed on Vercel. Each push to the main branch triggers an automatic deployment.

### Required Setup
1. Configure environment variables in Vercel
2. Enable Google Places API and set restrictions
3. Configure MongoDB Atlas connection
4. Set up proper CORS and security settings

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Next.js team for the amazing framework
- Vercel for hosting and deployment
- MongoDB for database services
- Google for Places API
- Contributors and maintainers

## Support

For support, please open an issue in the GitHub repository or contact the maintainers.
