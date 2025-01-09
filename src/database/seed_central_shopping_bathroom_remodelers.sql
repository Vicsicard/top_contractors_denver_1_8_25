-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Central Shopping area
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
-- 1. Cherry Creek Bath Design
(
  'cont_bath_cs_001',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Cherry Creek Bath Design',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-8201',
  'https://www.cherrycreekbath.com',
  4.9,
  189,
  'cherry-creek-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Bath & Tile
(
  'cont_bath_cs_002',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Lincoln Park Bath & Tile',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-8202',
  'https://www.lincolnparkbath.com',
  4.8,
  156,
  'lincoln-park-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Bath Masters
(
  'cont_bath_cs_003',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'North Cap Hill Bath Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-8203',
  'https://www.northcaphillbath.com',
  4.7,
  134,
  'north-cap-hill-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Bath Co
(
  'cont_bath_cs_004',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Shopping District Bath Co',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-8204',
  'https://www.shoppingdistrictbath.com',
  4.8,
  167,
  'shopping-district-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Bath Studio
(
  'cont_bath_cs_005',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Retail Row Bath Studio',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-8205',
  'https://www.retailrowbath.com',
  4.9,
  178,
  'retail-row-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Bath Design
(
  'cont_bath_cs_006',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Golden Triangle Bath Design',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-8206',
  'https://www.goldentrianglebath.com',
  4.7,
  145,
  'golden-triangle-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Bath Co
(
  'cont_bath_cs_007',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Bath Co',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-8207',
  'https://www.cherrycreeknorthbath.com',
  4.8,
  156,
  'cherry-creek-north-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Bath Studio
(
  'cont_bath_cs_008',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Art District Bath Studio',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-8208',
  'https://www.artdistrictbath.com',
  4.6,
  123,
  'art-district-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Bath Specialists
(
  'cont_bath_cs_009',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Uptown Bath Specialists',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-8209',
  'https://www.uptownbath.com',
  4.8,
  167,
  'uptown-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Bath Design
(
  'cont_bath_cs_010',
  'cat_bath_001',
  'neigh_central_shopping_001',
  'Mall District Bath Design',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-8210',
  'https://www.malldistrictbath.com',
  4.7,
  145,
  'mall-district-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
