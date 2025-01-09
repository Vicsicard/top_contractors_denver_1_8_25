-- Ensure Windows category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_windows_001',
  'Windows',
  'windows',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_thorn_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_thorn_north_001',
  'subreg_thorn_north_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for Thornton/Northglenn area
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
-- 1. Thornton Window Works
(
  'cont_wind_nes_001',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Thornton Window Works',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-8701',
  'https://www.thorntonwindows.com',
  4.9,
  173,
  'thornton-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Window & Glass
(
  'cont_wind_nes_002',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Northglenn Window & Glass',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-8702',
  'https://www.northglennwindows.com',
  4.8,
  148,
  'northglenn-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Window Masters
(
  'cont_wind_nes_003',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Washington Street Window Masters',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-8703',
  'https://www.washingtonstreetwindows.com',
  4.7,
  134,
  'washington-street-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Original Thornton Window Solutions
(
  'cont_wind_nes_004',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Original Thornton Window Solutions',
  '8800 N Washington St, Thornton, CO 80229',
  '(303) 555-8704',
  'https://www.originalthorntonwindows.com',
  4.8,
  159,
  'original-thornton-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. E-470 Window Co
(
  'cont_wind_nes_005',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'E-470 Window Co',
  '14000 E 112th Ave, Commerce City, CO 80022',
  '(303) 555-8705',
  'https://www.e470windows.com',
  4.9,
  177,
  'e470-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Huron Street Window Works
(
  'cont_wind_nes_006',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Huron Street Window Works',
  '10455 Huron St, Northglenn, CO 80234',
  '(303) 555-8706',
  'https://www.huronstreetwindows.com',
  4.7,
  138,
  'huron-street-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. 120th Avenue Window Specialists
(
  'cont_wind_nes_007',
  'cat_windows_001',
  'neigh_thorn_north_001',
  '120th Avenue Window Specialists',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-8707',
  'https://www.120thavewindows.com',
  4.8,
  152,
  '120th-avenue-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Brighton Road Window & Design
(
  'cont_wind_nes_008',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Brighton Road Window & Design',
  '12000 Brighton Rd, Henderson, CO 80640',
  '(303) 555-8708',
  'https://www.brightonroadwindows.com',
  4.6,
  123,
  'brighton-road-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Commerce City Window Pros
(
  'cont_wind_nes_009',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Commerce City Window Pros',
  '7200 Monaco St, Commerce City, CO 80022',
  '(303) 555-8709',
  'https://www.commercecitywindows.com',
  4.8,
  159,
  'commerce-city-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mile High Window Solutions
(
  'cont_wind_nes_010',
  'cat_windows_001',
  'neigh_thorn_north_001',
  'Mile High Window Solutions',
  '11900 Colorado Blvd, Thornton, CO 80233',
  '(303) 555-8710',
  'https://www.milehighwindows.com',
  4.7,
  141,
  'mile-high-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
