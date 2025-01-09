-- Ensure Masonry category exists
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

-- Create Central Parks subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_parks_001',
  'reg_central_001',
  'Central Parks',
  'central-parks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Central Parks neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_parks_001',
  'subreg_central_parks_001',
  'Central Parks',
  'central-parks',
  'Including City Park, City Park West, Congress Park, and Cheesman Park areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Masonry contractors for Central Parks area
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
-- 1. City Park Masonry Works
(
  'cont_masonry_cp_001',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'City Park Masonry Works',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-8101',
  'https://www.cityparkmasonry.com',
  4.9,
  177,
  'city-park-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Stone & Brick
(
  'cont_masonry_cp_002',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'Cheesman Park Stone & Brick',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-8102',
  'https://www.cheesmanstone.com',
  4.8,
  155,
  'cheesman-park-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Brick Masters
(
  'cont_masonry_cp_003',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'Congress Park Brick Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-8103',
  'https://www.congressbrick.com',
  4.7,
  144,
  'congress-park-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Stone Solutions
(
  'cont_masonry_cp_004',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'Zoo Area Stone Solutions',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-8104',
  'https://www.zooareastone.com',
  4.8,
  166,
  'zoo-area-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Masonry Co
(
  'cont_masonry_cp_005',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'Museum District Masonry Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-8105',
  'https://www.museumdistrictmasonry.com',
  4.9,
  188,
  'museum-district-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Stone Works
(
  'cont_masonry_cp_006',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'Botanic Gardens Stone Works',
  '1007 York St, Denver, CO 80206',
  '(303) 555-8106',
  'https://www.botanicgardensstone.com',
  4.7,
  133,
  'botanic-gardens-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Masonry Specialists
(
  'cont_masonry_cp_007',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'East High Masonry Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-8107',
  'https://www.easthighmasonry.com',
  4.8,
  155,
  'east-high-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Stone & Brick
(
  'cont_masonry_cp_008',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'City Park West Stone & Brick',
  '2199 California St, Denver, CO 80205',
  '(303) 555-8108',
  'https://www.cityparkweststone.com',
  4.6,
  122,
  'city-park-west-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Masonry Pros
(
  'cont_masonry_cp_009',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'Park Avenue Masonry Pros',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-8109',
  'https://www.parkavenuemasonry.com',
  4.8,
  167,
  'park-avenue-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Stone Solutions
(
  'cont_masonry_cp_010',
  'cat_masonry_001',
  'neigh_central_parks_001',
  'Esplanade Stone Solutions',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-8110',
  'https://www.esplanadestone.com',
  4.7,
  144,
  'esplanade-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
