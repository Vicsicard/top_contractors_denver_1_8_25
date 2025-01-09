-- Ensure Home Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
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

-- Insert 10 Home Remodelers for Aurora/DTC area
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
-- 1. Aurora Design Masters
(
  'cont_remod_ses_001',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Aurora Design Masters',
  '15000 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-7801',
  'https://www.auroradesignmasters.com',
  4.9,
  189,
  'aurora-design-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Tech Center Renovation Co
(
  'cont_remod_ses_002',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Tech Center Renovation Co',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-7802',
  'https://www.techcenterrenovation.com',
  4.8,
  167,
  'tech-center-renovation-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Hampden Avenue Design Build
(
  'cont_remod_ses_003',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Hampden Avenue Design Build',
  '10700 E Hampden Ave, Aurora, CO 80014',
  '(303) 555-7803',
  'https://www.hampdendesignbuild.com',
  4.7,
  145,
  'hampden-avenue-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Cherry Creek State Park Remodeling
(
  'cont_remod_ses_004',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park Remodeling',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-7804',
  'https://www.cherrycreekparkremodeling.com',
  4.8,
  156,
  'cherry-creek-state-park-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Southlands Design Studio
(
  'cont_remod_ses_005',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Southlands Design Studio',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-7805',
  'https://www.southlandsdesign.com',
  4.9,
  178,
  'southlands-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Belleview Avenue Remodeling
(
  'cont_remod_ses_006',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Belleview Avenue Remodeling',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-7806',
  'https://www.belleviewremodeling.com',
  4.7,
  134,
  'belleview-avenue-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Iliff Design Co
(
  'cont_remod_ses_007',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Iliff Design Co',
  '15200 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-7807',
  'https://www.iliffdesign.com',
  4.8,
  145,
  'iliff-design-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Greenwood Plaza Renovations
(
  'cont_remod_ses_008',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Greenwood Plaza Renovations',
  '6300 S Syracuse Way, Centennial, CO 80111',
  '(303) 555-7808',
  'https://www.greenwoodplazarenovations.com',
  4.6,
  123,
  'greenwood-plaza-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Arapahoe Road Design Build
(
  'cont_remod_ses_009',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Road Design Build',
  '12500 E Arapahoe Rd, Centennial, CO 80112',
  '(303) 555-7809',
  'https://www.arapahoeroaddesign.com',
  4.8,
  167,
  'arapahoe-road-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Parker Road Remodeling
(
  'cont_remod_ses_010',
  'cat_remod_001',
  'neigh_aurora_dtc_001',
  'Parker Road Remodeling',
  '16900 E Parker Rd, Parker, CO 80134',
  '(303) 555-7810',
  'https://www.parkerroadremodeling.com',
  4.7,
  145,
  'parker-road-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
