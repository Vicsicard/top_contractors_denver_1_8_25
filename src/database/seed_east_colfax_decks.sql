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

-- Ensure East Colfax subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_east_colfax_001',
  'reg_east_001',
  'East Colfax',
  'east-colfax',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Colfax neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_east_colfax_001',
  'subreg_east_colfax_001',
  'East Colfax',
  'east-colfax',
  'Including East Colfax corridor and surrounding neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Deck contractors for East Colfax area
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
-- 1. East Colfax Deck Works
(
  'cont_decks_ec_001',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'East Colfax Deck Works',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-9501',
  'https://www.eastcolfaxdecks.com',
  4.9,
  188,
  'east-colfax-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Deck & Patio
(
  'cont_decks_ec_002',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Mayfair Deck & Patio',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-9502',
  'https://www.mayfairdecks.com',
  4.8,
  166,
  'mayfair-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Deck Masters
(
  'cont_decks_ec_003',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Montclair Deck Masters',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-9503',
  'https://www.montclairdecks.com',
  4.7,
  144,
  'montclair-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Lowry Field Deck Solutions
(
  'cont_decks_ec_004',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Lowry Field Deck Solutions',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-9504',
  'https://www.lowryfielddecks.com',
  4.8,
  177,
  'lowry-field-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Hale Deck Co
(
  'cont_decks_ec_005',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Hale Deck Co',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-9505',
  'https://www.haledecks.com',
  4.9,
  199,
  'hale-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Aurora Boundary Deck Works
(
  'cont_decks_ec_006',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Aurora Boundary Deck Works',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-9506',
  'https://www.auroraboundarydecks.com',
  4.7,
  155,
  'aurora-boundary-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Quebec Street Deck Specialists
(
  'cont_decks_ec_007',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Quebec Street Deck Specialists',
  '7300 E Colfax Ave, Denver, CO 80220',
  '(303) 555-9507',
  'https://www.quebecstreetdecks.com',
  4.8,
  166,
  'quebec-street-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Syracuse Street Deck & Patio
(
  'cont_decks_ec_008',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Syracuse Street Deck & Patio',
  '1700 Syracuse St, Denver, CO 80220',
  '(303) 555-9508',
  'https://www.syracusedecks.com',
  4.6,
  133,
  'syracuse-street-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. East Side Deck Pros
(
  'cont_decks_ec_009',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'East Side Deck Pros',
  '8500 E Colfax Ave, Denver, CO 80220',
  '(303) 555-9509',
  'https://www.eastsidedecks.com',
  4.8,
  177,
  'east-side-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Yosemite Deck Solutions
(
  'cont_decks_ec_010',
  'cat_decks_001',
  'neigh_east_colfax_001',
  'Yosemite Deck Solutions',
  '1800 Yosemite St, Denver, CO 80220',
  '(303) 555-9510',
  'https://www.yosemitedecks.com',
  4.7,
  155,
  'yosemite-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
