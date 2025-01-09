-- Ensure Kitchen Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Shopping subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_shopping_001',
  'reg_central_001',
  'Central Shopping',
  'central-shopping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Shopping neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_shopping_001',
  'subreg_central_shopping_001',
  'Central Shopping',
  'central-shopping',
  'Including Cherry Creek, Lincoln Park, and North Capitol Hill shopping districts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Kitchen Remodelers for Central Shopping area
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
-- 1. Cherry Creek Kitchen Design
(
  'cont_kitchen_cs_001',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Cherry Creek Kitchen Design',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-9201',
  'https://www.cherrycreekkitchen.com',
  4.9,
  199,
  'cherry-creek-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Kitchen & Cabinets
(
  'cont_kitchen_cs_002',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Lincoln Park Kitchen & Cabinets',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-9202',
  'https://www.lincolnparkkitchen.com',
  4.8,
  166,
  'lincoln-park-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Kitchen Masters
(
  'cont_kitchen_cs_003',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'North Cap Hill Kitchen Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-9203',
  'https://www.northcaphillkitchen.com',
  4.7,
  144,
  'north-cap-hill-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Kitchen Co
(
  'cont_kitchen_cs_004',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Shopping District Kitchen Co',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-9204',
  'https://www.shoppingdistrictkitchen.com',
  4.8,
  177,
  'shopping-district-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Kitchen Studio
(
  'cont_kitchen_cs_005',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Retail Row Kitchen Studio',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-9205',
  'https://www.retailrowkitchen.com',
  4.9,
  188,
  'retail-row-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Kitchen Design
(
  'cont_kitchen_cs_006',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Golden Triangle Kitchen Design',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-9206',
  'https://www.goldentrianglekitchen.com',
  4.7,
  155,
  'golden-triangle-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Kitchen Co
(
  'cont_kitchen_cs_007',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Kitchen Co',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-9207',
  'https://www.cherrycreeknorthkitchen.com',
  4.8,
  166,
  'cherry-creek-north-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Kitchen Studio
(
  'cont_kitchen_cs_008',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Art District Kitchen Studio',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-9208',
  'https://www.artdistrictkitchen.com',
  4.6,
  133,
  'art-district-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Kitchen Specialists
(
  'cont_kitchen_cs_009',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Uptown Kitchen Specialists',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-9209',
  'https://www.uptownkitchen.com',
  4.8,
  177,
  'uptown-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Kitchen Design
(
  'cont_kitchen_cs_010',
  'cat_kitchen_001',
  'neigh_central_shopping_001',
  'Mall District Kitchen Design',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-9210',
  'https://www.malldistrictkitchen.com',
  4.7,
  155,
  'mall-district-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
