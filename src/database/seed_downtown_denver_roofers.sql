-- Create Roofers category
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

-- Insert 10 Roofers for Downtown Denver area
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
-- 1. LoDo Roofing Experts
(
  'cont_roof_dt_001',
  'cat_roof_001',
  'neigh_downtown_001',
  'LoDo Roofing Experts',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-4001',
  'https://www.lodoroofing.com',
  4.9,
  187,
  'lodo-roofing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Roofers
(
  'cont_roof_dt_002',
  'cat_roof_001',
  'neigh_downtown_001',
  'Union Station Roofers',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-4002',
  'https://www.unionstationroofers.com',
  4.8,
  156,
  'union-station-roofers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Denver Roofing Co
(
  'cont_roof_dt_003',
  'cat_roof_001',
  'neigh_downtown_001',
  'Downtown Denver Roofing Co',
  '1600 California St, Denver, CO 80202',
  '(303) 555-4003',
  'https://www.downtowndenverroofing.com',
  4.7,
  143,
  'downtown-denver-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark District Roofing
(
  'cont_roof_dt_004',
  'cat_roof_001',
  'neigh_downtown_001',
  'Ballpark District Roofing',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-4004',
  'https://www.ballparkroofing.com',
  4.8,
  165,
  'ballpark-district-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Mall Roofing
(
  'cont_roof_dt_005',
  'cat_roof_001',
  'neigh_downtown_001',
  '16th Street Mall Roofing',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-4005',
  'https://www.16thstreetroofing.com',
  4.9,
  178,
  '16th-street-mall-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Roofing Pros
(
  'cont_roof_dt_006',
  'cat_roof_001',
  'neigh_downtown_001',
  'Larimer Square Roofing Pros',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-4006',
  'https://www.larimersquareroofing.com',
  4.7,
  145,
  'larimer-square-roofing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Roofing Solutions
(
  'cont_roof_dt_007',
  'cat_roof_001',
  'neigh_downtown_001',
  'CBD Roofing Solutions',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-4007',
  'https://www.cbdroofing.com',
  4.8,
  134,
  'cbd-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Roofing Services
(
  'cont_roof_dt_008',
  'cat_roof_001',
  'neigh_downtown_001',
  'Five Points Roofing Services',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-4008',
  'https://www.fivepointsroofing.com',
  4.6,
  123,
  'five-points-roofing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Roofing Specialists
(
  'cont_roof_dt_009',
  'cat_roof_001',
  'neigh_downtown_001',
  'RiNo Roofing Specialists',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-4009',
  'https://www.rinoroofing.com',
  4.8,
  167,
  'rino-roofing-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Roofing
(
  'cont_roof_dt_010',
  'cat_roof_001',
  'neigh_downtown_001',
  'Commons Park Roofing',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-4010',
  'https://www.commonsparkroofing.com',
  4.7,
  145,
  'commons-park-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
