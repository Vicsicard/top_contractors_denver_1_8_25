-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
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

-- Insert 10 Fencing contractors for Central Shopping area
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
-- 1. Cherry Creek Fence Works
(
  'cont_fence_cs_001',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Cherry Creek Fence Works',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-9201',
  'https://www.cherrycreekfence.com',
  4.9,
  171,
  'cherry-creek-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Fence & Gate
(
  'cont_fence_cs_002',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Lincoln Park Fence & Gate',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-9202',
  'https://www.lincolnparkfence.com',
  4.8,
  149,
  'lincoln-park-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Fence Masters
(
  'cont_fence_cs_003',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'North Cap Hill Fence Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-9203',
  'https://www.northcaphillfence.com',
  4.7,
  127,
  'north-cap-hill-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Fence Solutions
(
  'cont_fence_cs_004',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Shopping District Fence Solutions',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-9204',
  'https://www.shoppingdistrictfence.com',
  4.8,
  160,
  'shopping-district-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Fence Co
(
  'cont_fence_cs_005',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Retail Row Fence Co',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-9205',
  'https://www.retailrowfence.com',
  4.9,
  171,
  'retail-row-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Fence Works
(
  'cont_fence_cs_006',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Golden Triangle Fence Works',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-9206',
  'https://www.goldentrianglefence.com',
  4.7,
  138,
  'golden-triangle-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Fence Specialists
(
  'cont_fence_cs_007',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Fence Specialists',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-9207',
  'https://www.cherrycreeknorthfence.com',
  4.8,
  149,
  'cherry-creek-north-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Fence & Design
(
  'cont_fence_cs_008',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Art District Fence & Design',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-9208',
  'https://www.artdistrictfence.com',
  4.6,
  120,
  'art-district-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Fence Pros
(
  'cont_fence_cs_009',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Uptown Fence Pros',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-9209',
  'https://www.uptownfence.com',
  4.8,
  160,
  'uptown-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Fence Solutions
(
  'cont_fence_cs_010',
  'cat_fencing_001',
  'neigh_central_shopping_001',
  'Mall District Fence Solutions',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-9210',
  'https://www.malldistrictfence.com',
  4.7,
  138,
  'mall-district-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
