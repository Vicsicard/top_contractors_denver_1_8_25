-- Create Bathroom Remodelers category
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Downtown Denver area
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
-- 1. LoDo Bathroom Design
(
  'cont_bath_dt_001',
  'cat_bath_001',
  'neigh_downtown_001',
  'LoDo Bathroom Design',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-8001',
  'https://www.lodobathroomdesign.com',
  4.9,
  167,
  'lodo-bathroom-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Bath & Tile
(
  'cont_bath_dt_002',
  'cat_bath_001',
  'neigh_downtown_001',
  'Union Station Bath & Tile',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-8002',
  'https://www.unionstationbath.com',
  4.8,
  145,
  'union-station-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Bathroom Masters
(
  'cont_bath_dt_003',
  'cat_bath_001',
  'neigh_downtown_001',
  'Downtown Bathroom Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-8003',
  'https://www.downtownbathroommasters.com',
  4.7,
  134,
  'downtown-bathroom-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Bath Renovations
(
  'cont_bath_dt_004',
  'cat_bath_001',
  'neigh_downtown_001',
  'Ballpark Bath Renovations',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-8004',
  'https://www.ballparkbath.com',
  4.8,
  156,
  'ballpark-bath-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Bathroom Co
(
  'cont_bath_dt_005',
  'cat_bath_001',
  'neigh_downtown_001',
  '16th Street Bathroom Co',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-8005',
  'https://www.16thstreetbathroom.com',
  4.9,
  178,
  '16th-street-bathroom-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Bath Design
(
  'cont_bath_dt_006',
  'cat_bath_001',
  'neigh_downtown_001',
  'Larimer Square Bath Design',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-8006',
  'https://www.larimersquarebath.com',
  4.7,
  123,
  'larimer-square-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Bathroom Specialists
(
  'cont_bath_dt_007',
  'cat_bath_001',
  'neigh_downtown_001',
  'CBD Bathroom Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-8007',
  'https://www.cbdbathroom.com',
  4.8,
  145,
  'cbd-bathroom-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Bath & Shower
(
  'cont_bath_dt_008',
  'cat_bath_001',
  'neigh_downtown_001',
  'Five Points Bath & Shower',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-8008',
  'https://www.fivepointsbath.com',
  4.6,
  112,
  'five-points-bath-shower',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Bathroom Design
(
  'cont_bath_dt_009',
  'cat_bath_001',
  'neigh_downtown_001',
  'RiNo Bathroom Design',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-8009',
  'https://www.rinobathroom.com',
  4.8,
  167,
  'rino-bathroom-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Bath Remodeling
(
  'cont_bath_dt_010',
  'cat_bath_001',
  'neigh_downtown_001',
  'Commons Park Bath Remodeling',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-8010',
  'https://www.commonsparkbath.com',
  4.7,
  134,
  'commons-park-bath-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
