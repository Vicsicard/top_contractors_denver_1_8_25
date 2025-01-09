-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
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

-- Insert 10 Fencing contractors for Central Parks area
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
-- 1. City Park Fence Works
(
  'cont_fence_cp_001',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'City Park Fence Works',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-9101',
  'https://www.cityparkfence.com',
  4.9,
  160,
  'city-park-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Fence & Gate
(
  'cont_fence_cp_002',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'Cheesman Park Fence & Gate',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-9102',
  'https://www.cheesmanfence.com',
  4.8,
  137,
  'cheesman-park-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Fence Masters
(
  'cont_fence_cp_003',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'Congress Park Fence Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-9103',
  'https://www.congressfence.com',
  4.7,
  131,
  'congress-park-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Fence Solutions
(
  'cont_fence_cp_004',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'Zoo Area Fence Solutions',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-9104',
  'https://www.zooareafence.com',
  4.8,
  153,
  'zoo-area-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Fence Co
(
  'cont_fence_cp_005',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'Museum District Fence Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-9105',
  'https://www.museumdistrictfence.com',
  4.9,
  171,
  'museum-district-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Fence Works
(
  'cont_fence_cp_006',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'Botanic Gardens Fence Works',
  '1007 York St, Denver, CO 80206',
  '(303) 555-9106',
  'https://www.botanicgardensfence.com',
  4.7,
  120,
  'botanic-gardens-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Fence Specialists
(
  'cont_fence_cp_007',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'East High Fence Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-9107',
  'https://www.easthighfence.com',
  4.8,
  142,
  'east-high-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Fence & Design
(
  'cont_fence_cp_008',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'City Park West Fence & Design',
  '2199 California St, Denver, CO 80205',
  '(303) 555-9108',
  'https://www.cityparkwestfence.com',
  4.6,
  109,
  'city-park-west-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Fence Pros
(
  'cont_fence_cp_009',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'Park Avenue Fence Pros',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-9109',
  'https://www.parkavenuefence.com',
  4.8,
  150,
  'park-avenue-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Fence Solutions
(
  'cont_fence_cp_010',
  'cat_fencing_001',
  'neigh_central_parks_001',
  'Esplanade Fence Solutions',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-9110',
  'https://www.esplanadefence.com',
  4.7,
  127,
  'esplanade-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
