-- Create Landscapers category
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

-- Insert 10 Landscapers for Downtown Denver area
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
-- 1. LoDo Urban Gardens
(
  'cont_land_dt_001',
  'cat_land_001',
  'neigh_downtown_001',
  'LoDo Urban Gardens',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-6001',
  'https://www.lodourbangardens.com',
  4.9,
  167,
  'lodo-urban-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Landscape Design
(
  'cont_land_dt_002',
  'cat_land_001',
  'neigh_downtown_001',
  'Union Station Landscape Design',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-6002',
  'https://www.unionstationlandscape.com',
  4.8,
  145,
  'union-station-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Green Spaces
(
  'cont_land_dt_003',
  'cat_land_001',
  'neigh_downtown_001',
  'Downtown Green Spaces',
  '1600 California St, Denver, CO 80202',
  '(303) 555-6003',
  'https://www.downtowngreenspaces.com',
  4.7,
  132,
  'downtown-green-spaces',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark District Gardens
(
  'cont_land_dt_004',
  'cat_land_001',
  'neigh_downtown_001',
  'Ballpark District Gardens',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-6004',
  'https://www.ballparkgardens.com',
  4.8,
  156,
  'ballpark-district-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Mall Landscaping
(
  'cont_land_dt_005',
  'cat_land_001',
  'neigh_downtown_001',
  '16th Street Mall Landscaping',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-6005',
  'https://www.16thstreetlandscaping.com',
  4.9,
  178,
  '16th-street-mall-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Gardens
(
  'cont_land_dt_006',
  'cat_land_001',
  'neigh_downtown_001',
  'Larimer Square Gardens',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-6006',
  'https://www.larimersquaregardens.com',
  4.7,
  134,
  'larimer-square-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Green Solutions
(
  'cont_land_dt_007',
  'cat_land_001',
  'neigh_downtown_001',
  'CBD Green Solutions',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-6007',
  'https://www.cbdgreensolutions.com',
  4.8,
  145,
  'cbd-green-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Garden Design
(
  'cont_land_dt_008',
  'cat_land_001',
  'neigh_downtown_001',
  'Five Points Garden Design',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-6008',
  'https://www.fivepointsgardens.com',
  4.6,
  123,
  'five-points-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Landscape Studio
(
  'cont_land_dt_009',
  'cat_land_001',
  'neigh_downtown_001',
  'RiNo Landscape Studio',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-6009',
  'https://www.rinolandscape.com',
  4.8,
  167,
  'rino-landscape-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Landscaping
(
  'cont_land_dt_010',
  'cat_land_001',
  'neigh_downtown_001',
  'Commons Park Landscaping',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-6010',
  'https://www.commonsparklandscaping.com',
  4.7,
  145,
  'commons-park-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
