-- Ensure Masonry category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_masonry_001',
  'Masonry',
  'masonry',
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

-- Insert 10 Masonry contractors for Thornton/Northglenn area
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
-- 1. Thornton Masonry Works
(
  'cont_masonry_nes_001',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Thornton Masonry Works',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-8701',
  'https://www.thorntonmasonry.com',
  4.9,
  188,
  'thornton-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Stone & Brick
(
  'cont_masonry_nes_002',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Northglenn Stone & Brick',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-8702',
  'https://www.northglennstone.com',
  4.8,
  166,
  'northglenn-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Brick Masters
(
  'cont_masonry_nes_003',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Washington Street Brick Masters',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-8703',
  'https://www.washingtonbrick.com',
  4.7,
  144,
  'washington-street-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Huron Stone Solutions
(
  'cont_masonry_nes_004',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Huron Stone Solutions',
  '10455 Huron St, Northglenn, CO 80234',
  '(303) 555-8704',
  'https://www.huronstone.com',
  4.8,
  177,
  'huron-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 120th Avenue Masonry Co
(
  'cont_masonry_nes_005',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  '120th Avenue Masonry Co',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-8705',
  'https://www.120thmasonry.com',
  4.9,
  198,
  '120th-avenue-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Grant Street Stone Works
(
  'cont_masonry_nes_006',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Grant Street Stone Works',
  '11701 Grant St, Northglenn, CO 80233',
  '(303) 555-8706',
  'https://www.grantstreetstone.com',
  4.7,
  155,
  'grant-street-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northeast Masonry Specialists
(
  'cont_masonry_nes_007',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Northeast Masonry Specialists',
  '12000 Washington Center Pkwy, Thornton, CO 80241',
  '(303) 555-8707',
  'https://www.northeastmasonry.com',
  4.8,
  166,
  'northeast-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Pearl Street Stone & Brick
(
  'cont_masonry_nes_008',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Pearl Street Stone & Brick',
  '11900 Pearl St, Northglenn, CO 80233',
  '(303) 555-8708',
  'https://www.pearlstreetstone.com',
  4.6,
  133,
  'pearl-street-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Thornton Parkway Masonry Pros
(
  'cont_masonry_nes_009',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Thornton Parkway Masonry Pros',
  '8900 Thornton Pkwy, Thornton, CO 80229',
  '(303) 555-8709',
  'https://www.thorntonparkwaymasonry.com',
  4.8,
  177,
  'thornton-parkway-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Colorado Boulevard Stone Solutions
(
  'cont_masonry_nes_010',
  'cat_masonry_001',
  'neigh_thorn_north_001',
  'Colorado Boulevard Stone Solutions',
  '10650 Colorado Blvd, Thornton, CO 80233',
  '(303) 555-8710',
  'https://www.coloradoblvdstone.com',
  4.7,
  155,
  'colorado-boulevard-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
