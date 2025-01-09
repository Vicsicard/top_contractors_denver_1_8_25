-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for Downtown Denver area
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
-- 1. LoDo Flooring Experts
(
  'cont_floor_dt_001',
  'cat_flooring_001',
  'neigh_downtown_001',
  'LoDo Flooring Experts',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-7001',
  'https://www.lodoflooring.com',
  4.9,
  185,
  'lodo-flooring-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Floor Masters
(
  'cont_floor_dt_002',
  'cat_flooring_001',
  'neigh_downtown_001',
  'Union Station Floor Masters',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-7002',
  'https://www.unionstationflooring.com',
  4.8,
  162,
  'union-station-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Hardwood Specialists
(
  'cont_floor_dt_003',
  'cat_flooring_001',
  'neigh_downtown_001',
  'Downtown Hardwood Specialists',
  '1600 California St, Denver, CO 80202',
  '(303) 555-7003',
  'https://www.downtownhardwood.com',
  4.7,
  148,
  'downtown-hardwood-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Tile & Stone
(
  'cont_floor_dt_004',
  'cat_flooring_001',
  'neigh_downtown_001',
  'Ballpark Tile & Stone',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-7004',
  'https://www.ballparktile.com',
  4.8,
  173,
  'ballpark-tile-stone',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Carpet Co
(
  'cont_floor_dt_005',
  'cat_flooring_001',
  'neigh_downtown_001',
  '16th Street Carpet Co',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-7005',
  'https://www.16thstreetcarpet.com',
  4.9,
  192,
  '16th-street-carpet-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Flooring Design
(
  'cont_floor_dt_006',
  'cat_flooring_001',
  'neigh_downtown_001',
  'Larimer Square Flooring Design',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-7006',
  'https://www.larimersquareflooring.com',
  4.7,
  138,
  'larimer-square-flooring-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Floor Specialists
(
  'cont_floor_dt_007',
  'cat_flooring_001',
  'neigh_downtown_001',
  'CBD Floor Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-7007',
  'https://www.cbdflooring.com',
  4.8,
  158,
  'cbd-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Flooring & Design
(
  'cont_floor_dt_008',
  'cat_flooring_001',
  'neigh_downtown_001',
  'Five Points Flooring & Design',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-7008',
  'https://www.fivepointsflooring.com',
  4.6,
  126,
  'five-points-flooring-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Floor Pros
(
  'cont_floor_dt_009',
  'cat_flooring_001',
  'neigh_downtown_001',
  'RiNo Floor Pros',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-7009',
  'https://www.rinoflooring.com',
  4.8,
  169,
  'rino-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Flooring Solutions
(
  'cont_floor_dt_010',
  'cat_flooring_001',
  'neigh_downtown_001',
  'Commons Park Flooring Solutions',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-7010',
  'https://www.commonsparkflooring.com',
  4.7,
  142,
  'commons-park-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
