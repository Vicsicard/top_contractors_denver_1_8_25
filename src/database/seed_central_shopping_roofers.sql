-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
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

-- Insert 10 Roofers for Central Shopping area
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
-- 1. Cherry Creek Roofing Masters
(
  'cont_roof_cs_001',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Cherry Creek Roofing Masters',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-4201',
  'https://www.cherrycreekroofing.com',
  4.9,
  187,
  'cherry-creek-roofing-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Roofing Systems
(
  'cont_roof_cs_002',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Lincoln Park Roofing Systems',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-4202',
  'https://www.lincolnparkroofing.com',
  4.8,
  156,
  'lincoln-park-roofing-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Roofing Co
(
  'cont_roof_cs_003',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'North Cap Hill Roofing Co',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-4203',
  'https://www.northcaphillroofing.com',
  4.7,
  143,
  'north-cap-hill-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Roofing Pros
(
  'cont_roof_cs_004',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Shopping District Roofing Pros',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-4204',
  'https://www.shoppingdistrictroofing.com',
  4.8,
  165,
  'shopping-district-roofing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Roofing Services
(
  'cont_roof_cs_005',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Retail Row Roofing Services',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-4205',
  'https://www.retailrowroofing.com',
  4.6,
  134,
  'retail-row-roofing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Roofing
(
  'cont_roof_cs_006',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Golden Triangle Roofing',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-4206',
  'https://www.goldentriangleroofing.com',
  4.9,
  178,
  'golden-triangle-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Roofing Systems
(
  'cont_roof_cs_007',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Roofing Systems',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-4207',
  'https://www.cherrycreeknorthroofing.com',
  4.8,
  145,
  'cherry-creek-north-roofing-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Roofing
(
  'cont_roof_cs_008',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Art District Roofing',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-4208',
  'https://www.artdistrictroofing.com',
  4.7,
  156,
  'art-district-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Retail Roofing
(
  'cont_roof_cs_009',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Uptown Retail Roofing',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-4209',
  'https://www.uptownretailroofing.com',
  4.8,
  167,
  'uptown-retail-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Roofing Experts
(
  'cont_roof_cs_010',
  'cat_roof_001',
  'neigh_central_shopping_001',
  'Mall District Roofing Experts',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-4210',
  'https://www.malldistrictroofing.com',
  4.7,
  145,
  'mall-district-roofing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
