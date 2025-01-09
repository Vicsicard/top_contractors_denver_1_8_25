-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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
  'subreg_thorn_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_thorn_north_001',
  'subreg_thorn_north_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Bathroom Remodelers for Thornton/Northglenn area
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
-- 1. Thornton Bath Design
(
  'cont_bath_nes_001',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Thornton Bath Design',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-8701',
  'https://www.thorntonbath.com',
  4.9,
  178,
  'thornton-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Bath & Tile
(
  'cont_bath_nes_002',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Northglenn Bath & Tile',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-8702',
  'https://www.northglennbath.com',
  4.8,
  156,
  'northglenn-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Bath Masters
(
  'cont_bath_nes_003',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Washington Street Bath Masters',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-8703',
  'https://www.washingtonbath.com',
  4.7,
  134,
  'washington-street-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Original Thornton Bath Co
(
  'cont_bath_nes_004',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Original Thornton Bath Co',
  '8800 Pearl St, Thornton, CO 80229',
  '(303) 555-8704',
  'https://www.originalthorntonnbath.com',
  4.8,
  167,
  'original-thornton-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Huron Bath Studio
(
  'cont_bath_nes_005',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Huron Bath Studio',
  '10500 Huron St, Northglenn, CO 80234',
  '(303) 555-8705',
  'https://www.huronbath.com',
  4.9,
  189,
  'huron-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Grant Street Bath Design
(
  'cont_bath_nes_006',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Grant Street Bath Design',
  '11900 Grant St, Northglenn, CO 80233',
  '(303) 555-8706',
  'https://www.grantstreetbath.com',
  4.7,
  145,
  'grant-street-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Thornton Parkway Bath Co
(
  'cont_bath_nes_007',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Thornton Parkway Bath Co',
  '8600 Thornton Pkwy, Thornton, CO 80229',
  '(303) 555-8707',
  'https://www.thorntonparkwaybath.com',
  4.8,
  156,
  'thornton-parkway-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. 120th Avenue Bath Studio
(
  'cont_bath_nes_008',
  'cat_bath_001',
  'neigh_thorn_north_001',
  '120th Avenue Bath Studio',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-8708',
  'https://www.120thbath.com',
  4.6,
  123,
  '120th-avenue-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Webster Lake Bath Specialists
(
  'cont_bath_nes_009',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Webster Lake Bath Specialists',
  '12301 Claude Ct, Northglenn, CO 80241',
  '(303) 555-8709',
  'https://www.websterlakebath.com',
  4.8,
  167,
  'webster-lake-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Eastlake Bath Design
(
  'cont_bath_nes_010',
  'cat_bath_001',
  'neigh_thorn_north_001',
  'Eastlake Bath Design',
  '12500 Claude Ct, Northglenn, CO 80241',
  '(303) 555-8710',
  'https://www.eastlakebath.com',
  4.7,
  145,
  'eastlake-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
