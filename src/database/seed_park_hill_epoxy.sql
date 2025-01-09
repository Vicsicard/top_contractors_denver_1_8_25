-- Ensure Epoxy Garage category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_east_001',
  'East Denver',
  'east-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill',
  'park-hill',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_park_hill_001',
  'subreg_park_hill_001',
  'Park Hill',
  'park-hill',
  'Including North Park Hill, South Park Hill, and Northeast Park Hill areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Epoxy Garage contractors for Park Hill area
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
-- 1. Park Hill Epoxy Solutions
(
  'cont_epoxy_ph_001',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'Park Hill Epoxy Solutions',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-7301',
  'https://www.parkhillepoxy.com',
  4.9,
  143,
  'park-hill-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Garage Coatings
(
  'cont_epoxy_ph_002',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'North Park Hill Garage Coatings',
  '3300 Holly St, Denver, CO 80207',
  '(303) 555-7302',
  'https://www.northparkhillepoxy.com',
  4.8,
  129,
  'north-park-hill-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Epoxy Masters
(
  'cont_epoxy_ph_003',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'South Park Hill Epoxy Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-7303',
  'https://www.southparkhillepoxy.com',
  4.7,
  116,
  'south-park-hill-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Monaco Parkway Garage Solutions
(
  'cont_epoxy_ph_004',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'Monaco Parkway Garage Solutions',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-7304',
  'https://www.monacoparkwayepoxy.com',
  4.8,
  135,
  'monaco-parkway-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Historic Park Hill Epoxy Pro
(
  'cont_epoxy_ph_005',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'Historic Park Hill Epoxy Pro',
  '2345 Dexter St, Denver, CO 80207',
  '(303) 555-7305',
  'https://www.historicparkhillepoxy.com',
  4.9,
  147,
  'historic-park-hill-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Northeast Park Hill Garage Finishes
(
  'cont_epoxy_ph_006',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Garage Finishes',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-7306',
  'https://www.neparkhillepoxy.com',
  4.7,
  112,
  'northeast-park-hill-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. 23rd Avenue Epoxy Specialists
(
  'cont_epoxy_ph_007',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  '23rd Avenue Epoxy Specialists',
  '2300 23rd Ave, Denver, CO 80207',
  '(303) 555-7307',
  'https://www.23rdavenueepoxy.com',
  4.8,
  125,
  '23rd-avenue-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Montview Garage Coatings
(
  'cont_epoxy_ph_008',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'Montview Garage Coatings',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-7308',
  'https://www.montviewepoxy.com',
  4.6,
  98,
  'montview-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Dahlia Street Epoxy Pros
(
  'cont_epoxy_ph_009',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'Dahlia Street Epoxy Pros',
  '2600 Dahlia St, Denver, CO 80207',
  '(303) 555-7309',
  'https://www.dahliastreetepoxy.com',
  4.8,
  133,
  'dahlia-street-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Forest Street Garage Solutions
(
  'cont_epoxy_ph_010',
  'cat_epoxy_001',
  'neigh_park_hill_001',
  'Forest Street Garage Solutions',
  '2400 Forest St, Denver, CO 80207',
  '(303) 555-7310',
  'https://www.foreststreetepoxy.com',
  4.7,
  118,
  'forest-street-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
