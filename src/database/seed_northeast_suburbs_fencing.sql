-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
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

-- Insert 10 Fencing contractors for Thornton/Northglenn area
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
-- 1. Thornton Fence Works
(
  'cont_fence_nes_001',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Thornton Fence Works',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-9701',
  'https://www.thorntonfence.com',
  4.9,
  166,
  'thornton-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Fence & Gate
(
  'cont_fence_nes_002',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Northglenn Fence & Gate',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-9702',
  'https://www.northglennfence.com',
  4.8,
  141,
  'northglenn-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Fence Masters
(
  'cont_fence_nes_003',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Washington Street Fence Masters',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-9703',
  'https://www.washingtonstreetfence.com',
  4.7,
  127,
  'washington-street-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Huron Street Fence Solutions
(
  'cont_fence_nes_004',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Huron Street Fence Solutions',
  '10450 Huron St, Northglenn, CO 80234',
  '(303) 555-9704',
  'https://www.huronstreetfence.com',
  4.8,
  154,
  'huron-street-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Original Thornton Fence Co
(
  'cont_fence_nes_005',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Original Thornton Fence Co',
  '8800 Pearl St, Thornton, CO 80229',
  '(303) 555-9705',
  'https://www.originalthorntonfence.com',
  4.9,
  171,
  'original-thornton-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. E.B. Rains Fence Works
(
  'cont_fence_nes_006',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'E.B. Rains Fence Works',
  '11701 Community Center Dr, Northglenn, CO 80233',
  '(303) 555-9706',
  'https://www.ebrainsfence.com',
  4.7,
  130,
  'eb-rains-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Thornton Parkway Fence Specialists
(
  'cont_fence_nes_007',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Thornton Parkway Fence Specialists',
  '9500 Civic Center Dr, Thornton, CO 80229',
  '(303) 555-9707',
  'https://www.thorntonparkwayfence.com',
  4.8,
  144,
  'thornton-parkway-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Webster Lake Fence & Design
(
  'cont_fence_nes_008',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Webster Lake Fence & Design',
  '11900 Grant St, Northglenn, CO 80233',
  '(303) 555-9708',
  'https://www.websterlakefence.com',
  4.6,
  114,
  'webster-lake-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Eastlake Fence Pros
(
  'cont_fence_nes_009',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Eastlake Fence Pros',
  '12500 Claude Ct, Northglenn, CO 80241',
  '(303) 555-9709',
  'https://www.eastlakefence.com',
  4.8,
  153,
  'eastlake-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Thornton Trail Fence Solutions
(
  'cont_fence_nes_010',
  'cat_fencing_001',
  'neigh_thorn_north_001',
  'Thornton Trail Fence Solutions',
  '13500 Holly St, Thornton, CO 80241',
  '(303) 555-9710',
  'https://www.thorntontrailfence.com',
  4.7,
  128,
  'thornton-trail-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
