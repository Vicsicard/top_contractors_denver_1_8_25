-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Park Hill area
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
-- 1. Park Hill Bath Design
(
  'cont_bath_ph_001',
  'cat_bath_001',
  'neigh_park_hill_001',
  'Park Hill Bath Design',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-8301',
  'https://www.parkhillbath.com',
  4.9,
  178,
  'park-hill-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Bath & Tile
(
  'cont_bath_ph_002',
  'cat_bath_001',
  'neigh_park_hill_001',
  'North Park Hill Bath & Tile',
  '3300 Holly St, Denver, CO 80207',
  '(303) 555-8302',
  'https://www.northparkhillbath.com',
  4.8,
  156,
  'north-park-hill-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Bath Masters
(
  'cont_bath_ph_003',
  'cat_bath_001',
  'neigh_park_hill_001',
  'South Park Hill Bath Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-8303',
  'https://www.southparkhillbath.com',
  4.7,
  134,
  'south-park-hill-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Historic Park Hill Bath Co
(
  'cont_bath_ph_004',
  'cat_bath_001',
  'neigh_park_hill_001',
  'Historic Park Hill Bath Co',
  '2600 Forest St, Denver, CO 80207',
  '(303) 555-8304',
  'https://www.historicparkhillbath.com',
  4.8,
  167,
  'historic-park-hill-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Montview Bath Studio
(
  'cont_bath_ph_005',
  'cat_bath_001',
  'neigh_park_hill_001',
  'Montview Bath Studio',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-8305',
  'https://www.montviewbath.com',
  4.9,
  189,
  'montview-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 23rd Avenue Bath Design
(
  'cont_bath_ph_006',
  'cat_bath_001',
  'neigh_park_hill_001',
  '23rd Avenue Bath Design',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-8306',
  'https://www.23rdbath.com',
  4.7,
  145,
  '23rd-avenue-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Greater Park Hill Bath Co
(
  'cont_bath_ph_007',
  'cat_bath_001',
  'neigh_park_hill_001',
  'Greater Park Hill Bath Co',
  '3000 Dexter St, Denver, CO 80207',
  '(303) 555-8307',
  'https://www.greaterparkhillbath.com',
  4.8,
  156,
  'greater-park-hill-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northeast Bath Studio
(
  'cont_bath_ph_008',
  'cat_bath_001',
  'neigh_park_hill_001',
  'Northeast Bath Studio',
  '3500 Hudson St, Denver, CO 80207',
  '(303) 555-8308',
  'https://www.northeastbath.com',
  4.6,
  123,
  'northeast-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Monaco Bath Specialists
(
  'cont_bath_ph_009',
  'cat_bath_001',
  'neigh_park_hill_001',
  'Monaco Bath Specialists',
  '2900 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-8309',
  'https://www.monacobath.com',
  4.8,
  167,
  'monaco-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Modern Bath
(
  'cont_bath_ph_010',
  'cat_bath_001',
  'neigh_park_hill_001',
  'Park Hill Modern Bath',
  '2500 Fairfax St, Denver, CO 80207',
  '(303) 555-8310',
  'https://www.parkhillmodernbath.com',
  4.7,
  145,
  'park-hill-modern-bath',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
