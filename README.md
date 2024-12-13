# Denver Contractors

A Next.js-based web application for finding and connecting with contractors in the Denver area. Built with TypeScript and deployed on Vercel.

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

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Database**: MongoDB 6.11.0
- **API**: Google Places API
- **Icons**: React Icons
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
```

4. Run the development server:
```bash
npm run dev
```

Open [http://localhost:3004](http://localhost:3004) with your browser to see the result.

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
