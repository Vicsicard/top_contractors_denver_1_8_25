-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Southwest Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_sw_suburbs_001',
  'Southwest Suburbs',
  'southwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Littleton/Lakewood subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_lit_lake_001',
  'reg_sw_suburbs_001',
  'Littleton/Lakewood',
  'littleton-lakewood',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Littleton/Lakewood neighborhood exists
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

-- Insert 10 Roofers for Littleton/Lakewood area
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
-- 1. Littleton Premier Roofing
(
  'cont_roof_sw_sub_001',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Littleton Premier Roofing',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-4901',
  'https://www.littletonpremierroofing.com',
  4.9,
  198,
  'littleton-premier-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Roofing Masters
(
  'cont_roof_sw_sub_002',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Lakewood Roofing Masters',
  '7777 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-4902',
  'https://www.lakewoodroofingmasters.com',
  4.8,
  167,
  'lakewood-roofing-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Roofing Solutions
(
  'cont_roof_sw_sub_003',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Belmar Roofing Solutions',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-4903',
  'https://www.belmarroofing.com',
  4.7,
  145,
  'belmar-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Roofing
(
  'cont_roof_sw_sub_004',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Roofing',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-4904',
  'https://www.southwestplazaroofing.com',
  4.8,
  156,
  'southwest-plaza-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Roofing Co
(
  'cont_roof_sw_sub_005',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Ken Caryl Roofing Co',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-4905',
  'https://www.kencarylroofing.com',
  4.9,
  187,
  'ken-caryl-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Roofing
(
  'cont_roof_sw_sub_006',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Union Boulevard Roofing',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-4906',
  'https://www.unionblvdroofing.com',
  4.7,
  143,
  'union-boulevard-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Roofing Pros
(
  'cont_roof_sw_sub_007',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Green Mountain Roofing Pros',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-4907',
  'https://www.greenmountainroofing.com',
  4.8,
  134,
  'green-mountain-roofing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Roofing
(
  'cont_roof_sw_sub_008',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Roofing',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-4908',
  'https://www.historiclittletonroofing.com',
  4.6,
  123,
  'historic-downtown-littleton-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Federal Center Roofing
(
  'cont_roof_sw_sub_009',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Federal Center Roofing',
  '11000 W 6th Ave, Lakewood, CO 80215',
  '(303) 555-4909',
  'https://www.federalcenterroofing.com',
  4.8,
  167,
  'federal-center-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Bear Creek Roofing Systems
(
  'cont_roof_sw_sub_010',
  'cat_roof_001',
  'neigh_lit_lake_001',
  'Bear Creek Roofing Systems',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-4910',
  'https://www.bearcreekroofing.com',
  4.7,
  145,
  'bear-creek-roofing-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
