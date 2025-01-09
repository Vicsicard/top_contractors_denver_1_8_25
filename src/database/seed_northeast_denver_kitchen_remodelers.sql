-- Ensure Kitchen Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_east_001',
  'East Denver',
  'east-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_northeast_001',
  'reg_east_001',
  'Northeast Denver',
  'northeast-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_northeast_001',
  'subreg_northeast_001',
  'Northeast Denver',
  'northeast-denver',
  'Including Montbello, Green Valley Ranch, and Gateway areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Kitchen Remodelers for Northeast Denver area
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
-- 1. Montbello Kitchen Design
(
  'cont_kitchen_ne_001',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Montbello Kitchen Design',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-9401',
  'https://www.montbellokitchen.com',
  4.9,
  188,
  'montbello-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Kitchen & Cabinets
(
  'cont_kitchen_ne_002',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Green Valley Ranch Kitchen & Cabinets',
  '18601 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-9402',
  'https://www.gvrkitchen.com',
  4.8,
  166,
  'green-valley-ranch-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Kitchen Masters
(
  'cont_kitchen_ne_003',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Gateway Kitchen Masters',
  '4800 Tower Rd, Denver, CO 80249',
  '(303) 555-9403',
  'https://www.gatewaykitchen.com',
  4.7,
  144,
  'gateway-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Kitchen Co
(
  'cont_kitchen_ne_004',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'DIA Kitchen Co',
  '8500 Peña Blvd, Denver, CO 80249',
  '(303) 555-9404',
  'https://www.diakitchen.com',
  4.8,
  177,
  'dia-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Peña Boulevard Kitchen Studio
(
  'cont_kitchen_ne_005',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Peña Boulevard Kitchen Studio',
  '16000 E 40th Ave, Denver, CO 80239',
  '(303) 555-9405',
  'https://www.penablvdkitchen.com',
  4.9,
  199,
  'pena-boulevard-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Tower Road Kitchen Design
(
  'cont_kitchen_ne_006',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Tower Road Kitchen Design',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-9406',
  'https://www.towerroadkitchen.com',
  4.7,
  155,
  'tower-road-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northeast Denver Kitchen Co
(
  'cont_kitchen_ne_007',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Northeast Denver Kitchen Co',
  '5000 Crown Blvd, Denver, CO 80239',
  '(303) 555-9407',
  'https://www.nedenkitchen.com',
  4.8,
  166,
  'northeast-denver-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Airport Kitchen Studio
(
  'cont_kitchen_ne_008',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Airport Kitchen Studio',
  '7500 E 35th Ave, Denver, CO 80238',
  '(303) 555-9408',
  'https://www.airportkitchen.com',
  4.6,
  133,
  'airport-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Chambers Kitchen Specialists
(
  'cont_kitchen_ne_009',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Chambers Kitchen Specialists',
  '4500 Chambers Rd, Denver, CO 80239',
  '(303) 555-9409',
  'https://www.chamberskitchen.com',
  4.8,
  177,
  'chambers-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal Kitchen Design
(
  'cont_kitchen_ne_010',
  'cat_kitchen_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Kitchen Design',
  '6550 Gateway Rd, Commerce City, CO 80022',
  '(303) 555-9410',
  'https://www.rockymountainkitchen.com',
  4.7,
  155,
  'rocky-mountain-arsenal-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
