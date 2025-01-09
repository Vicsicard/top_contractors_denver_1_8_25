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

-- Ensure East Colfax subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_east_colfax_001',
  'reg_east_001',
  'East Colfax',
  'east-colfax',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Colfax neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_east_colfax_001',
  'subreg_east_colfax_001',
  'East Colfax',
  'east-colfax',
  'Including East Colfax corridor and surrounding neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Kitchen Remodelers for East Colfax area
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
-- 1. East Colfax Kitchen Design
(
  'cont_kitchen_ec_001',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'East Colfax Kitchen Design',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-9501',
  'https://www.eastcolfaxkitchen.com',
  4.9,
  188,
  'east-colfax-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Kitchen & Cabinets
(
  'cont_kitchen_ec_002',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'Mayfair Kitchen & Cabinets',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-9502',
  'https://www.mayfairkitchen.com',
  4.8,
  166,
  'mayfair-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Kitchen Masters
(
  'cont_kitchen_ec_003',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'Montclair Kitchen Masters',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-9503',
  'https://www.montclairkitchen.com',
  4.7,
  144,
  'montclair-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Hale Kitchen Co
(
  'cont_kitchen_ec_004',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'Hale Kitchen Co',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-9504',
  'https://www.halekitchen.com',
  4.8,
  177,
  'hale-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. South Park Hill Kitchen Studio
(
  'cont_kitchen_ec_005',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'South Park Hill Kitchen Studio',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-9505',
  'https://www.southparkhillkitchenstudio.com',
  4.9,
  199,
  'south-park-hill-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Lowry Kitchen Design
(
  'cont_kitchen_ec_006',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'Lowry Kitchen Design',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-9506',
  'https://www.lowrykitchen.com',
  4.7,
  155,
  'lowry-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Side Kitchen Co
(
  'cont_kitchen_ec_007',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'East Side Kitchen Co',
  '6500 E Colfax Ave, Denver, CO 80220',
  '(303) 555-9507',
  'https://www.eastsidekitchen.com',
  4.8,
  166,
  'east-side-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Monaco Kitchen Studio
(
  'cont_kitchen_ec_008',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'Monaco Kitchen Studio',
  '2555 S Monaco Pkwy, Denver, CO 80222',
  '(303) 555-9508',
  'https://www.monacokitchenstudio.com',
  4.6,
  133,
  'monaco-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Quebec Kitchen Specialists
(
  'cont_kitchen_ec_009',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'Quebec Kitchen Specialists',
  '7300 E Quebec Pkwy, Denver, CO 80237',
  '(303) 555-9509',
  'https://www.quebeckitchen.com',
  4.8,
  177,
  'quebec-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Stapleton Kitchen Design
(
  'cont_kitchen_ec_010',
  'cat_kitchen_001',
  'neigh_east_colfax_001',
  'Stapleton Kitchen Design',
  '7351 E 29th Ave, Denver, CO 80238',
  '(303) 555-9510',
  'https://www.stapletonkitchen.com',
  4.7,
  155,
  'stapleton-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
