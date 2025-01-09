-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for Northeast Denver area
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
-- 1. Montbello Flooring Works
(
  'cont_floor_ne_001',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Montbello Flooring Works',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-7401',
  'https://www.montbelloflooring.com',
  4.9,
  178,
  'montbello-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Floor & Tile
(
  'cont_floor_ne_002',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Green Valley Ranch Floor & Tile',
  '18500 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-7402',
  'https://www.gvrflooring.com',
  4.8,
  156,
  'green-valley-ranch-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Floor Masters
(
  'cont_floor_ne_003',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Gateway Floor Masters',
  '4800 Tower Rd, Denver, CO 80249',
  '(303) 555-7403',
  'https://www.gatewayflooring.com',
  4.7,
  142,
  'gateway-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Flooring Solutions
(
  'cont_floor_ne_004',
  'cat_flooring_001',
  'neigh_northeast_001',
  'DIA Corridor Flooring Solutions',
  '16000 E 40th Ave, Denver, CO 80239',
  '(303) 555-7404',
  'https://www.diacorridorflooring.com',
  4.8,
  168,
  'dia-corridor-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Peña Boulevard Floor Co
(
  'cont_floor_ne_005',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Peña Boulevard Floor Co',
  '16161 E 40th Circle, Aurora, CO 80011',
  '(303) 555-7405',
  'https://www.penablvdflooring.com',
  4.9,
  184,
  'pena-boulevard-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Far Northeast Flooring Works
(
  'cont_floor_ne_006',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Far Northeast Flooring Works',
  '5555 N Chambers Rd, Denver, CO 80239',
  '(303) 555-7406',
  'https://www.farnortheastflooring.com',
  4.7,
  145,
  'far-northeast-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Tower Road Floor Specialists
(
  'cont_floor_ne_007',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Tower Road Floor Specialists',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-7407',
  'https://www.towerroadflooring.com',
  4.8,
  159,
  'tower-road-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Rocky Mountain Arsenal Floor & Design
(
  'cont_floor_ne_008',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Floor & Design',
  '5650 Havana St, Commerce City, CO 80022',
  '(303) 555-7408',
  'https://www.rmaflooring.com',
  4.6,
  128,
  'rocky-mountain-arsenal-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Airport Way Floor Pros
(
  'cont_floor_ne_009',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Airport Way Floor Pros',
  '7305 E 35th Ave, Denver, CO 80238',
  '(303) 555-7409',
  'https://www.airportwayflooring.com',
  4.8,
  167,
  'airport-way-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Chambers Road Flooring Solutions
(
  'cont_floor_ne_010',
  'cat_flooring_001',
  'neigh_northeast_001',
  'Chambers Road Flooring Solutions',
  '4800 Chambers Rd, Denver, CO 80239',
  '(303) 555-7410',
  'https://www.chambersroadflooring.com',
  4.7,
  143,
  'chambers-road-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
