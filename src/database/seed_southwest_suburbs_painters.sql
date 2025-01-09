-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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

-- Insert 10 Painters for Littleton/Lakewood area
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
-- 1. Littleton Paint Masters
(
  'cont_paint_sws_001',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Littleton Paint Masters',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-5901',
  'https://www.littletonpainting.com',
  4.9,
  167,
  'littleton-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Paint Co
(
  'cont_paint_sws_002',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Lakewood Paint Co',
  '7777 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-5902',
  'https://www.lakewoodpainting.com',
  4.8,
  145,
  'lakewood-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Paint Studio
(
  'cont_paint_sws_003',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Belmar Paint Studio',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-5903',
  'https://www.belmarpainting.com',
  4.7,
  132,
  'belmar-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Paint & Design
(
  'cont_paint_sws_004',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Paint & Design',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-5904',
  'https://www.southwestplazapainting.com',
  4.8,
  156,
  'southwest-plaza-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Paint Pros
(
  'cont_paint_sws_005',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Ken Caryl Paint Pros',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-5905',
  'https://www.kencarylpainting.com',
  4.9,
  178,
  'ken-caryl-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Paint Studio
(
  'cont_paint_sws_006',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Union Boulevard Paint Studio',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-5906',
  'https://www.unionblvdpainting.com',
  4.7,
  134,
  'union-boulevard-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Painters
(
  'cont_paint_sws_007',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Green Mountain Painters',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-5907',
  'https://www.greenmountainpainting.com',
  4.8,
  145,
  'green-mountain-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Paint Co
(
  'cont_paint_sws_008',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Paint Co',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-5908',
  'https://www.historiclittletonpainting.com',
  4.6,
  123,
  'historic-downtown-littleton-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Federal Center Paint Studio
(
  'cont_paint_sws_009',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Federal Center Paint Studio',
  '11000 W 6th Ave, Lakewood, CO 80215',
  '(303) 555-5909',
  'https://www.federalcenterpainting.com',
  4.8,
  156,
  'federal-center-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Bear Creek Paint Masters
(
  'cont_paint_sws_010',
  'cat_paint_001',
  'neigh_lit_lake_001',
  'Bear Creek Paint Masters',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-5910',
  'https://www.bearcreekpainting.com',
  4.7,
  134,
  'bear-creek-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
