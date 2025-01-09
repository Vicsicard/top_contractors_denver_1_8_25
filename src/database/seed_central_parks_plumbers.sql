-- Ensure category exists (same as downtown)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure region exists (same as downtown)
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure subregion exists for Central Parks
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_parks_001',
  'reg_central_001',
  'Central Parks',
  'central-parks-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_parks_001',
  'subreg_central_parks_001',
  'Central Parks',
  'central-parks-area',
  'Including City Park, City Park West, Cheesman Park, and Congress Park areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Central Parks area
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
-- 1. City Park Plumbing Services
(
  'cont_plumb_cp_001',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'City Park Plumbing Services',
  '2199 California St, Denver, CO 80205',
  '(303) 555-0201',
  'https://www.cityparkplumbing.com',
  4.8,
  178,
  'city-park-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Plumbers
(
  'cont_plumb_cp_002',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'Cheesman Park Plumbers',
  '1200 E 13th Ave, Denver, CO 80218',
  '(303) 555-0202',
  'https://www.cheesmanparkplumbers.com',
  4.9,
  192,
  'cheesman-park-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Pipe Pros
(
  'cont_plumb_cp_003',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'Congress Park Pipe Pros',
  '1260 E Colfax Ave, Denver, CO 80218',
  '(303) 555-0203',
  'https://www.congressparkpipepros.com',
  4.7,
  165,
  'congress-park-pipe-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Park District Plumbing
(
  'cont_plumb_cp_004',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'Park District Plumbing',
  '2300 E Colfax Ave, Denver, CO 80206',
  '(303) 555-0204',
  'https://www.parkdistrictplumbing.com',
  4.8,
  183,
  'park-district-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Central Parks Plumbing & Heating
(
  'cont_plumb_cp_005',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'Central Parks Plumbing & Heating',
  '1700 York St, Denver, CO 80206',
  '(303) 555-0205',
  'https://www.centralparksplumbing.com',
  4.9,
  201,
  'central-parks-plumbing-heating',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. City Park West Plumbing Solutions
(
  'cont_plumb_cp_006',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'City Park West Plumbing Solutions',
  '1900 E 20th Ave, Denver, CO 80205',
  '(303) 555-0206',
  'https://www.cityparkwestplumbing.com',
  4.7,
  156,
  'city-park-west-plumbing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Park Avenue Plumbers
(
  'cont_plumb_cp_007',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'Park Avenue Plumbers',
  '2001 E 17th Ave, Denver, CO 80206',
  '(303) 555-0207',
  'https://www.parkavenuplumbers.com',
  4.8,
  167,
  'park-avenue-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Esplanade Plumbing Experts
(
  'cont_plumb_cp_008',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'Esplanade Plumbing Experts',
  '1855 York St, Denver, CO 80206',
  '(303) 555-0208',
  'https://www.esplanadeplumbing.com',
  4.6,
  145,
  'esplanade-plumbing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. East High Plumbing Services
(
  'cont_plumb_cp_009',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'East High Plumbing Services',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-0209',
  'https://www.easthighplumbing.com',
  4.7,
  172,
  'east-high-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Zoo Area Plumbing & Drain
(
  'cont_plumb_cp_010',
  'cat_plumber_001',
  'neigh_central_parks_001',
  'Zoo Area Plumbing & Drain',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-0210',
  'https://www.zooareaplumbing.com',
  4.8,
  188,
  'zoo-area-plumbing-drain',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
