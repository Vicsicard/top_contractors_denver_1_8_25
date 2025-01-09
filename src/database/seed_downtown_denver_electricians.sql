-- Create Electrician category
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Denver region exists (same as plumbers)
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Downtown subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_downtown_001',
  'reg_central_001',
  'Downtown Denver',
  'downtown-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Downtown neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_downtown_001',
  'subreg_downtown_001',
  'Downtown Denver',
  'downtown-denver',
  'Including LoDo, Union Station, Central Business District, and Ballpark neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 electricians for Downtown Denver area
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
-- 1. LoDo Electric Masters
(
  'cont_elec_dt_001',
  'cat_elec_001',
  'neigh_downtown_001',
  'LoDo Electric Masters',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-2001',
  'https://www.lodoelectricmasters.com',
  4.9,
  234,
  'lodo-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Electrical Services
(
  'cont_elec_dt_002',
  'cat_elec_001',
  'neigh_downtown_001',
  'Union Station Electrical Services',
  '1701 Wewatta St, Denver, CO 80202',
  '(303) 555-2002',
  'https://www.unionstationelectrical.com',
  4.8,
  198,
  'union-station-electrical-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Denver Electric
(
  'cont_elec_dt_003',
  'cat_elec_001',
  'neigh_downtown_001',
  'Downtown Denver Electric',
  '1437 California St, Denver, CO 80202',
  '(303) 555-2003',
  'https://www.downtowndenverelectric.com',
  4.7,
  167,
  'downtown-denver-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark District Electrical
(
  'cont_elec_dt_004',
  'cat_elec_001',
  'neigh_downtown_001',
  'Ballpark District Electrical',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-2004',
  'https://www.ballparkelectrical.com',
  4.8,
  189,
  'ballpark-district-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Mall Electric
(
  'cont_elec_dt_005',
  'cat_elec_001',
  'neigh_downtown_001',
  '16th Street Mall Electric',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-2005',
  'https://www.16thstreetelectric.com',
  4.9,
  212,
  '16th-street-mall-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Electrical Pros
(
  'cont_elec_dt_006',
  'cat_elec_001',
  'neigh_downtown_001',
  'Larimer Square Electrical Pros',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-2006',
  'https://www.larimersquareelectrical.com',
  4.7,
  178,
  'larimer-square-electrical-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Electric Solutions
(
  'cont_elec_dt_007',
  'cat_elec_001',
  'neigh_downtown_001',
  'CBD Electric Solutions',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-2007',
  'https://www.cbdelectricsolutions.com',
  4.8,
  167,
  'cbd-electric-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Electrical Services
(
  'cont_elec_dt_008',
  'cat_elec_001',
  'neigh_downtown_001',
  'Five Points Electrical Services',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-2008',
  'https://www.fivepointselectrical.com',
  4.6,
  156,
  'five-points-electrical-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo District Electric
(
  'cont_elec_dt_009',
  'cat_elec_001',
  'neigh_downtown_001',
  'RiNo District Electric',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-2009',
  'https://www.rinoelectrical.com',
  4.8,
  201,
  'rino-district-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Electrical
(
  'cont_elec_dt_010',
  'cat_elec_001',
  'neigh_downtown_001',
  'Commons Park Electrical',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-2010',
  'https://www.commonsparkelectrical.com',
  4.7,
  182,
  'commons-park-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
