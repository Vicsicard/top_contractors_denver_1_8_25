-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
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

-- Insert 10 HVAC contractors for Central Shopping area
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
-- 1. Cherry Creek HVAC Masters
(
  'cont_hvac_cs_001',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Cherry Creek HVAC Masters',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-3201',
  'https://www.cherrycreekhvac.com',
  4.9,
  234,
  'cherry-creek-hvac-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Air Systems
(
  'cont_hvac_cs_002',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Lincoln Park Air Systems',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-3202',
  'https://www.lincolnparkhvac.com',
  4.8,
  198,
  'lincoln-park-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Climate Control
(
  'cont_hvac_cs_003',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'North Cap Hill Climate Control',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-3203',
  'https://www.northcaphillhvac.com',
  4.7,
  167,
  'north-cap-hill-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District HVAC Pros
(
  'cont_hvac_cs_004',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Shopping District HVAC Pros',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-3204',
  'https://www.shoppingdistricthvac.com',
  4.8,
  189,
  'shopping-district-hvac-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Climate Services
(
  'cont_hvac_cs_005',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Retail Row Climate Services',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-3205',
  'https://www.retailrowhvac.com',
  4.6,
  156,
  'retail-row-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle HVAC
(
  'cont_hvac_cs_006',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Golden Triangle HVAC',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-3206',
  'https://www.goldentrianglehvac.com',
  4.9,
  212,
  'golden-triangle-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Air Systems
(
  'cont_hvac_cs_007',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Air Systems',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-3207',
  'https://www.cherrycreeknorthhvac.com',
  4.8,
  167,
  'cherry-creek-north-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District HVAC
(
  'cont_hvac_cs_008',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Art District HVAC',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-3208',
  'https://www.artdistricthvac.com',
  4.7,
  178,
  'art-district-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Retail HVAC
(
  'cont_hvac_cs_009',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Uptown Retail HVAC',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-3209',
  'https://www.uptownretailhvac.com',
  4.8,
  201,
  'uptown-retail-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Climate Experts
(
  'cont_hvac_cs_010',
  'cat_hvac_001',
  'neigh_central_shopping_001',
  'Mall District Climate Experts',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-3210',
  'https://www.malldistricthvac.com',
  4.7,
  182,
  'mall-district-climate-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
