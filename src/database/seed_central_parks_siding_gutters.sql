-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Central Parks area
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
-- 1. City Park Siding & Gutters
(
  'cont_siding_cp_001',
  'cat_siding_001',
  'neigh_central_parks_001',
  'City Park Siding & Gutters',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7101',
  'https://www.cityparksiding.com',
  4.9,
  178,
  'city-park-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Exteriors
(
  'cont_siding_cp_002',
  'cat_siding_001',
  'neigh_central_parks_001',
  'Cheesman Park Exteriors',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-7102',
  'https://www.cheesmanexteriors.com',
  4.8,
  156,
  'cheesman-park-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Gutter Masters
(
  'cont_siding_cp_003',
  'cat_siding_001',
  'neigh_central_parks_001',
  'Congress Park Gutter Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-7103',
  'https://www.congressgutter.com',
  4.7,
  145,
  'congress-park-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Siding Solutions
(
  'cont_siding_cp_004',
  'cat_siding_001',
  'neigh_central_parks_001',
  'Zoo Area Siding Solutions',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-7104',
  'https://www.zooareasiding.com',
  4.8,
  167,
  'zoo-area-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Gutter Co
(
  'cont_siding_cp_005',
  'cat_siding_001',
  'neigh_central_parks_001',
  'Museum District Gutter Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7105',
  'https://www.museumdistrictgutter.com',
  4.9,
  189,
  'museum-district-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Siding & Gutters
(
  'cont_siding_cp_006',
  'cat_siding_001',
  'neigh_central_parks_001',
  'Botanic Gardens Siding & Gutters',
  '1007 York St, Denver, CO 80206',
  '(303) 555-7106',
  'https://www.botanicgardenssiding.com',
  4.7,
  134,
  'botanic-gardens-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Exterior Specialists
(
  'cont_siding_cp_007',
  'cat_siding_001',
  'neigh_central_parks_001',
  'East High Exterior Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7107',
  'https://www.easthighexteriors.com',
  4.8,
  156,
  'east-high-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Siding & Gutters
(
  'cont_siding_cp_008',
  'cat_siding_001',
  'neigh_central_parks_001',
  'City Park West Siding & Gutters',
  '2199 California St, Denver, CO 80205',
  '(303) 555-7108',
  'https://www.cityparkwestsiding.com',
  4.6,
  123,
  'city-park-west-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Gutter Pros
(
  'cont_siding_cp_009',
  'cat_siding_001',
  'neigh_central_parks_001',
  'Park Avenue Gutter Pros',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-7109',
  'https://www.parkavenuegutter.com',
  4.8,
  168,
  'park-avenue-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Siding Solutions
(
  'cont_siding_cp_010',
  'cat_siding_001',
  'neigh_central_parks_001',
  'Esplanade Siding Solutions',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7110',
  'https://www.esplanadesiding.com',
  4.7,
  145,
  'esplanade-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
