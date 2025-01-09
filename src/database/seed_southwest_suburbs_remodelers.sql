-- Ensure Home Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
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

-- Insert 10 Home Remodelers for Littleton/Lakewood area
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
-- 1. Littleton Design Masters
(
  'cont_remod_sws_001',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Littleton Design Masters',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-7901',
  'https://www.littletondesignmasters.com',
  4.9,
  189,
  'littleton-design-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Belmar Renovation Co
(
  'cont_remod_sws_002',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Belmar Renovation Co',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-7902',
  'https://www.belmarrenovation.com',
  4.8,
  167,
  'belmar-renovation-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southwest Plaza Design Build
(
  'cont_remod_sws_003',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Design Build',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-7903',
  'https://www.southwestplazadesign.com',
  4.7,
  145,
  'southwest-plaza-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ken Caryl Remodeling
(
  'cont_remod_sws_004',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Ken Caryl Remodeling',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-7904',
  'https://www.kencarylremodeling.com',
  4.8,
  156,
  'ken-caryl-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Union Boulevard Design Studio
(
  'cont_remod_sws_005',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Union Boulevard Design Studio',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-7905',
  'https://www.unionblvddesign.com',
  4.9,
  178,
  'union-boulevard-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Green Mountain Remodeling
(
  'cont_remod_sws_006',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Green Mountain Remodeling',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-7906',
  'https://www.greenmountainremodeling.com',
  4.7,
  134,
  'green-mountain-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Historic Downtown Littleton Design
(
  'cont_remod_sws_007',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Design',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-7907',
  'https://www.historiclittletondesign.com',
  4.8,
  145,
  'historic-downtown-littleton-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Federal Center Renovations
(
  'cont_remod_sws_008',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Federal Center Renovations',
  '11000 W 6th Ave, Lakewood, CO 80215',
  '(303) 555-7908',
  'https://www.federalcenterrenovations.com',
  4.6,
  123,
  'federal-center-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Design Build
(
  'cont_remod_sws_009',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Bear Creek Design Build',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-7909',
  'https://www.bearcreekdesignbuild.com',
  4.8,
  167,
  'bear-creek-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Remodeling
(
  'cont_remod_sws_010',
  'cat_remod_001',
  'neigh_lit_lake_001',
  'Columbine Remodeling',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-7910',
  'https://www.columbineremodeling.com',
  4.7,
  145,
  'columbine-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
