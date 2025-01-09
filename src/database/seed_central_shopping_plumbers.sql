-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure region exists (same as previous)
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure subregion exists for Central Shopping
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_shopping_001',
  'reg_central_001',
  'Central Shopping',
  'central-shopping-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_shopping_001',
  'subreg_central_shopping_001',
  'Central Shopping',
  'central-shopping-area',
  'Including Cherry Creek, Lincoln Park, and North Capitol Hill shopping districts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Central Shopping area
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
-- 1. Cherry Creek Plumbing Solutions
(
  'cont_plumb_cs_001',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Cherry Creek Plumbing Solutions',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-0301',
  'https://www.cherrycreekplumbing.com',
  4.9,
  212,
  'cherry-creek-plumbing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Plumbers
(
  'cont_plumb_cs_002',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Lincoln Park Plumbers',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-0302',
  'https://www.lincolnparkplumbers.com',
  4.8,
  187,
  'lincoln-park-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Plumbing & Drain
(
  'cont_plumb_cs_003',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'North Cap Hill Plumbing & Drain',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-0303',
  'https://www.northcaphillplumbing.com',
  4.7,
  165,
  'north-cap-hill-plumbing-drain',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Plumbing Pros
(
  'cont_plumb_cs_004',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Shopping District Plumbing Pros',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-0304',
  'https://www.shoppingdistrictplumbing.com',
  4.8,
  193,
  'shopping-district-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Plumbing Services
(
  'cont_plumb_cs_005',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Retail Row Plumbing Services',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-0305',
  'https://www.retailrowplumbing.com',
  4.6,
  156,
  'retail-row-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Plumbing
(
  'cont_plumb_cs_006',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Golden Triangle Plumbing',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-0306',
  'https://www.goldentriangleplumbing.com',
  4.9,
  178,
  'golden-triangle-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Plumbers
(
  'cont_plumb_cs_007',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Plumbers',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-0307',
  'https://www.cherrycreeknorthplumbers.com',
  4.8,
  201,
  'cherry-creek-north-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Plumbing
(
  'cont_plumb_cs_008',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Art District Plumbing',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-0308',
  'https://www.artdistrictplumbing.com',
  4.7,
  167,
  'art-district-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Retail Plumbing
(
  'cont_plumb_cs_009',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Uptown Retail Plumbing',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-0309',
  'https://www.uptownretailplumbing.com',
  4.8,
  189,
  'uptown-retail-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Plumbing Experts
(
  'cont_plumb_cs_010',
  'cat_plumber_001',
  'neigh_central_shopping_001',
  'Mall District Plumbing Experts',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-0310',
  'https://www.malldistrictplumbing.com',
  4.7,
  176,
  'mall-district-plumbing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
