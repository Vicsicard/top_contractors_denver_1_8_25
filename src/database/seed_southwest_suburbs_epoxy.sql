-- Ensure Epoxy Garage category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
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

-- Insert 10 Epoxy Garage contractors for Littleton/Lakewood area
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
-- 1. Littleton Epoxy Solutions
(
  'cont_epoxy_sw_sub_001',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Littleton Epoxy Solutions',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-7901',
  'https://www.littletonepoxy.com',
  4.9,
  155,
  'littleton-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Garage Coatings
(
  'cont_epoxy_sw_sub_002',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Lakewood Garage Coatings',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-7902',
  'https://www.lakewoodepoxy.com',
  4.8,
  141,
  'lakewood-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Epoxy Masters
(
  'cont_epoxy_sw_sub_003',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Belmar Epoxy Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-7903',
  'https://www.belmarepoxy.com',
  4.7,
  127,
  'belmar-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Garage Solutions
(
  'cont_epoxy_sw_sub_004',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Garage Solutions',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-7904',
  'https://www.southwestplazaepoxy.com',
  4.8,
  146,
  'southwest-plaza-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Epoxy Pro
(
  'cont_epoxy_sw_sub_005',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Ken Caryl Epoxy Pro',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-7905',
  'https://www.kencaryllepoxy.com',
  4.9,
  159,
  'ken-caryl-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Garage Finishes
(
  'cont_epoxy_sw_sub_006',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Union Boulevard Garage Finishes',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-7906',
  'https://www.unionblvdepoxy.com',
  4.7,
  122,
  'union-boulevard-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Epoxy Specialists
(
  'cont_epoxy_sw_sub_007',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Green Mountain Epoxy Specialists',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-7907',
  'https://www.greenmountainepoxy.com',
  4.8,
  135,
  'green-mountain-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Garage Coatings
(
  'cont_epoxy_sw_sub_008',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Garage Coatings',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-7908',
  'https://www.historiclittletonepoxy.com',
  4.6,
  108,
  'historic-downtown-littleton-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Epoxy Pros
(
  'cont_epoxy_sw_sub_009',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Bear Creek Epoxy Pros',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-7909',
  'https://www.bearcreekepoxy.com',
  4.8,
  144,
  'bear-creek-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Garage Solutions
(
  'cont_epoxy_sw_sub_010',
  'cat_epoxy_001',
  'neigh_lit_lake_001',
  'Columbine Garage Solutions',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-7910',
  'https://www.columbineepoxy.com',
  4.7,
  129,
  'columbine-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
