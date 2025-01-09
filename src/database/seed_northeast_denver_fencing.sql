-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_east_001',
  'East Denver',
  'east-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_northeast_001',
  'reg_east_001',
  'Northeast Denver',
  'northeast-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_northeast_001',
  'subreg_northeast_001',
  'Northeast Denver',
  'northeast-denver',
  'Including Montbello, Green Valley Ranch, and Gateway areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Fencing contractors for Northeast Denver area
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
-- 1. Montbello Fence Works
(
  'cont_fence_ne_001',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Montbello Fence Works',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-9401',
  'https://www.montbellofence.com',
  4.9,
  165,
  'montbello-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Fence & Gate
(
  'cont_fence_ne_002',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Green Valley Ranch Fence & Gate',
  '18500 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-9402',
  'https://www.gvrfence.com',
  4.8,
  142,
  'green-valley-ranch-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Fence Masters
(
  'cont_fence_ne_003',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Gateway Fence Masters',
  '4800 Tower Rd, Denver, CO 80249',
  '(303) 555-9403',
  'https://www.gatewayfence.com',
  4.7,
  128,
  'gateway-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Fence Solutions
(
  'cont_fence_ne_004',
  'cat_fencing_001',
  'neigh_northeast_001',
  'DIA Corridor Fence Solutions',
  '16000 E 40th Ave, Denver, CO 80239',
  '(303) 555-9404',
  'https://www.diacorridorfence.com',
  4.8,
  155,
  'dia-corridor-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Peña Boulevard Fence Co
(
  'cont_fence_ne_005',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Peña Boulevard Fence Co',
  '16100 E 51st Ave, Denver, CO 80239',
  '(303) 555-9405',
  'https://www.penablvdfence.com',
  4.9,
  172,
  'pena-boulevard-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Far Northeast Fence Works
(
  'cont_fence_ne_006',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Far Northeast Fence Works',
  '5500 Crown Blvd, Denver, CO 80239',
  '(303) 555-9406',
  'https://www.farnortheastfence.com',
  4.7,
  131,
  'far-northeast-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Airport Region Fence Specialists
(
  'cont_fence_ne_007',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Airport Region Fence Specialists',
  '15500 E 40th Ave, Denver, CO 80239',
  '(303) 555-9407',
  'https://www.airportregionfence.com',
  4.8,
  145,
  'airport-region-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Rocky Mountain Arsenal Fence & Design
(
  'cont_fence_ne_008',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Fence & Design',
  '5650 Havana St, Denver, CO 80239',
  '(303) 555-9408',
  'https://www.rmafence.com',
  4.6,
  115,
  'rocky-mountain-arsenal-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Northeast Community Fence Pros
(
  'cont_fence_ne_009',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Northeast Community Fence Pros',
  '4500 Chambers Rd, Denver, CO 80239',
  '(303) 555-9409',
  'https://www.northeastcommunityfence.com',
  4.8,
  154,
  'northeast-community-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Tower Road Fence Solutions
(
  'cont_fence_ne_010',
  'cat_fencing_001',
  'neigh_northeast_001',
  'Tower Road Fence Solutions',
  '4900 Tower Rd, Denver, CO 80249',
  '(303) 555-9410',
  'https://www.towerroadfence.com',
  4.7,
  129,
  'tower-road-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
