-- Ensure category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_downtown_001',
  'reg_central_001',
  'Downtown Area',
  'downtown-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_downtown_001',
  'subreg_downtown_001',
  'Downtown Denver',
  'downtown-denver',
  'Core downtown Denver business district including LoDo, Union Station, and Central Business District',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Downtown Denver
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
-- 1. Mile High Plumbing Pros
(
  'cont_plumb_dt_001',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Mile High Plumbing Pros',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-0101',
  'https://www.milehighplumbingpros.com',
  4.8,
  156,
  'mile-high-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Denver Elite Plumbers
(
  'cont_plumb_dt_002',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Denver Elite Plumbers',
  '1600 Glenarm Pl, Denver, CO 80202',
  '(303) 555-0102',
  'https://www.denvereliteplumbers.com',
  4.7,
  203,
  'denver-elite-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Drain Masters
(
  'cont_plumb_dt_003',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Downtown Drain Masters',
  '1750 Welton St, Denver, CO 80202',
  '(303) 555-0105',
  'https://www.downtowndrainmasters.com',
  4.9,
  167,
  'downtown-drain-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Pro Pipe Solutions
(
  'cont_plumb_dt_004',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Pro Pipe Solutions',
  '1800 California St, Denver, CO 80202',
  '(303) 555-0130',
  'https://www.propipesolutions.com',
  4.6,
  189,
  'pro-pipe-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Urban Flow Plumbing
(
  'cont_plumb_dt_005',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Urban Flow Plumbing',
  '1900 16th St, Denver, CO 80202',
  '(303) 555-0131',
  'https://www.urbanflowplumbing.com',
  4.8,
  145,
  'urban-flow-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Metro Plumbing & Drain
(
  'cont_plumb_dt_006',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Metro Plumbing & Drain',
  '1901 Arapahoe St, Denver, CO 80202',
  '(303) 555-0132',
  'https://www.metroplumbingdenver.com',
  4.7,
  167,
  'metro-plumbing-and-drain',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Precision Plumbing Denver
(
  'cont_plumb_dt_007',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Precision Plumbing Denver',
  '1634 18th St, Denver, CO 80202',
  '(303) 555-0133',
  'https://www.precisionplumbingdenver.com',
  4.9,
  178,
  'precision-plumbing-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. 24/7 Downtown Plumbers
(
  'cont_plumb_dt_008',
  'cat_plumber_001',
  'neigh_downtown_001',
  '24/7 Downtown Plumbers',
  '1560 Blake St, Denver, CO 80202',
  '(303) 555-0134',
  'https://www.247downtownplumbers.com',
  4.8,
  190,
  '24-7-downtown-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. LoDo Plumbing Experts
(
  'cont_plumb_dt_009',
  'cat_plumber_001',
  'neigh_downtown_001',
  'LoDo Plumbing Experts',
  '1700 Wazee St, Denver, CO 80202',
  '(303) 555-0135',
  'https://www.lodoplumbing.com',
  4.7,
  182,
  'lodo-plumbing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Union Station Plumbing
(
  'cont_plumb_dt_010',
  'cat_plumber_001',
  'neigh_downtown_001',
  'Union Station Plumbing',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-0136',
  'https://www.unionstationplumbing.com',
  4.8,
  165,
  'union-station-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
