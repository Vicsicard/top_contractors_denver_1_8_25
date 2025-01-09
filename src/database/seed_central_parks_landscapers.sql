-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for Central Parks area
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
-- 1. City Park Garden Masters
(
  'cont_land_cp_001',
  'cat_land_001',
  'neigh_central_parks_001',
  'City Park Garden Masters',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-6101',
  'https://www.cityparkgardens.com',
  4.9,
  187,
  'city-park-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Landscape Design
(
  'cont_land_cp_002',
  'cat_land_001',
  'neigh_central_parks_001',
  'Cheesman Park Landscape Design',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-6102',
  'https://www.cheesmanparklandscape.com',
  4.8,
  156,
  'cheesman-park-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Gardens
(
  'cont_land_cp_003',
  'cat_land_001',
  'neigh_central_parks_001',
  'Congress Park Gardens',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-6103',
  'https://www.congressparkgardens.com',
  4.7,
  134,
  'congress-park-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Denver Zoo Area Landscaping
(
  'cont_land_cp_004',
  'cat_land_001',
  'neigh_central_parks_001',
  'Denver Zoo Area Landscaping',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-6104',
  'https://www.denverzoolandscaping.com',
  4.8,
  145,
  'denver-zoo-area-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Gardens
(
  'cont_land_cp_005',
  'cat_land_001',
  'neigh_central_parks_001',
  'Museum District Gardens',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-6105',
  'https://www.museumdistrictgardens.com',
  4.9,
  176,
  'museum-district-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Landscape Co
(
  'cont_land_cp_006',
  'cat_land_001',
  'neigh_central_parks_001',
  'Botanic Gardens Landscape Co',
  '1007 York St, Denver, CO 80206',
  '(303) 555-6106',
  'https://www.botanicgardenslandscape.com',
  4.7,
  132,
  'botanic-gardens-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Green Spaces
(
  'cont_land_cp_007',
  'cat_land_001',
  'neigh_central_parks_001',
  'East High Green Spaces',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-6107',
  'https://www.easthighlandscaping.com',
  4.8,
  123,
  'east-high-green-spaces',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Gardens
(
  'cont_land_cp_008',
  'cat_land_001',
  'neigh_central_parks_001',
  'City Park West Gardens',
  '2199 California St, Denver, CO 80205',
  '(303) 555-6108',
  'https://www.cityparkwestgardens.com',
  4.6,
  112,
  'city-park-west-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Landscape Studio
(
  'cont_land_cp_009',
  'cat_land_001',
  'neigh_central_parks_001',
  'Park Avenue Landscape Studio',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-6109',
  'https://www.parkavenuegardens.com',
  4.8,
  156,
  'park-avenue-landscape-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Garden Design
(
  'cont_land_cp_010',
  'cat_land_001',
  'neigh_central_parks_001',
  'Esplanade Garden Design',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-6110',
  'https://www.esplanadegardens.com',
  4.7,
  134,
  'esplanade-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
