-- Create Masonry category
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

-- Ensure Downtown subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_downtown_001',
  'reg_central_001',
  'Downtown Denver',
  'downtown-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Downtown neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_downtown_001',
  'subreg_downtown_001',
  'Downtown Denver',
  'downtown-denver',
  'Including LoDo, Union Station, Central Business District, and Ballpark neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Masonry contractors for Downtown Denver area
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
-- 1. LoDo Masonry Works
(
  'cont_masonry_dt_001',
  'cat_masonry_001',
  'neigh_downtown_001',
  'LoDo Masonry Works',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-8001',
  'https://www.lodomasonry.com',
  4.9,
  187,
  'lodo-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Stone & Brick
(
  'cont_masonry_dt_002',
  'cat_masonry_001',
  'neigh_downtown_001',
  'Union Station Stone & Brick',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-8002',
  'https://www.unionstationstone.com',
  4.8,
  164,
  'union-station-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Brick Masters
(
  'cont_masonry_dt_003',
  'cat_masonry_001',
  'neigh_downtown_001',
  'Downtown Brick Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-8003',
  'https://www.downtownbrick.com',
  4.7,
  142,
  'downtown-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Stone Artisans
(
  'cont_masonry_dt_004',
  'cat_masonry_001',
  'neigh_downtown_001',
  'Ballpark Stone Artisans',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-8004',
  'https://www.ballparkstone.com',
  4.8,
  175,
  'ballpark-stone-artisans',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Masonry Co
(
  'cont_masonry_dt_005',
  'cat_masonry_001',
  'neigh_downtown_001',
  '16th Street Masonry Co',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-8005',
  'https://www.16thstreetmasonry.com',
  4.9,
  193,
  '16th-street-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Stone Works
(
  'cont_masonry_dt_006',
  'cat_masonry_001',
  'neigh_downtown_001',
  'Larimer Square Stone Works',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-8006',
  'https://www.larimersquarestone.com',
  4.7,
  133,
  'larimer-square-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Masonry Specialists
(
  'cont_masonry_dt_007',
  'cat_masonry_001',
  'neigh_downtown_001',
  'CBD Masonry Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-8007',
  'https://www.cbdmasonry.com',
  4.8,
  155,
  'cbd-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Stone & Brick
(
  'cont_masonry_dt_008',
  'cat_masonry_001',
  'neigh_downtown_001',
  'Five Points Stone & Brick',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-8008',
  'https://www.fivepointsstone.com',
  4.6,
  121,
  'five-points-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Masonry Pros
(
  'cont_masonry_dt_009',
  'cat_masonry_001',
  'neigh_downtown_001',
  'RiNo Masonry Pros',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-8009',
  'https://www.rinomasonry.com',
  4.8,
  166,
  'rino-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Masonry
(
  'cont_masonry_dt_010',
  'cat_masonry_001',
  'neigh_downtown_001',
  'Commons Park Masonry',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-8010',
  'https://www.commonsparkmasonry.com',
  4.7,
  144,
  'commons-park-masonry',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
