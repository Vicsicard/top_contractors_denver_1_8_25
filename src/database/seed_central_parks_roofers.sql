-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
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

-- Insert 10 Roofers for Central Parks area
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
-- 1. City Park Roofing
(
  'cont_roof_cp_001',
  'cat_roof_001',
  'neigh_central_parks_001',
  'City Park Roofing',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-4101',
  'https://www.cityparkroofing.com',
  4.9,
  198,
  'city-park-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Roofing Co
(
  'cont_roof_cp_002',
  'cat_roof_001',
  'neigh_central_parks_001',
  'Cheesman Park Roofing Co',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-4102',
  'https://www.cheesmanparkroofing.com',
  4.8,
  167,
  'cheesman-park-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Roofing Pros
(
  'cont_roof_cp_003',
  'cat_roof_001',
  'neigh_central_parks_001',
  'Congress Park Roofing Pros',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-4103',
  'https://www.congressparkroofing.com',
  4.7,
  145,
  'congress-park-roofing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Denver Zoo Area Roofing
(
  'cont_roof_cp_004',
  'cat_roof_001',
  'neigh_central_parks_001',
  'Denver Zoo Area Roofing',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-4104',
  'https://www.denverzooarearoofing.com',
  4.8,
  156,
  'denver-zoo-area-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Roofing
(
  'cont_roof_cp_005',
  'cat_roof_001',
  'neigh_central_parks_001',
  'Museum District Roofing',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-4105',
  'https://www.museumdistrictroofing.com',
  4.9,
  187,
  'museum-district-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Roofing Services
(
  'cont_roof_cp_006',
  'cat_roof_001',
  'neigh_central_parks_001',
  'Botanic Gardens Roofing Services',
  '1007 York St, Denver, CO 80206',
  '(303) 555-4106',
  'https://www.botanicgardensroofing.com',
  4.7,
  143,
  'botanic-gardens-roofing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Roofing Solutions
(
  'cont_roof_cp_007',
  'cat_roof_001',
  'neigh_central_parks_001',
  'East High Roofing Solutions',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-4107',
  'https://www.easthighroofing.com',
  4.8,
  134,
  'east-high-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Roofing
(
  'cont_roof_cp_008',
  'cat_roof_001',
  'neigh_central_parks_001',
  'City Park West Roofing',
  '2199 California St, Denver, CO 80205',
  '(303) 555-4108',
  'https://www.cityparkwestroofing.com',
  4.6,
  123,
  'city-park-west-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Roofing Co
(
  'cont_roof_cp_009',
  'cat_roof_001',
  'neigh_central_parks_001',
  'Park Avenue Roofing Co',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-4109',
  'https://www.parkavenueroofing.com',
  4.8,
  167,
  'park-avenue-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Roofing Specialists
(
  'cont_roof_cp_010',
  'cat_roof_001',
  'neigh_central_parks_001',
  'Esplanade Roofing Specialists',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-4110',
  'https://www.esplanaderoofing.com',
  4.7,
  145,
  'esplanade-roofing-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
