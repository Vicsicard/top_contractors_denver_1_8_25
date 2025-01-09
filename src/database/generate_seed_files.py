#!/usr/bin/env python3
"""
Seed File Generator for Denver Contractor Directory
Based on SCHEMA_2025_01_03.md specification
Created: January 3rd, 2025
"""

import os
import random
from datetime import datetime

# Constants from SCHEMA_2025_01_03.md
SUBREGIONS = [
    ('Arvada', 'arvada', '80002'),
    ('Aurora', 'aurora', '80012'),
    ('Broomfield', 'broomfield', '80020'),
    ('Central Parks Area', 'central-parks-area', '80238'),
    ('Central Shopping Area', 'central-shopping-area', '80206'),
    ('Denver Tech Center', 'denver-tech-center', '80237'),
    ('Downtown Denver', 'downtown-denver', '80202'),
    ('East Colfax Area', 'east-colfax-area', '80220'),
    ('Lakewood', 'lakewood', '80214'),
    ('Littleton', 'littleton', '80120'),
    ('Northeast Area', 'northeast-area', '80239'),
    ('Northglenn', 'northglenn', '80233'),
    ('Park Hill Area', 'park-hill-area', '80207'),
    ('Thornton', 'thornton', '80229'),
    ('Westminster', 'westminster', '80030')
]

TRADES = [
    ('Plumbers', 'plumbers', 'Plumbing'),
    ('Electricians', 'electricians', 'Electrical'),
    ('HVAC', 'hvac', 'HVAC'),
    ('Roofers', 'roofers', 'Roofing'),
    ('Painters', 'painters', 'Painting'),
    ('Landscapers', 'landscapers', 'Landscaping'),
    ('Home Remodelers', 'home-remodelers', 'Home Remodeling'),
    ('Bathroom Remodelers', 'bathroom-remodelers', 'Bathroom Remodeling'),
    ('Kitchen Remodelers', 'kitchen-remodelers', 'Kitchen Remodeling'),
    ('Siding & Gutters', 'siding-gutters', 'Siding & Gutters'),
    ('Masonry', 'masonry', 'Masonry'),
    ('Decks', 'decks', 'Deck'),
    ('Flooring', 'flooring', 'Flooring'),
    ('Windows', 'windows', 'Window'),
    ('Fencing', 'fencing', 'Fence'),
    ('Epoxy Garage', 'epoxy-garage', 'Epoxy Garage')
]

# Street names by subregion
STREETS = {
    'downtown-denver': [
        '1700 Broadway',
        '1601 Blake Street',
        '1747 Wynkoop St',
        '1430 Larimer St',
        '1144 15th St',
        '1001 16th Street Mall',
        '1437 Bannock St',
        '200 E Colfax Ave',
        '1701 Champa St',
        '1801 California St'
    ],
    'central-parks-area': [
        '8350 Central Park Blvd',
        '7995 E 49th Pl',
        '2373 Central Park Blvd',
        '7484 E 29th Pl',
        '7351 E 29th Ave',
        '2900 Syracuse St',
        '2373 Central Park Blvd',
        '7711 MLK Blvd',
        '8801 E Lowry Blvd',
        '8370 Northfield Blvd'
    ],
    # Add more streets for other subregions
}

def generate_seed_file(subregion, trade):
    """Generate a seed file for a specific subregion and trade."""
    subregion_name, subregion_slug, zip_code = subregion
    trade_name, trade_slug, trade_service = trade
    
    filename = f"seed_{subregion_slug}_{trade_slug}.sql"
    filepath = os.path.join(os.path.dirname(__file__), filename)
    
    # Get street addresses for the subregion
    streets = STREETS.get(subregion_slug, STREETS['downtown-denver'])  # Default to downtown if not found
    
    contractors = []
    for i in range(10):
        phone = f"(303) 555-{1001 + i:04d}"
        reviews_avg = round(random.uniform(4.5, 4.9), 1)
        reviews_count = random.randint(145, 324)
        
        # Generate contractor name variations
        if i == 0:
            name = f"{subregion_name} {trade_name}"
        elif i == 1:
            name = f"{trade_service} Experts of {subregion_name}"
        elif i == 2:
            name = f"Professional {trade_service} {subregion_name}"
        else:
            name = f"{subregion_name} {trade_service} Company {i}"
            
        slug = name.lower().replace(' & ', '-and-').replace(' ', '-')
        website = f"https://{slug}.com"
        address = f"{streets[i]}, Denver, CO {zip_code}"
        
        contractors.append({
            'name': name,
            'address': address,
            'phone': phone,
            'website': website,
            'reviews_avg': reviews_avg,
            'reviews_count': reviews_count,
            'slug': slug
        })
    
    # Generate SQL file
    with open(filepath, 'w') as f:
        f.write(f"""-- Seed file for {subregion_name} {trade_name}
-- Generated: {datetime.now().strftime('%B %d, %Y')}
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for {trade_name}
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = '{trade_slug}'
),
-- Get the subregion_id for {subregion_name}
target_subregion AS (
    SELECT id FROM subregions WHERE slug = '{subregion_slug}'
)
INSERT INTO contractors (
    category_id,
    subregion_id,
    contractor_name,
    address,
    phone,
    website,
    reviews_avg,
    reviews_count,
    slug
) VALUES
""")
        
        # Write contractor values
        for i, contractor in enumerate(contractors):
            f.write(f"""(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    '{contractor['name']}',
    '{contractor['address']}',
    '{contractor['phone']}',
    '{contractor['website']}',
    {contractor['reviews_avg']},
    {contractor['reviews_count']},
    '{contractor['slug']}'
){',' if i < len(contractors)-1 else ';'}\n""")
        
        # Add verification query
        f.write("""
-- Verify insertion
SELECT 
    c.contractor_name,
    s.subregion_name,
    cat.category_name,
    c.address,
    c.phone,
    c.reviews_avg,
    c.reviews_count
FROM contractors c
JOIN categories cat ON c.category_id = cat.id
JOIN subregions s ON c.subregion_id = s.id
WHERE 
    cat.slug = '""" + trade_slug + """' 
    AND s.slug = '""" + subregion_slug + """'
ORDER BY c.contractor_name;
""")

def main():
    """Generate seed files for all combinations of subregions and trades."""
    print(f"Generating seed files based on SCHEMA_2025_01_03.md...")
    
    total_files = len(SUBREGIONS) * len(TRADES)
    files_created = 0
    
    for subregion in SUBREGIONS:
        for trade in TRADES:
            generate_seed_file(subregion, trade)
            files_created += 1
            print(f"Generated seed file for {subregion[0]} {trade[0]} ({files_created}/{total_files})")
    
    print(f"\nCompleted! Generated {files_created} seed files.")
    print("Each file contains 10 contractors as specified in SCHEMA_2025_01_03.md")

if __name__ == "__main__":
    main()
