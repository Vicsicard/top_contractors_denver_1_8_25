-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for Westminster/Arvada area
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
-- 1. Westminster Siding & Gutters
(
  'cont_siding_nw_001',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Westminster Siding & Gutters',
  '7301 Federal Blvd, Westminster, CO 80030',
  '(303) 555-7601',
  'https://www.westminstersiding.com',
  4.9,
  182,
  'westminster-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Exteriors
(
  'cont_siding_nw_002',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Arvada Exteriors',
  '5700 Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-7602',
  'https://www.arvadaexteriors.com',
  4.8,
  165,
  'arvada-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Gutter Masters
(
  'cont_siding_nw_003',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Olde Town Gutter Masters',
  '5600 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-7603',
  'https://www.oldetowngutter.com',
  4.7,
  143,
  'olde-town-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Siding Solutions
(
  'cont_siding_nw_004',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Standley Lake Siding Solutions',
  '8900 W 88th Ave, Westminster, CO 80021',
  '(303) 555-7604',
  'https://www.standleylakesiding.com',
  4.8,
  176,
  'standley-lake-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Wadsworth Gutter Co
(
  'cont_siding_nw_005',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Wadsworth Gutter Co',
  '6900 Wadsworth Blvd, Arvada, CO 80003',
  '(303) 555-7605',
  'https://www.wadsworthgutter.com',
  4.9,
  195,
  'wadsworth-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ralston Creek Siding & Gutters
(
  'cont_siding_nw_006',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Ralston Creek Siding & Gutters',
  '5800 Ralston Rd, Arvada, CO 80002',
  '(303) 555-7606',
  'https://www.ralstoncreeksiding.com',
  4.7,
  134,
  'ralston-creek-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northwest Exterior Specialists
(
  'cont_siding_nw_007',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Northwest Exterior Specialists',
  '7200 W 92nd Ave, Westminster, CO 80021',
  '(303) 555-7607',
  'https://www.northwestexteriors.com',
  4.8,
  156,
  'northwest-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Sheridan Siding & Gutters
(
  'cont_siding_nw_008',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Sheridan Siding & Gutters',
  '5300 Sheridan Blvd, Arvada, CO 80002',
  '(303) 555-7608',
  'https://www.sheridansiding.com',
  4.6,
  122,
  'sheridan-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Kipling Gutter Pros
(
  'cont_siding_nw_009',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Kipling Gutter Pros',
  '6400 Kipling St, Arvada, CO 80004',
  '(303) 555-7609',
  'https://www.kiplinggutter.com',
  4.8,
  167,
  'kipling-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Promenade Siding
(
  'cont_siding_nw_010',
  'cat_siding_001',
  'neigh_west_arvada_001',
  'Promenade Siding',
  '10901 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-7610',
  'https://www.promenadesiding.com',
  4.7,
  145,
  'promenade-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
