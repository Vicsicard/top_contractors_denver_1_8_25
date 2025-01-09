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

-- Ensure Park Hill subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill',
  'park-hill',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_park_hill_001',
  'subreg_park_hill_001',
  'Park Hill',
  'park-hill',
  'Including North Park Hill, South Park Hill, and Northeast Park Hill areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Masonry contractors for Park Hill area
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
-- 1. Park Hill Masonry Works
(
  'cont_masonry_ph_001',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'Park Hill Masonry Works',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-8301',
  'https://www.parkhillmasonry.com',
  4.9,
  188,
  'park-hill-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Stone & Brick
(
  'cont_masonry_ph_002',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'North Park Hill Stone & Brick',
  '3300 Holly St, Denver, CO 80207',
  '(303) 555-8302',
  'https://www.northparkhillstone.com',
  4.8,
  166,
  'north-park-hill-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Brick Masters
(
  'cont_masonry_ph_003',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'South Park Hill Brick Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-8303',
  'https://www.southparkhillbrick.com',
  4.7,
  144,
  'south-park-hill-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Historic Park Hill Stone Solutions
(
  'cont_masonry_ph_004',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'Historic Park Hill Stone Solutions',
  '2600 Forest St, Denver, CO 80207',
  '(303) 555-8304',
  'https://www.historicparkhillstone.com',
  4.8,
  177,
  'historic-park-hill-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Montview Masonry Co
(
  'cont_masonry_ph_005',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'Montview Masonry Co',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-8305',
  'https://www.montviewmasonry.com',
  4.9,
  198,
  'montview-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 23rd Avenue Stone Works
(
  'cont_masonry_ph_006',
  'cat_masonry_001',
  'neigh_park_hill_001',
  '23rd Avenue Stone Works',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-8306',
  'https://www.23rdstone.com',
  4.7,
  155,
  '23rd-avenue-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Greater Park Hill Masonry Specialists
(
  'cont_masonry_ph_007',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'Greater Park Hill Masonry Specialists',
  '3000 Dexter St, Denver, CO 80207',
  '(303) 555-8307',
  'https://www.greaterparkhillmasonry.com',
  4.8,
  166,
  'greater-park-hill-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northeast Stone & Brick
(
  'cont_masonry_ph_008',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'Northeast Stone & Brick',
  '3500 Hudson St, Denver, CO 80207',
  '(303) 555-8308',
  'https://www.northeaststone.com',
  4.6,
  133,
  'northeast-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Monaco Masonry Pros
(
  'cont_masonry_ph_009',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'Monaco Masonry Pros',
  '2900 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-8309',
  'https://www.monacomasonry.com',
  4.8,
  177,
  'monaco-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Modern Stone
(
  'cont_masonry_ph_010',
  'cat_masonry_001',
  'neigh_park_hill_001',
  'Park Hill Modern Stone',
  '2500 Fairfax St, Denver, CO 80207',
  '(303) 555-8310',
  'https://www.parkhillmodernstone.com',
  4.7,
  155,
  'park-hill-modern-stone',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
