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

-- Create Central Parks subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_parks_001',
  'reg_central_001',
  'Central Parks',
  'central-parks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Central Parks neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_parks_001',
  'subreg_central_parks_001',
  'Central Parks',
  'central-parks',
  'Including City Park, City Park West, Congress Park, and Cheesman Park areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Deck contractors for Central Parks area
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
-- 1. City Park Deck Works
(
  'cont_decks_cp_001',
  'cat_decks_001',
  'neigh_central_parks_001',
  'City Park Deck Works',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-9101',
  'https://www.cityparkdecks.com',
  4.9,
  177,
  'city-park-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Deck & Patio
(
  'cont_decks_cp_002',
  'cat_decks_001',
  'neigh_central_parks_001',
  'Cheesman Park Deck & Patio',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-9102',
  'https://www.cheesmandecks.com',
  4.8,
  155,
  'cheesman-park-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Deck Masters
(
  'cont_decks_cp_003',
  'cat_decks_001',
  'neigh_central_parks_001',
  'Congress Park Deck Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-9103',
  'https://www.congressdecks.com',
  4.7,
  144,
  'congress-park-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Deck Solutions
(
  'cont_decks_cp_004',
  'cat_decks_001',
  'neigh_central_parks_001',
  'Zoo Area Deck Solutions',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-9104',
  'https://www.zooareadecks.com',
  4.8,
  166,
  'zoo-area-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Deck Co
(
  'cont_decks_cp_005',
  'cat_decks_001',
  'neigh_central_parks_001',
  'Museum District Deck Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-9105',
  'https://www.museumdistrictdecks.com',
  4.9,
  188,
  'museum-district-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Deck Works
(
  'cont_decks_cp_006',
  'cat_decks_001',
  'neigh_central_parks_001',
  'Botanic Gardens Deck Works',
  '1007 York St, Denver, CO 80206',
  '(303) 555-9106',
  'https://www.botanicgardensdecks.com',
  4.7,
  133,
  'botanic-gardens-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Deck Specialists
(
  'cont_decks_cp_007',
  'cat_decks_001',
  'neigh_central_parks_001',
  'East High Deck Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-9107',
  'https://www.easthighdecks.com',
  4.8,
  155,
  'east-high-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Deck & Patio
(
  'cont_decks_cp_008',
  'cat_decks_001',
  'neigh_central_parks_001',
  'City Park West Deck & Patio',
  '2199 California St, Denver, CO 80205',
  '(303) 555-9108',
  'https://www.cityparkwestdecks.com',
  4.6,
  122,
  'city-park-west-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Deck Pros
(
  'cont_decks_cp_009',
  'cat_decks_001',
  'neigh_central_parks_001',
  'Park Avenue Deck Pros',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-9109',
  'https://www.parkavenuedecks.com',
  4.8,
  167,
  'park-avenue-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Deck Solutions
(
  'cont_decks_cp_010',
  'cat_decks_001',
  'neigh_central_parks_001',
  'Esplanade Deck Solutions',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-9110',
  'https://www.esplanadedecks.com',
  4.7,
  144,
  'esplanade-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
