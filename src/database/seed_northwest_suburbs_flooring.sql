-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for Westminster/Arvada area
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
-- 1. Westminster Flooring Works
(
  'cont_floor_nw_001',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Westminster Flooring Works',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-7601',
  'https://www.westminsterflooring.com',
  4.9,
  172,
  'westminster-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Floor & Tile
(
  'cont_floor_nw_002',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Arvada Floor & Tile',
  '7525 W 57th Ave, Arvada, CO 80002',
  '(303) 555-7602',
  'https://www.arvadaflooring.com',
  4.8,
  150,
  'arvada-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Floor Masters
(
  'cont_floor_nw_003',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Olde Town Floor Masters',
  '5711 Olde Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-7603',
  'https://www.oldetownflooring.com',
  4.7,
  135,
  'olde-town-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Flooring Solutions
(
  'cont_floor_nw_004',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Standley Lake Flooring Solutions',
  '8901 W 100th Ave, Westminster, CO 80021',
  '(303) 555-7604',
  'https://www.standleylakeflooring.com',
  4.8,
  162,
  'standley-lake-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Promenade Floor Co
(
  'cont_floor_nw_005',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Promenade Floor Co',
  '10601 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-7605',
  'https://www.promenadeflooring.com',
  4.9,
  178,
  'promenade-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ralston Valley Flooring Works
(
  'cont_floor_nw_006',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Ralston Valley Flooring Works',
  '7600 W 64th Ave, Arvada, CO 80004',
  '(303) 555-7606',
  'https://www.ralstonvalleyflooring.com',
  4.7,
  139,
  'ralston-valley-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Church Ranch Floor Specialists
(
  'cont_floor_nw_007',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Church Ranch Floor Specialists',
  '10050 Wadsworth Pkwy, Westminster, CO 80021',
  '(303) 555-7607',
  'https://www.churchranchflooring.com',
  4.8,
  153,
  'church-ranch-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Candelas Floor & Design
(
  'cont_floor_nw_008',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Candelas Floor & Design',
  '18815 W 85th Dr, Arvada, CO 80007',
  '(303) 555-7608',
  'https://www.candelasflooring.com',
  4.6,
  122,
  'candelas-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Sheridan Floor Pros
(
  'cont_floor_nw_009',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Sheridan Floor Pros',
  '7309 Sheridan Blvd, Westminster, CO 80003',
  '(303) 555-7609',
  'https://www.sheridanflooring.com',
  4.8,
  161,
  'sheridan-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Federal Heights Flooring Solutions
(
  'cont_floor_nw_010',
  'cat_flooring_001',
  'neigh_west_arvada_001',
  'Federal Heights Flooring Solutions',
  '2800 W 92nd Ave, Federal Heights, CO 80260',
  '(303) 555-7610',
  'https://www.federalheightsflooring.com',
  4.7,
  137,
  'federal-heights-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
