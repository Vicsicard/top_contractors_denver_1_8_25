-- Ensure Home Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
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

-- Insert 10 Home Remodelers for Central Shopping area
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
-- 1. Cherry Creek Renovation Masters
(
  'cont_remod_cs_001',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Cherry Creek Renovation Masters',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-7201',
  'https://www.cherrycreekrenovations.com',
  4.9,
  178,
  'cherry-creek-renovation-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Design Build
(
  'cont_remod_cs_002',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Lincoln Park Design Build',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-7202',
  'https://www.lincolnparkdesignbuild.com',
  4.8,
  145,
  'lincoln-park-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Remodeling
(
  'cont_remod_cs_003',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'North Cap Hill Remodeling',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-7203',
  'https://www.northcaphillremodeling.com',
  4.7,
  132,
  'north-cap-hill-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Design Co
(
  'cont_remod_cs_004',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Shopping District Design Co',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-7204',
  'https://www.shoppingdistrictdesign.com',
  4.8,
  156,
  'shopping-district-design-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Renovations
(
  'cont_remod_cs_005',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Retail Row Renovations',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-7205',
  'https://www.retailrowrenovations.com',
  4.6,
  123,
  'retail-row-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Design Build
(
  'cont_remod_cs_006',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Golden Triangle Design Build',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-7206',
  'https://www.goldentriangledesign.com',
  4.9,
  167,
  'golden-triangle-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Remodeling
(
  'cont_remod_cs_007',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Remodeling',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-7207',
  'https://www.cherrycreeknorthremodeling.com',
  4.8,
  134,
  'cherry-creek-north-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Renovation Studio
(
  'cont_remod_cs_008',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Art District Renovation Studio',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-7208',
  'https://www.artdistrictrenovations.com',
  4.7,
  145,
  'art-district-renovation-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Retail Remodeling
(
  'cont_remod_cs_009',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Uptown Retail Remodeling',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-7209',
  'https://www.uptownretailremodeling.com',
  4.8,
  156,
  'uptown-retail-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Design Studio
(
  'cont_remod_cs_010',
  'cat_remod_001',
  'neigh_central_shopping_001',
  'Mall District Design Studio',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-7210',
  'https://www.malldistrictdesign.com',
  4.7,
  134,
  'mall-district-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
