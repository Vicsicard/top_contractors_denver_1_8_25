-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for Aurora/DTC area
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
-- 1. Aurora Garden Masters
(
  'cont_land_ses_001',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Aurora Garden Masters',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-6801',
  'https://www.auroragardens.com',
  4.9,
  167,
  'aurora-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Landscape Design
(
  'cont_land_ses_002',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'DTC Landscape Design',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-6802',
  'https://www.dtclandscape.com',
  4.8,
  145,
  'dtc-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Gardens
(
  'cont_land_ses_003',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Southlands Gardens',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-6803',
  'https://www.southlandsgardens.com',
  4.7,
  132,
  'southlands-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Landscaping
(
  'cont_land_ses_004',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Tech Center Landscaping',
  '8400 E Crescent Pkwy, Greenwood Village, CO 80111',
  '(303) 555-6804',
  'https://www.techcenterlandscaping.com',
  4.8,
  156,
  'tech-center-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Southeast Garden Design
(
  'cont_land_ses_005',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Southeast Garden Design',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-6805',
  'https://www.southeastgardendesign.com',
  4.9,
  178,
  'southeast-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Cherry Creek State Park Gardens
(
  'cont_land_ses_006',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park Gardens',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-6806',
  'https://www.cherrycreekgardens.com',
  4.7,
  134,
  'cherry-creek-state-park-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Hampden Gardens
(
  'cont_land_ses_007',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Hampden Gardens',
  '10355 E Hampden Ave, Denver, CO 80231',
  '(303) 555-6807',
  'https://www.hampdengardens.com',
  4.8,
  145,
  'hampden-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Belleview Garden Studio
(
  'cont_land_ses_008',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Belleview Garden Studio',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-6808',
  'https://www.belleviewgardens.com',
  4.6,
  123,
  'belleview-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Arapahoe Landscape Design
(
  'cont_land_ses_009',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Landscape Design',
  '6924 S Lima St, Centennial, CO 80112',
  '(303) 555-6809',
  'https://www.arapahoelandscape.com',
  4.8,
  156,
  'arapahoe-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Reservoir Gardens
(
  'cont_land_ses_010',
  'cat_land_001',
  'neigh_aurora_dtc_001',
  'Reservoir Gardens',
  '5800 S Parker Rd, Aurora, CO 80015',
  '(303) 555-6810',
  'https://www.reservoirgardens.com',
  4.7,
  134,
  'reservoir-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
