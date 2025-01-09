-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Aurora/DTC area
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
-- 1. Aurora Siding & Gutters
(
  'cont_siding_ses_001',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Aurora Siding & Gutters',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-7801',
  'https://www.aurorasiding.com',
  4.9,
  182,
  'aurora-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Exteriors
(
  'cont_siding_ses_002',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'DTC Exteriors',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-7802',
  'https://www.dtcexteriors.com',
  4.8,
  165,
  'dtc-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Tech Center Gutter Masters
(
  'cont_siding_ses_003',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Tech Center Gutter Masters',
  '8515 E Orchard Rd, Greenwood Village, CO 80111',
  '(303) 555-7803',
  'https://www.techcentergutter.com',
  4.7,
  143,
  'tech-center-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Hampden South Siding Solutions
(
  'cont_siding_ses_004',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Hampden South Siding Solutions',
  '7400 E Hampden Ave, Denver, CO 80231',
  '(303) 555-7804',
  'https://www.hampdensouthsiding.com',
  4.8,
  176,
  'hampden-south-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Parker Road Gutter Co
(
  'cont_siding_ses_005',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Parker Road Gutter Co',
  '12500 E Parker Rd, Aurora, CO 80014',
  '(303) 555-7805',
  'https://www.parkerroadgutter.com',
  4.9,
  195,
  'parker-road-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Iliff Avenue Siding & Gutters
(
  'cont_siding_ses_006',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Iliff Avenue Siding & Gutters',
  '15000 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-7806',
  'https://www.iliffsiding.com',
  4.7,
  134,
  'iliff-avenue-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Southeast Exterior Specialists
(
  'cont_siding_ses_007',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Southeast Exterior Specialists',
  '6300 S Syracuse Way, Centennial, CO 80111',
  '(303) 555-7807',
  'https://www.southeastexteriors.com',
  4.8,
  156,
  'southeast-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Cherry Creek Siding & Gutters
(
  'cont_siding_ses_008',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek Siding & Gutters',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-7808',
  'https://www.cherrycreeksiding.com',
  4.6,
  122,
  'cherry-creek-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Arapahoe Gutter Pros
(
  'cont_siding_ses_009',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Gutter Pros',
  '7600 E Arapahoe Rd, Centennial, CO 80112',
  '(303) 555-7809',
  'https://www.arapahoegutter.com',
  4.8,
  167,
  'arapahoe-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Southlands Siding
(
  'cont_siding_ses_010',
  'cat_siding_001',
  'neigh_aurora_dtc_001',
  'Southlands Siding',
  '24300 E Smoky Hill Rd, Aurora, CO 80016',
  '(303) 555-7810',
  'https://www.southlandssiding.com',
  4.7,
  145,
  'southlands-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
