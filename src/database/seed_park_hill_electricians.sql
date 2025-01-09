-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
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

-- Create Park Hill Area subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill Area',
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
  'park-hill',
  'Including Park Hill, North Park Hill, Northeast Park Hill, and South Park Hill neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 electricians for Park Hill area
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
-- 1. Park Hill Electric Masters
(
  'cont_elec_ph_001',
  'cat_elec_001',
  'neigh_park_hill_001',
  'Park Hill Electric Masters',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-2301',
  'https://www.parkhillelectric.com',
  4.9,
  234,
  'park-hill-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Electrical
(
  'cont_elec_ph_002',
  'cat_elec_001',
  'neigh_park_hill_001',
  'North Park Hill Electrical',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-2302',
  'https://www.northparkhillelectrical.com',
  4.8,
  198,
  'north-park-hill-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Northeast Electric Solutions
(
  'cont_elec_ph_003',
  'cat_elec_001',
  'neigh_park_hill_001',
  'Northeast Electric Solutions',
  '3800 Elm St, Denver, CO 80207',
  '(303) 555-2303',
  'https://www.northeastelectricdenver.com',
  4.7,
  167,
  'northeast-electric-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. South Park Hill Electric
(
  'cont_elec_ph_004',
  'cat_elec_001',
  'neigh_park_hill_001',
  'South Park Hill Electric',
  '1900 Forest St, Denver, CO 80207',
  '(303) 555-2304',
  'https://www.southparkhillelectric.com',
  4.8,
  189,
  'south-park-hill-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Greater Park Hill Electrical
(
  'cont_elec_ph_005',
  'cat_elec_001',
  'neigh_park_hill_001',
  'Greater Park Hill Electrical',
  '2600 Kearney St, Denver, CO 80207',
  '(303) 555-2305',
  'https://www.greaterparkhillelectrical.com',
  4.9,
  212,
  'greater-park-hill-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Monaco Parkway Electric
(
  'cont_elec_ph_006',
  'cat_elec_001',
  'neigh_park_hill_001',
  'Monaco Parkway Electric',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-2306',
  'https://www.monacoparkwayelectric.com',
  4.7,
  178,
  'monaco-parkway-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Denver Electrical Experts
(
  'cont_elec_ph_007',
  'cat_elec_001',
  'neigh_park_hill_001',
  'East Denver Electrical Experts',
  '3200 Krameria St, Denver, CO 80207',
  '(303) 555-2307',
  'https://www.eastdenverelectrical.com',
  4.8,
  167,
  'east-denver-electrical-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Park Hill Emergency Electric
(
  'cont_elec_ph_008',
  'cat_elec_001',
  'neigh_park_hill_001',
  'Park Hill Emergency Electric',
  '2900 Dexter St, Denver, CO 80207',
  '(303) 555-2308',
  'https://www.parkhillemergencyelectric.com',
  4.6,
  156,
  'park-hill-emergency-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Montview Electric Services
(
  'cont_elec_ph_009',
  'cat_elec_001',
  'neigh_park_hill_001',
  'Montview Electric Services',
  '2200 Montview Blvd, Denver, CO 80207',
  '(303) 555-2309',
  'https://www.montviewelectric.com',
  4.8,
  201,
  'montview-electric-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. 23rd Avenue Electric
(
  'cont_elec_ph_010',
  'cat_elec_001',
  'neigh_park_hill_001',
  '23rd Avenue Electric',
  '2300 23rd Ave, Denver, CO 80207',
  '(303) 555-2310',
  'https://www.23rdavenueelectric.com',
  4.7,
  182,
  '23rd-avenue-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
