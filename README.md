# Denver Contractors Search

A modern Next.js application designed to help users find and connect with contractors in the Denver area. The application provides a streamlined interface to search for and view detailed information about local contractors.

## Features

- 🔍 Advanced contractor search with trade-specific filters
- 📍 Comprehensive contractor information including:
  - Business name and rating
  - Complete address with location icon
  - Phone number with click-to-call
  - Website links with direct access
  - Star ratings and reviews
- 🎯 Specialized trade categories including:
  - Home Remodeling
  - Bathroom Remodeling
  - Kitchen Remodeling
  - Siding & Gutters
  - And many more!
- 🌐 Powered by Google Places API for accurate data
- 📱 Fully responsive design for all devices
- ⚡ Lightning-fast performance with Next.js
- 🎨 Modern UI with beautiful blue gradients
- 🔄 Smooth transitions and loading states
- 🔒 Secure API handling

## UI Components

- **Header**: Modern design with blue gradient background
- **Search Box**: Glass-morphism effect with smooth animations
- **Trade Cards**: Interactive cards with hover effects
- **Location Cards**: Clean design with subtle animations
- **Footer**: Rich blue gradient with essential information
- **Loading States**: Elegant loading animations during:
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

## Project Status

- The project is currently in development.
- Recent changes have been made to the header color and the trade route handling.

## Recent Changes

1. **Header Component**: Updated the title color to match the main blue color in the UI.
2. **Trade Route**: Fixed the parameter handling in the `trade` route to await the `params` object before accessing its properties.
3. **Error Handling**: Improved error handling for invalid trade types in the `TradePage` component.

## Project Updates

### Recent Changes
- Added "Handy Man" and "Landscaper" categories back to the application.
- Integrated Bottleneck for rate limiting in Google Places API requests.
- Updated icons for new categories in the UI.

### Known Issues
- Build process encountered permission issues with the `.next` directory.
- Port 3004 was in use, switched to 3005 for development server.

### Next Steps
- Resolve permission issues and test build.
- Verify that new categories retrieve correct data from Google Places API.

### Current Time
- The current local time is: 2024-12-16T08:56:20-07:00.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
