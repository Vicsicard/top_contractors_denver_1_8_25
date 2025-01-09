-- Ensure Masonry category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_masonry_001',
  'Masonry',
  'masonry',
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

-- Insert 10 Masonry contractors for Northeast Denver area
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
-- 1. Montbello Masonry Works
(
  'cont_masonry_ne_001',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Montbello Masonry Works',
  '4880 Chambers Rd, Denver, CO 80239',
  '(303) 555-8401',
  'https://www.montbellomasonry.com',
  4.9,
  188,
  'montbello-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Stone & Brick
(
  'cont_masonry_ne_002',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Green Valley Ranch Stone & Brick',
  '18501 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-8402',
  'https://www.gvrstone.com',
  4.8,
  166,
  'green-valley-ranch-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Brick Masters
(
  'cont_masonry_ne_003',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Gateway Brick Masters',
  '4760 Pena Blvd, Denver, CO 80239',
  '(303) 555-8403',
  'https://www.gatewaybrick.com',
  4.7,
  144,
  'gateway-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Area Stone Solutions
(
  'cont_masonry_ne_004',
  'cat_masonry_001',
  'neigh_northeast_001',
  'DIA Area Stone Solutions',
  '16000 E 40th Ave, Denver, CO 80239',
  '(303) 555-8404',
  'https://www.diastone.com',
  4.8,
  177,
  'dia-area-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Tower Road Masonry Co
(
  'cont_masonry_ne_005',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Tower Road Masonry Co',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-8405',
  'https://www.towerroadmasonry.com',
  4.9,
  198,
  'tower-road-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Chambers Stone Works
(
  'cont_masonry_ne_006',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Chambers Stone Works',
  '5200 Chambers Rd, Denver, CO 80239',
  '(303) 555-8406',
  'https://www.chambersstone.com',
  4.7,
  155,
  'chambers-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northeast Denver Masonry Specialists
(
  'cont_masonry_ne_007',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Northeast Denver Masonry Specialists',
  '5555 Crown Blvd, Denver, CO 80239',
  '(303) 555-8407',
  'https://www.nedmasonry.com',
  4.8,
  166,
  'northeast-denver-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Airport Stone & Brick
(
  'cont_masonry_ne_008',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Airport Stone & Brick',
  '15500 E 40th Ave, Denver, CO 80239',
  '(303) 555-8408',
  'https://www.airportstone.com',
  4.6,
  133,
  'airport-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Peña Boulevard Masonry Pros
(
  'cont_masonry_ne_009',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Peña Boulevard Masonry Pros',
  '16161 E 40th Ave, Denver, CO 80239',
  '(303) 555-8409',
  'https://www.penablvdmasonry.com',
  4.8,
  177,
  'pena-boulevard-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Far Northeast Stone Solutions
(
  'cont_masonry_ne_010',
  'cat_masonry_001',
  'neigh_northeast_001',
  'Far Northeast Stone Solutions',
  '18000 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-8410',
  'https://www.farnortheaststone.com',
  4.7,
  155,
  'far-northeast-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
