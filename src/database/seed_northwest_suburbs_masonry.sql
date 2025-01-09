-- Ensure Masonry category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_masonry_001',
  'Masonry',
  'masonry',
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

-- Insert 10 Masonry contractors for Westminster/Arvada area
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
-- 1. Westminster Masonry Works
(
  'cont_masonry_nw_001',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Westminster Masonry Works',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-8601',
  'https://www.westminstermasonry.com',
  4.9,
  188,
  'westminster-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Stone & Brick
(
  'cont_masonry_nw_002',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Arvada Stone & Brick',
  '7525 Ralston Rd, Arvada, CO 80002',
  '(303) 555-8602',
  'https://www.arvadastonebrick.com',
  4.8,
  166,
  'arvada-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Brick Masters
(
  'cont_masonry_nw_003',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Olde Town Brick Masters',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-8603',
  'https://www.oldetownbrick.com',
  4.7,
  144,
  'olde-town-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Stone Solutions
(
  'cont_masonry_nw_004',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Standley Lake Stone Solutions',
  '8901 W 100th Ave, Westminster, CO 80021',
  '(303) 555-8604',
  'https://www.standleylakestone.com',
  4.8,
  177,
  'standley-lake-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Federal Heights Masonry Co
(
  'cont_masonry_nw_005',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Federal Heights Masonry Co',
  '2800 W 92nd Ave, Federal Heights, CO 80260',
  '(303) 555-8605',
  'https://www.federalheightsmasonry.com',
  4.9,
  198,
  'federal-heights-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Wadsworth Stone Works
(
  'cont_masonry_nw_006',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Wadsworth Stone Works',
  '6701 Wadsworth Blvd, Arvada, CO 80003',
  '(303) 555-8606',
  'https://www.wadsworthstone.com',
  4.7,
  155,
  'wadsworth-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northwest Masonry Specialists
(
  'cont_masonry_nw_007',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Northwest Masonry Specialists',
  '7309 Grandview Ave, Arvada, CO 80002',
  '(303) 555-8607',
  'https://www.northwestmasonry.com',
  4.8,
  166,
  'northwest-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Sheridan Stone & Brick
(
  'cont_masonry_nw_008',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Sheridan Stone & Brick',
  '5151 W 80th Ave, Arvada, CO 80003',
  '(303) 555-8608',
  'https://www.sheridanstone.com',
  4.6,
  133,
  'sheridan-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Promenade Masonry Pros
(
  'cont_masonry_nw_009',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Promenade Masonry Pros',
  '10655 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-8609',
  'https://www.promenademasonry.com',
  4.8,
  177,
  'promenade-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Stone Solutions
(
  'cont_masonry_nw_010',
  'cat_masonry_001',
  'neigh_west_arvada_001',
  'Rocky Mountain Stone Solutions',
  '8000 Sheridan Blvd, Arvada, CO 80003',
  '(303) 555-8610',
  'https://www.rockymountainstone.com',
  4.7,
  155,
  'rocky-mountain-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
