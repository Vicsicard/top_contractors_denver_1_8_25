-- Create Painters category
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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

-- Insert 10 Painters for Downtown Denver area
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
-- 1. LoDo Fine Finishes
(
  'cont_paint_dt_001',
  'cat_paint_001',
  'neigh_downtown_001',
  'LoDo Fine Finishes',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-5001',
  'https://www.lodofinepainting.com',
  4.9,
  167,
  'lodo-fine-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Painters
(
  'cont_paint_dt_002',
  'cat_paint_001',
  'neigh_downtown_001',
  'Union Station Painters',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-5002',
  'https://www.unionstationpainters.com',
  4.8,
  145,
  'union-station-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Color Experts
(
  'cont_paint_dt_003',
  'cat_paint_001',
  'neigh_downtown_001',
  'Downtown Color Experts',
  '1600 California St, Denver, CO 80202',
  '(303) 555-5003',
  'https://www.downtowncolorexperts.com',
  4.7,
  132,
  'downtown-color-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark District Painting
(
  'cont_paint_dt_004',
  'cat_paint_001',
  'neigh_downtown_001',
  'Ballpark District Painting',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-5004',
  'https://www.ballparkpainting.com',
  4.8,
  156,
  'ballpark-district-painting',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Mall Painters
(
  'cont_paint_dt_005',
  'cat_paint_001',
  'neigh_downtown_001',
  '16th Street Mall Painters',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-5005',
  'https://www.16thstreetpainters.com',
  4.9,
  178,
  '16th-street-mall-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Paint Co
(
  'cont_paint_dt_006',
  'cat_paint_001',
  'neigh_downtown_001',
  'Larimer Square Paint Co',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-5006',
  'https://www.larimersquarepainting.com',
  4.7,
  134,
  'larimer-square-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Painting Solutions
(
  'cont_paint_dt_007',
  'cat_paint_001',
  'neigh_downtown_001',
  'CBD Painting Solutions',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-5007',
  'https://www.cbdpainting.com',
  4.8,
  145,
  'cbd-painting-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Paint & Design
(
  'cont_paint_dt_008',
  'cat_paint_001',
  'neigh_downtown_001',
  'Five Points Paint & Design',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-5008',
  'https://www.fivepointspainting.com',
  4.6,
  123,
  'five-points-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Paint Studio
(
  'cont_paint_dt_009',
  'cat_paint_001',
  'neigh_downtown_001',
  'RiNo Paint Studio',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-5009',
  'https://www.rinopainting.com',
  4.8,
  167,
  'rino-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Painters
(
  'cont_paint_dt_010',
  'cat_paint_001',
  'neigh_downtown_001',
  'Commons Park Painters',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-5010',
  'https://www.commonsparkpainters.com',
  4.7,
  145,
  'commons-park-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
