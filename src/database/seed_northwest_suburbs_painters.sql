-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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

-- Insert 10 Painters for Westminster/Arvada area
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
-- 1. Westminster Paint Masters
(
  'cont_paint_nw_001',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Westminster Paint Masters',
  '7301 Federal Blvd, Westminster, CO 80030',
  '(303) 555-5601',
  'https://www.westminsterpainting.com',
  4.9,
  167,
  'westminster-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Paint Co
(
  'cont_paint_nw_002',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Arvada Paint Co',
  '5700 Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-5602',
  'https://www.arvadapainting.com',
  4.8,
  145,
  'arvada-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Painters
(
  'cont_paint_nw_003',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Olde Town Painters',
  '7525 Grandview Ave, Arvada, CO 80002',
  '(303) 555-5603',
  'https://www.oldetownpainting.com',
  4.7,
  132,
  'olde-town-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Paint Studio
(
  'cont_paint_nw_004',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Standley Lake Paint Studio',
  '8900 W 88th Ave, Westminster, CO 80021',
  '(303) 555-5604',
  'https://www.standleylakepainting.com',
  4.8,
  156,
  'standley-lake-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Ralston Valley Painters
(
  'cont_paint_nw_005',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Ralston Valley Painters',
  '6600 W 80th Ave, Arvada, CO 80003',
  '(303) 555-5605',
  'https://www.ralstonvalleypainting.com',
  4.9,
  178,
  'ralston-valley-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Church Ranch Paint & Design
(
  'cont_paint_nw_006',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Church Ranch Paint & Design',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-5606',
  'https://www.churchranchpainting.com',
  4.7,
  134,
  'church-ranch-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Sheridan Paint Pros
(
  'cont_paint_nw_007',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Sheridan Paint Pros',
  '5151 Sheridan Blvd, Arvada, CO 80002',
  '(303) 555-5607',
  'https://www.sheridanpainting.com',
  4.8,
  145,
  'sheridan-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Kipling Paint Solutions
(
  'cont_paint_nw_008',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Kipling Paint Solutions',
  '6400 Kipling St, Arvada, CO 80004',
  '(303) 555-5608',
  'https://www.kiplingpainting.com',
  4.6,
  123,
  'kipling-paint-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Promenade Paint Studio
(
  'cont_paint_nw_009',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Promenade Paint Studio',
  '10801 Town Center Dr, Westminster, CO 80021',
  '(303) 555-5609',
  'https://www.promenadepainting.com',
  4.8,
  156,
  'promenade-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Flats Paint Co
(
  'cont_paint_nw_010',
  'cat_paint_001',
  'neigh_west_arv_001',
  'Rocky Flats Paint Co',
  '8000 Simms St, Arvada, CO 80005',
  '(303) 555-5610',
  'https://www.rockyflatspaint.com',
  4.7,
  134,
  'rocky-flats-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
