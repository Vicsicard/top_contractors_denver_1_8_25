-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Northeast Denver area
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
-- 1. Montbello Bath Design
(
  'cont_bath_ne_001',
  'cat_bath_001',
  'neigh_northeast_001',
  'Montbello Bath Design',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-8401',
  'https://www.montbellobath.com',
  4.9,
  167,
  'montbello-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Bath & Tile
(
  'cont_bath_ne_002',
  'cat_bath_001',
  'neigh_northeast_001',
  'Green Valley Ranch Bath & Tile',
  '4800 Tower Rd, Denver, CO 80249',
  '(303) 555-8402',
  'https://www.gvrbath.com',
  4.8,
  145,
  'green-valley-ranch-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Bath Masters
(
  'cont_bath_ne_003',
  'cat_bath_001',
  'neigh_northeast_001',
  'Gateway Bath Masters',
  '16300 E 40th Ave, Denver, CO 80239',
  '(303) 555-8403',
  'https://www.gatewaybath.com',
  4.7,
  134,
  'gateway-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Area Bath Co
(
  'cont_bath_ne_004',
  'cat_bath_001',
  'neigh_northeast_001',
  'DIA Area Bath Co',
  '18500 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-8404',
  'https://www.diabath.com',
  4.8,
  156,
  'dia-area-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northeast Bath Studio
(
  'cont_bath_ne_005',
  'cat_bath_001',
  'neigh_northeast_001',
  'Northeast Bath Studio',
  '5000 Crown Blvd, Denver, CO 80239',
  '(303) 555-8405',
  'https://www.northeastbathstudio.com',
  4.9,
  178,
  'northeast-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Peoria Street Bath Design
(
  'cont_bath_ne_006',
  'cat_bath_001',
  'neigh_northeast_001',
  'Peoria Street Bath Design',
  '4500 Peoria St, Denver, CO 80239',
  '(303) 555-8406',
  'https://www.peoriabath.com',
  4.7,
  123,
  'peoria-street-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Tower Road Bath Co
(
  'cont_bath_ne_007',
  'cat_bath_001',
  'neigh_northeast_001',
  'Tower Road Bath Co',
  '4900 Tower Rd, Denver, CO 80249',
  '(303) 555-8407',
  'https://www.towerroadbath.com',
  4.8,
  145,
  'tower-road-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Airport Bath Studio
(
  'cont_bath_ne_008',
  'cat_bath_001',
  'neigh_northeast_001',
  'Airport Bath Studio',
  '16401 E 40th Ave, Denver, CO 80239',
  '(303) 555-8408',
  'https://www.airportbath.com',
  4.6,
  112,
  'airport-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Chambers Bath Specialists
(
  'cont_bath_ne_009',
  'cat_bath_001',
  'neigh_northeast_001',
  'Chambers Bath Specialists',
  '4700 Chambers Rd, Denver, CO 80239',
  '(303) 555-8409',
  'https://www.chambersbath.com',
  4.8,
  167,
  'chambers-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal Bath
(
  'cont_bath_ne_010',
  'cat_bath_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Bath',
  '5000 Havana St, Denver, CO 80239',
  '(303) 555-8410',
  'https://www.arsenalbath.com',
  4.7,
  134,
  'rocky-mountain-arsenal-bath',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
