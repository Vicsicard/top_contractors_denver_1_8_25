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

-- Ensure Northeast subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_northeast_001',
  'reg_east_001',
  'Northeast Denver',
  'northeast-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_northeast_001',
  'subreg_northeast_001',
  'Northeast Denver',
  'northeast-denver',
  'Including Montbello, Green Valley Ranch, and Gateway areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for Northeast Denver area
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
-- 1. Montbello Window Works
(
  'cont_wind_ne_001',
  'cat_windows_001',
  'neigh_northeast_001',
  'Montbello Window Works',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-8401',
  'https://www.montbellowindows.com',
  4.9,
  175,
  'montbello-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Window & Glass
(
  'cont_wind_ne_002',
  'cat_windows_001',
  'neigh_northeast_001',
  'Green Valley Ranch Window & Glass',
  '18501 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-8402',
  'https://www.gvrwindows.com',
  4.8,
  152,
  'green-valley-ranch-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Window Masters
(
  'cont_wind_ne_003',
  'cat_windows_001',
  'neigh_northeast_001',
  'Gateway Window Masters',
  '4760 Pena Blvd, Denver, CO 80239',
  '(303) 555-8403',
  'https://www.gatewaywindows.com',
  4.7,
  138,
  'gateway-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Window Solutions
(
  'cont_wind_ne_004',
  'cat_windows_001',
  'neigh_northeast_001',
  'DIA Corridor Window Solutions',
  '16000 E 40th Ave, Denver, CO 80239',
  '(303) 555-8404',
  'https://www.diacorridorwindows.com',
  4.8,
  164,
  'dia-corridor-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Far Northeast Window Co
(
  'cont_wind_ne_005',
  'cat_windows_001',
  'neigh_northeast_001',
  'Far Northeast Window Co',
  '5000 Crown Blvd, Denver, CO 80239',
  '(303) 555-8405',
  'https://www.farnortheastwindows.com',
  4.9,
  181,
  'far-northeast-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Chambers Road Window Works
(
  'cont_wind_ne_006',
  'cat_windows_001',
  'neigh_northeast_001',
  'Chambers Road Window Works',
  '4500 Chambers Rd, Denver, CO 80239',
  '(303) 555-8406',
  'https://www.chambersroadwindows.com',
  4.7,
  142,
  'chambers-road-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Tower Road Window Specialists
(
  'cont_wind_ne_007',
  'cat_windows_001',
  'neigh_northeast_001',
  'Tower Road Window Specialists',
  '18890 E Colfax Ave, Aurora, CO 80011',
  '(303) 555-8407',
  'https://www.towerroadwindows.com',
  4.8,
  156,
  'tower-road-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Peña Boulevard Window & Design
(
  'cont_wind_ne_008',
  'cat_windows_001',
  'neigh_northeast_001',
  'Peña Boulevard Window & Design',
  '16161 E 40th Ave, Denver, CO 80239',
  '(303) 555-8408',
  'https://www.penablvdwindows.com',
  4.6,
  127,
  'pena-boulevard-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Rocky Mountain Arsenal Window Pros
(
  'cont_wind_ne_009',
  'cat_windows_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Window Pros',
  '5650 Havana St, Commerce City, CO 80022',
  '(303) 555-8409',
  'https://www.rmawindows.com',
  4.8,
  163,
  'rocky-mountain-arsenal-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Denver International Window Solutions
(
  'cont_wind_ne_010',
  'cat_windows_001',
  'neigh_northeast_001',
  'Denver International Window Solutions',
  '8500 Peña Blvd, Denver, CO 80249',
  '(303) 555-8410',
  'https://www.denverinternationalwindows.com',
  4.7,
  145,
  'denver-international-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
