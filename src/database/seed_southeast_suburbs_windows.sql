-- Ensure Windows category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_windows_001',
  'Windows',
  'windows',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Southeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_se_suburbs_001',
  'Southeast Suburbs',
  'southeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Aurora/DTC subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_aurora_dtc_001',
  'reg_se_suburbs_001',
  'Aurora/DTC',
  'aurora-dtc',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Aurora/DTC neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_aurora_dtc_001',
  'subreg_aurora_dtc_001',
  'Aurora/DTC',
  'aurora-dtc',
  'Including Aurora, Denver Tech Center, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Window contractors for Aurora/DTC area
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
-- 1. Aurora Window Works
(
  'cont_wind_ses_001',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Aurora Window Works',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-8801',
  'https://www.aurorawindows.com',
  4.9,
  174,
  'aurora-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Window & Glass
(
  'cont_wind_ses_002',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'DTC Window & Glass',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-8802',
  'https://www.dtcwindows.com',
  4.8,
  149,
  'dtc-window-glass',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Window Masters
(
  'cont_wind_ses_003',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Southlands Window Masters',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-8803',
  'https://www.southlandswindows.com',
  4.7,
  135,
  'southlands-window-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Window Solutions
(
  'cont_wind_ses_004',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Tech Center Window Solutions',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-8804',
  'https://www.techcenterwindows.com',
  4.8,
  160,
  'tech-center-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Cherry Creek State Park Window Co
(
  'cont_wind_ses_005',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park Window Co',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-8805',
  'https://www.cherrycreekparkwindows.com',
  4.9,
  178,
  'cherry-creek-state-park-window-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Hampden Avenue Window Works
(
  'cont_wind_ses_006',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Hampden Avenue Window Works',
  '10355 E Hampden Ave, Denver, CO 80231',
  '(303) 555-8806',
  'https://www.hampdenwindows.com',
  4.7,
  139,
  'hampden-avenue-window-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Nine Mile Window Specialists
(
  'cont_wind_ses_007',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Nine Mile Window Specialists',
  '3100 S Parker Rd, Aurora, CO 80014',
  '(303) 555-8807',
  'https://www.ninemilewindows.com',
  4.8,
  153,
  'nine-mile-window-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Greenwood Village Window & Design
(
  'cont_wind_ses_008',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Greenwood Village Window & Design',
  '6300 S Syracuse Way, Centennial, CO 80111',
  '(303) 555-8808',
  'https://www.greenwoodvillagewindows.com',
  4.6,
  124,
  'greenwood-village-window-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Southeast Aurora Window Pros
(
  'cont_wind_ses_009',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Southeast Aurora Window Pros',
  '25100 E Quincy Ave, Aurora, CO 80016',
  '(303) 555-8809',
  'https://www.southeastaurorawindows.com',
  4.8,
  160,
  'southeast-aurora-window-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Centennial Window Solutions
(
  'cont_wind_ses_010',
  'cat_windows_001',
  'neigh_aurora_dtc_001',
  'Centennial Window Solutions',
  '7600 E Arapahoe Rd, Centennial, CO 80112',
  '(303) 555-8810',
  'https://www.centennialwindows.com',
  4.7,
  142,
  'centennial-window-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
