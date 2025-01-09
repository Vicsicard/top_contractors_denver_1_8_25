-- Ensure Epoxy Garage category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
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
  'subreg_west_arv_001',
  'reg_nw_suburbs_001',
  'Westminster/Arvada',
  'westminster-arvada',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Westminster/Arvada neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_west_arv_001',
  'subreg_west_arv_001',
  'Westminster/Arvada',
  'westminster-arvada',
  'Including Westminster, Arvada, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Epoxy Garage contractors for Westminster/Arvada area
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
-- 1. Westminster Epoxy Solutions
(
  'cont_epoxy_nw_001',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Westminster Epoxy Solutions',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-7601',
  'https://www.westminsterepoxy.com',
  4.9,
  157,
  'westminster-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Garage Coatings
(
  'cont_epoxy_nw_002',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Arvada Garage Coatings',
  '7525 Ralston Rd, Arvada, CO 80002',
  '(303) 555-7602',
  'https://www.arvadaepoxy.com',
  4.8,
  142,
  'arvada-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Epoxy Masters
(
  'cont_epoxy_nw_003',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Olde Town Epoxy Masters',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-7603',
  'https://www.oldetownepoxy.com',
  4.7,
  128,
  'olde-town-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Garage Solutions
(
  'cont_epoxy_nw_004',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Standley Lake Garage Solutions',
  '8901 W 100th Ave, Westminster, CO 80021',
  '(303) 555-7604',
  'https://www.standleylakeepoxy.com',
  4.8,
  147,
  'standley-lake-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Promenade Epoxy Pro
(
  'cont_epoxy_nw_005',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Promenade Epoxy Pro',
  '10601 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-7605',
  'https://www.promenadeepoxy.com',
  4.9,
  160,
  'promenade-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ralston Valley Garage Finishes
(
  'cont_epoxy_nw_006',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Ralston Valley Garage Finishes',
  '6701 W 84th Ave, Arvada, CO 80003',
  '(303) 555-7606',
  'https://www.ralstonvalleyepoxy.com',
  4.7,
  123,
  'ralston-valley-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Church Ranch Epoxy Specialists
(
  'cont_epoxy_nw_007',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Church Ranch Epoxy Specialists',
  '10050 Wadsworth Pkwy, Westminster, CO 80021',
  '(303) 555-7607',
  'https://www.churchranchepoxy.com',
  4.8,
  136,
  'church-ranch-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Candelas Garage Coatings
(
  'cont_epoxy_nw_008',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Candelas Garage Coatings',
  '9355 Candelas Pkwy, Arvada, CO 80007',
  '(303) 555-7608',
  'https://www.candelasepoxy.com',
  4.6,
  109,
  'candelas-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Interlocken Epoxy Pros
(
  'cont_epoxy_nw_009',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Interlocken Epoxy Pros',
  '8001 Arista Pl, Broomfield, CO 80021',
  '(303) 555-7609',
  'https://www.interlockenepoxy.com',
  4.8,
  145,
  'interlocken-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Front Range Garage Solutions
(
  'cont_epoxy_nw_010',
  'cat_epoxy_001',
  'neigh_west_arv_001',
  'Front Range Garage Solutions',
  '7315 Grandview Ave, Arvada, CO 80002',
  '(303) 555-7610',
  'https://www.frontrangeepoxy.com',
  4.7,
  130,
  'front-range-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
