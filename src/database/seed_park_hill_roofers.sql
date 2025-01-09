-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
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

-- Insert 10 Roofers for Park Hill area
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
-- 1. Park Hill Premier Roofing
(
  'cont_roof_ph_001',
  'cat_roof_001',
  'neigh_park_hill_001',
  'Park Hill Premier Roofing',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-4301',
  'https://www.parkhillpremierroofing.com',
  4.9,
  198,
  'park-hill-premier-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Roofing Co
(
  'cont_roof_ph_002',
  'cat_roof_001',
  'neigh_park_hill_001',
  'North Park Hill Roofing Co',
  '3300 Holly St, Denver, CO 80207',
  '(303) 555-4302',
  'https://www.northparkhillroofing.com',
  4.8,
  167,
  'north-park-hill-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Roofing
(
  'cont_roof_ph_003',
  'cat_roof_001',
  'neigh_park_hill_001',
  'South Park Hill Roofing',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-4303',
  'https://www.southparkhillroofing.com',
  4.7,
  145,
  'south-park-hill-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Monaco Parkway Roofing
(
  'cont_roof_ph_004',
  'cat_roof_001',
  'neigh_park_hill_001',
  'Monaco Parkway Roofing',
  '2555 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-4304',
  'https://www.monacoparkwayroofing.com',
  4.8,
  156,
  'monaco-parkway-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Historic Park Hill Roofing
(
  'cont_roof_ph_005',
  'cat_roof_001',
  'neigh_park_hill_001',
  'Historic Park Hill Roofing',
  '2345 Dexter St, Denver, CO 80207',
  '(303) 555-4305',
  'https://www.historicparkhillroofing.com',
  4.9,
  187,
  'historic-park-hill-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Northeast Park Hill Roofing
(
  'cont_roof_ph_006',
  'cat_roof_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Roofing',
  '3500 Dahlia St, Denver, CO 80207',
  '(303) 555-4306',
  'https://www.northeastparkhillroofing.com',
  4.7,
  143,
  'northeast-park-hill-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Montview Boulevard Roofing
(
  'cont_roof_ph_007',
  'cat_roof_001',
  'neigh_park_hill_001',
  'Montview Boulevard Roofing',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-4307',
  'https://www.montviewroofing.com',
  4.8,
  134,
  'montview-boulevard-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. 23rd Avenue Roofing Pros
(
  'cont_roof_ph_008',
  'cat_roof_001',
  'neigh_park_hill_001',
  '23rd Avenue Roofing Pros',
  '2300 23rd Ave, Denver, CO 80207',
  '(303) 555-4308',
  'https://www.23rdaveroofing.com',
  4.6,
  123,
  '23rd-avenue-roofing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Greater Park Hill Roofing
(
  'cont_roof_ph_009',
  'cat_roof_001',
  'neigh_park_hill_001',
  'Greater Park Hill Roofing',
  '2823 Fairfax St, Denver, CO 80207',
  '(303) 555-4309',
  'https://www.greaterparkhillroofing.com',
  4.8,
  167,
  'greater-park-hill-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Community Roofing
(
  'cont_roof_ph_010',
  'cat_roof_001',
  'neigh_park_hill_001',
  'Park Hill Community Roofing',
  '2900 Forest St, Denver, CO 80207',
  '(303) 555-4310',
  'https://www.parkhillcommunityroofing.com',
  4.7,
  145,
  'park-hill-community-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
