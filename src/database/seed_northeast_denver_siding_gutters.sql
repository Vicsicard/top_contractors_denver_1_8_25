-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_east_001',
  'East Denver',
  'east-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_northeast_001',
  'reg_east_001',
  'Northeast Denver',
  'northeast-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_northeast_001',
  'subreg_northeast_001',
  'Northeast Denver',
  'northeast-denver',
  'Including Montbello, Green Valley Ranch, and Gateway areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Siding & Gutters contractors for Northeast Denver area
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
-- 1. Montbello Siding & Gutters
(
  'cont_siding_ne_001',
  'cat_siding_001',
  'neigh_northeast_001',
  'Montbello Siding & Gutters',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-7401',
  'https://www.montbellosiding.com',
  4.9,
  182,
  'montbello-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Exteriors
(
  'cont_siding_ne_002',
  'cat_siding_001',
  'neigh_northeast_001',
  'Green Valley Ranch Exteriors',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-7402',
  'https://www.gvrexteriors.com',
  4.8,
  165,
  'green-valley-ranch-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Gutter Masters
(
  'cont_siding_ne_003',
  'cat_siding_001',
  'neigh_northeast_001',
  'Gateway Gutter Masters',
  '16300 E 40th Ave, Denver, CO 80239',
  '(303) 555-7403',
  'https://www.gatewaygutter.com',
  4.7,
  143,
  'gateway-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Siding Solutions
(
  'cont_siding_ne_004',
  'cat_siding_001',
  'neigh_northeast_001',
  'DIA Corridor Siding Solutions',
  '15500 E 40th Ave, Denver, CO 80239',
  '(303) 555-7404',
  'https://www.diacorridorsiding.com',
  4.8,
  176,
  'dia-corridor-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Peoria Street Gutter Co
(
  'cont_siding_ne_005',
  'cat_siding_001',
  'neigh_northeast_001',
  'Peoria Street Gutter Co',
  '5200 Peoria St, Denver, CO 80239',
  '(303) 555-7405',
  'https://www.peoriagutter.com',
  4.9,
  195,
  'peoria-street-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Tower Road Siding & Gutters
(
  'cont_siding_ne_006',
  'cat_siding_001',
  'neigh_northeast_001',
  'Tower Road Siding & Gutters',
  '4800 Tower Rd, Denver, CO 80249',
  '(303) 555-7406',
  'https://www.towerroadsiding.com',
  4.7,
  134,
  'tower-road-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Far Northeast Exterior Specialists
(
  'cont_siding_ne_007',
  'cat_siding_001',
  'neigh_northeast_001',
  'Far Northeast Exterior Specialists',
  '5500 Chambers Rd, Denver, CO 80239',
  '(303) 555-7407',
  'https://www.farnortheastexteriors.com',
  4.8,
  156,
  'far-northeast-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Airport Region Siding & Gutters
(
  'cont_siding_ne_008',
  'cat_siding_001',
  'neigh_northeast_001',
  'Airport Region Siding & Gutters',
  '16001 E 40th Ave, Denver, CO 80239',
  '(303) 555-7408',
  'https://www.airportregionsiding.com',
  4.6,
  122,
  'airport-region-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Chambers Gutter Pros
(
  'cont_siding_ne_009',
  'cat_siding_001',
  'neigh_northeast_001',
  'Chambers Gutter Pros',
  '4900 Chambers Rd, Denver, CO 80239',
  '(303) 555-7409',
  'https://www.chambersgutter.com',
  4.8,
  167,
  'chambers-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal Siding
(
  'cont_siding_ne_010',
  'cat_siding_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Siding',
  '5650 Havana St, Denver, CO 80239',
  '(303) 555-7410',
  'https://www.arsenalsiding.com',
  4.7,
  145,
  'rocky-mountain-arsenal-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
