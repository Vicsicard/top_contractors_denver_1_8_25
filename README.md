# Denver Contractors

A Next.js-based platform connecting Denver residents with trusted local contractors. The platform features location-based search, contractor profiles, and an easy-to-use inquiry system.

## Features

- 🔍 Location-based contractor search
- 📱 Mobile-responsive design
- 📝 Easy contact system with phone and form options
- 🗺️ Google Places API integration
- 📊 Dynamic trade and location pages
- 📱 Responsive design
- 🔒 SSL security
- 📰 Blog integration
- 🗺️ Dynamic sitemap generation

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Database**: MongoDB
- **Styling**: Tailwind CSS
- **APIs**: 
  - Google Places API
  - Ghost CMS
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
Create a `.env.local` file with:
```env
NEXT_PUBLIC_GOOGLE_PLACES_API_KEY=your_api_key
MONGODB_URI=your_mongodb_uri
MONGODB_DB=your_database_name
NEXT_PUBLIC_DOMAIN=your_domain
```

4. Run the development server:
```bash
npm run dev
```

5. Build for production:
```bash
npm run build
```

## Project Structure

```
denver_contractors/
├── src/
│   ├── app/                 # Next.js 13+ app directory
│   ├── components/          # Reusable components
│   ├── utils/              # Utility functions
│   └── types/              # TypeScript type definitions
├── public/                 # Static files
├── prisma/                # Database schema
└── package.json           # Project dependencies
```

## Key Components

- `InquiryForm`: Handles user inquiries with both form submission and direct call options
- `Header`: Navigation and contact options
- `ContractorLayout`: Template for contractor service pages
- `SearchBox`: Location-based contractor search
- `LocationPages`: Dynamic location-based routing

## API Routes

- `/api/inquiries`: Handles form submissions
- `/api/search/places`: Google Places API integration
- `/api/test-db`: Database connection testing
- `/sitemap.xml`: Dynamic sitemap generation

## Contact Options

Users can contact contractors through:
1. Direct phone call: (720) 555-5555
2. Online inquiry form with fields for:
   - Name
   - Email
   - Phone
   - Service type
   - Project description
   - Budget range
   - Preferred contact method

## Development Guidelines

1. Follow TypeScript best practices
2. Use ESLint for code quality
3. Implement proper error handling
4. Add loading states for async operations
5. Keep components modular and reusable
6. Maintain mobile-first approach
7. Optimize for SEO

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to the branch
5. Open a pull request

## License

This project is private and proprietary. All rights reserved.

## Support

For support, email support@topcontractorsdenver.com
