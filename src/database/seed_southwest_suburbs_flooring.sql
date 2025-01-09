-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for Littleton/Lakewood area
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
-- 1. Littleton Flooring Works
(
  'cont_floor_sws_001',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Littleton Flooring Works',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-7901',
  'https://www.littletonflooring.com',
  4.9,
  163,
  'littleton-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Floor & Tile
(
  'cont_floor_sws_002',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Lakewood Floor & Tile',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-7902',
  'https://www.lakewoodflooring.com',
  4.8,
  141,
  'lakewood-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Floor Masters
(
  'cont_floor_sws_003',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Belmar Floor Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-7903',
  'https://www.belmarflooring.com',
  4.7,
  126,
  'belmar-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Flooring Solutions
(
  'cont_floor_sws_004',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Flooring Solutions',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-7904',
  'https://www.southwestplazaflooring.com',
  4.8,
  153,
  'southwest-plaza-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Floor Co
(
  'cont_floor_sws_005',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Ken Caryl Floor Co',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-7905',
  'https://www.kencarylfloors.com',
  4.9,
  169,
  'ken-caryl-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Flooring Works
(
  'cont_floor_sws_006',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Union Boulevard Flooring Works',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-7906',
  'https://www.unionblvdflooring.com',
  4.7,
  130,
  'union-boulevard-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Floor Specialists
(
  'cont_floor_sws_007',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Green Mountain Floor Specialists',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-7907',
  'https://www.greenmountainflooring.com',
  4.8,
  144,
  'green-mountain-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Floor & Design
(
  'cont_floor_sws_008',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Floor & Design',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-7908',
  'https://www.historiclittletonflooring.com',
  4.6,
  113,
  'historic-downtown-littleton-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Floor Pros
(
  'cont_floor_sws_009',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Bear Creek Floor Pros',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-7909',
  'https://www.bearcreekflooring.com',
  4.8,
  152,
  'bear-creek-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Flooring Solutions
(
  'cont_floor_sws_010',
  'cat_flooring_001',
  'neigh_lit_lake_001',
  'Columbine Flooring Solutions',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-7910',
  'https://www.columbineflooring.com',
  4.7,
  128,
  'columbine-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
