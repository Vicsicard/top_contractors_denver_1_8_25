-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Southwest Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_sw_suburbs_001',
  'Southwest Suburbs',
  'southwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Littleton/Lakewood subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_lit_lake_001',
  'reg_sw_suburbs_001',
  'Littleton/Lakewood',
  'littleton-lakewood',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Littleton/Lakewood neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_lit_lake_001',
  'subreg_lit_lake_001',
  'Littleton/Lakewood',
  'littleton-lakewood',
  'Including Littleton, Lakewood, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Fencing contractors for Littleton/Lakewood area
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
-- 1. Littleton Fence Works
(
  'cont_fence_sws_001',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Littleton Fence Works',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-9901',
  'https://www.littletonfence.com',
  4.9,
  170,
  'littleton-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Fence & Gate
(
  'cont_fence_sws_002',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Lakewood Fence & Gate',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-9902',
  'https://www.lakewoodfence.com',
  4.8,
  145,
  'lakewood-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Fence Masters
(
  'cont_fence_sws_003',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Belmar Fence Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-9903',
  'https://www.belmarfence.com',
  4.7,
  131,
  'belmar-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Fence Solutions
(
  'cont_fence_sws_004',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Fence Solutions',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-9904',
  'https://www.southwestplazafence.com',
  4.8,
  158,
  'southwest-plaza-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Fence Co
(
  'cont_fence_sws_005',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Ken Caryl Fence Co',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-9905',
  'https://www.kencaryllfence.com',
  4.9,
  175,
  'ken-caryl-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Fence Works
(
  'cont_fence_sws_006',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Union Boulevard Fence Works',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-9906',
  'https://www.unionblvdfence.com',
  4.7,
  134,
  'union-boulevard-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Fence Specialists
(
  'cont_fence_sws_007',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Green Mountain Fence Specialists',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-9907',
  'https://www.greenmountainfence.com',
  4.8,
  148,
  'green-mountain-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Fence & Design
(
  'cont_fence_sws_008',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Fence & Design',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-9908',
  'https://www.historiclittletonfence.com',
  4.6,
  118,
  'historic-downtown-littleton-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Fence Pros
(
  'cont_fence_sws_009',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Bear Creek Fence Pros',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-9909',
  'https://www.bearcreekfence.com',
  4.8,
  157,
  'bear-creek-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Fence Solutions
(
  'cont_fence_sws_010',
  'cat_fencing_001',
  'neigh_lit_lake_001',
  'Columbine Fence Solutions',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-9910',
  'https://www.columbinefence.com',
  4.7,
  132,
  'columbine-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
