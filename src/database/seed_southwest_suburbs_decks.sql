-- Ensure Decks category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_decks_001',
  'Decks',
  'decks',
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

-- Insert 10 Deck contractors for Littleton/Lakewood area
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
-- 1. Littleton Deck Works
(
  'cont_decks_sws_001',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Littleton Deck Works',
  '2255 W Main St, Littleton, CO 80120',
  '(303) 555-9901',
  'https://www.littletondecks.com',
  4.9,
  188,
  'littleton-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Deck & Patio
(
  'cont_decks_sws_002',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Lakewood Deck & Patio',
  '7155 W Alameda Ave, Lakewood, CO 80226',
  '(303) 555-9902',
  'https://www.lakewooddecks.com',
  4.8,
  166,
  'lakewood-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Deck Masters
(
  'cont_decks_sws_003',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Belmar Deck Masters',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-9903',
  'https://www.belmardecks.com',
  4.7,
  144,
  'belmar-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southwest Plaza Deck Solutions
(
  'cont_decks_sws_004',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Southwest Plaza Deck Solutions',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-9904',
  'https://www.southwestplazadecks.com',
  4.8,
  177,
  'southwest-plaza-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ken Caryl Deck Co
(
  'cont_decks_sws_005',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Ken Caryl Deck Co',
  '7981 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-9905',
  'https://www.kencaryldecks.com',
  4.9,
  199,
  'ken-caryl-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Union Boulevard Deck Works
(
  'cont_decks_sws_006',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Union Boulevard Deck Works',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-9906',
  'https://www.unionblvddecks.com',
  4.7,
  155,
  'union-boulevard-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Deck Specialists
(
  'cont_decks_sws_007',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Green Mountain Deck Specialists',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-9907',
  'https://www.greenmountaindecks.com',
  4.8,
  166,
  'green-mountain-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Historic Downtown Littleton Deck
(
  'cont_decks_sws_008',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Historic Downtown Littleton Deck',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-9908',
  'https://www.historiclittletondecks.com',
  4.6,
  133,
  'historic-downtown-littleton-deck',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Bear Creek Deck Pros
(
  'cont_decks_sws_009',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Bear Creek Deck Pros',
  '3101 S Kipling Pkwy, Lakewood, CO 80227',
  '(303) 555-9909',
  'https://www.bearcreekdecks.com',
  4.8,
  177,
  'bear-creek-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Deck Solutions
(
  'cont_decks_sws_010',
  'cat_decks_001',
  'neigh_lit_lake_001',
  'Columbine Deck Solutions',
  '6777 W Ken Caryl Ave, Littleton, CO 80128',
  '(303) 555-9910',
  'https://www.columbinedecks.com',
  4.7,
  155,
  'columbine-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
