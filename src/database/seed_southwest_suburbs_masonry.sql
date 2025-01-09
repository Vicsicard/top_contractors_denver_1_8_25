-- Ensure Masonry category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_masonry_001',
  'Masonry',
  'masonry',
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

-- Insert 10 Masonry contractors for Littleton/Lakewood area
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
-- 1. Littleton Masonry Works
(
  'cont_masonry_sws_001',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Littleton Masonry Works',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-8901',
  'https://www.littletonmasonry.com',
  4.9,
  188,
  'littleton-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Stone & Brick
(
  'cont_masonry_sws_002',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Lakewood Stone & Brick',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-8902',
  'https://www.lakewoodstone.com',
  4.8,
  166,
  'lakewood-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Brick Masters
(
  'cont_masonry_sws_003',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Belmar Brick Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-8903',
  'https://www.belmarbrick.com',
  4.7,
  144,
  'belmar-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Stone Solutions
(
  'cont_masonry_sws_004',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Stone Solutions',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-8904',
  'https://www.southwestplazastone.com',
  4.8,
  177,
  'southwest-plaza-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Masonry Co
(
  'cont_masonry_sws_005',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Ken Caryl Masonry Co',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-8905',
  'https://www.kencarylmasonry.com',
  4.9,
  198,
  'ken-caryl-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Stone Works
(
  'cont_masonry_sws_006',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Union Boulevard Stone Works',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-8906',
  'https://www.unionblvdstone.com',
  4.7,
  155,
  'union-boulevard-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Masonry Specialists
(
  'cont_masonry_sws_007',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Green Mountain Masonry Specialists',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-8907',
  'https://www.greenmountainmasonry.com',
  4.8,
  166,
  'green-mountain-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Stone
(
  'cont_masonry_sws_008',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Stone',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-8908',
  'https://www.historiclittletonstone.com',
  4.6,
  133,
  'historic-downtown-littleton-stone',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Masonry Pros
(
  'cont_masonry_sws_009',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Bear Creek Masonry Pros',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-8909',
  'https://www.bearcreekmasonry.com',
  4.8,
  177,
  'bear-creek-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Stone Solutions
(
  'cont_masonry_sws_010',
  'cat_masonry_001',
  'neigh_lit_lake_001',
  'Columbine Stone Solutions',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-8910',
  'https://www.columbinestone.com',
  4.7,
  155,
  'columbine-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
