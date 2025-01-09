-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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
  'subreg_aur_dtc_001',
  'reg_se_suburbs_001',
  'Aurora/DTC',
  'aurora-dtc',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Aurora/DTC neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_aur_dtc_001',
  'subreg_aur_dtc_001',
  'Aurora/DTC',
  'aurora-dtc',
  'Including Aurora, Denver Tech Center, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Painters for Aurora/DTC area
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
-- 1. Aurora Paint Masters
(
  'cont_paint_ses_001',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Aurora Paint Masters',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-5801',
  'https://www.aurorapainting.com',
  4.9,
  167,
  'aurora-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Paint Co
(
  'cont_paint_ses_002',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'DTC Paint Co',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-5802',
  'https://www.dtcpainting.com',
  4.8,
  145,
  'dtc-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Paint Studio
(
  'cont_paint_ses_003',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Southlands Paint Studio',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-5803',
  'https://www.southlandspainting.com',
  4.7,
  132,
  'southlands-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Paint & Design
(
  'cont_paint_ses_004',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Tech Center Paint & Design',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-5804',
  'https://www.techcenterpainting.com',
  4.8,
  156,
  'tech-center-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Hampden Paint Pros
(
  'cont_paint_ses_005',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Hampden Paint Pros',
  '10355 E Hampden Ave, Aurora, CO 80014',
  '(303) 555-5805',
  'https://www.hampdenpainting.com',
  4.9,
  178,
  'hampden-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Cherry Creek State Park Painters
(
  'cont_paint_ses_006',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Cherry Creek State Park Painters',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-5806',
  'https://www.cherrycreekparkpainting.com',
  4.7,
  134,
  'cherry-creek-state-park-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Orchard Road Paint Studio
(
  'cont_paint_ses_007',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Orchard Road Paint Studio',
  '8000 E Orchard Rd, Greenwood Village, CO 80111',
  '(303) 555-5807',
  'https://www.orchardrdpainting.com',
  4.8,
  145,
  'orchard-road-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Iliff Paint Solutions
(
  'cont_paint_ses_008',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Iliff Paint Solutions',
  '15200 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-5808',
  'https://www.iliffpainting.com',
  4.6,
  123,
  'iliff-paint-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Arapahoe Paint Co
(
  'cont_paint_ses_009',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Arapahoe Paint Co',
  '7600 E Arapahoe Rd, Centennial, CO 80112',
  '(303) 555-5809',
  'https://www.arapahoepainting.com',
  4.8,
  156,
  'arapahoe-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Quincy Paint Masters
(
  'cont_paint_ses_010',
  'cat_paint_001',
  'neigh_aur_dtc_001',
  'Quincy Paint Masters',
  '16900 E Quincy Ave, Aurora, CO 80015',
  '(303) 555-5810',
  'https://www.quincypainting.com',
  4.7,
  134,
  'quincy-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
