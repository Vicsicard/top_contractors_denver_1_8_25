# Denver Contractors

A Next.js application to help users find and connect with contractors in the Denver area.

## Features
- 🔍 Search contractors by service type and location
- 📍 Integration with Google Places API
- 💾 MongoDB Atlas for data persistence
- 🚀 Server-side rendering with Next.js
- 📱 Responsive design with Tailwind CSS
- 🔒 Type-safe with TypeScript

## Getting Started

### Prerequisites
- Node.js 18 or later
- MongoDB Atlas account
- Google Places API key

### Environment Setup
1. Clone the repository
2. Create a `.env.local` file in the root directory with the following variables:
```
MONGODB_URI=your_mongodb_atlas_uri
MONGODB_DB=denver_contractors
GOOGLE_PLACES_API_KEY=your_google_places_api_key
```

### Installation
```bash
# Install dependencies
npm install

# Run development server
npm run dev

# Build for production
npm run build

# Start production server
npm start
```

### Database Setup
The application uses MongoDB Atlas for data storage. Make sure to:
1. Create a MongoDB Atlas account
2. Create a new cluster
3. Configure network access
4. Create a database user
5. Add the connection string to `.env.local`

## Project Structure
```
denver_contractors/
├── src/
│   ├── app/
│   │   ├── (api)/
│   │   │   └── search/
│   │   │       └── places/
│   │   ├── location/
│   │   │   └── [location]/
│   │   ├── trade/
│   │   │   └── [trade]/
│   │   └── search/
│   │       └── results/
│   ├── components/
│   ├── lib/
│   └── utils/
├── public/
├── docs/
└── tests/
```

## Development

### Running the Development Server
```bash
npm run dev
```
The development server will start on http://localhost:3004

### Building for Production
```bash
npm run build
```

### Type Safety
The project uses TypeScript for type safety. Key type definitions include:
- Dynamic route parameters (location, trade)
- API response types
- MongoDB document interfaces
- Google Places API types

### API Routes
- `/api/search/places`: Search contractors using Google Places API
- `/location/[location]`: View contractors by location
- `/trade/[trade]`: View contractors by trade
- `/search/results`: Search results page

### Environment Variables
Required environment variables:
```env
MONGODB_URI=your_mongodb_connection_string
MONGODB_DB=your_database_name
NEXT_PUBLIC_GOOGLE_PLACES_API_KEY=your_google_places_api_key
```

## Documentation
- [TypeScript Setup](./docs/typescript-eslint-setup.md)
- [MongoDB Integration](./docs/mongodb-typescript.md)
- [Testing Guide](./docs/mongodb-typescript-testing.md)
- [Next.js Components](./docs/nextjs-server-components-typescript.md)

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## Testing
```bash
# Run tests
npm test

# Run tests with coverage
npm run test:coverage
```

## Built With
- [Next.js](https://nextjs.org/) - React framework
- [TypeScript](https://www.typescriptlang.org/) - Type safety
- [MongoDB](https://www.mongodb.com/) - Database
- [Tailwind CSS](https://tailwindcss.com/) - Styling
- [Google Places API](https://developers.google.com/maps/documentation/places/web-service/overview) - Location data

## License
This project is licensed under the MIT License - see the LICENSE file for details

## Acknowledgments
- Next.js team for the amazing framework
- MongoDB team for the database solution
- Google Maps Platform for the Places API
