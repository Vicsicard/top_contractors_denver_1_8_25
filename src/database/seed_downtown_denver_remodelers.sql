-- Create Home Remodelers category
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
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

-- Insert 10 Home Remodelers for Downtown Denver area
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
-- 1. LoDo Renovation Masters
(
  'cont_remod_dt_001',
  'cat_remod_001',
  'neigh_downtown_001',
  'LoDo Renovation Masters',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-7001',
  'https://www.lodorenovations.com',
  4.9,
  187,
  'lodo-renovation-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Home Design
(
  'cont_remod_dt_002',
  'cat_remod_001',
  'neigh_downtown_001',
  'Union Station Home Design',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-7002',
  'https://www.unionstationdesign.com',
  4.8,
  156,
  'union-station-home-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Remodeling Experts
(
  'cont_remod_dt_003',
  'cat_remod_001',
  'neigh_downtown_001',
  'Downtown Remodeling Experts',
  '1600 California St, Denver, CO 80202',
  '(303) 555-7003',
  'https://www.downtownremodeling.com',
  4.7,
  142,
  'downtown-remodeling-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark District Renovations
(
  'cont_remod_dt_004',
  'cat_remod_001',
  'neigh_downtown_001',
  'Ballpark District Renovations',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-7004',
  'https://www.ballparkrenovations.com',
  4.8,
  165,
  'ballpark-district-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Design Build
(
  'cont_remod_dt_005',
  'cat_remod_001',
  'neigh_downtown_001',
  '16th Street Design Build',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-7005',
  'https://www.16thstreetdesignbuild.com',
  4.9,
  198,
  '16th-street-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Remodeling
(
  'cont_remod_dt_006',
  'cat_remod_001',
  'neigh_downtown_001',
  'Larimer Square Remodeling',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-7006',
  'https://www.larimersquareremodeling.com',
  4.7,
  134,
  'larimer-square-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Home Transformations
(
  'cont_remod_dt_007',
  'cat_remod_001',
  'neigh_downtown_001',
  'CBD Home Transformations',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-7007',
  'https://www.cbdhometransformations.com',
  4.8,
  145,
  'cbd-home-transformations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Renovation Co
(
  'cont_remod_dt_008',
  'cat_remod_001',
  'neigh_downtown_001',
  'Five Points Renovation Co',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-7008',
  'https://www.fivepointsrenovation.com',
  4.6,
  123,
  'five-points-renovation-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Design Build
(
  'cont_remod_dt_009',
  'cat_remod_001',
  'neigh_downtown_001',
  'RiNo Design Build',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-7009',
  'https://www.rinodesignbuild.com',
  4.8,
  167,
  'rino-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Remodeling
(
  'cont_remod_dt_010',
  'cat_remod_001',
  'neigh_downtown_001',
  'Commons Park Remodeling',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-7010',
  'https://www.commonsparkdesign.com',
  4.7,
  145,
  'commons-park-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
