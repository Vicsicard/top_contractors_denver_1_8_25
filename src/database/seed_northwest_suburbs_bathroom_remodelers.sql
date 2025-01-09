-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
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

-- Insert 10 Bathroom Remodelers for Westminster/Arvada area
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
-- 1. Westminster Bath Design
(
  'cont_bath_nw_001',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Westminster Bath Design',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-8601',
  'https://www.westminsterbath.com',
  4.9,
  178,
  'westminster-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Bath & Tile
(
  'cont_bath_nw_002',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Arvada Bath & Tile',
  '7525 Ralston Rd, Arvada, CO 80002',
  '(303) 555-8602',
  'https://www.arvadabath.com',
  4.8,
  156,
  'arvada-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Bath Masters
(
  'cont_bath_nw_003',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Olde Town Bath Masters',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-8603',
  'https://www.oldetownbath.com',
  4.7,
  134,
  'olde-town-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Bath Co
(
  'cont_bath_nw_004',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Standley Lake Bath Co',
  '8000 Kipling St, Arvada, CO 80005',
  '(303) 555-8604',
  'https://www.standleylakebath.com',
  4.8,
  167,
  'standley-lake-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Promenade Bath Studio
(
  'cont_bath_nw_005',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Promenade Bath Studio',
  '10578 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-8605',
  'https://www.promenadebath.com',
  4.9,
  189,
  'promenade-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Church Ranch Bath Design
(
  'cont_bath_nw_006',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Church Ranch Bath Design',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-8606',
  'https://www.churchranchbath.com',
  4.7,
  145,
  'church-ranch-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Candelas Bath Co
(
  'cont_bath_nw_007',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Candelas Bath Co',
  '9200 Candelas Pkwy, Arvada, CO 80007',
  '(303) 555-8607',
  'https://www.candelasbath.com',
  4.8,
  156,
  'candelas-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Federal Heights Bath Studio
(
  'cont_bath_nw_008',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Federal Heights Bath Studio',
  '2800 W 92nd Ave, Federal Heights, CO 80260',
  '(303) 555-8608',
  'https://www.federalheightsbath.com',
  4.6,
  123,
  'federal-heights-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Sheridan Bath Specialists
(
  'cont_bath_nw_009',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Sheridan Bath Specialists',
  '5151 Sheridan Blvd, Arvada, CO 80002',
  '(303) 555-8609',
  'https://www.sheridanbath.com',
  4.8,
  167,
  'sheridan-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Flats Bath Design
(
  'cont_bath_nw_010',
  'cat_bath_001',
  'neigh_west_arv_001',
  'Rocky Flats Bath Design',
  '8000 Indiana St, Arvada, CO 80007',
  '(303) 555-8610',
  'https://www.rockyflatsbath.com',
  4.7,
  145,
  'rocky-flats-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
