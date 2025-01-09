-- Ensure Decks category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_decks_001',
  'Decks',
  'decks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_thorn_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_thorn_north_001',
  'subreg_thorn_north_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Deck contractors for Thornton/Northglenn area
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
-- 1. Thornton Deck Works
(
  'cont_decks_nes_001',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Thornton Deck Works',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-9701',
  'https://www.thorntondecks.com',
  4.9,
  188,
  'thornton-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Deck & Patio
(
  'cont_decks_nes_002',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Northglenn Deck & Patio',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-9702',
  'https://www.northglenndecks.com',
  4.8,
  166,
  'northglenn-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Deck Masters
(
  'cont_decks_nes_003',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Washington Street Deck Masters',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-9703',
  'https://www.washingtondecks.com',
  4.7,
  144,
  'washington-street-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Huron Street Deck Solutions
(
  'cont_decks_nes_004',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Huron Street Deck Solutions',
  '10450 Huron St, Northglenn, CO 80234',
  '(303) 555-9704',
  'https://www.hurondecks.com',
  4.8,
  177,
  'huron-street-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Original Thornton Deck Co
(
  'cont_decks_nes_005',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Original Thornton Deck Co',
  '8800 Pearl St, Thornton, CO 80229',
  '(303) 555-9705',
  'https://www.originalthorntondeck.com',
  4.9,
  199,
  'original-thornton-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 120th Avenue Deck Works
(
  'cont_decks_nes_006',
  'cat_decks_001',
  'neigh_thorn_north_001',
  '120th Avenue Deck Works',
  '2191 E 120th Ave, Thornton, CO 80241',
  '(303) 555-9706',
  'https://www.120thdecks.com',
  4.7,
  155,
  '120th-avenue-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Grant Park Deck Specialists
(
  'cont_decks_nes_007',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Grant Park Deck Specialists',
  '11701 Grant St, Northglenn, CO 80233',
  '(303) 555-9707',
  'https://www.grantparkdecks.com',
  4.8,
  166,
  'grant-park-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Webster Lake Deck & Patio
(
  'cont_decks_nes_008',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Webster Lake Deck & Patio',
  '3501 E 104th Ave, Thornton, CO 80233',
  '(303) 555-9708',
  'https://www.websterlakedecks.com',
  4.6,
  133,
  'webster-lake-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Northeast Deck Pros
(
  'cont_decks_nes_009',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Northeast Deck Pros',
  '12000 Washington Center Pkwy, Thornton, CO 80241',
  '(303) 555-9709',
  'https://www.northeastdeckpros.com',
  4.8,
  177,
  'northeast-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Eastlake Deck Solutions
(
  'cont_decks_nes_010',
  'cat_decks_001',
  'neigh_thorn_north_001',
  'Eastlake Deck Solutions',
  '2255 E 104th Ave, Thornton, CO 80233',
  '(303) 555-9710',
  'https://www.eastlakedecks.com',
  4.7,
  155,
  'eastlake-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
