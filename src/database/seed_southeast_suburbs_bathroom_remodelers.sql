-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Aurora/DTC area
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
-- 1. Aurora Bath Design
(
  'cont_bath_ses_001',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Aurora Bath Design',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-8801',
  'https://www.aurorabathdesign.com',
  4.9,
  178,
  'aurora-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Bath & Tile
(
  'cont_bath_ses_002',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'DTC Bath & Tile',
  '5555 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-8802',
  'https://www.dtcbath.com',
  4.8,
  156,
  'dtc-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Bath Masters
(
  'cont_bath_ses_003',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Southlands Bath Masters',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-8803',
  'https://www.southlandsbath.com',
  4.7,
  134,
  'southlands-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Bath Co
(
  'cont_bath_ses_004',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Tech Center Bath Co',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-8804',
  'https://www.techcenterbath.com',
  4.8,
  167,
  'tech-center-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Hampden Bath Studio
(
  'cont_bath_ses_005',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Hampden Bath Studio',
  '10355 E Hampden Ave, Aurora, CO 80014',
  '(303) 555-8805',
  'https://www.hampdenbath.com',
  4.9,
  189,
  'hampden-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Parker Road Bath Design
(
  'cont_bath_ses_006',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Parker Road Bath Design',
  '16901 E Quincy Ave, Aurora, CO 80015',
  '(303) 555-8806',
  'https://www.parkerroadbath.com',
  4.7,
  145,
  'parker-road-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Arapahoe Bath Co
(
  'cont_bath_ses_007',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Bath Co',
  '6500 S Quebec St, Centennial, CO 80111',
  '(303) 555-8807',
  'https://www.arapahoebath.com',
  4.8,
  156,
  'arapahoe-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Cherry Creek Bath Studio
(
  'cont_bath_ses_008',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek Bath Studio',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-8808',
  'https://www.cherrycreekbathstudio.com',
  4.6,
  123,
  'cherry-creek-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Iliff Bath Specialists
(
  'cont_bath_ses_009',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Iliff Bath Specialists',
  '15200 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-8809',
  'https://www.iliffbath.com',
  4.8,
  167,
  'iliff-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Greenwood Village Bath Design
(
  'cont_bath_ses_010',
  'cat_bath_001',
  'neigh_aurora_dtc_001',
  'Greenwood Village Bath Design',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-8810',
  'https://www.greenwoodvillagebath.com',
  4.7,
  145,
  'greenwood-village-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
