# Denver Contractors Search

A Next.js application to help users find and connect with contractors in the Denver area.

## Features

- 🔍 Search for contractors by trade or location
- 📍 Integration with Google Places API for accurate business information
- 📱 Responsive design for mobile and desktop
- ⚡ Fast server-side rendering with Next.js
- 🎨 Modern UI with Tailwind CSS
- 🔒 Secure API key handling
- 🔄 Real-time search results
- 📊 Loading states and error handling

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **API**: Google Places API
- **Database**: MongoDB (planned)
- **Deployment**: Vercel (planned)

## Getting Started

### Prerequisites

- Node.js (v18 or higher)
- npm
- Google Places API key
- MongoDB connection (for future features)

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

3. Create a `.env.local` file in the root directory and add your environment variables:
   ```env
   GOOGLE_PLACES_API_KEY=your_api_key_here
   MONGODB_URI=your_mongodb_uri
   MONGODB_DB=your_database_name
   ```

4. Run the development server:
   ```bash
   npm run dev
   ```

5. Open [http://localhost:3000](http://localhost:3000) in your browser.

### Production Build

1. Build the application:
   ```bash
   npm run build
   ```

2. Start the production server:
   ```bash
   npm run start
   ```

## Project Structure

```
denver_contractors/
├── src/
│   ├── app/
│   │   ├── (pages)/
│   │   │   ├── search/
│   │   │   ├── trade/
│   │   │   └── location/
│   │   ├── api/
│   │   │   └── search/
│   │   └── components/
│   ├── lib/
│   └── types/
├── public/
└── docs/
```

## API Routes

- `/api/search/places`: Search contractors using Google Places API
- `/api/inquiries`: Handle contact form submissions (planned)

## Components

- `SearchResults`: Main component for displaying search results
- `ClientResultsList`: Client-side component for handling search result interactions
- `SearchForm`: Form component for search inputs
- `LoadingState`: Loading indicator component
- `ErrorDisplay`: Error message component

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Next.js team for the amazing framework
- Google Places API for business data
- Tailwind CSS for the styling system

## Contact

Your Name - your.email@example.com
Project Link: [https://github.com/yourusername/denver_contractors](https://github.com/yourusername/denver_contractors)
