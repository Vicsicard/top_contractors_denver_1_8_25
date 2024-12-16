# Denver Contractors Search

A modern Next.js application designed to help users find and connect with contractors in the Denver area. The application provides a streamlined interface to search for and view detailed information about local contractors.

## Features

- 🔍 Intuitive contractor search functionality
- 📍 Detailed contractor information including:
  - Business name and rating
  - Complete address with location icon
  - Phone number with click-to-call
  - Website links with direct access
  - Star ratings and reviews
- 🌐 Powered by Google Places API for accurate data
- 📱 Responsive design for all devices
- ⚡ Fast and efficient with Next.js
- 🎨 Clean, modern UI using Tailwind CSS
- 🔄 Smooth page transitions with loading indicators
- 🔒 Secure API handling

## UI Components

- **Header**: Minimalist design showing only "Denver Contractors"
- **Footer**: Streamlined footer with essential information:
  - Company name and description
  - Location
  - Contact email
- **Loading Spinner**: Elegant loading animation during:
  - Page transitions
  - Search operations
  - Data fetching

## Tech Stack

- **Framework**: Next.js 15.1.0
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **APIs**: 
  - Google Places API
  - Google Places Details API
- **Deployment**: Vercel (planned)

## Getting Started

### Prerequisites

- Node.js (v18 or higher)
- npm
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

3. Create a `.env.local` file in the root directory:
   ```env
   GOOGLE_PLACES_API_KEY=your_api_key_here
   ```

4. Run the development server:
   ```bash
   npm run dev
   ```

5. Open [http://localhost:3000](http://localhost:3000) in your browser.

## Project Structure

```
denver_contractors/
├── src/
│   ├── app/
│   │   ├── (pages)/
│   │   │   └── search/
│   │   ├── api/
│   │   │   └── search/
│   │   └── components/
│   │       ├── Header.tsx
│   │       ├── Footer.tsx
│   │       ├── LoadingSpinner.tsx
│   │       └── ClientResultsList.tsx
│   ├── lib/
│   └── types/
├── public/
```

## Recent Updates

- Simplified header to only show "Denver Contractors"
- Streamlined footer with essential contact information
- Added loading spinner for better user experience
- Enhanced contractor cards with detailed information
- Improved responsive design
- Integrated Google Places Details API

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
