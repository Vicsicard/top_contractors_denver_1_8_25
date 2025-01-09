-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Park Hill area
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
-- 1. Park Hill Siding & Gutters
(
  'cont_siding_ph_001',
  'cat_siding_001',
  'neigh_park_hill_001',
  'Park Hill Siding & Gutters',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-7301',
  'https://www.parkhillsiding.com',
  4.9,
  189,
  'park-hill-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Exteriors
(
  'cont_siding_ph_002',
  'cat_siding_001',
  'neigh_park_hill_001',
  'North Park Hill Exteriors',
  '3300 Holly St, Denver, CO 80207',
  '(303) 555-7302',
  'https://www.northparkhillexteriors.com',
  4.8,
  167,
  'north-park-hill-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Gutter Masters
(
  'cont_siding_ph_003',
  'cat_siding_001',
  'neigh_park_hill_001',
  'South Park Hill Gutter Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-7303',
  'https://www.southparkhillgutter.com',
  4.7,
  145,
  'south-park-hill-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Historic Park Hill Siding Solutions
(
  'cont_siding_ph_004',
  'cat_siding_001',
  'neigh_park_hill_001',
  'Historic Park Hill Siding Solutions',
  '2600 Forest St, Denver, CO 80207',
  '(303) 555-7304',
  'https://www.historicparkhillsiding.com',
  4.8,
  178,
  'historic-park-hill-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Montview Gutter Co
(
  'cont_siding_ph_005',
  'cat_siding_001',
  'neigh_park_hill_001',
  'Montview Gutter Co',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-7305',
  'https://www.montviewgutter.com',
  4.9,
  199,
  'montview-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 23rd Avenue Siding & Gutters
(
  'cont_siding_ph_006',
  'cat_siding_001',
  'neigh_park_hill_001',
  '23rd Avenue Siding & Gutters',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-7306',
  'https://www.23rdsiding.com',
  4.7,
  156,
  '23rd-avenue-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Greater Park Hill Exterior Specialists
(
  'cont_siding_ph_007',
  'cat_siding_001',
  'neigh_park_hill_001',
  'Greater Park Hill Exterior Specialists',
  '3000 Dexter St, Denver, CO 80207',
  '(303) 555-7307',
  'https://www.greaterparkhillexteriors.com',
  4.8,
  167,
  'greater-park-hill-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northeast Siding & Gutters
(
  'cont_siding_ph_008',
  'cat_siding_001',
  'neigh_park_hill_001',
  'Northeast Siding & Gutters',
  '3500 Hudson St, Denver, CO 80207',
  '(303) 555-7308',
  'https://www.northeastsiding.com',
  4.6,
  134,
  'northeast-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Monaco Gutter Pros
(
  'cont_siding_ph_009',
  'cat_siding_001',
  'neigh_park_hill_001',
  'Monaco Gutter Pros',
  '2900 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-7309',
  'https://www.monacogutter.com',
  4.8,
  178,
  'monaco-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Modern Siding
(
  'cont_siding_ph_010',
  'cat_siding_001',
  'neigh_park_hill_001',
  'Park Hill Modern Siding',
  '2500 Fairfax St, Denver, CO 80207',
  '(303) 555-7310',
  'https://www.parkhillmodernsiding.com',
  4.7,
  156,
  'park-hill-modern-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
