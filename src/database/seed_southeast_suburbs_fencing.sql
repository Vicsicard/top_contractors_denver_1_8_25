-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
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

-- Insert 10 Fencing contractors for Aurora/DTC area
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
-- 1. Aurora Fence Works
(
  'cont_fence_ses_001',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Aurora Fence Works',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-9801',
  'https://www.aurorafence.com',
  4.9,
  168,
  'aurora-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Fence & Gate
(
  'cont_fence_ses_002',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'DTC Fence & Gate',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-9802',
  'https://www.dtcfence.com',
  4.8,
  143,
  'dtc-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Fence Masters
(
  'cont_fence_ses_003',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Southlands Fence Masters',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-9803',
  'https://www.southlandsfence.com',
  4.7,
  129,
  'southlands-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Fence Solutions
(
  'cont_fence_ses_004',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Tech Center Fence Solutions',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-9804',
  'https://www.techcenterfence.com',
  4.8,
  156,
  'tech-center-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Cherry Creek State Park Fence Co
(
  'cont_fence_ses_005',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park Fence Co',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-9805',
  'https://www.cherrycreekparkfence.com',
  4.9,
  173,
  'cherry-creek-state-park-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Hampden South Fence Works
(
  'cont_fence_ses_006',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Hampden South Fence Works',
  '7600 E Hampden Ave, Denver, CO 80231',
  '(303) 555-9806',
  'https://www.hampdensouthfence.com',
  4.7,
  132,
  'hampden-south-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Centennial Fence Specialists
(
  'cont_fence_ses_007',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Centennial Fence Specialists',
  '6901 S Clinton St, Centennial, CO 80112',
  '(303) 555-9807',
  'https://www.centennialfence.com',
  4.8,
  146,
  'centennial-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Greenwood Village Fence & Design
(
  'cont_fence_ses_008',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Greenwood Village Fence & Design',
  '6300 S Syracuse Way, Centennial, CO 80111',
  '(303) 555-9808',
  'https://www.greenwoodvillagefence.com',
  4.6,
  116,
  'greenwood-village-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Southeast Aurora Fence Pros
(
  'cont_fence_ses_009',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Southeast Aurora Fence Pros',
  '25100 E Quincy Ave, Aurora, CO 80016',
  '(303) 555-9809',
  'https://www.seaurorafence.com',
  4.8,
  155,
  'southeast-aurora-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Inverness Fence Solutions
(
  'cont_fence_ses_010',
  'cat_fencing_001',
  'neigh_aurora_dtc_001',
  'Inverness Fence Solutions',
  '155 Inverness Dr W, Englewood, CO 80112',
  '(303) 555-9810',
  'https://www.invernessfence.com',
  4.7,
  130,
  'inverness-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
