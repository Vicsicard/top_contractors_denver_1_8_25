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

-- Ensure Park Hill subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill',
  'park-hill',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_park_hill_001',
  'subreg_park_hill_001',
  'Park Hill',
  'park-hill',
  'Including North Park Hill, South Park Hill, and Northeast Park Hill areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Kitchen Remodelers for Park Hill area
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
-- 1. Park Hill Kitchen Design
(
  'cont_kitchen_ph_001',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'Park Hill Kitchen Design',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-9301',
  'https://www.parkhillkitchen.com',
  4.9,
  188,
  'park-hill-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Kitchen & Cabinets
(
  'cont_kitchen_ph_002',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'North Park Hill Kitchen & Cabinets',
  '3300 Holly St, Denver, CO 80207',
  '(303) 555-9302',
  'https://www.northparkhillkitchen.com',
  4.8,
  166,
  'north-park-hill-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Kitchen Masters
(
  'cont_kitchen_ph_003',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'South Park Hill Kitchen Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-9303',
  'https://www.southparkhillkitchen.com',
  4.7,
  144,
  'south-park-hill-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Historic Park Hill Kitchen Co
(
  'cont_kitchen_ph_004',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'Historic Park Hill Kitchen Co',
  '2600 Forest St, Denver, CO 80207',
  '(303) 555-9304',
  'https://www.historicparkhillkitchen.com',
  4.8,
  177,
  'historic-park-hill-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Montview Kitchen Studio
(
  'cont_kitchen_ph_005',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'Montview Kitchen Studio',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-9305',
  'https://www.montviewkitchen.com',
  4.9,
  199,
  'montview-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 23rd Avenue Kitchen Design
(
  'cont_kitchen_ph_006',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  '23rd Avenue Kitchen Design',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-9306',
  'https://www.23rdkitchen.com',
  4.7,
  155,
  '23rd-avenue-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Greater Park Hill Kitchen Co
(
  'cont_kitchen_ph_007',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'Greater Park Hill Kitchen Co',
  '3000 Dexter St, Denver, CO 80207',
  '(303) 555-9307',
  'https://www.greaterparkhillkitchen.com',
  4.8,
  166,
  'greater-park-hill-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northeast Kitchen Studio
(
  'cont_kitchen_ph_008',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'Northeast Kitchen Studio',
  '3500 Hudson St, Denver, CO 80207',
  '(303) 555-9308',
  'https://www.northeastkitchen.com',
  4.6,
  133,
  'northeast-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Monaco Kitchen Specialists
(
  'cont_kitchen_ph_009',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'Monaco Kitchen Specialists',
  '2900 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-9309',
  'https://www.monacokitchen.com',
  4.8,
  177,
  'monaco-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Modern Kitchen
(
  'cont_kitchen_ph_010',
  'cat_kitchen_001',
  'neigh_park_hill_001',
  'Park Hill Modern Kitchen',
  '2500 Fairfax St, Denver, CO 80207',
  '(303) 555-9310',
  'https://www.parkhillmodernkitchen.com',
  4.7,
  155,
  'park-hill-modern-kitchen',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
