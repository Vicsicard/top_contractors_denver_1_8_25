# Contractor Directory

A public directory website for finding local contractors in the Denver metropolitan area.

## Features

- Browse contractors by trade (plumbers, electricians, etc.)
- Find contractors in specific regions and neighborhoods
- View complete contractor information
- Simple and easy-to-use interface
- Mobile-friendly design

## Technology Stack

- Next.js 15.1.3
- React 19
- Supabase (PostgreSQL)
- Tailwind CSS
- TypeScript

## Directory Structure

```
src/
├── app/                    # Next.js App Router
│   ├── api/               # Data retrieval endpoints
│   └── trades/           # Trade pages
├── components/            # React components
├── lib/                  # Utility functions
└── types/               # TypeScript definitions
```

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```
3. Set up environment variables:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key
   ```
4. Run the development server:
   ```bash
   npm run dev
   ```

## Data Structure

The directory organizes contractors hierarchically:
- Trade Categories (e.g., Plumbers)
- Regions (e.g., Central Denver)
- Neighborhoods (e.g., Downtown)

Each neighborhood contains 10 verified contractors per trade.

## Contributing

To update contractor information or report issues, please open a GitHub issue.

## License

MIT
