-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
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

-- Insert 10 Fencing contractors for Downtown Denver area
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
-- 1. LoDo Fence Works
(
  'cont_fence_dt_001',
  'cat_fencing_001',
  'neigh_downtown_001',
  'LoDo Fence Works',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-9001',
  'https://www.lodofence.com',
  4.9,
  167,
  'lodo-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Fence & Gate
(
  'cont_fence_dt_002',
  'cat_fencing_001',
  'neigh_downtown_001',
  'Union Station Fence & Gate',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-9002',
  'https://www.unionstationfence.com',
  4.8,
  145,
  'union-station-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Fence Masters
(
  'cont_fence_dt_003',
  'cat_fencing_001',
  'neigh_downtown_001',
  'Downtown Fence Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-9003',
  'https://www.downtownfencemasters.com',
  4.7,
  132,
  'downtown-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Fence Solutions
(
  'cont_fence_dt_004',
  'cat_fencing_001',
  'neigh_downtown_001',
  'Ballpark Fence Solutions',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-9004',
  'https://www.ballparkfence.com',
  4.8,
  156,
  'ballpark-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Fence Co
(
  'cont_fence_dt_005',
  'cat_fencing_001',
  'neigh_downtown_001',
  '16th Street Fence Co',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-9005',
  'https://www.16thstreetfence.com',
  4.9,
  177,
  '16th-street-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Fence Design
(
  'cont_fence_dt_006',
  'cat_fencing_001',
  'neigh_downtown_001',
  'Larimer Square Fence Design',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-9006',
  'https://www.larimersquarefence.com',
  4.7,
  124,
  'larimer-square-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Fence Specialists
(
  'cont_fence_dt_007',
  'cat_fencing_001',
  'neigh_downtown_001',
  'CBD Fence Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-9007',
  'https://www.cbdfence.com',
  4.8,
  143,
  'cbd-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Fence & Design
(
  'cont_fence_dt_008',
  'cat_fencing_001',
  'neigh_downtown_001',
  'Five Points Fence & Design',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-9008',
  'https://www.fivepointsfence.com',
  4.6,
  111,
  'five-points-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Fence Pros
(
  'cont_fence_dt_009',
  'cat_fencing_001',
  'neigh_downtown_001',
  'RiNo Fence Pros',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-9009',
  'https://www.rinofence.com',
  4.8,
  154,
  'rino-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Fence Solutions
(
  'cont_fence_dt_010',
  'cat_fencing_001',
  'neigh_downtown_001',
  'Commons Park Fence Solutions',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-9010',
  'https://www.commonsparkfence.com',
  4.7,
  127,
  'commons-park-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
