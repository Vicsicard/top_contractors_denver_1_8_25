-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
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

-- Insert 10 HVAC contractors for Park Hill area
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
-- 1. Park Hill HVAC Masters
(
  'cont_hvac_ph_001',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'Park Hill HVAC Masters',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-3301',
  'https://www.parkhillhvac.com',
  4.9,
  234,
  'park-hill-hvac-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Air Systems
(
  'cont_hvac_ph_002',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'North Park Hill Air Systems',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-3302',
  'https://www.northparkhillhvac.com',
  4.8,
  198,
  'north-park-hill-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Northeast Climate Solutions
(
  'cont_hvac_ph_003',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'Northeast Climate Solutions',
  '3800 Elm St, Denver, CO 80207',
  '(303) 555-3303',
  'https://www.northeasthvacdenver.com',
  4.7,
  167,
  'northeast-climate-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. South Park Hill HVAC
(
  'cont_hvac_ph_004',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'South Park Hill HVAC',
  '1900 Forest St, Denver, CO 80207',
  '(303) 555-3304',
  'https://www.southparkhillhvac.com',
  4.8,
  189,
  'south-park-hill-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Greater Park Hill Climate Control
(
  'cont_hvac_ph_005',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'Greater Park Hill Climate Control',
  '2600 Kearney St, Denver, CO 80207',
  '(303) 555-3305',
  'https://www.greaterparkhillhvac.com',
  4.9,
  212,
  'greater-park-hill-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Monaco Parkway HVAC
(
  'cont_hvac_ph_006',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'Monaco Parkway HVAC',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-3306',
  'https://www.monacoparkwayhvac.com',
  4.7,
  178,
  'monaco-parkway-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Denver Air Experts
(
  'cont_hvac_ph_007',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'East Denver Air Experts',
  '3200 Krameria St, Denver, CO 80207',
  '(303) 555-3307',
  'https://www.eastdenverhvac.com',
  4.8,
  167,
  'east-denver-air-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Park Hill Emergency HVAC
(
  'cont_hvac_ph_008',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'Park Hill Emergency HVAC',
  '2900 Dexter St, Denver, CO 80207',
  '(303) 555-3308',
  'https://www.parkhillemergencyhvac.com',
  4.6,
  156,
  'park-hill-emergency-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Montview Climate Services
(
  'cont_hvac_ph_009',
  'cat_hvac_001',
  'neigh_park_hill_001',
  'Montview Climate Services',
  '2200 Montview Blvd, Denver, CO 80207',
  '(303) 555-3309',
  'https://www.montviewhvac.com',
  4.8,
  201,
  'montview-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. 23rd Avenue HVAC
(
  'cont_hvac_ph_010',
  'cat_hvac_001',
  'neigh_park_hill_001',
  '23rd Avenue HVAC',
  '2300 23rd Ave, Denver, CO 80207',
  '(303) 555-3310',
  'https://www.23rdavenuehvac.com',
  4.7,
  182,
  '23rd-avenue-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
