-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Littleton/Lakewood area
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
-- 1. Littleton Siding & Gutters
(
  'cont_siding_sws_001',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Littleton Siding & Gutters',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-7901',
  'https://www.littletonsiding.com',
  4.9,
  182,
  'littleton-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Exteriors
(
  'cont_siding_sws_002',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Lakewood Exteriors',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-7902',
  'https://www.lakewoodexteriors.com',
  4.8,
  165,
  'lakewood-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Gutter Masters
(
  'cont_siding_sws_003',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Belmar Gutter Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-7903',
  'https://www.belmargutter.com',
  4.7,
  143,
  'belmar-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Siding Solutions
(
  'cont_siding_sws_004',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Siding Solutions',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-7904',
  'https://www.southwestplazasiding.com',
  4.8,
  176,
  'southwest-plaza-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Gutter Co
(
  'cont_siding_sws_005',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Ken Caryl Gutter Co',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-7905',
  'https://www.kencarylgutter.com',
  4.9,
  195,
  'ken-caryl-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Siding & Gutters
(
  'cont_siding_sws_006',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Union Boulevard Siding & Gutters',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-7906',
  'https://www.unionblvdsiding.com',
  4.7,
  134,
  'union-boulevard-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Exterior Specialists
(
  'cont_siding_sws_007',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Green Mountain Exterior Specialists',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-7907',
  'https://www.greenmountainexteriors.com',
  4.8,
  156,
  'green-mountain-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Siding
(
  'cont_siding_sws_008',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Siding',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-7908',
  'https://www.historiclittletonsiding.com',
  4.6,
  122,
  'historic-downtown-littleton-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Gutter Pros
(
  'cont_siding_sws_009',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Bear Creek Gutter Pros',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-7909',
  'https://www.bearcreekgutter.com',
  4.8,
  167,
  'bear-creek-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Siding Solutions
(
  'cont_siding_sws_010',
  'cat_siding_001',
  'neigh_lit_lake_001',
  'Columbine Siding Solutions',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-7910',
  'https://www.columbinesiding.com',
  4.7,
  145,
  'columbine-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
