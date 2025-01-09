-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for Westminster/Arvada area
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
-- 1. Westminster Garden Masters
(
  'cont_land_nw_001',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Westminster Garden Masters',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-6601',
  'https://www.westminstergardens.com',
  4.9,
  167,
  'westminster-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Landscape Design
(
  'cont_land_nw_002',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Arvada Landscape Design',
  '7525 Ralston Rd, Arvada, CO 80002',
  '(303) 555-6602',
  'https://www.arvadalandscape.com',
  4.8,
  145,
  'arvada-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Gardens
(
  'cont_land_nw_003',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Olde Town Gardens',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-6603',
  'https://www.oldetowngardens.com',
  4.7,
  132,
  'olde-town-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Landscaping
(
  'cont_land_nw_004',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Standley Lake Landscaping',
  '9785 W 100th Ave, Westminster, CO 80021',
  '(303) 555-6604',
  'https://www.standleylakelandscaping.com',
  4.8,
  156,
  'standley-lake-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northwest Garden Design
(
  'cont_land_nw_005',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Northwest Garden Design',
  '8000 Sheridan Blvd, Arvada, CO 80003',
  '(303) 555-6605',
  'https://www.northwestgardendesign.com',
  4.9,
  178,
  'northwest-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Promenade Landscape Co
(
  'cont_land_nw_006',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Promenade Landscape Co',
  '10655 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-6606',
  'https://www.promenadelandscape.com',
  4.7,
  134,
  'promenade-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Candelas Gardens
(
  'cont_land_nw_007',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Candelas Gardens',
  '9100 Indiana St, Arvada, CO 80007',
  '(303) 555-6607',
  'https://www.candelasgardens.com',
  4.8,
  145,
  'candelas-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Church Ranch Garden Studio
(
  'cont_land_nw_008',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Church Ranch Garden Studio',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-6608',
  'https://www.churchranchgardens.com',
  4.6,
  123,
  'church-ranch-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Wadsworth Landscape Design
(
  'cont_land_nw_009',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Wadsworth Landscape Design',
  '6701 Wadsworth Blvd, Arvada, CO 80003',
  '(303) 555-6609',
  'https://www.wadsworthlandscape.com',
  4.8,
  156,
  'wadsworth-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Flats Gardens
(
  'cont_land_nw_010',
  'cat_land_001',
  'neigh_west_arvada_001',
  'Rocky Flats Gardens',
  '8300 Indiana St, Arvada, CO 80007',
  '(303) 555-6610',
  'https://www.rockyflatsgardens.com',
  4.7,
  134,
  'rocky-flats-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
