-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
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

-- Insert 10 HVAC contractors for Central Parks area
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
-- 1. City Park HVAC
(
  'cont_hvac_cp_001',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'City Park HVAC',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-3101',
  'https://www.cityparkhvac.com',
  4.9,
  245,
  'city-park-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Climate Control
(
  'cont_hvac_cp_002',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'Cheesman Park Climate Control',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-3102',
  'https://www.cheesmanparkhvac.com',
  4.8,
  198,
  'cheesman-park-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park HVAC Pros
(
  'cont_hvac_cp_003',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'Congress Park HVAC Pros',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-3103',
  'https://www.congressparkhvac.com',
  4.7,
  167,
  'congress-park-hvac-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Denver Zoo Area Air Systems
(
  'cont_hvac_cp_004',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'Denver Zoo Area Air Systems',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-3104',
  'https://www.denverzoareahvac.com',
  4.8,
  189,
  'denver-zoo-area-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District HVAC
(
  'cont_hvac_cp_005',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'Museum District HVAC',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-3105',
  'https://www.museumdistricthvac.com',
  4.9,
  212,
  'museum-district-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Climate Services
(
  'cont_hvac_cp_006',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'Botanic Gardens Climate Services',
  '1007 York St, Denver, CO 80206',
  '(303) 555-3106',
  'https://www.botanicgardenshvac.com',
  4.7,
  178,
  'botanic-gardens-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Air Solutions
(
  'cont_hvac_cp_007',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'East High Air Solutions',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-3107',
  'https://www.easthighhvac.com',
  4.8,
  167,
  'east-high-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West HVAC
(
  'cont_hvac_cp_008',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'City Park West HVAC',
  '2199 California St, Denver, CO 80205',
  '(303) 555-3108',
  'https://www.cityparkwesthvac.com',
  4.6,
  156,
  'city-park-west-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Climate Control
(
  'cont_hvac_cp_009',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'Park Avenue Climate Control',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-3109',
  'https://www.parkavenuehvac.com',
  4.8,
  201,
  'park-avenue-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade HVAC Services
(
  'cont_hvac_cp_010',
  'cat_hvac_001',
  'neigh_central_parks_001',
  'Esplanade HVAC Services',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-3110',
  'https://www.esplanadehvac.com',
  4.7,
  182,
  'esplanade-hvac-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
