-- Ensure Kitchen Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
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

-- Insert 10 Kitchen Remodelers for Littleton/Lakewood area
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
-- 1. Littleton Kitchen Design
(
  'cont_kitchen_sws_001',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Littleton Kitchen Design',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-9901',
  'https://www.littletonkitchen.com',
  4.9,
  188,
  'littleton-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Kitchen & Cabinets
(
  'cont_kitchen_sws_002',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Lakewood Kitchen & Cabinets',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-9902',
  'https://www.lakewoodkitchen.com',
  4.8,
  166,
  'lakewood-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Kitchen Masters
(
  'cont_kitchen_sws_003',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Belmar Kitchen Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-9903',
  'https://www.belmarkitchen.com',
  4.7,
  144,
  'belmar-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Kitchen Co
(
  'cont_kitchen_sws_004',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Kitchen Co',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-9904',
  'https://www.southwestplazakitchen.com',
  4.8,
  177,
  'southwest-plaza-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Kitchen Studio
(
  'cont_kitchen_sws_005',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Ken Caryl Kitchen Studio',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-9905',
  'https://www.kencarylkitchen.com',
  4.9,
  199,
  'ken-caryl-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Kitchen Design
(
  'cont_kitchen_sws_006',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Union Boulevard Kitchen Design',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-9906',
  'https://www.unionblvdkitchen.com',
  4.7,
  155,
  'union-boulevard-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Kitchen Co
(
  'cont_kitchen_sws_007',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Green Mountain Kitchen Co',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-9907',
  'https://www.greenmountainkitchen.com',
  4.8,
  166,
  'green-mountain-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Kitchen
(
  'cont_kitchen_sws_008',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Kitchen',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-9908',
  'https://www.historiclittletonkitchen.com',
  4.6,
  133,
  'historic-downtown-littleton-kitchen',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Kitchen Specialists
(
  'cont_kitchen_sws_009',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Bear Creek Kitchen Specialists',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-9909',
  'https://www.bearcreekkitchen.com',
  4.8,
  177,
  'bear-creek-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Kitchen Design
(
  'cont_kitchen_sws_010',
  'cat_kitchen_001',
  'neigh_lit_lake_001',
  'Columbine Kitchen Design',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-9910',
  'https://www.columbinekitchen.com',
  4.7,
  155,
  'columbine-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
