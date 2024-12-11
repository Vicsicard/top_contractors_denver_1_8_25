# Denver Contractors

A Next.js-based web application for finding and connecting with contractors in the Denver area. Built with TypeScript and deployed on Vercel.

## Features

- 🔍 Search for contractors by service type
- 📍 Location-based contractor filtering
- 📱 Responsive design for all devices
- ⚡ Fast, server-side rendered pages
- 🎨 Modern UI with TailwindCSS

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Styling**: TailwindCSS
- **Database**: MongoDB
- **API**: Google Places API
- **Deployment**: Vercel

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
GOOGLE_PLACES_API_KEY=your_google_places_api_key
```

4. Run the development server:
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

## Project Structure

- `/src/app` - Next.js app router pages and layouts
- `/src/components` - Reusable React components
- `/src/utils` - Utility functions and helpers
- `/src/models` - Data models and types
- `/public` - Static assets

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run lint` - Run ESLint
- `npm run type-check` - Run TypeScript compiler check

## Deployment

The application is deployed on Vercel. Each push to the main branch triggers an automatic deployment.

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
