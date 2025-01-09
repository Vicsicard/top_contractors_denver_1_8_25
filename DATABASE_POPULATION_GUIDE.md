# Contractor Directory Database Population Guide

## Database Schema (Source of Truth)

### Core Tables

#### 1. contractors
```typescript
{
  id: string                  // UUID format
  category_id: string         // References categories.id
  neighborhood_id: string     // References neighborhoods.id
  contractor_name: string     // Full business name
  address: string            // Full street address
  phone: string             // Format: (303) XXX-XXXX
  website: string | null    // Full URL or null
  reviews_avg: number       // Range: 1.0 to 5.0
  reviews_count: number     // Integer
  slug: string             // URL-friendly version of name
  created_at: string       // Timestamp
  updated_at: string       // Timestamp
}
```

#### 2. categories
```typescript
{
  id: string              // UUID format
  category_name: string   // Trade name (e.g., "Plumber")
  slug: string           // URL-friendly version of category_name
  created_at: string     // Timestamp
  updated_at: string     // Timestamp
}
```

#### 3. regions
```typescript
{
  id: string            // UUID format
  region_name: string   // Main area name (e.g., "Central Denver")
  slug: string         // URL-friendly version of region_name
  created_at: string   // Timestamp
  updated_at: string   // Timestamp
}
```

#### 4. subregions
```typescript
{
  id: string              // UUID format
  region_id: string       // References regions.id
  subregion_name: string  // Area name (e.g., "Downtown Area")
  slug: string           // URL-friendly version of subregion_name
  created_at: string     // Timestamp
  updated_at: string     // Timestamp
}
```

#### 5. neighborhoods
```typescript
{
  id: string                // UUID format
  subregion_id: string      // References subregions.id
  neighborhood_name: string  // Specific area (e.g., "Downtown Denver")
  slug: string             // URL-friendly version of neighborhood_name
  description: string | null // Optional description
  created_at: string       // Timestamp
  updated_at: string       // Timestamp
}
```

## Schema Structure

### Tables

1. **categories**
   - `id`: UUID (Primary Key)
   - `category_name`: VARCHAR(255)
   - `slug`: VARCHAR(255) UNIQUE
   - `created_at`: TIMESTAMP WITH TIME ZONE
   - `updated_at`: TIMESTAMP WITH TIME ZONE

2. **regions**
   - `id`: UUID (Primary Key)
   - `region_name`: VARCHAR(255)
   - `slug`: VARCHAR(255) UNIQUE
   - `created_at`: TIMESTAMP WITH TIME ZONE
   - `updated_at`: TIMESTAMP WITH TIME ZONE

3. **subregions**
   - `id`: UUID (Primary Key)
   - `region_id`: UUID (Foreign Key to regions.id)
   - `subregion_name`: VARCHAR(255)
   - `slug`: VARCHAR(255) UNIQUE
   - `created_at`: TIMESTAMP WITH TIME ZONE
   - `updated_at`: TIMESTAMP WITH TIME ZONE

4. **neighborhoods**
   - `id`: UUID (Primary Key)
   - `subregion_id`: UUID (Foreign Key to subregions.id)
   - `neighborhood_name`: VARCHAR(255)
   - `slug`: VARCHAR(255) UNIQUE
   - `description`: TEXT
   - `created_at`: TIMESTAMP WITH TIME ZONE
   - `updated_at`: TIMESTAMP WITH TIME ZONE

5. **contractors**
   - `id`: UUID (Primary Key)
   - `category_id`: UUID (Foreign Key to categories.id)
   - `neighborhood_id`: UUID (Foreign Key to neighborhoods.id)
   - `contractor_name`: VARCHAR(255)
   - `address`: VARCHAR(255)
   - `phone`: VARCHAR(20) with pattern check '^\\(\\d{3}\\) \\d{3}-\\d{4}$'
   - `website`: VARCHAR(255)
   - `reviews_avg`: DECIMAL(2,1) range [1.0, 5.0]
   - `reviews_count`: INTEGER (non-negative)
   - `slug`: VARCHAR(255) UNIQUE
   - `created_at`: TIMESTAMP WITH TIME ZONE
   - `updated_at`: TIMESTAMP WITH TIME ZONE

## URL Structure

The website uses a hierarchical URL structure: `/{trade}/{region}/{area}`

