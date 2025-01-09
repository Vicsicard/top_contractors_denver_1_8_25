-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
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
  'Including Aurora, Denver Tech Center, and surrounding areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Roofers for Aurora/DTC area
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
-- 1. Aurora Premier Roofing
(
  'cont_roof_se_sub_001',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Aurora Premier Roofing',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-4801',
  'https://www.aurorapremierroofing.com',
  4.9,
  198,
  'aurora-premier-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Tech Center Roofing Specialists
(
  'cont_roof_se_sub_002',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Tech Center Roofing Specialists',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-4802',
  'https://www.techcenterroofing.com',
  4.8,
  167,
  'tech-center-roofing-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Roofing Co
(
  'cont_roof_se_sub_003',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Southlands Roofing Co',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-4803',
  'https://www.southlandsroofing.com',
  4.7,
  145,
  'southlands-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Cherry Creek State Park Roofing
(
  'cont_roof_se_sub_004',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park Roofing',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-4804',
  'https://www.cherrycreekparkroofing.com',
  4.8,
  156,
  'cherry-creek-state-park-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Greenwood Village Roofing
(
  'cont_roof_se_sub_005',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Greenwood Village Roofing',
  '5500 Greenwood Plaza Blvd, Greenwood Village, CO 80111',
  '(303) 555-4805',
  'https://www.greenwoodvillageroofing.com',
  4.9,
  187,
  'greenwood-village-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Hampden South Roofing Solutions
(
  'cont_roof_se_sub_006',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Hampden South Roofing Solutions',
  '7600 E Hampden Ave, Denver, CO 80231',
  '(303) 555-4806',
  'https://www.hampdensouthroofing.com',
  4.7,
  143,
  'hampden-south-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Iliff Avenue Roofing
(
  'cont_roof_se_sub_007',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Iliff Avenue Roofing',
  '2200 S Peoria St, Aurora, CO 80014',
  '(303) 555-4807',
  'https://www.iliffavenueroofing.com',
  4.8,
  134,
  'iliff-avenue-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Nine Mile Station Roofing
(
  'cont_roof_se_sub_008',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Nine Mile Station Roofing',
  '3100 S Parker Rd, Aurora, CO 80014',
  '(303) 555-4808',
  'https://www.ninemileroofing.com',
  4.6,
  123,
  'nine-mile-station-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Belleview Tech Center Roofing
(
  'cont_roof_se_sub_009',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Belleview Tech Center Roofing',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-4809',
  'https://www.belleviewtechroofing.com',
  4.8,
  167,
  'belleview-tech-center-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Southeast Aurora Roofing
(
  'cont_roof_se_sub_010',
  'cat_roof_001',
  'neigh_aurora_dtc_001',
  'Southeast Aurora Roofing',
  '25100 E Quincy Ave, Aurora, CO 80016',
  '(303) 555-4810',
  'https://www.southeastauroraroofing.com',
  4.7,
  145,
  'southeast-aurora-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
