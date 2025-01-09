-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_thor_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_thor_north_001',
  'subreg_thor_north_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Painters for Thornton/Northglenn area
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
-- 1. Thornton Paint Masters
(
  'cont_paint_nes_001',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Thornton Paint Masters',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-5701',
  'https://www.thorntonpainting.com',
  4.9,
  167,
  'thornton-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Paint Co
(
  'cont_paint_nes_002',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Northglenn Paint Co',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-5702',
  'https://www.northglennpainting.com',
  4.8,
  145,
  'northglenn-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Painters
(
  'cont_paint_nes_003',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Washington Street Painters',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-5703',
  'https://www.washingtonstreetpainting.com',
  4.7,
  132,
  'washington-street-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Original Thornton Paint Studio
(
  'cont_paint_nes_004',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Original Thornton Paint Studio',
  '8800 N Washington St, Thornton, CO 80229',
  '(303) 555-5704',
  'https://www.originalthorntonpainting.com',
  4.8,
  156,
  'original-thornton-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Huron Paint & Design
(
  'cont_paint_nes_005',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Huron Paint & Design',
  '10400 Huron St, Northglenn, CO 80234',
  '(303) 555-5705',
  'https://www.huronpainting.com',
  4.9,
  178,
  'huron-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 120th Avenue Painters
(
  'cont_paint_nes_006',
  'cat_paint_001',
  'neigh_thor_north_001',
  '120th Avenue Painters',
  '2191 E 120th Ave, Thornton, CO 80241',
  '(303) 555-5706',
  'https://www.120thavepainting.com',
  4.7,
  134,
  '120th-avenue-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Grant Park Paint Pros
(
  'cont_paint_nes_007',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Grant Park Paint Pros',
  '11701 Grant St, Northglenn, CO 80233',
  '(303) 555-5707',
  'https://www.grantparkpainting.com',
  4.8,
  145,
  'grant-park-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Thornton Town Center Painters
(
  'cont_paint_nes_008',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Thornton Town Center Painters',
  '10001 Grant St, Thornton, CO 80229',
  '(303) 555-5708',
  'https://www.thorntontownpainting.com',
  4.6,
  123,
  'thornton-town-center-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Webster Lake Paint Studio
(
  'cont_paint_nes_009',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Webster Lake Paint Studio',
  '12301 Claude Ct, Northglenn, CO 80241',
  '(303) 555-5709',
  'https://www.websterlakepainting.com',
  4.8,
  156,
  'webster-lake-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Eastlake Paint Co
(
  'cont_paint_nes_010',
  'cat_paint_001',
  'neigh_thor_north_001',
  'Eastlake Paint Co',
  '12500 Claude Ct, Northglenn, CO 80241',
  '(303) 555-5710',
  'https://www.eastlakepainting.com',
  4.7,
  134,
  'eastlake-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
