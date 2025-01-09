-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southwest Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_sw_suburbs_001',
  'Southwest Suburbs',
  'southwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Littleton/Lakewood subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_lit_lake_001',
  'reg_sw_suburbs_001',
  'Littleton/Lakewood',
  'littleton-lakewood',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Littleton/Lakewood neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_lit_lake_001',
  'subreg_lit_lake_001',
  'Littleton/Lakewood',
  'littleton-lakewood',
  'Including Littleton, Lakewood, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 HVAC contractors for Littleton/Lakewood area
INSERT INTO contractors (
  id,
  category_id,
  neighborhood_id,
  contractor_name,
  address,
  phone,
  website,
  reviews_avg,
  reviews_count,
  slug,
  created_at,
  updated_at
) VALUES 
-- 1. Littleton HVAC Masters
(
  'cont_hvac_sws_001',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Littleton HVAC Masters',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-3901',
  'https://www.littletonhvac.com',
  4.9,
  234,
  'littleton-hvac-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Air Systems
(
  'cont_hvac_sws_002',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Lakewood Air Systems',
  '7777 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-3902',
  'https://www.lakewoodhvac.com',
  4.8,
  198,
  'lakewood-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Climate Control
(
  'cont_hvac_sws_003',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Belmar Climate Control',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-3903',
  'https://www.belmarhvac.com',
  4.7,
  167,
  'belmar-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza HVAC
(
  'cont_hvac_sws_004',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Southwest Plaza HVAC',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-3904',
  'https://www.southwestplazahvac.com',
  4.8,
  189,
  'southwest-plaza-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Southwest Metro Climate Pros
(
  'cont_hvac_sws_005',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Southwest Metro Climate Pros',
  '3500 S Wadsworth Blvd, Lakewood, CO 80235',
  '(303) 555-3905',
  'https://www.swmetrohvac.com',
  4.9,
  212,
  'southwest-metro-climate-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ken Caryl HVAC
(
  'cont_hvac_sws_006',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Ken Caryl HVAC',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-3906',
  'https://www.kencarylhvac.com',
  4.7,
  178,
  'ken-caryl-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Union Boulevard Air Solutions
(
  'cont_hvac_sws_007',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Union Boulevard Air Solutions',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-3907',
  'https://www.unionblvdhvac.com',
  4.8,
  167,
  'union-boulevard-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Green Mountain HVAC Services
(
  'cont_hvac_sws_008',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Green Mountain HVAC Services',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-3908',
  'https://www.greenmountainhvac.com',
  4.6,
  156,
  'green-mountain-hvac-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Historic Downtown Littleton Climate Services
(
  'cont_hvac_sws_009',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Climate Services',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-3909',
  'https://www.historiclittletonhvac.com',
  4.8,
  201,
  'historic-downtown-littleton-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Federal Center HVAC Specialists
(
  'cont_hvac_sws_010',
  'cat_hvac_001',
  'neigh_lit_lake_001',
  'Federal Center HVAC Specialists',
  '11000 W 6th Ave, Lakewood, CO 80215',
  '(303) 555-3910',
  'https://www.federalcenterhvac.com',
  4.7,
  182,
  'federal-center-hvac-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
