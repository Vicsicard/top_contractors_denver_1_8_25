-- Create Decks category
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

-- Ensure Downtown subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_downtown_001',
  'reg_central_001',
  'Downtown Denver',
  'downtown-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Downtown neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_downtown_001',
  'subreg_downtown_001',
  'Downtown Denver',
  'downtown-denver',
  'Including LoDo, Union Station, Central Business District, and Ballpark neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Deck contractors for Downtown Denver area
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
-- 1. LoDo Deck Builders
(
  'cont_decks_dt_001',
  'cat_decks_001',
  'neigh_downtown_001',
  'LoDo Deck Builders',
  '1601 Wewatta St, Denver, CO 80202',
  '(303) 555-9001',
  'https://www.lododecks.com',
  4.9,
  182,
  'lodo-deck-builders',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Custom Decks
(
  'cont_decks_dt_002',
  'cat_decks_001',
  'neigh_downtown_001',
  'Union Station Custom Decks',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-9002',
  'https://www.unionstationdecks.com',
  4.8,
  165,
  'union-station-custom-decks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Deck Masters
(
  'cont_decks_dt_003',
  'cat_decks_001',
  'neigh_downtown_001',
  'Downtown Deck Masters',
  '1600 California St, Denver, CO 80202',
  '(303) 555-9003',
  'https://www.downtowndeckmasters.com',
  4.7,
  143,
  'downtown-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark Deck & Patio
(
  'cont_decks_dt_004',
  'cat_decks_001',
  'neigh_downtown_001',
  'Ballpark Deck & Patio',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-9004',
  'https://www.ballparkdecks.com',
  4.8,
  176,
  'ballpark-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Deck Company
(
  'cont_decks_dt_005',
  'cat_decks_001',
  'neigh_downtown_001',
  '16th Street Deck Company',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-9005',
  'https://www.16thstreetdecks.com',
  4.9,
  195,
  '16th-street-deck-company',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Deck Design
(
  'cont_decks_dt_006',
  'cat_decks_001',
  'neigh_downtown_001',
  'Larimer Square Deck Design',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-9006',
  'https://www.larimersquaredecks.com',
  4.7,
  134,
  'larimer-square-deck-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Deck Specialists
(
  'cont_decks_dt_007',
  'cat_decks_001',
  'neigh_downtown_001',
  'CBD Deck Specialists',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-9007',
  'https://www.cbddecks.com',
  4.8,
  156,
  'cbd-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points Deck & Design
(
  'cont_decks_dt_008',
  'cat_decks_001',
  'neigh_downtown_001',
  'Five Points Deck & Design',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-9008',
  'https://www.fivepointsdecks.com',
  4.6,
  122,
  'five-points-deck-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Deck Pros
(
  'cont_decks_dt_009',
  'cat_decks_001',
  'neigh_downtown_001',
  'RiNo Deck Pros',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-9009',
  'https://www.rinodecks.com',
  4.8,
  167,
  'rino-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park Deck Builders
(
  'cont_decks_dt_010',
  'cat_decks_001',
  'neigh_downtown_001',
  'Commons Park Deck Builders',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-9010',
  'https://www.commonsparkdecks.com',
  4.7,
  145,
  'commons-park-deck-builders',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
