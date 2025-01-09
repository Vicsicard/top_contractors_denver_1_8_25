-- Ensure Windows category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_windows_001',
  'Windows',
  'windows',
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

-- Insert 10 Window contractors for Park Hill area
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
-- 1. Park Hill Window Works
(
  'cont_wind_ph_001',
  'cat_windows_001',
  'neigh_park_hill_001',
  'Park Hill Window Works',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-8301',
  'https://www.parkhillwindows.com',
  4.9,
  178,
  'park-hill-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Window & Glass
(
  'cont_wind_ph_002',
  'cat_windows_001',
  'neigh_park_hill_001',
  'North Park Hill Window & Glass',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-8302',
  'https://www.northparkhillwindows.com',
  4.8,
  154,
  'north-park-hill-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Window Masters
(
  'cont_wind_ph_003',
  'cat_windows_001',
  'neigh_park_hill_001',
  'South Park Hill Window Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-8303',
  'https://www.southparkhillwindows.com',
  4.7,
  141,
  'south-park-hill-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Monaco Parkway Window Solutions
(
  'cont_wind_ph_004',
  'cat_windows_001',
  'neigh_park_hill_001',
  'Monaco Parkway Window Solutions',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-8304',
  'https://www.monacoparkwaywindows.com',
  4.8,
  168,
  'monaco-parkway-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Historic Park Hill Window Co
(
  'cont_wind_ph_005',
  'cat_windows_001',
  'neigh_park_hill_001',
  'Historic Park Hill Window Co',
  '2345 Dexter St, Denver, CO 80207',
  '(303) 555-8305',
  'https://www.historicparkhillwindows.com',
  4.9,
  185,
  'historic-park-hill-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Northeast Park Hill Window Works
(
  'cont_wind_ph_006',
  'cat_windows_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Window Works',
  '3600 Dahlia St, Denver, CO 80207',
  '(303) 555-8306',
  'https://www.northeastparkhillwindows.com',
  4.7,
  144,
  'northeast-park-hill-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. 23rd Avenue Window Specialists
(
  'cont_wind_ph_007',
  'cat_windows_001',
  'neigh_park_hill_001',
  '23rd Avenue Window Specialists',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-8307',
  'https://www.23rdavenuewindows.com',
  4.8,
  158,
  '23rd-avenue-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Montview Window & Design
(
  'cont_wind_ph_008',
  'cat_windows_001',
  'neigh_park_hill_001',
  'Montview Window & Design',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-8308',
  'https://www.montviewwindows.com',
  4.6,
  128,
  'montview-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Greater Park Hill Window Pros
(
  'cont_wind_ph_009',
  'cat_windows_001',
  'neigh_park_hill_001',
  'Greater Park Hill Window Pros',
  '2823 Fairfax St, Denver, CO 80207',
  '(303) 555-8309',
  'https://www.greaterparkhillwindows.com',
  4.8,
  167,
  'greater-park-hill-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Village Window Solutions
(
  'cont_wind_ph_010',
  'cat_windows_001',
  'neigh_park_hill_001',
  'Park Hill Village Window Solutions',
  '2900 Forest St, Denver, CO 80207',
  '(303) 555-8310',
  'https://www.parkhillvillagewindows.com',
  4.7,
  142,
  'park-hill-village-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
