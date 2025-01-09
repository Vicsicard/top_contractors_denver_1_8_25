-- Ensure Kitchen Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
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

-- Insert 10 Kitchen Remodelers for Aurora/DTC area
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
-- 1. Aurora Kitchen Design
(
  'cont_kitchen_ses_001',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Aurora Kitchen Design',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-9801',
  'https://www.aurorakitchen.com',
  4.9,
  188,
  'aurora-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Kitchen & Cabinets
(
  'cont_kitchen_ses_002',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'DTC Kitchen & Cabinets',
  '5000 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-9802',
  'https://www.dtckitchen.com',
  4.8,
  166,
  'dtc-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Kitchen Masters
(
  'cont_kitchen_ses_003',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Southlands Kitchen Masters',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-9803',
  'https://www.southlandskitchen.com',
  4.7,
  144,
  'southlands-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Kitchen Co
(
  'cont_kitchen_ses_004',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Tech Center Kitchen Co',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-9804',
  'https://www.techcenterkitchen.com',
  4.8,
  177,
  'tech-center-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Hampden Kitchen Studio
(
  'cont_kitchen_ses_005',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Hampden Kitchen Studio',
  '10355 E Hampden Ave, Aurora, CO 80014',
  '(303) 555-9805',
  'https://www.hampdenkitchen.com',
  4.9,
  199,
  'hampden-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Parker Road Kitchen Design
(
  'cont_kitchen_ses_006',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Parker Road Kitchen Design',
  '15000 E Parker Rd, Aurora, CO 80014',
  '(303) 555-9806',
  'https://www.parkerroadkitchen.com',
  4.7,
  155,
  'parker-road-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Iliff Kitchen Co
(
  'cont_kitchen_ses_007',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Iliff Kitchen Co',
  '15200 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-9807',
  'https://www.iliffkitchen.com',
  4.8,
  166,
  'iliff-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Greenwood Village Kitchen Studio
(
  'cont_kitchen_ses_008',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Greenwood Village Kitchen Studio',
  '6300 S Syracuse Way, Greenwood Village, CO 80111',
  '(303) 555-9808',
  'https://www.greenwoodvillagekitchen.com',
  4.6,
  133,
  'greenwood-village-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Arapahoe Kitchen Specialists
(
  'cont_kitchen_ses_009',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Kitchen Specialists',
  '7400 E Arapahoe Rd, Centennial, CO 80112',
  '(303) 555-9809',
  'https://www.arapahoekitchen.com',
  4.8,
  177,
  'arapahoe-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Southeast Kitchen Design
(
  'cont_kitchen_ses_010',
  'cat_kitchen_001',
  'neigh_aurora_dtc_001',
  'Southeast Kitchen Design',
  '15900 E Briarwood Cir, Aurora, CO 80016',
  '(303) 555-9810',
  'https://www.southeastkitchen.com',
  4.7,
  155,
  'southeast-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
