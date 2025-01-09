-- Ensure Windows category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_windows_001',
  'Windows',
  'windows',
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

-- Insert 10 Window contractors for Littleton/Lakewood area
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
-- 1. Littleton Window Works
(
  'cont_wind_sws_001',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Littleton Window Works',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-8901',
  'https://www.littletonwindows.com',
  4.9,
  175,
  'littleton-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Window & Glass
(
  'cont_wind_sws_002',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Lakewood Window & Glass',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-8902',
  'https://www.lakewoodwindows.com',
  4.8,
  150,
  'lakewood-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Window Masters
(
  'cont_wind_sws_003',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Belmar Window Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-8903',
  'https://www.belmarwindows.com',
  4.7,
  136,
  'belmar-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Window Solutions
(
  'cont_wind_sws_004',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Window Solutions',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-8904',
  'https://www.southwestplazawindows.com',
  4.8,
  161,
  'southwest-plaza-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Window Co
(
  'cont_wind_sws_005',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Ken Caryl Window Co',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-8905',
  'https://www.kencarylwindows.com',
  4.9,
  179,
  'ken-caryl-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Window Works
(
  'cont_wind_sws_006',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Union Boulevard Window Works',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-8906',
  'https://www.unionblvdwindows.com',
  4.7,
  140,
  'union-boulevard-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Window Specialists
(
  'cont_wind_sws_007',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Green Mountain Window Specialists',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-8907',
  'https://www.greenmountainwindows.com',
  4.8,
  154,
  'green-mountain-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Window & Design
(
  'cont_wind_sws_008',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Window & Design',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-8908',
  'https://www.historiclittletonwindows.com',
  4.6,
  125,
  'historic-downtown-littleton-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Window Pros
(
  'cont_wind_sws_009',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Bear Creek Window Pros',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-8909',
  'https://www.bearcreekwindows.com',
  4.8,
  161,
  'bear-creek-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Window Solutions
(
  'cont_wind_sws_010',
  'cat_windows_001',
  'neigh_lit_lake_001',
  'Columbine Window Solutions',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-8910',
  'https://www.columbinewindows.com',
  4.7,
  143,
  'columbine-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
