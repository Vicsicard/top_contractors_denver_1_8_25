-- Ensure Decks category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_decks_001',
  'Decks',
  'decks',
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

-- Insert 10 Deck contractors for Northeast Denver area
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
-- 1. Montbello Deck Works
(
  'cont_decks_ne_001',
  'cat_decks_001',
  'neigh_northeast_001',
  'Montbello Deck Works',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-9401',
  'https://www.montbellodecks.com',
  4.9,
  188,
  'montbello-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Deck & Patio
(
  'cont_decks_ne_002',
  'cat_decks_001',
  'neigh_northeast_001',
  'Green Valley Ranch Deck & Patio',
  '18501 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-9402',
  'https://www.gvrdecks.com',
  4.8,
  166,
  'green-valley-ranch-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Deck Masters
(
  'cont_decks_ne_003',
  'cat_decks_001',
  'neigh_northeast_001',
  'Gateway Deck Masters',
  '4855 N Salida St, Denver, CO 80239',
  '(303) 555-9403',
  'https://www.gatewaydecks.com',
  4.7,
  144,
  'gateway-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Area Deck Solutions
(
  'cont_decks_ne_004',
  'cat_decks_001',
  'neigh_northeast_001',
  'DIA Area Deck Solutions',
  '16001 E 40th Ave, Denver, CO 80239',
  '(303) 555-9404',
  'https://www.diadecks.com',
  4.8,
  177,
  'dia-area-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Rocky Mountain Arsenal Deck Co
(
  'cont_decks_ne_005',
  'cat_decks_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Deck Co',
  '5650 Havana St, Denver, CO 80239',
  '(303) 555-9405',
  'https://www.rmadecks.com',
  4.9,
  199,
  'rocky-mountain-arsenal-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Peña Boulevard Deck Works
(
  'cont_decks_ne_006',
  'cat_decks_001',
  'neigh_northeast_001',
  'Peña Boulevard Deck Works',
  '16200 E 40th Ave, Denver, CO 80239',
  '(303) 555-9406',
  'https://www.penablvddecks.com',
  4.7,
  155,
  'pena-boulevard-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Tower Road Deck Specialists
(
  'cont_decks_ne_007',
  'cat_decks_001',
  'neigh_northeast_001',
  'Tower Road Deck Specialists',
  '18890 E 47th Ave, Denver, CO 80249',
  '(303) 555-9407',
  'https://www.towerroaddecks.com',
  4.8,
  166,
  'tower-road-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Chambers Road Deck & Patio
(
  'cont_decks_ne_008',
  'cat_decks_001',
  'neigh_northeast_001',
  'Chambers Road Deck & Patio',
  '4500 Chambers Rd, Denver, CO 80239',
  '(303) 555-9408',
  'https://www.chambersdecks.com',
  4.6,
  133,
  'chambers-road-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Northeast Denver Deck Pros
(
  'cont_decks_ne_009',
  'cat_decks_001',
  'neigh_northeast_001',
  'Northeast Denver Deck Pros',
  '5200 Havana St, Denver, CO 80239',
  '(303) 555-9409',
  'https://www.northeastdenverdecks.com',
  4.8,
  177,
  'northeast-denver-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Airport Way Deck Solutions
(
  'cont_decks_ne_010',
  'cat_decks_001',
  'neigh_northeast_001',
  'Airport Way Deck Solutions',
  '16000 E Smith Rd, Denver, CO 80239',
  '(303) 555-9410',
  'https://www.airportwaydecks.com',
  4.7,
  155,
  'airport-way-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