### Slug Rules

1. **Trade Categories**
   - Must be pluralized (except 'hvac')
   - Example: 'plumber' -> 'plumbers'
   - Valid slugs: 'plumbers', 'electricians', 'hvac', 'roofers', 'painters'

2. **Regions**
   - Hyphenated, lowercase
   - Example: 'Central Denver' -> 'central-denver'
   - Valid slugs: 'central-denver', 'east-denver', 'northwest-suburbs', 'northeast-suburbs', 'southeast-suburbs'

3. **Areas/Neighborhoods**
   - Most end in '-area'
   - Downtown is special case: 'downtown-denver'
   - Example: 'Central Parks' -> 'central-parks-area'
   - Valid slugs: 'central-parks-area', 'central-shopping-area', 'downtown-denver'

### Example Valid URLs
- `/plumbers/central-denver/central-parks-area`
- `/plumbers/central-denver/downtown-denver`
- `/plumbers/central-denver/central-shopping-area`
- `/electricians/central-denver/downtown-denver`
- `/hvac/central-denver/central-parks-area`

## Overview
This guide outlines the systematic approach to populating the contractor directory database with verified business data. Each trade category is populated region by region, ensuring comprehensive coverage of the Denver metropolitan area.

## Geographic Coverage

### Denver Core Areas
1. **Central Denver**
   - Downtown Denver
   - Central Parks Area
   - Central Shopping Area

2. **East Denver**
   - Park Hill Area
   - Northeast Area
   - East Colfax Area

### Denver Suburbs
1. **Northwest Suburbs**
   - Westminster
   - Arvada
   - Broomfield

2. **Northeast Suburbs**
   - Thornton
   - Northglenn

3. **Southeast Suburbs**
   - Aurora
   - Denver Tech Center (DTC)

4. **Southwest Suburbs**
   - Littleton
   - Lakewood

## Population Process

### Step 1: Populate Base Tables
1. Categories (trades)
2. Regions (main areas)
3. Subregions (area groups)
4. Neighborhoods (specific areas)

### Step 2: Populate Contractors by Trade
Starting with Plumbers:
1. Ensure each neighborhood has exactly 10 contractors
2. Required fields for each contractor:
   - Full business name (unique)
   - Physical address (in correct neighborhood)
   - Phone number (303 area code)
   - Website (if available)
   - Review ratings (realistic distribution)
   - Review counts (realistic numbers)
   - Emergency service availability (noted in description)

## Data Entry Rules
1. **Slugs**: Always lowercase, hyphenated (e.g., "mile-high-plumbing")
2. **Phone Numbers**: (303) XXX-XXXX format
3. **Addresses**: Must be real streets in the correct neighborhood
4. **Reviews**: 
   - Average: Between 3.5 and 5.0
   - Count: Between 50 and 500
5. **Websites**: Format: https://www.businessname.com

## Trade Category Slug Rules

The following rules govern how trade category slugs are formatted:

1. **Countable Trades (Pluralized)**
   - Plumber → `plumbers`
   - Electrician → `electricians`
   - Roofer → `roofers`
   - Painter → `painters`
   - Landscaper → `landscapers`

2. **Already Plural/Collection Names (Unchanged)**
   - Bathroom Remodeler → `bathroom-remodelers`
   - Kitchen Remodeler → `kitchen-remodelers`
   - Home Remodeler → `home-remodelers`
   - Decks → `decks`
   - Windows → `windows`

3. **Uncountable/Mass Nouns (Singular)**
   - HVAC → `hvac`
   - Masonry → `masonry`
   - Flooring → `flooring`
   - Fencing → `fencing`
   - Epoxy Garage → `epoxy-garage`
   - Siding & Gutters → `siding-gutters`

### Slug Validation Rules
- All slugs must be lowercase
- Words are separated by hyphens
- No special characters (except hyphens)
- No trailing or leading hyphens
- Must be unique across all categories

## Cross-Area Listings
- Contractors can be listed in multiple areas if:
  1. They are within reasonable distance
  2. The areas are adjacent
  3. They service multiple areas
- Each listing must have a unique physical address
- Phone and website can be reused across areas

## Implementation Progress

### 1. Plumbers (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 2. Electricians (COMPLETED)
- All areas populated with 10 contractors each
- Total: 100 contractors

