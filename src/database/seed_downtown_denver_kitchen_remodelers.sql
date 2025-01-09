-- Create Kitchen Remodelers category
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
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

-- Insert 10 Kitchen Remodelers for Downtown Denver area
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
-- 1. LoDo Kitchen Design
(
  'cont_kitchen_dt_001',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'LoDo Kitchen Design',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-9001',
  'https://www.lodokitchendesign.com',
  4.9,
  187,
  'lodo-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Kitchen & Cabinets
(
  'cont_kitchen_dt_002',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'Union Station Kitchen & Cabinets',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-9002',
  'https://www.unionstationkitchen.com',
  4.8,
  165,
  'union-station-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Kitchen Masters
(
  'cont_kitchen_dt_003',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'Downtown Kitchen Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-9003',
  'https://www.downtownkitchenmasters.com',
  4.7,
  144,
  'downtown-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Kitchen Renovations
(
  'cont_kitchen_dt_004',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'Ballpark Kitchen Renovations',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-9004',
  'https://www.ballparkkitchen.com',
  4.8,
  176,
  'ballpark-kitchen-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Kitchen Co
(
  'cont_kitchen_dt_005',
  'cat_kitchen_001',
  'neigh_downtown_001',
  '16th Street Kitchen Co',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-9005',
  'https://www.16thstreetkitchen.com',
  4.9,
  198,
  '16th-street-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Kitchen Design
(
  'cont_kitchen_dt_006',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'Larimer Square Kitchen Design',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-9006',
  'https://www.larimersquarekitchen.com',
  4.7,
  133,
  'larimer-square-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Kitchen Specialists
(
  'cont_kitchen_dt_007',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'CBD Kitchen Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-9007',
  'https://www.cbdkitchen.com',
  4.8,
  155,
  'cbd-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Kitchen & Design
(
  'cont_kitchen_dt_008',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'Five Points Kitchen & Design',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-9008',
  'https://www.fivepointskitchen.com',
  4.6,
  122,
  'five-points-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Kitchen Design
(
  'cont_kitchen_dt_009',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'RiNo Kitchen Design',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-9009',
  'https://www.rinokitchen.com',
  4.8,
  177,
  'rino-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Kitchen Remodeling
(
  'cont_kitchen_dt_010',
  'cat_kitchen_001',
  'neigh_downtown_001',
  'Commons Park Kitchen Remodeling',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-9010',
  'https://www.commonskitchen.com',
  4.7,
  144,
  'commons-park-kitchen-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
