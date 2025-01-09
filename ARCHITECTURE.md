# Contractor Directory - System Architecture

## Overview
The Contractor Directory is a modern web application built using Next.js 15, providing a simple and efficient way to find local contractors. The application follows a clean, straightforward architecture focused on delivering contractor information to users.

## System Components

### 1. Frontend Architecture
- **Pages**
  - Home page (`/`)
  - Category pages (`/[category]`)
  - Subregion pages (`/[category]/[subregion]`)
  - Contractor details (`/[category]/[subregion]/[contractor]`)

- **Components**
  - ContractorCard
  - CategoryList
  - SubregionSelector
  - SearchBar
  - Navigation
  - Layout

### 2. Core Technologies
- **Framework**: Next.js 15.1.3 with React 19
- **Database**: Supabase (PostgreSQL)
- **Styling**: Tailwind CSS + Radix UI

### 3. Key Components

#### Frontend Components
- **Layout System**: App Router-based layouts with shared components
- **UI Components**: Built on Radix UI primitives
- **API Client**: Axios for data fetching

#### Backend Services
- **API Routes**: Next.js API routes for data retrieval
- **Database**: Supabase for data storage
- **Search**: Basic trade and location filtering

### 4. Data Flow
1. **Client-Side Flow**
   - Component renders and displays data
   - User navigates through trades and regions
   - API calls fetch relevant contractor data
   - UI updates to show results

2. **Server-Side Flow**
   - Next.js handles initial page load
   - API routes process data requests
   - Supabase retrieves contractor information
   - Response sent back to client

### 5. Performance Optimizations
- Server-side rendering
- Image optimization
- Code splitting
- Route prefetching
- Caching strategies
- Asset optimization

## Design Decisions

### 1. Next.js App Router
- Chosen for better SEO
- Server components for reduced client bundle
- Simplified routing and layouts
- Built-in optimization features

### 2. Supabase
- Simple data storage solution
- Efficient querying capabilities
- Reduced backend maintenance

### 3. Tailwind CSS
- Utility-first approach
- Consistent design system
- Reduced CSS bundle size
- Easy responsive design

### 4. Radix UI
- Accessible by default
- Customizable components
- Consistent behavior
- Reduced implementation time

## Project Architecture

### Components
- **TradePage**: Displays trade information
- **TradeRegionPage**: Shows details for specific regions
- **TradeLocationContainer**: Fetches and displays contractor data

### Data Fetching
- Utilizes server-side data fetching with caching for performance

## Data Model

### Hierarchical Structure
```
Categories (Trades)
└── Regions
    └── Subregions
        └── Neighborhoods
            └── Contractors
```

### Database Schema
- Full schema details in `DATABASE_POPULATION_GUIDE.md`
- Referential integrity via foreign keys
- Unique constraints on slugs

#### Tables Overview
- **contractors**: Main contractor information
- **categories**: Trade categories (e.g., plumbers, electricians)
- **regions**: Main geographical regions
- **subregions**: Sub-areas within regions
- **neighborhoods**: Specific neighborhoods

### URL Structure
```
/[trade]/[region]/[neighborhood]
└─ Trade  └─ Region └─ Neighborhood
```

## Current Implementation Status

### Completed
1. **Database Structure**
   - All tables created and configured
   - Relationships established
   - Indexes optimized

2. **API Integration**
   - Google Places API connection
   - Data fetching and formatting
   - Error handling and rate limiting

3. **Base Components**
   - Core UI components
   - Navigation system
   - Layout structure

### In Progress
1. **Data Population**
   - Populating contractors table with real data
   - ~2,400 contractors being added
   - Data validation and formatting

### Next Phase
1. **Frontend Updates**
   - Integrate real contractor data
   - Enhance search functionality
   - Improve filtering system
   - Add pagination

2. **Performance Optimization**
   - Implement caching
   - Optimize database queries
   - Add loading states

3. **Testing**
   - Component testing
   - Integration testing
   - Performance testing

## Technical Stack
- Next.js 15.1.3
- TypeScript
- Tailwind CSS
- Supabase
- Google Places API

## Development Guidelines
1. Use TypeScript for all new components
2. Follow component-based architecture
3. Implement proper error handling
4. Add loading states for async operations
5. Use proper type definitions
6. Document all major functions and components

## Deployment
- Vercel for frontend
- Supabase for backend
- Environment variables properly configured
- Production build optimizations implemented

This architecture document should be updated as the system evolves.
