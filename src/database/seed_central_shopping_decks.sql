-- Ensure Decks category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_decks_001',
  'Decks',
  'decks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Shopping subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_shopping_001',
  'reg_central_001',
  'Central Shopping',
  'central-shopping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Shopping neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_shopping_001',
  'subreg_central_shopping_001',
  'Central Shopping',
  'central-shopping',
  'Including Cherry Creek, Lincoln Park, and North Capitol Hill shopping districts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Deck contractors for Central Shopping area
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
-- 1. Cherry Creek Deck Works
(
  'cont_decks_cs_001',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Cherry Creek Deck Works',
  '2800 E 1st Ave, Denver, CO 80206',
  '(303) 555-9201',
  'https://www.cherrycreekdecks.com',
  4.9,
  188,
  'cherry-creek-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lincoln Park Deck & Patio
(
  'cont_decks_cs_002',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Lincoln Park Deck & Patio',
  '1100 Santa Fe Dr, Denver, CO 80204',
  '(303) 555-9202',
  'https://www.lincolnparkdecks.com',
  4.8,
  166,
  'lincoln-park-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. North Cap Hill Deck Masters
(
  'cont_decks_cs_003',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'North Cap Hill Deck Masters',
  '1400 Pearl St, Denver, CO 80203',
  '(303) 555-9203',
  'https://www.northcaphilldecks.com',
  4.7,
  144,
  'north-cap-hill-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Shopping District Deck Solutions
(
  'cont_decks_cs_004',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Shopping District Deck Solutions',
  '3000 E 3rd Ave, Denver, CO 80206',
  '(303) 555-9204',
  'https://www.shoppingdistrictdecks.com',
  4.8,
  177,
  'shopping-district-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Retail Row Deck Co
(
  'cont_decks_cs_005',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Retail Row Deck Co',
  '2899 N Speer Blvd, Denver, CO 80211',
  '(303) 555-9205',
  'https://www.retailrowdecks.com',
  4.9,
  188,
  'retail-row-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Golden Triangle Deck Works
(
  'cont_decks_cs_006',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Golden Triangle Deck Works',
  '1200 Broadway, Denver, CO 80203',
  '(303) 555-9206',
  'https://www.goldentriangledecks.com',
  4.7,
  155,
  'golden-triangle-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Cherry Creek North Deck Specialists
(
  'cont_decks_cs_007',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Cherry Creek North Deck Specialists',
  '2930 E 2nd Ave, Denver, CO 80206',
  '(303) 555-9207',
  'https://www.cherrycreeknorthdecks.com',
  4.8,
  166,
  'cherry-creek-north-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Art District Deck & Patio
(
  'cont_decks_cs_008',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Art District Deck & Patio',
  '855 Inca St, Denver, CO 80204',
  '(303) 555-9208',
  'https://www.artdistrictdecks.com',
  4.6,
  133,
  'art-district-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Uptown Deck Pros
(
  'cont_decks_cs_009',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Uptown Deck Pros',
  '1600 Pearl St, Denver, CO 80203',
  '(303) 555-9209',
  'https://www.uptowndecks.com',
  4.8,
  177,
  'uptown-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Mall District Deck Solutions
(
  'cont_decks_cs_010',
  'cat_decks_001',
  'neigh_central_shopping_001',
  'Mall District Deck Solutions',
  '3000 E 1st Ave, Denver, CO 80206',
  '(303) 555-9210',
  'https://www.malldistrictdecks.com',
  4.7,
  155,
  'mall-district-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
