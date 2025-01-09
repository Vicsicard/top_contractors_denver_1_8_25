-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for Thornton/Northglenn area
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
-- 1. Thornton Flooring Works
(
  'cont_floor_nes_001',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Thornton Flooring Works',
  '8901 Washington St, Thornton, CO 80229',
  '(303) 555-7701',
  'https://www.thorntonflooring.com',
  4.9,
  169,
  'thornton-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Floor & Tile
(
  'cont_floor_nes_002',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Northglenn Floor & Tile',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-7702',
  'https://www.northglennflooring.com',
  4.8,
  147,
  'northglenn-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Original Thornton Floor Masters
(
  'cont_floor_nes_003',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Original Thornton Floor Masters',
  '8851 Pearl St, Thornton, CO 80229',
  '(303) 555-7703',
  'https://www.originalthorntonflooring.com',
  4.7,
  132,
  'original-thornton-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Washington Street Flooring Solutions
(
  'cont_floor_nes_004',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Washington Street Flooring Solutions',
  '9501 Washington St, Thornton, CO 80229',
  '(303) 555-7704',
  'https://www.washingtonstreetflooring.com',
  4.8,
  159,
  'washington-street-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Huron Floor Co
(
  'cont_floor_nes_005',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Huron Floor Co',
  '10455 Huron St, Northglenn, CO 80234',
  '(303) 555-7705',
  'https://www.huronflooring.com',
  4.9,
  175,
  'huron-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 120th Avenue Flooring Works
(
  'cont_floor_nes_006',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  '120th Avenue Flooring Works',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-7706',
  'https://www.120thavenueflooring.com',
  4.7,
  136,
  '120th-avenue-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Eastlake Floor Specialists
(
  'cont_floor_nes_007',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Eastlake Floor Specialists',
  '12500 Claude Ct, Northglenn, CO 80241',
  '(303) 555-7707',
  'https://www.eastlakeflooring.com',
  4.8,
  150,
  'eastlake-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Webster Lake Floor & Design
(
  'cont_floor_nes_008',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Webster Lake Floor & Design',
  '12301 Claude Ct, Northglenn, CO 80241',
  '(303) 555-7708',
  'https://www.websterlakeflooring.com',
  4.6,
  119,
  'webster-lake-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Grant Street Floor Pros
(
  'cont_floor_nes_009',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Grant Street Floor Pros',
  '11651 Pearl St, Northglenn, CO 80233',
  '(303) 555-7709',
  'https://www.grantstreetflooring.com',
  4.8,
  158,
  'grant-street-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Thornton Parkway Flooring Solutions
(
  'cont_floor_nes_010',
  'cat_flooring_001',
  'neigh_thorn_north_001',
  'Thornton Parkway Flooring Solutions',
  '8891 Thornton Pkwy, Thornton, CO 80229',
  '(303) 555-7710',
  'https://www.thorntonparkwayflooring.com',
  4.7,
  134,
  'thornton-parkway-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
