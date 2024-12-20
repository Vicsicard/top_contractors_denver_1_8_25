# Denver Contractors Search Platform

A modern, type-safe Next.js application for finding and connecting with contractors in the Greater Denver Area. Built with performance and user experience in mind.

## Features

- 🔍 Advanced contractor search with location-based filtering
- 📍 Browse by location (Denver neighborhoods and surrounding areas)
- 🏠 Popular trades categories with specialized contractor listings
- 💾 Efficient caching system for API responses
- 📱 Responsive design optimized for all devices
- 🎨 Modern UI with Material-UI components
- 🚀 Server-side rendering for optimal performance
- 🔒 Type-safe implementation with TypeScript

## Tech Stack

- **Framework**: Next.js 15.1.0
- **UI Library**: Material-UI
- **Database**: MongoDB (for caching)
- **API**: Google Places API
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Deployment**: Vercel

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/denver_contractors.git
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
   - Copy `.env.example` to `.env.local`
   - Add your API keys and configuration

4. Run the development server:
   ```bash
   npm run dev
   ```

5. Open [http://localhost:3000](http://localhost:3000) in your browser

## Environment Variables

Required environment variables:
- `MONGODB_URI`: MongoDB connection string
- `GOOGLE_PLACES_API_KEY`: Google Places API key

## Project Structure

```
denver_contractors/
├── src/
│   ├── app/                 # Next.js app directory
│   ├── components/          # Reusable React components
│   ├── models/             # MongoDB models
│   ├── types/              # TypeScript type definitions
│   └── utils/              # Utility functions
├── public/                 # Static assets
└── prisma/                # Prisma schema and migrations
```

## Available Scripts

- `npm run dev`: Start development server
- `npm run build`: Build production application
- `npm run start`: Start production server
- `npm run lint`: Run ESLint
- `npm run test`: Run tests

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Next.js team for the amazing framework
- Google Places API for contractor data
- Material-UI team for the component library
- All contributors who have helped with the project

## Contact

For questions or feedback, please open an issue in the repository.
