-- Ensure Decks category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_decks_001',
  'Decks',
  'decks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northwest Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_nw_suburbs_001',
  'Northwest Suburbs',
  'northwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Westminster/Arvada subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_west_arvada_001',
  'reg_nw_suburbs_001',
  'Westminster/Arvada',
  'westminster-arvada',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Westminster/Arvada neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_west_arvada_001',
  'subreg_west_arvada_001',
  'Westminster/Arvada',
  'westminster-arvada',
  'Including Westminster, Arvada, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Deck contractors for Westminster/Arvada area
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
-- 1. Westminster Deck Works
(
  'cont_decks_nw_001',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Westminster Deck Works',
  '7301 Federal Blvd, Westminster, CO 80030',
  '(303) 555-9601',
  'https://www.westminsterdecks.com',
  4.9,
  188,
  'westminster-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Deck & Patio
(
  'cont_decks_nw_002',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Arvada Deck & Patio',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-9602',
  'https://www.arvadadecks.com',
  4.8,
  166,
  'arvada-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Deck Masters
(
  'cont_decks_nw_003',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Olde Town Deck Masters',
  '5600 Olde Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-9603',
  'https://www.oldetowndecks.com',
  4.7,
  144,
  'olde-town-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Deck Solutions
(
  'cont_decks_nw_004',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Standley Lake Deck Solutions',
  '8900 W 88th Ave, Westminster, CO 80021',
  '(303) 555-9604',
  'https://www.standleylakedecks.com',
  4.8,
  177,
  'standley-lake-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ralston Valley Deck Co
(
  'cont_decks_nw_005',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Ralston Valley Deck Co',
  '7600 W 64th Ave, Arvada, CO 80004',
  '(303) 555-9605',
  'https://www.ralstonvalleydecks.com',
  4.9,
  199,
  'ralston-valley-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Church Ranch Deck Works
(
  'cont_decks_nw_006',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Church Ranch Deck Works',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-9606',
  'https://www.churchranchdecks.com',
  4.7,
  155,
  'church-ranch-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Kipling Deck Specialists
(
  'cont_decks_nw_007',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Kipling Deck Specialists',
  '6400 Kipling St, Arvada, CO 80004',
  '(303) 555-9607',
  'https://www.kiplingdecks.com',
  4.8,
  166,
  'kipling-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Sheridan Deck & Patio
(
  'cont_decks_nw_008',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Sheridan Deck & Patio',
  '7301 Sheridan Blvd, Westminster, CO 80030',
  '(303) 555-9608',
  'https://www.sheridandecks.com',
  4.6,
  133,
  'sheridan-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Northwest Deck Pros
(
  'cont_decks_nw_009',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Northwest Deck Pros',
  '9200 W 58th Ave, Arvada, CO 80002',
  '(303) 555-9609',
  'https://www.northwestdeckpros.com',
  4.8,
  177,
  'northwest-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Promenade Deck Solutions
(
  'cont_decks_nw_010',
  'cat_decks_001',
  'neigh_west_arvada_001',
  'Promenade Deck Solutions',
  '10801 Town Center Dr, Westminster, CO 80021',
  '(303) 555-9610',
  'https://www.promenadedecks.com',
  4.7,
  155,
  'promenade-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
