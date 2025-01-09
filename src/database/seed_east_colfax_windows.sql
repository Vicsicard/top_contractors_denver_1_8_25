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

-- Ensure East Colfax subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_east_colfax_001',
  'reg_east_001',
  'East Colfax',
  'east-colfax',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Colfax neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_east_colfax_001',
  'subreg_east_colfax_001',
  'East Colfax',
  'east-colfax',
  'Including East Colfax corridor and surrounding neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for East Colfax area
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
-- 1. East Colfax Window Works
(
  'cont_wind_ec_001',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'East Colfax Window Works',
  '8001 E Colfax Ave, Denver, CO 80220',
  '(303) 555-8501',
  'https://www.eastcolfaxwindows.com',
  4.9,
  172,
  'east-colfax-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Window & Glass
(
  'cont_wind_ec_002',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Mayfair Window & Glass',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-8502',
  'https://www.mayfairwindows.com',
  4.8,
  149,
  'mayfair-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Window Masters
(
  'cont_wind_ec_003',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Montclair Window Masters',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-8503',
  'https://www.montclairwindows.com',
  4.7,
  135,
  'montclair-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Lowry Window Solutions
(
  'cont_wind_ec_004',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Lowry Window Solutions',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-8504',
  'https://www.lowrywindows.com',
  4.8,
  161,
  'lowry-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Hale Window Co
(
  'cont_wind_ec_005',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Hale Window Co',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-8505',
  'https://www.halewindows.com',
  4.9,
  178,
  'hale-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Quebec Street Window Works
(
  'cont_wind_ec_006',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Quebec Street Window Works',
  '7300 E Colfax Ave, Denver, CO 80220',
  '(303) 555-8506',
  'https://www.quebecstreetwindows.com',
  4.7,
  139,
  'quebec-street-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Side Window Specialists
(
  'cont_wind_ec_007',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'East Side Window Specialists',
  '9095 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-8507',
  'https://www.eastsidewindows.com',
  4.8,
  153,
  'east-side-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Aurora Boundary Window & Design
(
  'cont_wind_ec_008',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Aurora Boundary Window & Design',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-8508',
  'https://www.auroraboundarywindows.com',
  4.6,
  124,
  'aurora-boundary-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Fitzsimons Window Pros
(
  'cont_wind_ec_009',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Fitzsimons Window Pros',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-8509',
  'https://www.fitzsimonswindows.com',
  4.8,
  160,
  'fitzsimons-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Original Aurora Window Solutions
(
  'cont_wind_ec_010',
  'cat_windows_001',
  'neigh_east_colfax_001',
  'Original Aurora Window Solutions',
  '9801 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-8510',
  'https://www.originalaurorawindows.com',
  4.7,
  142,
  'original-aurora-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
