-- Ensure Masonry category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_masonry_001',
  'Masonry',
  'masonry',
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

-- Insert 10 Masonry contractors for Central Shopping area
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
-- 1. Cherry Creek Masonry Works
(
  'cont_masonry_cs_001',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Cherry Creek Masonry Works',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-8201',
  'https://www.cherrycreekmasonry.com',
  4.9,
  188,
  'cherry-creek-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Stone & Brick
(
  'cont_masonry_cs_002',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Lincoln Park Stone & Brick',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-8202',
  'https://www.lincolnparkstone.com',
  4.8,
  166,
  'lincoln-park-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Brick Masters
(
  'cont_masonry_cs_003',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'North Cap Hill Brick Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-8203',
  'https://www.northcaphillbrick.com',
  4.7,
  144,
  'north-cap-hill-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Stone Solutions
(
  'cont_masonry_cs_004',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Shopping District Stone Solutions',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-8204',
  'https://www.shoppingdistrictstone.com',
  4.8,
  177,
  'shopping-district-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Masonry Co
(
  'cont_masonry_cs_005',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Retail Row Masonry Co',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-8205',
  'https://www.retailrowmasonry.com',
  4.9,
  188,
  'retail-row-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Stone Works
(
  'cont_masonry_cs_006',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Golden Triangle Stone Works',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-8206',
  'https://www.goldentrianglestone.com',
  4.7,
  155,
  'golden-triangle-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Masonry Specialists
(
  'cont_masonry_cs_007',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Masonry Specialists',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-8207',
  'https://www.cherrycreeknorthmasonry.com',
  4.8,
  166,
  'cherry-creek-north-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Stone & Brick
(
  'cont_masonry_cs_008',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Art District Stone & Brick',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-8208',
  'https://www.artdistrictstone.com',
  4.6,
  133,
  'art-district-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Masonry Pros
(
  'cont_masonry_cs_009',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Uptown Masonry Pros',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-8209',
  'https://www.uptownmasonry.com',
  4.8,
  177,
  'uptown-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Stone Solutions
(
  'cont_masonry_cs_010',
  'cat_masonry_001',
  'neigh_central_shopping_001',
  'Mall District Stone Solutions',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-8210',
  'https://www.malldistrictstone.com',
  4.7,
  155,
  'mall-district-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
