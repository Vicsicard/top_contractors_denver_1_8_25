-- Create Siding & Gutters category
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Downtown Denver area
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
-- 1. LoDo Siding & Gutters
(
  'cont_siding_dt_001',
  'cat_siding_001',
  'neigh_downtown_001',
  'LoDo Siding & Gutters',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-7001',
  'https://www.lodosiding.com',
  4.9,
  182,
  'lodo-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Exteriors
(
  'cont_siding_dt_002',
  'cat_siding_001',
  'neigh_downtown_001',
  'Union Station Exteriors',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-7002',
  'https://www.unionstationexteriors.com',
  4.8,
  165,
  'union-station-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Gutter Masters
(
  'cont_siding_dt_003',
  'cat_siding_001',
  'neigh_downtown_001',
  'Downtown Gutter Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-7003',
  'https://www.downtownguttermasters.com',
  4.7,
  143,
  'downtown-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Siding Solutions
(
  'cont_siding_dt_004',
  'cat_siding_001',
  'neigh_downtown_001',
  'Ballpark Siding Solutions',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-7004',
  'https://www.ballparksiding.com',
  4.8,
  176,
  'ballpark-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Gutter Co
(
  'cont_siding_dt_005',
  'cat_siding_001',
  'neigh_downtown_001',
  '16th Street Gutter Co',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-7005',
  'https://www.16thstreetgutter.com',
  4.9,
  195,
  '16th-street-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Siding & Gutters
(
  'cont_siding_dt_006',
  'cat_siding_001',
  'neigh_downtown_001',
  'Larimer Square Siding & Gutters',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-7006',
  'https://www.larimersquaresiding.com',
  4.7,
  134,
  'larimer-square-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Exterior Specialists
(
  'cont_siding_dt_007',
  'cat_siding_001',
  'neigh_downtown_001',
  'CBD Exterior Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-7007',
  'https://www.cbdexteriors.com',
  4.8,
  156,
  'cbd-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Siding & Gutters
(
  'cont_siding_dt_008',
  'cat_siding_001',
  'neigh_downtown_001',
  'Five Points Siding & Gutters',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-7008',
  'https://www.fivepointssiding.com',
  4.6,
  122,
  'five-points-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Gutter Pros
(
  'cont_siding_dt_009',
  'cat_siding_001',
  'neigh_downtown_001',
  'RiNo Gutter Pros',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-7009',
  'https://www.rinogutter.com',
  4.8,
  167,
  'rino-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Siding
(
  'cont_siding_dt_010',
  'cat_siding_001',
  'neigh_downtown_001',
  'Commons Park Siding',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-7010',
  'https://www.commonssiding.com',
  4.7,
  145,
  'commons-park-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
