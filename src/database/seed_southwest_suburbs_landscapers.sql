-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for Littleton/Lakewood area
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
-- 1. Littleton Garden Masters
(
  'cont_land_sws_001',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Littleton Garden Masters',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-6901',
  'https://www.littletongardens.com',
  4.9,
  167,
  'littleton-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Landscape Design
(
  'cont_land_sws_002',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Lakewood Landscape Design',
  '7777 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-6902',
  'https://www.lakewoodlandscape.com',
  4.8,
  145,
  'lakewood-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Gardens
(
  'cont_land_sws_003',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Belmar Gardens',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-6903',
  'https://www.belmargardens.com',
  4.7,
  132,
  'belmar-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Landscaping
(
  'cont_land_sws_004',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Landscaping',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-6904',
  'https://www.southwestplazalandscaping.com',
  4.8,
  156,
  'southwest-plaza-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Garden Design
(
  'cont_land_sws_005',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Ken Caryl Garden Design',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-6905',
  'https://www.kencarylgardens.com',
  4.9,
  178,
  'ken-caryl-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Gardens
(
  'cont_land_sws_006',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Union Boulevard Gardens',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-6906',
  'https://www.unionblvdgardens.com',
  4.7,
  134,
  'union-boulevard-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Landscape Co
(
  'cont_land_sws_007',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Green Mountain Landscape Co',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-6907',
  'https://www.greenmountainlandscape.com',
  4.8,
  145,
  'green-mountain-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Gardens
(
  'cont_land_sws_008',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Gardens',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-6908',
  'https://www.historiclittletongardens.com',
  4.6,
  123,
  'historic-downtown-littleton-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Federal Center Garden Studio
(
  'cont_land_sws_009',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Federal Center Garden Studio',
  '11000 W 6th Ave, Lakewood, CO 80215',
  '(303) 555-6909',
  'https://www.federalcentergardens.com',
  4.8,
  156,
  'federal-center-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Bear Creek Gardens
(
  'cont_land_sws_010',
  'cat_land_001',
  'neigh_lit_lake_001',
  'Bear Creek Gardens',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-6910',
  'https://www.bearcreekgardens.com',
  4.7,
  134,
  'bear-creek-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