### 3. HVAC Contractors (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 4. Roofers (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 5. Painters (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 6. Landscapers (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 7. Home Remodelers (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 8. Bathroom Remodelers (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 9. Kitchen Remodelers (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 10. Siding & Gutters (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 11. Masonry (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 12. Decks (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 13. Flooring (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 14. Windows (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 15. Fencing (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### 16. Epoxy Garage (COMPLETED)
- **Central Denver**
  - Downtown Denver (10 contractors)
  - Central Parks Area (10 contractors)
  - Central Shopping Area (10 contractors)
- **East Denver**
  - Park Hill Area (10 contractors)
  - Northeast Area (10 contractors)
  - East Colfax Area (10 contractors)
- **Northwest Suburbs**
  - Westminster/Arvada Area (10 contractors)
- **Northeast Suburbs**
  - Thornton/Northglenn Area (10 contractors)
- **Southeast Suburbs**
  - Aurora/DTC Area (10 contractors)
- **Southwest Suburbs**
  - Littleton/Lakewood Area (10 contractors)

### Epoxy Garage
- Garage floor epoxy coating
- Decorative epoxy finishes
- Commercial epoxy flooring
- Industrial epoxy solutions
- Moisture barrier systems
- Anti-slip coatings
- Custom color designs
- Clear coat finishes
- Epoxy repair and maintenance
- Surface preparation

## Current Progress
1. **Plumbers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

2. **Electricians**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

3. **HVAC Contractors**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

4. **Roofers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

5. **Painters**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

6. **Landscapers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

7. **Home Remodelers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

8. **Bathroom Remodelers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

9. **Kitchen Remodelers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

10. **Siding & Gutters**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

11. **Masonry**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

12. **Decks**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

13. **Flooring**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

14. **Windows**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

15. **Fencing**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

16. **Epoxy Garage**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

## Trade Categories to Complete
1. ✓ Plumbers
2. ✓ Electricians
3. ✓ HVAC Technicians
4. ✓ Roofers
5. ✓ Painters
6. ✓ Landscapers
7. ✓ Home Remodelers
8. ✓ Bathroom Remodelers
9. ✓ Kitchen Remodelers
10. ✓ Siding & Gutters
11. ✓ Masonry
12. ✓ Decks
13. ✓ Flooring
14. ✓ Windows
15. ✓ Fencing
16. ✓ Epoxy Garage

## Category-Specific Guidelines

### Plumbers
- Emergency service availability noted
- Common services: repairs, installations, maintenance
- Service areas clearly defined
- License numbers included where available

### Electricians
- Emergency service availability noted
- Residential and commercial service distinction
- Common services: repairs, installations, upgrades
- Focus on safety certifications
- License numbers included where available

### HVAC Contractors
- Emergency service availability noted
- Residential and commercial capabilities
- Services: installations, repairs, maintenance
- Specialties: heating, cooling, ventilation
- Focus on energy efficiency
- License and certification information
- 24/7 emergency services highlighted
- Seasonal maintenance programs noted

### Roofers
- Emergency service availability noted
- Residential and commercial capabilities
- Services: repairs, installations, inspections
- Storm damage expertise
- Insurance claim assistance
- Warranty information included
- Material specialties listed
- Safety certifications and insurance
- License numbers included where available

### Painters
- Interior and exterior painting services
- Residential and commercial capabilities
- Surface preparation expertise
- Color consultation services
- Specialty finishes and techniques
- Eco-friendly paint options
- Warranty information
- Insurance and licensing details
- Project portfolio examples

### Landscapers
- Residential and commercial landscaping services
- Lawn care and maintenance
- Garden design and installation
- Hardscaping (patios, walkways, retaining walls)
- Irrigation system installation and repair
- Tree and shrub planting and care
- Seasonal cleanup and maintenance
- Outdoor lighting installation
- Water features and fountains
- Sustainable landscaping practices

### Home Remodelers
- Kitchen and bathroom remodeling
- Whole house renovations
- Room additions and expansions
- Basement finishing
- Custom cabinetry and countertops
- Flooring installation and refinishing
- Interior design services
- Structural modifications
- Permit acquisition and management
- Energy-efficient upgrades

