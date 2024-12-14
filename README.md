# Denver Contractors

A Next.js application for finding and reviewing contractors in the Denver area.

## Features

- Search contractors by keyword and location
- View contractor details including ratings and reviews
- Responsive design with Tailwind CSS
- MongoDB caching for improved performance
- Google Places API integration

## Getting Started

### Prerequisites

- Node.js 18 or later
- npm or yarn
- MongoDB database
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

3. Create a `.env` file in the root directory with the following variables:
```env
MONGODB_URI=your_mongodb_uri
GOOGLE_PLACES_API_KEY=your_google_places_api_key
NEXT_PUBLIC_BASE_URL=your_base_url
```

4. Run the development server:
```bash
npm run dev
```

5. Build for production:
```bash
npm run build
```

## Known Issues

1. TypeScript errors in the search results page:
   - Currently working on resolving type compatibility with Next.js App Router
   - Build fails due to incorrect type definitions

## Documentation

- [Next.js API Routes](./docs/nextjs-api-routes.md)
- [Next.js Conflicting Files](./docs/nextjs-conflicting-files.md)
- [Google Places API Integration](./docs/google-places-api.md)
- [Next.js Route Handlers](./docs/nextjs-route-handlers.md)

## Project Structure

```
denver_contractors/
├── src/
│   ├── app/
│   │   ├── (pages)/
│   │   │   └── search/
│   │   │       └── results/
│   │   │           └── page.tsx
│   │   └── (api)/
│   │       └── places/
│   │           └── search/
│   │               └── route.ts
│   ├── components/
│   ├── models/
│   └── utils/
├── docs/
├── public/
└── package.json
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
