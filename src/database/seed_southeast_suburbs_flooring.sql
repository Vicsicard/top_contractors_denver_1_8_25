-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for Aurora/DTC area
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
-- 1. Aurora Flooring Works
(
  'cont_floor_ses_001',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Aurora Flooring Works',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-7801',
  'https://www.auroraflooring.com',
  4.9,
  166,
  'aurora-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Floor & Tile
(
  'cont_floor_ses_002',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'DTC Floor & Tile',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-7802',
  'https://www.dtcflooring.com',
  4.8,
  144,
  'dtc-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Floor Masters
(
  'cont_floor_ses_003',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Southlands Floor Masters',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-7803',
  'https://www.southlandsflooring.com',
  4.7,
  129,
  'southlands-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Flooring Solutions
(
  'cont_floor_ses_004',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Tech Center Flooring Solutions',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-7804',
  'https://www.techcenterflooring.com',
  4.8,
  156,
  'tech-center-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Cherry Creek Floor Co
(
  'cont_floor_ses_005',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek Floor Co',
  '3000 S Jamaica Ct, Aurora, CO 80014',
  '(303) 555-7805',
  'https://www.cherrycreekflooring.com',
  4.9,
  172,
  'cherry-creek-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Hampden Avenue Flooring Works
(
  'cont_floor_ses_006',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Hampden Avenue Flooring Works',
  '10701 E Hampden Ave, Aurora, CO 80014',
  '(303) 555-7806',
  'https://www.hampdenavenueflooring.com',
  4.7,
  133,
  'hampden-avenue-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Orchard Road Floor Specialists
(
  'cont_floor_ses_007',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Orchard Road Floor Specialists',
  '8000 E Orchard Rd, Greenwood Village, CO 80111',
  '(303) 555-7807',
  'https://www.orchardroadflooring.com',
  4.8,
  147,
  'orchard-road-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Arapahoe Floor & Design
(
  'cont_floor_ses_008',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Floor & Design',
  '6900 S Clinton St, Greenwood Village, CO 80112',
  '(303) 555-7808',
  'https://www.arapahoeflooring.com',
  4.6,
  116,
  'arapahoe-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Parker Road Floor Pros
(
  'cont_floor_ses_009',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Parker Road Floor Pros',
  '15000 E Parker Rd, Aurora, CO 80014',
  '(303) 555-7809',
  'https://www.parkerroadflooring.com',
  4.8,
  155,
  'parker-road-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Iliff Flooring Solutions
(
  'cont_floor_ses_010',
  'cat_flooring_001',
  'neigh_aurora_dtc_001',
  'Iliff Flooring Solutions',
  '15200 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-7810',
  'https://www.iliffflooring.com',
  4.7,
  131,
  'iliff-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