### Bathroom Remodelers
- Complete bathroom renovations
- Shower and tub installations
- Vanity and sink replacements
- Tile work and flooring
- Plumbing fixtures and fittings
- Lighting and electrical updates
- Custom cabinetry
- Accessibility modifications
- Water-efficient fixtures
- Ventilation systems

### Kitchen Remodelers
- Complete kitchen renovations
- Custom cabinet design and installation
- Countertop selection and installation
- Kitchen island design
- Appliance installation
- Lighting and electrical updates
- Plumbing fixtures and fittings
- Flooring installation
- Backsplash design and installation
- Smart kitchen technology integration

### Siding & Gutters
- Siding installation and repair
- Vinyl, fiber cement, and wood siding
- Gutter installation and maintenance
- Seamless gutter systems
- Gutter guards and protection
- Downspout installation
- Fascia and soffit repair
- Exterior trim work
- Weatherproofing services
- Storm damage repair

### Masonry
- Brick installation and repair
- Stone masonry work
- Retaining walls
- Chimneys and fireplaces
- Outdoor kitchens and BBQ pits
- Decorative stonework
- Foundation repair
- Concrete block work
- Tuckpointing and restoration
- Historic masonry preservation

### Decks
- Custom deck design and construction
- Deck repair and restoration
- Composite decking installation
- Wood deck installation
- Multi-level deck construction
- Pool deck installation
- Deck staining and sealing
- Deck railings and stairs
- Covered deck construction
- Deck lighting installation

### Flooring
- Hardwood floor installation
- Tile and stone flooring
- Carpet installation
- Laminate flooring
- Vinyl and linoleum
- Floor refinishing
- Floor repair and restoration
- Custom flooring designs
- Commercial flooring
- Eco-friendly flooring options

### Windows
- Window installation and replacement
- Energy-efficient window solutions
- Storm windows
- Custom window designs
- Window repair and restoration
- Bay and bow windows
- Sliding glass doors
- Window frame repair
- Glass replacement
- Window weatherization

### Fencing
- Residential fence installation
- Commercial fencing solutions
- Privacy fences
- Security fences
- Decorative fencing
- Chain link fences
- Wood fences
- Vinyl fencing
- Metal and wrought iron fences
- Gate installation and repair

### Epoxy Garage
- Garage floor epoxy coating
- Decorative epoxy finishes
- Commercial epoxy flooring
- Industrial epoxy solutions
- Moisture barrier systems
- Anti-slip coatings
- Custom color designs
- Clear coat finishes
- Epoxy repair and maintenance
- Surface preparation

## Current Progress
1. **Plumbers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

2. **Electricians**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

3. **HVAC Contractors**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

4. **Roofers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

5. **Painters**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

6. **Landscapers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

7. **Home Remodelers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

8. **Bathroom Remodelers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

9. **Kitchen Remodelers**
   - All areas populated
   - 10 contractors per area
   - Total: 100 contractors

10. **Siding & Gutters**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

11. **Masonry**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

12. **Decks**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

13. **Flooring**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

14. **Windows**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

15. **Fencing**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

16. **Epoxy Garage**
    - All areas populated
    - 10 contractors per area
    - Total: 100 contractors

## Trade Categories to Complete
1. ✓ Plumbers
2. ✓ Electricians
3. ✓ HVAC Technicians
4. ✓ Roofers
5. ✓ Painters
6. ✓ Landscapers
7. ✓ Home Remodelers
8. ✓ Bathroom Remodelers
9. ✓ Kitchen Remodelers
10. ✓ Siding & Gutters
11. ✓ Masonry
12. ✓ Decks
13. ✓ Flooring
14. ✓ Windows
15. ✓ Fencing
16. ✓ Epoxy Garage

## Data Consistency
- Each area maintains exactly 10 contractors
- All contractors have complete profiles
- Reviews maintain realistic distribution
- Contact information verified and formatted consistently
- Geographic coverage ensures no gaps in service areas

## Automatic Updates

- All tables have `created_at` and `updated_at` timestamps
- `updated_at` is automatically updated via triggers when records are modified

## Data Relationships

1. Contractors belong to:
   - One category (trade type)
   - One neighborhood

2. Neighborhoods belong to:
   - One subregion

3. Subregions belong to:
   - One region

This hierarchical structure ensures proper organization and navigation through the website.
