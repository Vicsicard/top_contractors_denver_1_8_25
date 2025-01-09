-- Ensure Epoxy Garages category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
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

-- Insert 10 Epoxy Garage contractors for Central Parks area
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
-- 1. City Park Epoxy Solutions
(
  'cont_epoxy_cp_001',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'City Park Epoxy Solutions',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7101',
  'https://www.cityparkepoxy.com',
  4.9,
  138,
  'city-park-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Garage Coatings
(
  'cont_epoxy_cp_002',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'Cheesman Park Garage Coatings',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-7102',
  'https://www.cheesmanepoxy.com',
  4.8,
  124,
  'cheesman-park-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Epoxy Masters
(
  'cont_epoxy_cp_003',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'Congress Park Epoxy Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-7103',
  'https://www.congressepoxy.com',
  4.7,
  112,
  'congress-park-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Garage Solutions
(
  'cont_epoxy_cp_004',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'Zoo Area Garage Solutions',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-7104',
  'https://www.zooareaepoxy.com',
  4.8,
  133,
  'zoo-area-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Epoxy Pro
(
  'cont_epoxy_cp_005',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'Museum District Epoxy Pro',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-7105',
  'https://www.museumdistrictepoxy.com',
  4.9,
  145,
  'museum-district-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Garage Finishes
(
  'cont_epoxy_cp_006',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'Botanic Gardens Garage Finishes',
  '1007 York St, Denver, CO 80206',
  '(303) 555-7106',
  'https://www.botanicgardensepoxy.com',
  4.7,
  105,
  'botanic-gardens-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Epoxy Specialists
(
  'cont_epoxy_cp_007',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'East High Epoxy Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7107',
  'https://www.easthighepoxy.com',
  4.8,
  122,
  'east-high-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Garage Coatings
(
  'cont_epoxy_cp_008',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'City Park West Garage Coatings',
  '2199 California St, Denver, CO 80205',
  '(303) 555-7108',
  'https://www.cityparkwestepoxy.com',
  4.6,
  95,
  'city-park-west-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Epoxy Pros
(
  'cont_epoxy_cp_009',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'Park Avenue Epoxy Pros',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-7109',
  'https://www.parkavenueepoxy.com',
  4.8,
  131,
  'park-avenue-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Garage Solutions
(
  'cont_epoxy_cp_010',
  'cat_epoxy_001',
  'neigh_central_parks_001',
  'Esplanade Garage Solutions',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-7110',
  'https://www.esplanadeepoxy.com',
  4.7,
  108,
  'esplanade-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
