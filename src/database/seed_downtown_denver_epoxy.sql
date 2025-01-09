-- Ensure Epoxy Garage category exists
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

-- Insert 10 Epoxy Garage contractors for Downtown Denver area
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
-- 1. LoDo Epoxy Solutions
(
  'cont_epoxy_dt_001',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'LoDo Epoxy Solutions',
  '1601 Blake St, Denver, CO 80202',
  '(303) 555-7001',
  'https://www.lodoepoxy.com',
  4.9,
  142,
  'lodo-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Garage Coatings
(
  'cont_epoxy_dt_002',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'Union Station Garage Coatings',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-7002',
  'https://www.unionstationepoxy.com',
  4.8,
  128,
  'union-station-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Epoxy Masters
(
  'cont_epoxy_dt_003',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'Downtown Epoxy Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-7003',
  'https://www.downtownepoxy.com',
  4.7,
  115,
  'downtown-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Garage Specialists
(
  'cont_epoxy_dt_004',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'Ballpark Garage Specialists',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-7004',
  'https://www.ballparkepoxy.com',
  4.8,
  137,
  'ballpark-garage-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Epoxy Pro
(
  'cont_epoxy_dt_005',
  'cat_epoxy_001',
  'neigh_downtown_001',
  '16th Street Epoxy Pro',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-7005',
  'https://www.16thstreetepoxy.com',
  4.9,
  149,
  '16th-street-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Garage Solutions
(
  'cont_epoxy_dt_006',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'Larimer Square Garage Solutions',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-7006',
  'https://www.larimersquareepoxy.com',
  4.7,
  108,
  'larimer-square-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Epoxy Specialists
(
  'cont_epoxy_dt_007',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'CBD Epoxy Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-7007',
  'https://www.cbdepoxy.com',
  4.8,
  126,
  'cbd-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Garage Coatings
(
  'cont_epoxy_dt_008',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'Five Points Garage Coatings',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-7008',
  'https://www.fivepointsepoxy.com',
  4.6,
  98,
  'five-points-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Epoxy Pros
(
  'cont_epoxy_dt_009',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'RiNo Epoxy Pros',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-7009',
  'https://www.rinoepoxy.com',
  4.8,
  134,
  'rino-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Garage Finishes
(
  'cont_epoxy_dt_010',
  'cat_epoxy_001',
  'neigh_downtown_001',
  'Commons Park Garage Finishes',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-7010',
  'https://www.commonsparkepoxy.com',
  4.7,
  112,
  'commons-park-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
