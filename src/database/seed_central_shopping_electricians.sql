-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
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

-- Insert 10 electricians for Central Shopping area
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
-- 1. Cherry Creek Electric Masters
(
  'cont_elec_cs_001',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Cherry Creek Electric Masters',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-2201',
  'https://www.cherrycreekelectric.com',
  4.9,
  234,
  'cherry-creek-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Electrical
(
  'cont_elec_cs_002',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Lincoln Park Electrical',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-2202',
  'https://www.lincolnparkelectrical.com',
  4.8,
  198,
  'lincoln-park-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Electric
(
  'cont_elec_cs_003',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'North Cap Hill Electric',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-2203',
  'https://www.northcaphillelectric.com',
  4.7,
  167,
  'north-cap-hill-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Electrical Pros
(
  'cont_elec_cs_004',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Shopping District Electrical Pros',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-2204',
  'https://www.shoppingdistrictelectrical.com',
  4.8,
  189,
  'shopping-district-electrical-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Electric Services
(
  'cont_elec_cs_005',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Retail Row Electric Services',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-2205',
  'https://www.retailrowelectric.com',
  4.6,
  156,
  'retail-row-electric-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Electrical
(
  'cont_elec_cs_006',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Golden Triangle Electrical',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-2206',
  'https://www.goldentriangleelectrical.com',
  4.9,
  212,
  'golden-triangle-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Electric
(
  'cont_elec_cs_007',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Electric',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-2207',
  'https://www.cherrycreeknorthelectric.com',
  4.8,
  167,
  'cherry-creek-north-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Electrical
(
  'cont_elec_cs_008',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Art District Electrical',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-2208',
  'https://www.artdistrictelectrical.com',
  4.7,
  178,
  'art-district-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Retail Electric
(
  'cont_elec_cs_009',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Uptown Retail Electric',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-2209',
  'https://www.uptownretailelectric.com',
  4.8,
  201,
  'uptown-retail-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Electrical Experts
(
  'cont_elec_cs_010',
  'cat_elec_001',
  'neigh_central_shopping_001',
  'Mall District Electrical Experts',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-2210',
  'https://www.malldistrictelectrical.com',
  4.7,
  182,
  'mall-district-electrical-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
