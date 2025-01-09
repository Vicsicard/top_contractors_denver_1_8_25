-- Ensure Windows category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_windows_001',
  'Windows',
  'windows',
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

-- Create Central Parks subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_parks_001',
  'reg_central_001',
  'Central Parks',
  'central-parks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Central Parks neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_parks_001',
  'subreg_central_parks_001',
  'Central Parks',
  'central-parks',
  'Including City Park, City Park West, Congress Park, and Cheesman Park areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for Central Parks area
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
-- 1. City Park Window Works
(
  'cont_wind_cp_001',
  'cat_windows_001',
  'neigh_central_parks_001',
  'City Park Window Works',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-8101',
  'https://www.cityparkwindows.com',
  4.9,
  171,
  'city-park-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Window & Glass
(
  'cont_wind_cp_002',
  'cat_windows_001',
  'neigh_central_parks_001',
  'Cheesman Park Window & Glass',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-8102',
  'https://www.cheesmanwindows.com',
  4.8,
  148,
  'cheesman-park-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Window Masters
(
  'cont_wind_cp_003',
  'cat_windows_001',
  'neigh_central_parks_001',
  'Congress Park Window Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-8103',
  'https://www.congresswindows.com',
  4.7,
  142,
  'congress-park-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Window Solutions
(
  'cont_wind_cp_004',
  'cat_windows_001',
  'neigh_central_parks_001',
  'Zoo Area Window Solutions',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-8104',
  'https://www.zooareawindows.com',
  4.8,
  164,
  'zoo-area-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Window Co
(
  'cont_wind_cp_005',
  'cat_windows_001',
  'neigh_central_parks_001',
  'Museum District Window Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-8105',
  'https://www.museumdistrictwindows.com',
  4.9,
  182,
  'museum-district-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Window Works
(
  'cont_wind_cp_006',
  'cat_windows_001',
  'neigh_central_parks_001',
  'Botanic Gardens Window Works',
  '1007 York St, Denver, CO 80206',
  '(303) 555-8106',
  'https://www.botanicgardenswindows.com',
  4.7,
  131,
  'botanic-gardens-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Window Specialists
(
  'cont_wind_cp_007',
  'cat_windows_001',
  'neigh_central_parks_001',
  'East High Window Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-8107',
  'https://www.easthighwindows.com',
  4.8,
  153,
  'east-high-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Window & Design
(
  'cont_wind_cp_008',
  'cat_windows_001',
  'neigh_central_parks_001',
  'City Park West Window & Design',
  '2199 California St, Denver, CO 80205',
  '(303) 555-8108',
  'https://www.cityparkwestwindows.com',
  4.6,
  120,
  'city-park-west-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Window Pros
(
  'cont_wind_cp_009',
  'cat_windows_001',
  'neigh_central_parks_001',
  'Park Avenue Window Pros',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-8109',
  'https://www.parkavenuewindows.com',
  4.8,
  161,
  'park-avenue-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Window Solutions
(
  'cont_wind_cp_010',
  'cat_windows_001',
  'neigh_central_parks_001',
  'Esplanade Window Solutions',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-8110',
  'https://www.esplanadewindows.com',
  4.7,
  138,
  'esplanade-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
