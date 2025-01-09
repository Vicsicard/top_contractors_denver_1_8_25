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

-- Ensure Central Shopping subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_shopping_001',
  'reg_central_001',
  'Central Shopping',
  'central-shopping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Shopping neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_shopping_001',
  'subreg_central_shopping_001',
  'Central Shopping',
  'central-shopping',
  'Including Cherry Creek, Lincoln Park, and North Capitol Hill shopping districts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for Central Shopping area
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
-- 1. Cherry Creek Window Works
(
  'cont_wind_cs_001',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Cherry Creek Window Works',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-8201',
  'https://www.cherrycreekwindows.com',
  4.9,
  182,
  'cherry-creek-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Window & Glass
(
  'cont_wind_cs_002',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Lincoln Park Window & Glass',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-8202',
  'https://www.lincolnparkwindows.com',
  4.8,
  160,
  'lincoln-park-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Window Masters
(
  'cont_wind_cs_003',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'North Cap Hill Window Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-8203',
  'https://www.northcaphillwindows.com',
  4.7,
  138,
  'north-cap-hill-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Window Solutions
(
  'cont_wind_cs_004',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Shopping District Window Solutions',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-8204',
  'https://www.shoppingdistrictwindows.com',
  4.8,
  171,
  'shopping-district-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Window Co
(
  'cont_wind_cs_005',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Retail Row Window Co',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-8205',
  'https://www.retailrowwindows.com',
  4.9,
  182,
  'retail-row-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Window Works
(
  'cont_wind_cs_006',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Golden Triangle Window Works',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-8206',
  'https://www.goldentrianglewindows.com',
  4.7,
  149,
  'golden-triangle-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Window Specialists
(
  'cont_wind_cs_007',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Window Specialists',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-8207',
  'https://www.cherrycreeknorthwindows.com',
  4.8,
  160,
  'cherry-creek-north-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Window & Design
(
  'cont_wind_cs_008',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Art District Window & Design',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-8208',
  'https://www.artdistrictwindows.com',
  4.6,
  131,
  'art-district-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Window Pros
(
  'cont_wind_cs_009',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Uptown Window Pros',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-8209',
  'https://www.uptownwindows.com',
  4.8,
  171,
  'uptown-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Window Solutions
(
  'cont_wind_cs_010',
  'cat_windows_001',
  'neigh_central_shopping_001',
  'Mall District Window Solutions',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-8210',
  'https://www.malldistrictwindows.com',
  4.7,
  149,
  'mall-district-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
