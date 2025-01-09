-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northwest Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_nw_suburbs_001',
  'Northwest Suburbs',
  'northwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northwest Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_nw_suburbs_001',
  'reg_nw_suburbs_001',
  'Westminster/Arvada Area',
  'westminster-arvada-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northwest Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_nw_suburbs_001',
  'subreg_nw_suburbs_001',
  'Westminster/Arvada',
  'westminster-arvada',
  'Including Westminster, Arvada, and Broomfield areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 electricians for Northwest Suburbs area
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
-- 1. Westminster Electric Masters
(
  'cont_elec_nw_001',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Westminster Electric Masters',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-2601',
  'https://www.westminsterelectric.com',
  4.9,
  234,
  'westminster-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Electrical Solutions
(
  'cont_elec_nw_002',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Arvada Electrical Solutions',
  '7525 Ralston Rd, Arvada, CO 80002',
  '(303) 555-2602',
  'https://www.arvadaelectrical.com',
  4.8,
  198,
  'arvada-electrical-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Broomfield Electric Experts
(
  'cont_elec_nw_003',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Broomfield Electric Experts',
  '120 Edgeview Dr, Broomfield, CO 80020',
  '(303) 555-2603',
  'https://www.broomfieldelectric.com',
  4.7,
  167,
  'broomfield-electric-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Olde Town Arvada Electric
(
  'cont_elec_nw_004',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Olde Town Arvada Electric',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-2604',
  'https://www.oldetownelectric.com',
  4.8,
  189,
  'olde-town-arvada-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Westminster Mall Electric
(
  'cont_elec_nw_005',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Westminster Mall Electric',
  '5501 W 88th Ave, Westminster, CO 80031',
  '(303) 555-2605',
  'https://www.westminstermallelectric.com',
  4.6,
  156,
  'westminster-mall-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Interlocken Electric
(
  'cont_elec_nw_006',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Interlocken Electric',
  '280 Interlocken Blvd, Broomfield, CO 80021',
  '(303) 555-2606',
  'https://www.interlockenelectric.com',
  4.9,
  212,
  'interlocken-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Standley Lake Electrical
(
  'cont_elec_nw_007',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Standley Lake Electrical',
  '9785 Standley Lake Dr, Westminster, CO 80021',
  '(303) 555-2607',
  'https://www.standleylakeelectric.com',
  4.8,
  167,
  'standley-lake-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Rocky Flats Electric
(
  'cont_elec_nw_008',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Rocky Flats Electric',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-2608',
  'https://www.rockyflatselectric.com',
  4.7,
  178,
  'rocky-flats-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Federal Heights Electric
(
  'cont_elec_nw_009',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Federal Heights Electric',
  '2800 W 92nd Ave, Federal Heights, CO 80260',
  '(303) 555-2609',
  'https://www.federalheightselectric.com',
  4.8,
  201,
  'federal-heights-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Northwest Parkway Electric
(
  'cont_elec_nw_010',
  'cat_elec_001',
  'neigh_nw_suburbs_001',
  'Northwest Parkway Electric',
  '11802 Ridge Pkwy, Broomfield, CO 80021',
  '(303) 555-2610',
  'https://www.northwestparkwayelectric.com',
  4.7,
  182,
  'northwest-parkway-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
