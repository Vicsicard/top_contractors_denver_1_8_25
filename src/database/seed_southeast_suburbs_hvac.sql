-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southeast Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_se_suburbs_001',
  'Southeast Suburbs',
  'southeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Aurora/DTC subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_aurora_dtc_001',
  'reg_se_suburbs_001',
  'Aurora/DTC',
  'aurora-dtc',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Aurora/DTC neighborhood
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

-- Insert 10 HVAC contractors for Aurora/DTC area
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
-- 1. Aurora HVAC Experts
(
  'cont_hvac_ses_001',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Aurora HVAC Experts',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-3801',
  'https://www.aurorahvac.com',
  4.9,
  234,
  'aurora-hvac-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Tech Center Air Systems
(
  'cont_hvac_ses_002',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Tech Center Air Systems',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-3802',
  'https://www.techcenterhvac.com',
  4.8,
  198,
  'tech-center-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Climate Control
(
  'cont_hvac_ses_003',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Southlands Climate Control',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-3803',
  'https://www.southlandshvac.com',
  4.7,
  167,
  'southlands-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Hampden Avenue HVAC
(
  'cont_hvac_ses_004',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Hampden Avenue HVAC',
  '10700 E Hampden Ave, Aurora, CO 80014',
  '(303) 555-3804',
  'https://www.hampdenavehvac.com',
  4.8,
  189,
  'hampden-avenue-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Southeast Metro Climate Pros
(
  'cont_hvac_ses_005',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Southeast Metro Climate Pros',
  '15151 E Mississippi Ave, Aurora, CO 80012',
  '(303) 555-3805',
  'https://www.semetrohvac.com',
  4.9,
  212,
  'southeast-metro-climate-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Cherry Creek State Park HVAC
(
  'cont_hvac_ses_006',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park HVAC',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-3806',
  'https://www.cherrycreekhvac.com',
  4.7,
  178,
  'cherry-creek-state-park-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Belleview Air Solutions
(
  'cont_hvac_ses_007',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Belleview Air Solutions',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-3807',
  'https://www.belleviewhvac.com',
  4.8,
  167,
  'belleview-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Iliff Avenue HVAC Services
(
  'cont_hvac_ses_008',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Iliff Avenue HVAC Services',
  '15200 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-3808',
  'https://www.iliffhvac.com',
  4.6,
  156,
  'iliff-avenue-hvac-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Arapahoe Crossing Climate Services
(
  'cont_hvac_ses_009',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Crossing Climate Services',
  '6616 S Parker Rd, Aurora, CO 80016',
  '(303) 555-3809',
  'https://www.arapahoecrossinghvac.com',
  4.8,
  201,
  'arapahoe-crossing-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Greenwood Plaza HVAC Specialists
(
  'cont_hvac_ses_010',
  'cat_hvac_001',
  'neigh_aurora_dtc_001',
  'Greenwood Plaza HVAC Specialists',
  '5600 S Quebec St, Greenwood Village, CO 80111',
  '(303) 555-3810',
  'https://www.greenwoodplazahvac.com',
  4.7,
  182,
  'greenwood-plaza-hvac-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
