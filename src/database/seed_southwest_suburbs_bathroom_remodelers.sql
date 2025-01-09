-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Littleton/Lakewood area
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
-- 1. Littleton Bath Design
(
  'cont_bath_sws_001',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Littleton Bath Design',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-8901',
  'https://www.littletonbathdesign.com',
  4.9,
  178,
  'littleton-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Bath & Tile
(
  'cont_bath_sws_002',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Lakewood Bath & Tile',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-8902',
  'https://www.lakewoodbath.com',
  4.8,
  156,
  'lakewood-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Bath Masters
(
  'cont_bath_sws_003',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Belmar Bath Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-8903',
  'https://www.belmarbath.com',
  4.7,
  134,
  'belmar-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Bath Co
(
  'cont_bath_sws_004',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Bath Co',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-8904',
  'https://www.southwestplazabath.com',
  4.8,
  167,
  'southwest-plaza-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Bath Studio
(
  'cont_bath_sws_005',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Ken Caryl Bath Studio',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-8905',
  'https://www.kencarylbath.com',
  4.9,
  189,
  'ken-caryl-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Bath Design
(
  'cont_bath_sws_006',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Union Boulevard Bath Design',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-8906',
  'https://www.unionblvdbath.com',
  4.7,
  145,
  'union-boulevard-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Bath Co
(
  'cont_bath_sws_007',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Green Mountain Bath Co',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-8907',
  'https://www.greenmountainbath.com',
  4.8,
  156,
  'green-mountain-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Bath
(
  'cont_bath_sws_008',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Bath',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-8908',
  'https://www.historiclittletonbath.com',
  4.6,
  123,
  'historic-downtown-littleton-bath',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Bath Specialists
(
  'cont_bath_sws_009',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Bear Creek Bath Specialists',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-8909',
  'https://www.bearcreekbath.com',
  4.8,
  167,
  'bear-creek-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Bath Design
(
  'cont_bath_sws_010',
  'cat_bath_001',
  'neigh_lit_lake_001',
  'Columbine Bath Design',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-8910',
  'https://www.columbinebath.com',
  4.7,
  145,
  'columbine-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
