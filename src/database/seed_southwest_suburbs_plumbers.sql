-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumber',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Suburbs region exists (same as previous)
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_suburbs_001',
  'Denver Suburbs',
  'denver-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southwest Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_sw_suburbs_001',
  'reg_suburbs_001',
  'Southwest Suburbs',
  'southwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southwest Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_sw_suburbs_001',
  'subreg_sw_suburbs_001',
  'Southwest Suburbs',
  'southwest-suburbs',
  'Including Littleton, Lakewood, and surrounding areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Southwest Suburbs area
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
-- 1. Littleton Downtown Plumbing
(
  'cont_plumb_sws_001',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Littleton Downtown Plumbing',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-1001',
  'https://www.littletondowntownplumbing.com',
  4.9,
  245,
  'littleton-downtown-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Belmar Lakewood Plumbers
(
  'cont_plumb_sws_002',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Belmar Lakewood Plumbers',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-1002',
  'https://www.belmarplumbers.com',
  4.8,
  198,
  'belmar-lakewood-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southwest Plaza Plumbing Services
(
  'cont_plumb_sws_003',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Southwest Plaza Plumbing Services',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-1003',
  'https://www.southwestplazaplumbing.com',
  4.7,
  167,
  'southwest-plaza-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Green Mountain Area Plumbing
(
  'cont_plumb_sws_004',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Green Mountain Area Plumbing',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-1004',
  'https://www.greenmountainplumbing.com',
  4.8,
  189,
  'green-mountain-area-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Plumbing Experts
(
  'cont_plumb_sws_005',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Ken Caryl Plumbing Experts',
  '7731 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-1005',
  'https://www.kencarylplumbing.com',
  4.9,
  212,
  'ken-caryl-plumbing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Plumbing
(
  'cont_plumb_sws_006',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Union Boulevard Plumbing',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-1006',
  'https://www.unionblvdplumbing.com',
  4.7,
  178,
  'union-boulevard-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Columbine Valley Plumbing
(
  'cont_plumb_sws_007',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Columbine Valley Plumbing',
  '6691 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-1007',
  'https://www.columbinevalleyplumbing.com',
  4.8,
  167,
  'columbine-valley-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Federal Center Plumbing Pros
(
  'cont_plumb_sws_008',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Federal Center Plumbing Pros',
  '11000 W 6th Ave, Lakewood, CO 80215',
  '(303) 555-1008',
  'https://www.federalcenterplumbing.com',
  4.6,
  156,
  'federal-center-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Chatfield Area Plumbing
(
  'cont_plumb_sws_009',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Chatfield Area Plumbing',
  '11500 N Roxborough Park Rd, Littleton, CO 80125',
  '(303) 555-1009',
  'https://www.chatfieldareaplumbing.com',
  4.8,
  201,
  'chatfield-area-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Bear Creek Plumbing & Drain
(
  'cont_plumb_sws_010',
  'cat_plumber_001',
  'neigh_sw_suburbs_001',
  'Bear Creek Plumbing & Drain',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-1010',
  'https://www.bearcreekplumbing.com',
  4.7,
  182,
  'bear-creek-plumbing-drain',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
