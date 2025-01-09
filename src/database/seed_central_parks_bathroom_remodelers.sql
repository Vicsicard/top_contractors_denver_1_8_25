-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Central Parks area
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
-- 1. City Park Bathroom Design
(
  'cont_bath_cp_001',
  'cat_bath_001',
  'neigh_central_parks_001',
  'City Park Bathroom Design',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-8101',
  'https://www.cityparkbathroom.com',
  4.9,
  178,
  'city-park-bathroom-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Bath & Tile
(
  'cont_bath_cp_002',
  'cat_bath_001',
  'neigh_central_parks_001',
  'Cheesman Park Bath & Tile',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-8102',
  'https://www.cheesmanparkbath.com',
  4.8,
  145,
  'cheesman-park-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Bathroom Masters
(
  'cont_bath_cp_003',
  'cat_bath_001',
  'neigh_central_parks_001',
  'Congress Park Bathroom Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-8103',
  'https://www.congressparkbathroom.com',
  4.7,
  134,
  'congress-park-bathroom-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Bath Renovations
(
  'cont_bath_cp_004',
  'cat_bath_001',
  'neigh_central_parks_001',
  'Zoo Area Bath Renovations',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-8104',
  'https://www.zooareabath.com',
  4.8,
  156,
  'zoo-area-bath-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Bath Co
(
  'cont_bath_cp_005',
  'cat_bath_001',
  'neigh_central_parks_001',
  'Museum District Bath Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-8105',
  'https://www.museumdistrictbath.com',
  4.9,
  167,
  'museum-district-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Bath Design
(
  'cont_bath_cp_006',
  'cat_bath_001',
  'neigh_central_parks_001',
  'Botanic Gardens Bath Design',
  '1007 York St, Denver, CO 80206',
  '(303) 555-8106',
  'https://www.botanicgardensbath.com',
  4.7,
  123,
  'botanic-gardens-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Bath Specialists
(
  'cont_bath_cp_007',
  'cat_bath_001',
  'neigh_central_parks_001',
  'East High Bath Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-8107',
  'https://www.easthighbath.com',
  4.8,
  145,
  'east-high-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Bath & Shower
(
  'cont_bath_cp_008',
  'cat_bath_001',
  'neigh_central_parks_001',
  'City Park West Bath & Shower',
  '2199 California St, Denver, CO 80205',
  '(303) 555-8108',
  'https://www.cityparkwestbath.com',
  4.6,
  112,
  'city-park-west-bath-shower',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Bath Design
(
  'cont_bath_cp_009',
  'cat_bath_001',
  'neigh_central_parks_001',
  'Park Avenue Bath Design',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-8109',
  'https://www.parkavenuebath.com',
  4.8,
  167,
  'park-avenue-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Bath Studio
(
  'cont_bath_cp_010',
  'cat_bath_001',
  'neigh_central_parks_001',
  'Esplanade Bath Studio',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-8110',
  'https://www.esplanadebath.com',
  4.7,
  134,
  'esplanade-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
