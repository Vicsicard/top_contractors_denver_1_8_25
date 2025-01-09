-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create East Denver region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_east_001',
  'East Denver',
  'east-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Park Hill Area subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill',
  'park-hill-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Park Hill neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_park_hill_001',
  'subreg_park_hill_001',
  'Park Hill',
  'park-hill-area',
  'Including North Park Hill, South Park Hill, and Northeast Park Hill neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Park Hill area
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
-- 1. Park Hill Plumbing Masters
(
  'cont_plumb_ph_001',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'Park Hill Plumbing Masters',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-0401',
  'https://www.parkhillplumbing.com',
  4.9,
  198,
  'park-hill-plumbing-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Plumbing Services
(
  'cont_plumb_ph_002',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'North Park Hill Plumbing Services',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-0402',
  'https://www.northparkhillplumbing.com',
  4.8,
  167,
  'north-park-hill-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Northeast Plumbing Solutions
(
  'cont_plumb_ph_003',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'Northeast Plumbing Solutions',
  '3800 Elm St, Denver, CO 80207',
  '(303) 555-0403',
  'https://www.northeastplumbingdenver.com',
  4.7,
  156,
  'northeast-plumbing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. South Park Hill Plumbers
(
  'cont_plumb_ph_004',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'South Park Hill Plumbers',
  '1900 Forest St, Denver, CO 80207',
  '(303) 555-0404',
  'https://www.southparkhillplumbers.com',
  4.8,
  189,
  'south-park-hill-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Greater Park Hill Plumbing
(
  'cont_plumb_ph_005',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'Greater Park Hill Plumbing',
  '2600 Kearney St, Denver, CO 80207',
  '(303) 555-0405',
  'https://www.greaterparkhillplumbing.com',
  4.9,
  201,
  'greater-park-hill-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Monaco Parkway Plumbing
(
  'cont_plumb_ph_006',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'Monaco Parkway Plumbing',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-0406',
  'https://www.monacoparkwayplumbing.com',
  4.7,
  178,
  'monaco-parkway-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Denver Drain Experts
(
  'cont_plumb_ph_007',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'East Denver Drain Experts',
  '3200 Krameria St, Denver, CO 80207',
  '(303) 555-0407',
  'https://www.eastdenverdrains.com',
  4.8,
  167,
  'east-denver-drain-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Park Hill Emergency Plumbing
(
  'cont_plumb_ph_008',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'Park Hill Emergency Plumbing',
  '2900 Dexter St, Denver, CO 80207',
  '(303) 555-0408',
  'https://www.parkhillemergencyplumbing.com',
  4.6,
  145,
  'park-hill-emergency-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Montview Plumbing Services
(
  'cont_plumb_ph_009',
  'cat_plumber_001',
  'neigh_park_hill_001',
  'Montview Plumbing Services',
  '2200 Montview Blvd, Denver, CO 80207',
  '(303) 555-0409',
  'https://www.montviewplumbing.com',
  4.7,
  182,
  'montview-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. 23rd Avenue Plumbing Pros
(
  'cont_plumb_ph_010',
  'cat_plumber_001',
  'neigh_park_hill_001',
  '23rd Avenue Plumbing Pros',
  '2300 23rd Ave, Denver, CO 80207',
  '(303) 555-0410',
  'https://www.23rdavenueplumbing.com',
  4.8,
  176,
  '23rd-avenue-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
