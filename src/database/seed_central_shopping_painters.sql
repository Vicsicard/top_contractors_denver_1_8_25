-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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

-- Insert 10 Painters for Central Shopping area
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
-- 1. Cherry Creek Paint Masters
(
  'cont_paint_cs_001',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Cherry Creek Paint Masters',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-5201',
  'https://www.cherrycreekpainting.com',
  4.9,
  178,
  'cherry-creek-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Paint Studio
(
  'cont_paint_cs_002',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Lincoln Park Paint Studio',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-5202',
  'https://www.lincolnparkpainting.com',
  4.8,
  145,
  'lincoln-park-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Painters
(
  'cont_paint_cs_003',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'North Cap Hill Painters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-5203',
  'https://www.northcaphillpainters.com',
  4.7,
  132,
  'north-cap-hill-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Paint Co
(
  'cont_paint_cs_004',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Shopping District Paint Co',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-5204',
  'https://www.shoppingdistrictpainting.com',
  4.8,
  156,
  'shopping-district-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Painters
(
  'cont_paint_cs_005',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Retail Row Painters',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-5205',
  'https://www.retailrowpainters.com',
  4.6,
  123,
  'retail-row-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Paint & Design
(
  'cont_paint_cs_006',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Golden Triangle Paint & Design',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-5206',
  'https://www.goldentrianglepainting.com',
  4.9,
  167,
  'golden-triangle-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Painters
(
  'cont_paint_cs_007',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Painters',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-5207',
  'https://www.cherrycreeknorthpainters.com',
  4.8,
  134,
  'cherry-creek-north-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Paint Studio
(
  'cont_paint_cs_008',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Art District Paint Studio',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-5208',
  'https://www.artdistrictpainting.com',
  4.7,
  145,
  'art-district-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Retail Painters
(
  'cont_paint_cs_009',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Uptown Retail Painters',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-5209',
  'https://www.uptownretailpainters.com',
  4.8,
  156,
  'uptown-retail-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Paint Pros
(
  'cont_paint_cs_010',
  'cat_paint_001',
  'neigh_central_shopping_001',
  'Mall District Paint Pros',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-5210',
  'https://www.malldistrictpainting.com',
  4.7,
  134,
  'mall-district-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
