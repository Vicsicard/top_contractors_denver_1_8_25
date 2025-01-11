# Service Pages Implementation Plan

## Page Structure Overview

### 1. Main Services Page (`/services`)
- Denver skyline hero image
- Grid of service categories
  - Each card links to the respective trade page
  - Visual icons for each trade category

### 2. Trade Service Pages (`/services/[trade]`)
- Denver skyline hero image
- Service category description
- Grid of service areas
  - Links to location-specific pages
  - Coverage area visualization

### 3. Location-Specific Pages (`/services/[trade]/[location]`)
- Denver skyline hero image
- Location-specific content
- Contractor listings
- Relevant FAQs

## Implementation Steps

### Phase 1: Core Components
1. [ ] Update ServiceHero component
   - Consistent Denver skyline background
   - Gradient overlay for text readability
   - Responsive design for all screen sizes

2. [ ] Create ContractorCard component
   - Business name
   - Contact information
   - Website link (if available)
   - Clean, professional design

3. [ ] Create ServiceFAQs component
   - Question and answer format
   - Mobile-friendly accordion style
   - Generic but helpful content

### Phase 2: Database Structure
1. [ ] Set up tables in Supabase
   - Trades (categories)
   - Locations (subregions)
   - Contractors
   - Trade-Location relationships

2. [ ] Create database utility functions
   - getCategoryBySlug
   - getSubregionBySlug
   - getContractorsByTradeAndLocation

### Phase 3: Page Implementation
1. [ ] Main Services Page
   - Implement service category grid
   - Add trade icons and descriptions
   - Optimize for mobile view

2. [ ] Trade Service Pages
   - Create dynamic routing
   - Implement area selection grid
   - Add service descriptions

3. [ ] Location-Specific Pages
   - Implement contractor listings
   - Add location-specific content
   - Set up FAQ sections

### Phase 4: SEO Optimization
1. [ ] Metadata Implementation
   - Dynamic title and description
   - OpenGraph tags
   - Canonical URLs

2. [ ] Content Structure
   - Semantic HTML
   - Proper heading hierarchy
   - Alt text for images

3. [ ] URL Structure
   - Clean URLs (/services/[trade]/[location])
   - Static path generation
   - Proper redirects

## Content Guidelines

### Service Descriptions
- Focus on general service information
- No specific claims about individual contractors
- Keep content factual and helpful

### Location Content
- Brief area description
- Mention of service availability
- No specific claims about service quality

### FAQs
Standard questions across all pages:
1. How to choose a contractor?
2. How to contact contractors?
3. What questions to ask?

## Technical Requirements

### Components
```typescript
// Key components needed:
- ServiceHero
- ContractorCard
- ServiceFAQs
```

### Database Schema
```sql
-- Key tables needed:
trades
  - id
  - category_name
  - slug
  - description

locations
  - id
  - subregion_name
  - slug
  - description

contractors
  - id
  - business_name
  - contact_info
  - website
  - trade_id
  - location_id
```

## Next Steps
1. Begin with Phase 1: Core Components
2. Set up database structure
3. Implement main services page
4. Test and validate the implementation

## Notes
- Keep design consistent with Denver skyline theme
- Focus on mobile-first approach
- Maintain clean, professional appearance
- Prioritize user experience and easy navigation
