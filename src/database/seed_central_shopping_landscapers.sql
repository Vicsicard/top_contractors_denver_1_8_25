-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for Central Shopping area
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
-- 1. Cherry Creek Garden Masters
(
  'cont_land_cs_001',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Cherry Creek Garden Masters',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-6201',
  'https://www.cherrycreekgardens.com',
  4.9,
  178,
  'cherry-creek-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Landscape Studio
(
  'cont_land_cs_002',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Lincoln Park Landscape Studio',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-6202',
  'https://www.lincolnparklandscape.com',
  4.8,
  145,
  'lincoln-park-landscape-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Gardens
(
  'cont_land_cs_003',
  'cat_land_001',
  'neigh_central_shopping_001',
  'North Cap Hill Gardens',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-6203',
  'https://www.northcaphillgardens.com',
  4.7,
  132,
  'north-cap-hill-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Landscape Co
(
  'cont_land_cs_004',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Shopping District Landscape Co',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-6204',
  'https://www.shoppingdistrictlandscape.com',
  4.8,
  156,
  'shopping-district-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Gardens
(
  'cont_land_cs_005',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Retail Row Gardens',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-6205',
  'https://www.retailrowgardens.com',
  4.6,
  123,
  'retail-row-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Landscape Design
(
  'cont_land_cs_006',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Golden Triangle Landscape Design',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-6206',
  'https://www.goldentrianglelandscape.com',
  4.9,
  167,
  'golden-triangle-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Gardens
(
  'cont_land_cs_007',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Gardens',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-6207',
  'https://www.cherrycreeknorthgardens.com',
  4.8,
  134,
  'cherry-creek-north-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Garden Studio
(
  'cont_land_cs_008',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Art District Garden Studio',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-6208',
  'https://www.artdistrictgardens.com',
  4.7,
  145,
  'art-district-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Retail Gardens
(
  'cont_land_cs_009',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Uptown Retail Gardens',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-6209',
  'https://www.uptownretailgardens.com',
  4.8,
  156,
  'uptown-retail-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Landscape Pros
(
  'cont_land_cs_010',
  'cat_land_001',
  'neigh_central_shopping_001',
  'Mall District Landscape Pros',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-6210',
  'https://www.malldistrictlandscape.com',
  4.7,
  134,
  'mall-district-landscape-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
