-- Ensure Epoxy Garage category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
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

-- Insert 10 Epoxy Garage contractors for Central Shopping area
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
-- 1. Cherry Creek Epoxy Solutions
(
  'cont_epoxy_cs_001',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Cherry Creek Epoxy Solutions',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-7201',
  'https://www.cherrycreekepoxy.com',
  4.9,
  147,
  'cherry-creek-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Garage Coatings
(
  'cont_epoxy_cs_002',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Lincoln Park Garage Coatings',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-7202',
  'https://www.lincolnparkepoxy.com',
  4.8,
  132,
  'lincoln-park-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Epoxy Masters
(
  'cont_epoxy_cs_003',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'North Cap Hill Epoxy Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-7203',
  'https://www.northcaphillepoxy.com',
  4.7,
  114,
  'north-cap-hill-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Garage Solutions
(
  'cont_epoxy_cs_004',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Shopping District Garage Solutions',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-7204',
  'https://www.shoppingdistrictepoxy.com',
  4.8,
  139,
  'shopping-district-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Epoxy Pro
(
  'cont_epoxy_cs_005',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Retail Row Epoxy Pro',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-7205',
  'https://www.retailrowepoxy.com',
  4.9,
  151,
  'retail-row-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Garage Finishes
(
  'cont_epoxy_cs_006',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Golden Triangle Garage Finishes',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-7206',
  'https://www.goldentriangleepoxy.com',
  4.7,
  119,
  'golden-triangle-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Epoxy Specialists
(
  'cont_epoxy_cs_007',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Epoxy Specialists',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-7207',
  'https://www.cherrycreeknorthepoxy.com',
  4.8,
  128,
  'cherry-creek-north-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Garage Coatings
(
  'cont_epoxy_cs_008',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Art District Garage Coatings',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-7208',
  'https://www.artdistrictepoxy.com',
  4.6,
  102,
  'art-district-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Epoxy Pros
(
  'cont_epoxy_cs_009',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Uptown Epoxy Pros',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-7209',
  'https://www.uptownepoxy.com',
  4.8,
  137,
  'uptown-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Garage Solutions
(
  'cont_epoxy_cs_010',
  'cat_epoxy_001',
  'neigh_central_shopping_001',
  'Mall District Garage Solutions',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-7210',
  'https://www.malldistrictepoxy.com',
  4.7,
  121,
  'mall-district-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
