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

-- Insert 10 Deck contractors for Park Hill area
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
-- 1. Park Hill Deck Works
(
  'cont_decks_ph_001',
  'cat_decks_001',
  'neigh_park_hill_001',
  'Park Hill Deck Works',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-9301',
  'https://www.parkhilldecks.com',
  4.9,
  177,
  'park-hill-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Deck & Patio
(
  'cont_decks_ph_002',
  'cat_decks_001',
  'neigh_park_hill_001',
  'North Park Hill Deck & Patio',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-9302',
  'https://www.northparkhilldecks.com',
  4.8,
  166,
  'north-park-hill-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Deck Masters
(
  'cont_decks_ph_003',
  'cat_decks_001',
  'neigh_park_hill_001',
  'South Park Hill Deck Masters',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-9303',
  'https://www.southparkhilldecks.com',
  4.7,
  144,
  'south-park-hill-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Monaco Deck Solutions
(
  'cont_decks_ph_004',
  'cat_decks_001',
  'neigh_park_hill_001',
  'Monaco Deck Solutions',
  '2800 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-9304',
  'https://www.monacodecks.com',
  4.8,
  188,
  'monaco-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Historic Park Hill Deck Co
(
  'cont_decks_ph_005',
  'cat_decks_001',
  'neigh_park_hill_001',
  'Historic Park Hill Deck Co',
  '2600 Fairfax St, Denver, CO 80207',
  '(303) 555-9305',
  'https://www.historicparkhilldecks.com',
  4.9,
  199,
  'historic-park-hill-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Northeast Park Hill Deck Works
(
  'cont_decks_ph_006',
  'cat_decks_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Deck Works',
  '3300 Dahlia St, Denver, CO 80207',
  '(303) 555-9306',
  'https://www.nephdecks.com',
  4.7,
  155,
  'northeast-park-hill-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Montview Deck Specialists
(
  'cont_decks_ph_007',
  'cat_decks_001',
  'neigh_park_hill_001',
  'Montview Deck Specialists',
  '2000 Montview Blvd, Denver, CO 80207',
  '(303) 555-9307',
  'https://www.montviewdecks.com',
  4.8,
  166,
  'montview-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. 23rd Avenue Deck & Patio
(
  'cont_decks_ph_008',
  'cat_decks_001',
  'neigh_park_hill_001',
  '23rd Avenue Deck & Patio',
  '2300 23rd Ave, Denver, CO 80207',
  '(303) 555-9308',
  'https://www.23rdavedecks.com',
  4.6,
  133,
  '23rd-avenue-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Greater Park Hill Deck Pros
(
  'cont_decks_ph_009',
  'cat_decks_001',
  'neigh_park_hill_001',
  'Greater Park Hill Deck Pros',
  '2900 Forest St, Denver, CO 80207',
  '(303) 555-9309',
  'https://www.greaterparkhilldecks.com',
  4.8,
  177,
  'greater-park-hill-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Eudora Deck Solutions
(
  'cont_decks_ph_010',
  'cat_decks_001',
  'neigh_park_hill_001',
  'Eudora Deck Solutions',
  '2800 Eudora St, Denver, CO 80207',
  '(303) 555-9310',
  'https://www.eudoradecks.com',
  4.7,
  155,
  'eudora-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
