-- Ensure Home Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
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

-- Insert 10 Home Remodelers for Central Parks area
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
-- 1. City Park Renovation Masters
(
  'cont_remod_cp_001',
  'cat_remod_001',
  'neigh_central_parks_001',
  'City Park Renovation Masters',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7101',
  'https://www.cityparkrenovations.com',
  4.9,
  187,
  'city-park-renovation-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Design Build
(
  'cont_remod_cp_002',
  'cat_remod_001',
  'neigh_central_parks_001',
  'Cheesman Park Design Build',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-7102',
  'https://www.cheesmanparkdesign.com',
  4.8,
  156,
  'cheesman-park-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Home Remodeling
(
  'cont_remod_cp_003',
  'cat_remod_001',
  'neigh_central_parks_001',
  'Congress Park Home Remodeling',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-7103',
  'https://www.congressparkremodeling.com',
  4.7,
  134,
  'congress-park-home-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Denver Zoo Area Renovations
(
  'cont_remod_cp_004',
  'cat_remod_001',
  'neigh_central_parks_001',
  'Denver Zoo Area Renovations',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-7104',
  'https://www.denverzoorenovations.com',
  4.8,
  145,
  'denver-zoo-area-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Design Co
(
  'cont_remod_cp_005',
  'cat_remod_001',
  'neigh_central_parks_001',
  'Museum District Design Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7105',
  'https://www.museumdistrictdesign.com',
  4.9,
  176,
  'museum-district-design-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Remodeling
(
  'cont_remod_cp_006',
  'cat_remod_001',
  'neigh_central_parks_001',
  'Botanic Gardens Remodeling',
  '1007 York St, Denver, CO 80206',
  '(303) 555-7106',
  'https://www.botanicgardensremodeling.com',
  4.7,
  132,
  'botanic-gardens-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Renovation Co
(
  'cont_remod_cp_007',
  'cat_remod_001',
  'neigh_central_parks_001',
  'East High Renovation Co',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7107',
  'https://www.easthighrenovations.com',
  4.8,
  123,
  'east-high-renovation-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Design Build
(
  'cont_remod_cp_008',
  'cat_remod_001',
  'neigh_central_parks_001',
  'City Park West Design Build',
  '2199 California St, Denver, CO 80205',
  '(303) 555-7108',
  'https://www.cityparkwestdesign.com',
  4.6,
  112,
  'city-park-west-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Remodeling
(
  'cont_remod_cp_009',
  'cat_remod_001',
  'neigh_central_parks_001',
  'Park Avenue Remodeling',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-7109',
  'https://www.parkavenuerenovations.com',
  4.8,
  156,
  'park-avenue-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Design Studio
(
  'cont_remod_cp_010',
  'cat_remod_001',
  'neigh_central_parks_001',
  'Esplanade Design Studio',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7110',
  'https://www.esplanadedesign.com',
  4.7,
  134,
  'esplanade-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
