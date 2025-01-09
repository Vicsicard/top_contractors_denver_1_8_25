-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumber',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_suburbs_001',
  'Denver Suburbs',
  'denver-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northwest Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_nw_suburbs_001',
  'reg_suburbs_001',
  'Northwest Suburbs',
  'northwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northwest Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_nw_suburbs_001',
  'subreg_nw_suburbs_001',
  'Northwest Suburbs',
  'northwest-suburbs',
  'Including Westminster, Arvada, and Broomfield areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Northwest Suburbs area
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
-- 1. Westminster Premier Plumbing
(
  'cont_plumb_nws_001',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Westminster Premier Plumbing',
  '7301 Federal Blvd, Westminster, CO 80030',
  '(303) 555-0701',
  'https://www.westminsterpremierplumbing.com',
  4.9,
  245,
  'westminster-premier-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Plumbing Masters
(
  'cont_plumb_nws_002',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Arvada Plumbing Masters',
  '5700 Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-0702',
  'https://www.arvadaplumbingmasters.com',
  4.8,
  198,
  'arvada-plumbing-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Broomfield Drain Experts
(
  'cont_plumb_nws_003',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Broomfield Drain Experts',
  '120 US-287, Broomfield, CO 80020',
  '(303) 555-0703',
  'https://www.broomfielddrainexperts.com',
  4.7,
  167,
  'broomfield-drain-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Olde Town Arvada Plumbing
(
  'cont_plumb_nws_004',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Olde Town Arvada Plumbing',
  '5711 Olde Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-0704',
  'https://www.oldetownplumbing.com',
  4.8,
  189,
  'olde-town-arvada-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Flatiron Crossing Plumbers
(
  'cont_plumb_nws_005',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Flatiron Crossing Plumbers',
  '1 W Flatiron Crossing Dr, Broomfield, CO 80021',
  '(303) 555-0705',
  'https://www.flatironcrossingplumbers.com',
  4.9,
  212,
  'flatiron-crossing-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Standley Lake Plumbing Services
(
  'cont_plumb_nws_006',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Standley Lake Plumbing Services',
  '8485 Kipling St, Westminster, CO 80005',
  '(303) 555-0706',
  'https://www.standleylakeplumbing.com',
  4.7,
  178,
  'standley-lake-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Interlocken Plumbing Pros
(
  'cont_plumb_nws_007',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Interlocken Plumbing Pros',
  '280 Interlocken Blvd, Broomfield, CO 80021',
  '(303) 555-0707',
  'https://www.interlockenplumbing.com',
  4.8,
  167,
  'interlocken-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Westminster Mall Area Plumbing
(
  'cont_plumb_nws_008',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Westminster Mall Area Plumbing',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-0708',
  'https://www.westminsterareaplumbing.com',
  4.6,
  156,
  'westminster-mall-area-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Ralston Valley Plumbing
(
  'cont_plumb_nws_009',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Ralston Valley Plumbing',
  '7600 Ralston Rd, Arvada, CO 80002',
  '(303) 555-0709',
  'https://www.ralstonvalleyplumbing.com',
  4.8,
  201,
  'ralston-valley-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Church Ranch Plumbing & Drain
(
  'cont_plumb_nws_010',
  'cat_plumber_001',
  'neigh_nw_suburbs_001',
  'Church Ranch Plumbing & Drain',
  '10425 Town Center Dr, Westminster, CO 80021',
  '(303) 555-0710',
  'https://www.churchranchplumbing.com',
  4.7,
  182,
  'church-ranch-plumbing-drain',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
