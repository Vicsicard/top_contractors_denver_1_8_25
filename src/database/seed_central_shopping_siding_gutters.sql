-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Central Shopping area
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
-- 1. Cherry Creek Siding & Gutters
(
  'cont_siding_cs_001',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Cherry Creek Siding & Gutters',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-7201',
  'https://www.cherrycreeksiding.com',
  4.9,
  189,
  'cherry-creek-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Exteriors
(
  'cont_siding_cs_002',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Lincoln Park Exteriors',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-7202',
  'https://www.lincolnparkexteriors.com',
  4.8,
  167,
  'lincoln-park-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Gutter Masters
(
  'cont_siding_cs_003',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'North Cap Hill Gutter Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-7203',
  'https://www.northcaphillgutter.com',
  4.7,
  145,
  'north-cap-hill-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Siding Solutions
(
  'cont_siding_cs_004',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Shopping District Siding Solutions',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-7204',
  'https://www.shoppingdistrictsiding.com',
  4.8,
  178,
  'shopping-district-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Gutter Co
(
  'cont_siding_cs_005',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Retail Row Gutter Co',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-7205',
  'https://www.retailrowgutter.com',
  4.9,
  189,
  'retail-row-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Siding & Gutters
(
  'cont_siding_cs_006',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Golden Triangle Siding & Gutters',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-7206',
  'https://www.goldentrianglesiding.com',
  4.7,
  156,
  'golden-triangle-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Exterior Specialists
(
  'cont_siding_cs_007',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Exterior Specialists',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-7207',
  'https://www.cherrycreeknorthexteriors.com',
  4.8,
  167,
  'cherry-creek-north-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Siding & Gutters
(
  'cont_siding_cs_008',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Art District Siding & Gutters',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-7208',
  'https://www.artdistrictsiding.com',
  4.6,
  134,
  'art-district-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Gutter Pros
(
  'cont_siding_cs_009',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Uptown Gutter Pros',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-7209',
  'https://www.uptowngutter.com',
  4.8,
  178,
  'uptown-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Siding Solutions
(
  'cont_siding_cs_010',
  'cat_siding_001',
  'neigh_central_shopping_001',
  'Mall District Siding Solutions',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-7210',
  'https://www.malldistrictsiding.com',
  4.7,
  156,
  'mall-district-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
