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

-- Ensure Downtown subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_downtown_001',
  'reg_central_001',
  'Downtown Denver',
  'downtown-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Downtown neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_downtown_001',
  'subreg_downtown_001',
  'Downtown Denver',
  'downtown-denver',
  'Including LoDo, Union Station, Central Business District, and Ballpark neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for Downtown Denver area
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
-- 1. LoDo Window Works
(
  'cont_wind_dt_001',
  'cat_windows_001',
  'neigh_downtown_001',
  'LoDo Window Works',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-8001',
  'https://www.lodowindows.com',
  4.9,
  182,
  'lodo-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Window & Glass
(
  'cont_wind_dt_002',
  'cat_windows_001',
  'neigh_downtown_001',
  'Union Station Window & Glass',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-8002',
  'https://www.unionstationwindows.com',
  4.8,
  156,
  'union-station-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Window Masters
(
  'cont_wind_dt_003',
  'cat_windows_001',
  'neigh_downtown_001',
  'Downtown Window Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-8003',
  'https://www.downtownwindowmasters.com',
  4.7,
  143,
  'downtown-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Window Solutions
(
  'cont_wind_dt_004',
  'cat_windows_001',
  'neigh_downtown_001',
  'Ballpark Window Solutions',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-8004',
  'https://www.ballparkwindows.com',
  4.8,
  167,
  'ballpark-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Window Co
(
  'cont_wind_dt_005',
  'cat_windows_001',
  'neigh_downtown_001',
  '16th Street Window Co',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-8005',
  'https://www.16thstreetwindows.com',
  4.9,
  188,
  '16th-street-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Window Design
(
  'cont_wind_dt_006',
  'cat_windows_001',
  'neigh_downtown_001',
  'Larimer Square Window Design',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-8006',
  'https://www.larimersquarewindows.com',
  4.7,
  135,
  'larimer-square-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Window Specialists
(
  'cont_wind_dt_007',
  'cat_windows_001',
  'neigh_downtown_001',
  'CBD Window Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-8007',
  'https://www.cbdwindows.com',
  4.8,
  154,
  'cbd-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Window & Design
(
  'cont_wind_dt_008',
  'cat_windows_001',
  'neigh_downtown_001',
  'Five Points Window & Design',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-8008',
  'https://www.fivepointswindows.com',
  4.6,
  122,
  'five-points-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Window Pros
(
  'cont_wind_dt_009',
  'cat_windows_001',
  'neigh_downtown_001',
  'RiNo Window Pros',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-8009',
  'https://www.rinowindows.com',
  4.8,
  165,
  'rino-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Window Solutions
(
  'cont_wind_dt_010',
  'cat_windows_001',
  'neigh_downtown_001',
  'Commons Park Window Solutions',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-8010',
  'https://www.commonsparkwindows.com',
  4.7,
  138,
  'commons-park-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
