-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_east_001',
  'East Denver',
  'east-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill',
  'park-hill',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_park_hill_001',
  'subreg_park_hill_001',
  'Park Hill',
  'park-hill',
  'Including North Park Hill, South Park Hill, and Northeast Park Hill areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Flooring contractors for Park Hill area
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
-- 1. Park Hill Flooring Works
(
  'cont_floor_ph_001',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'Park Hill Flooring Works',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-7301',
  'https://www.parkhillflooring.com',
  4.9,
  182,
  'park-hill-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Floor & Tile
(
  'cont_floor_ph_002',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'North Park Hill Floor & Tile',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-7302',
  'https://www.northparkhillflooring.com',
  4.8,
  158,
  'north-park-hill-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Floor Masters
(
  'cont_floor_ph_003',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'South Park Hill Floor Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-7303',
  'https://www.southparkhillflooring.com',
  4.7,
  145,
  'south-park-hill-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Monaco Parkway Flooring Solutions
(
  'cont_floor_ph_004',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'Monaco Parkway Flooring Solutions',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-7304',
  'https://www.monacoparkwayflooring.com',
  4.8,
  172,
  'monaco-parkway-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Historic Park Hill Floor Co
(
  'cont_floor_ph_005',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'Historic Park Hill Floor Co',
  '2345 Dexter St, Denver, CO 80207',
  '(303) 555-7305',
  'https://www.historicparkhillflooring.com',
  4.9,
  189,
  'historic-park-hill-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Northeast Park Hill Flooring Works
(
  'cont_floor_ph_006',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Flooring Works',
  '3600 Dahlia St, Denver, CO 80207',
  '(303) 555-7306',
  'https://www.northeastparkhillflooring.com',
  4.7,
  148,
  'northeast-park-hill-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. 23rd Avenue Floor Specialists
(
  'cont_floor_ph_007',
  'cat_flooring_001',
  'neigh_park_hill_001',
  '23rd Avenue Floor Specialists',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-7307',
  'https://www.23rdavenueflooring.com',
  4.8,
  162,
  '23rd-avenue-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Montview Floor & Design
(
  'cont_floor_ph_008',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'Montview Floor & Design',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-7308',
  'https://www.montviewflooring.com',
  4.6,
  132,
  'montview-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Greater Park Hill Floor Pros
(
  'cont_floor_ph_009',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'Greater Park Hill Floor Pros',
  '2823 Fairfax St, Denver, CO 80207',
  '(303) 555-7309',
  'https://www.greaterparkhillflooring.com',
  4.8,
  171,
  'greater-park-hill-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Village Flooring Solutions
(
  'cont_floor_ph_010',
  'cat_flooring_001',
  'neigh_park_hill_001',
  'Park Hill Village Flooring Solutions',
  '2900 Forest St, Denver, CO 80207',
  '(303) 555-7310',
  'https://www.parkhillvillageflooring.com',
  4.7,
  146,
  'park-hill-village-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
