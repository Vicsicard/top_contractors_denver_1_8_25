-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for Central Parks area
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
-- 1. City Park Flooring Works
(
  'cont_floor_cp_001',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'City Park Flooring Works',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7101',
  'https://www.cityparkflooring.com',
  4.9,
  175,
  'city-park-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Floor & Tile
(
  'cont_floor_cp_002',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'Cheesman Park Floor & Tile',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-7102',
  'https://www.cheesmanflooring.com',
  4.8,
  152,
  'cheesman-park-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Floor Masters
(
  'cont_floor_cp_003',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'Congress Park Floor Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-7103',
  'https://www.congressflooring.com',
  4.7,
  146,
  'congress-park-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Flooring Solutions
(
  'cont_floor_cp_004',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'Zoo Area Flooring Solutions',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-7104',
  'https://www.zooareaflooring.com',
  4.8,
  168,
  'zoo-area-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Floor Co
(
  'cont_floor_cp_005',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'Museum District Floor Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7105',
  'https://www.museumdistrictflooring.com',
  4.9,
  186,
  'museum-district-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Flooring Works
(
  'cont_floor_cp_006',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'Botanic Gardens Flooring Works',
  '1007 York St, Denver, CO 80206',
  '(303) 555-7106',
  'https://www.botanicgardensflooring.com',
  4.7,
  135,
  'botanic-gardens-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Floor Specialists
(
  'cont_floor_cp_007',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'East High Floor Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7107',
  'https://www.easthighflooring.com',
  4.8,
  157,
  'east-high-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Floor & Design
(
  'cont_floor_cp_008',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'City Park West Floor & Design',
  '2199 California St, Denver, CO 80205',
  '(303) 555-7108',
  'https://www.cityparkwestflooring.com',
  4.6,
  124,
  'city-park-west-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Floor Pros
(
  'cont_floor_cp_009',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'Park Avenue Floor Pros',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-7109',
  'https://www.parkavenueflooring.com',
  4.8,
  165,
  'park-avenue-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Flooring Solutions
(
  'cont_floor_cp_010',
  'cat_flooring_001',
  'neigh_central_parks_001',
  'Esplanade Flooring Solutions',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7110',
  'https://www.esplanadeflooring.com',
  4.7,
  142,
  'esplanade-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
