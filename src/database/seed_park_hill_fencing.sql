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

-- Ensure Park Hill subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill',
  'park-hill',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_park_hill_001',
  'subreg_park_hill_001',
  'Park Hill',
  'park-hill',
  'Including North Park Hill, South Park Hill, and Northeast Park Hill areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Fencing contractors for Park Hill area
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
-- 1. Park Hill Fence Works
(
  'cont_fence_ph_001',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'Park Hill Fence Works',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-9301',
  'https://www.parkhillfence.com',
  4.9,
  167,
  'park-hill-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Fence & Gate
(
  'cont_fence_ph_002',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'North Park Hill Fence & Gate',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-9302',
  'https://www.northparkhillfence.com',
  4.8,
  143,
  'north-park-hill-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Fence Masters
(
  'cont_fence_ph_003',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'South Park Hill Fence Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-9303',
  'https://www.southparkhillfence.com',
  4.7,
  130,
  'south-park-hill-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Monaco Parkway Fence Solutions
(
  'cont_fence_ph_004',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'Monaco Parkway Fence Solutions',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-9304',
  'https://www.monacoparkwayfence.com',
  4.8,
  157,
  'monaco-parkway-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Historic Park Hill Fence Co
(
  'cont_fence_ph_005',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'Historic Park Hill Fence Co',
  '2345 Dexter St, Denver, CO 80207',
  '(303) 555-9305',
  'https://www.historicparkhillfence.com',
  4.9,
  174,
  'historic-park-hill-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Northeast Park Hill Fence Works
(
  'cont_fence_ph_006',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Fence Works',
  '3600 Dahlia St, Denver, CO 80207',
  '(303) 555-9306',
  'https://www.northeastparkhillfence.com',
  4.7,
  133,
  'northeast-park-hill-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. 23rd Avenue Fence Specialists
(
  'cont_fence_ph_007',
  'cat_fencing_001',
  'neigh_park_hill_001',
  '23rd Avenue Fence Specialists',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-9307',
  'https://www.23rdavenuefence.com',
  4.8,
  147,
  '23rd-avenue-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Montview Fence & Design
(
  'cont_fence_ph_008',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'Montview Fence & Design',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-9308',
  'https://www.montviewfence.com',
  4.6,
  117,
  'montview-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Greater Park Hill Fence Pros
(
  'cont_fence_ph_009',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'Greater Park Hill Fence Pros',
  '2823 Fairfax St, Denver, CO 80207',
  '(303) 555-9309',
  'https://www.greaterparkhillfence.com',
  4.8,
  156,
  'greater-park-hill-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Park Hill Village Fence Solutions
(
  'cont_fence_ph_010',
  'cat_fencing_001',
  'neigh_park_hill_001',
  'Park Hill Village Fence Solutions',
  '2900 Forest St, Denver, CO 80207',
  '(303) 555-9310',
  'https://www.parkhillvillagefence.com',
  4.7,
  131,
  'park-hill-village-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
