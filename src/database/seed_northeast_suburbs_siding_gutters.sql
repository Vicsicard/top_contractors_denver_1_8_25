-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Thornton/Northglenn area
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
-- 1. Thornton Siding & Gutters
(
  'cont_siding_nes_001',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Thornton Siding & Gutters',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-7701',
  'https://www.thorntonsiding.com',
  4.9,
  182,
  'thornton-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Exteriors
(
  'cont_siding_nes_002',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Northglenn Exteriors',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-7702',
  'https://www.northglennexteriors.com',
  4.8,
  165,
  'northglenn-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Original Thornton Gutter Masters
(
  'cont_siding_nes_003',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Original Thornton Gutter Masters',
  '8800 Pearl St, Thornton, CO 80229',
  '(303) 555-7703',
  'https://www.originalthorntongutter.com',
  4.7,
  143,
  'original-thornton-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Washington Street Siding Solutions
(
  'cont_siding_nes_004',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Washington Street Siding Solutions',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-7704',
  'https://www.washingtonstsiding.com',
  4.8,
  176,
  'washington-street-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 120th Avenue Gutter Co
(
  'cont_siding_nes_005',
  'cat_siding_001',
  'neigh_thorn_north_001',
  '120th Avenue Gutter Co',
  '2191 E 120th Ave, Thornton, CO 80241',
  '(303) 555-7705',
  'https://www.120thgutter.com',
  4.9,
  195,
  '120th-avenue-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Huron Street Siding & Gutters
(
  'cont_siding_nes_006',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Huron Street Siding & Gutters',
  '10650 Huron St, Northglenn, CO 80234',
  '(303) 555-7706',
  'https://www.huronstsiding.com',
  4.7,
  134,
  'huron-street-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northeast Exterior Specialists
(
  'cont_siding_nes_007',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Northeast Exterior Specialists',
  '11900 Washington St, Northglenn, CO 80233',
  '(303) 555-7707',
  'https://www.northeastexteriors.com',
  4.8,
  156,
  'northeast-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Grant Park Siding & Gutters
(
  'cont_siding_nes_008',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Grant Park Siding & Gutters',
  '11701 Grant St, Northglenn, CO 80233',
  '(303) 555-7708',
  'https://www.grantparksiding.com',
  4.6,
  122,
  'grant-park-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Colorado Blvd Gutter Pros
(
  'cont_siding_nes_009',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Colorado Blvd Gutter Pros',
  '12000 Colorado Blvd, Thornton, CO 80241',
  '(303) 555-7709',
  'https://www.coloradoblvdgutter.com',
  4.8,
  167,
  'colorado-blvd-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Thornton Parkway Siding
(
  'cont_siding_nes_010',
  'cat_siding_001',
  'neigh_thorn_north_001',
  'Thornton Parkway Siding',
  '8900 Thornton Pkwy, Thornton, CO 80229',
  '(303) 555-7710',
  'https://www.thorntonpkwysiding.com',
  4.7,
  145,
  'thornton-parkway-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
