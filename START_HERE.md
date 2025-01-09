# Denver Contractor Directory

## Database Schema

The database consists of three main tables:

### Categories Table
Stores the different types of contractors (plumbers, electricians, etc.)
```sql
CREATE TABLE categories (
    id UUID PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);
```

### Subregions Table
Stores the 15 distinct subregions of Denver
```sql
CREATE TABLE subregions (
    id UUID PRIMARY KEY,
    subregion_name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);
```

### Contractors Table
Stores contractor information linked to categories and subregions
```sql
CREATE TABLE contractors (
    id UUID PRIMARY KEY,
    category_id UUID REFERENCES categories(id),
    subregion_id UUID REFERENCES subregions(id),
    contractor_name VARCHAR(200) NOT NULL,
    address VARCHAR(500) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    website VARCHAR(200),
    reviews_avg DECIMAL(2,1),
    reviews_count INTEGER,
    slug VARCHAR(200) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ
);
```

## Subregions (15 Total)
1. Arvada
2. Aurora
3. Broomfield
4. Central Parks Area
5. Central Shopping Area
6. Denver Tech Center
7. Downtown Denver
8. East Colfax Area
9. Lakewood
10. Littleton
11. Northeast Area
12. Northglenn
13. Park Hill Area
14. Thornton
15. Westminster

## Trade Categories (16 Total)
1. Plumbers
2. Electricians
3. HVAC
4. Roofers
5. Painters
6. Landscapers
7. Home Remodelers
8. Bathroom Remodelers
9. Kitchen Remodelers
10. Siding & Gutters
11. Masonry
12. Decks
13. Flooring
14. Windows
15. Fencing
16. Epoxy Garage

## Database Population
- Each subregion has contractors from every trade category
- Each trade category has exactly 10 contractors per subregion
- Total contractors per subregion: 160 (16 trades × 10 contractors)
- Total contractors in database: 2,400 (15 subregions × 16 trades × 10 contractors)

## Seed Files
Seed files are organized by trade category and subregion:
- Example: `seed_downtown_denver_plumbers.sql`
- Each seed file contains exactly 10 contractors
- Total seed files needed: 240 (15 subregions × 16 trades)
