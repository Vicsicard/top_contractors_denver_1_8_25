-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Shopping subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_shopping_001',
  'reg_central_001',
  'Central Shopping',
  'central-shopping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Shopping neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_shopping_001',
  'subreg_central_shopping_001',
  'Central Shopping',
  'central-shopping',
  'Including Cherry Creek, Lincoln Park, and North Capitol Hill shopping districts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Flooring contractors for Central Shopping area
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
-- 1. Cherry Creek Flooring Works
(
  'cont_floor_cs_001',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Cherry Creek Flooring Works',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-7201',
  'https://www.cherrycreekflooring.com',
  4.9,
  186,
  'cherry-creek-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Floor & Tile
(
  'cont_floor_cs_002',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Lincoln Park Floor & Tile',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-7202',
  'https://www.lincolnparkflooring.com',
  4.8,
  164,
  'lincoln-park-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Floor Masters
(
  'cont_floor_cs_003',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'North Cap Hill Floor Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-7203',
  'https://www.northcaphillflooring.com',
  4.7,
  142,
  'north-cap-hill-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Flooring Solutions
(
  'cont_floor_cs_004',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Shopping District Flooring Solutions',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-7204',
  'https://www.shoppingdistrictflooring.com',
  4.8,
  175,
  'shopping-district-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Floor Co
(
  'cont_floor_cs_005',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Retail Row Floor Co',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-7205',
  'https://www.retailrowflooring.com',
  4.9,
  186,
  'retail-row-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Flooring Works
(
  'cont_floor_cs_006',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Golden Triangle Flooring Works',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-7206',
  'https://www.goldentriangleflooring.com',
  4.7,
  153,
  'golden-triangle-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Floor Specialists
(
  'cont_floor_cs_007',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Floor Specialists',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-7207',
  'https://www.cherrycreeknorthflooring.com',
  4.8,
  164,
  'cherry-creek-north-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Floor & Design
(
  'cont_floor_cs_008',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Art District Floor & Design',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-7208',
  'https://www.artdistrictflooring.com',
  4.6,
  135,
  'art-district-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Floor Pros
(
  'cont_floor_cs_009',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Uptown Floor Pros',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-7209',
  'https://www.uptownflooring.com',
  4.8,
  175,
  'uptown-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Flooring Solutions
(
  'cont_floor_cs_010',
  'cat_flooring_001',
  'neigh_central_shopping_001',
  'Mall District Flooring Solutions',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-7210',
  'https://www.malldistrictflooring.com',
  4.7,
  153,
  'mall-district-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
