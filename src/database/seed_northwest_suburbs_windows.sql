-- Ensure Windows category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_windows_001',
  'Windows',
  'windows',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northwest Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_nw_suburbs_001',
  'Northwest Suburbs',
  'northwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Westminster/Arvada subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_west_arvada_001',
  'reg_nw_suburbs_001',
  'Westminster/Arvada',
  'westminster-arvada',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Westminster/Arvada neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_west_arvada_001',
  'subreg_west_arvada_001',
  'Westminster/Arvada',
  'westminster-arvada',
  'Including Westminster, Arvada, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for Westminster/Arvada area
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
-- 1. Westminster Window Works
(
  'cont_wind_nw_001',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Westminster Window Works',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-8601',
  'https://www.westminsterwindows.com',
  4.9,
  176,
  'westminster-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Window & Glass
(
  'cont_wind_nw_002',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Arvada Window & Glass',
  '7525 Ralston Rd, Arvada, CO 80002',
  '(303) 555-8602',
  'https://www.arvadawindows.com',
  4.8,
  151,
  'arvada-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Window Masters
(
  'cont_wind_nw_003',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Olde Town Window Masters',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-8603',
  'https://www.oldetownwindows.com',
  4.7,
  137,
  'olde-town-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Window Solutions
(
  'cont_wind_nw_004',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Standley Lake Window Solutions',
  '8900 Wadsworth Pkwy, Westminster, CO 80021',
  '(303) 555-8604',
  'https://www.standleylakewindows.com',
  4.8,
  163,
  'standley-lake-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Federal Heights Window Co
(
  'cont_wind_nw_005',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Federal Heights Window Co',
  '2800 W 92nd Ave, Federal Heights, CO 80260',
  '(303) 555-8605',
  'https://www.federalheightswindows.com',
  4.9,
  180,
  'federal-heights-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Sheridan Window Works
(
  'cont_wind_nw_006',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Sheridan Window Works',
  '5275 W 52nd Ave, Denver, CO 80212',
  '(303) 555-8606',
  'https://www.sheridanwindows.com',
  4.7,
  141,
  'sheridan-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Rocky Flats Window Specialists
(
  'cont_wind_nw_007',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Rocky Flats Window Specialists',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-8607',
  'https://www.rockyflatwindows.com',
  4.8,
  155,
  'rocky-flats-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Broomfield Border Window & Design
(
  'cont_wind_nw_008',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Broomfield Border Window & Design',
  '4800 W 120th Ave, Westminster, CO 80020',
  '(303) 555-8608',
  'https://www.broomfieldborderwindows.com',
  4.6,
  126,
  'broomfield-border-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Northwest Corridor Window Pros
(
  'cont_wind_nw_009',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Northwest Corridor Window Pros',
  '7315 Grandview Ave, Arvada, CO 80002',
  '(303) 555-8609',
  'https://www.northwestcorridorwindows.com',
  4.8,
  162,
  'northwest-corridor-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Golden Gate Window Solutions
(
  'cont_wind_nw_010',
  'cat_windows_001',
  'neigh_west_arvada_001',
  'Golden Gate Window Solutions',
  '6700 W 44th Ave, Wheat Ridge, CO 80033',
  '(303) 555-8610',
  'https://www.goldengatewindows.com',
  4.7,
  144,
  'golden-gate-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
