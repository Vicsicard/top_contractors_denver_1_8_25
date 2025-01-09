-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
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

-- Insert 10 Roofers for Westminster/Arvada area
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
-- 1. Westminster Premier Roofing
(
  'cont_roof_nw_001',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Westminster Premier Roofing',
  '5000 W 92nd Ave, Westminster, CO 80031',
  '(303) 555-4601',
  'https://www.westminsterroofing.com',
  4.9,
  198,
  'westminster-premier-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Roofing Masters
(
  'cont_roof_nw_002',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Arvada Roofing Masters',
  '7525 Ralston Rd, Arvada, CO 80002',
  '(303) 555-4602',
  'https://www.arvadaroofing.com',
  4.8,
  167,
  'arvada-roofing-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Roofing Co
(
  'cont_roof_nw_003',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Olde Town Roofing Co',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-4603',
  'https://www.oldetownroofing.com',
  4.7,
  145,
  'olde-town-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Roofing
(
  'cont_roof_nw_004',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Standley Lake Roofing',
  '8900 W 100th Ave, Westminster, CO 80021',
  '(303) 555-4604',
  'https://www.standleylakeroofing.com',
  4.8,
  156,
  'standley-lake-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northwest Corridor Roofing
(
  'cont_roof_nw_005',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Northwest Corridor Roofing',
  '10455 Sheridan Blvd, Westminster, CO 80020',
  '(303) 555-4605',
  'https://www.nwcorridorroofing.com',
  4.9,
  187,
  'northwest-corridor-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Wadsworth Boulevard Roofing
(
  'cont_roof_nw_006',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Wadsworth Boulevard Roofing',
  '6500 Wadsworth Blvd, Arvada, CO 80003',
  '(303) 555-4606',
  'https://www.wadsworthroofing.com',
  4.7,
  143,
  'wadsworth-boulevard-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Promenade Roofing Solutions
(
  'cont_roof_nw_007',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Promenade Roofing Solutions',
  '10901 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-4607',
  'https://www.promenaderoofing.com',
  4.8,
  134,
  'promenade-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Candelas Roofing Experts
(
  'cont_roof_nw_008',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Candelas Roofing Experts',
  '9100 Candelas Pkwy, Arvada, CO 80007',
  '(303) 555-4608',
  'https://www.candelasroofing.com',
  4.6,
  123,
  'candelas-roofing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Church Ranch Roofing
(
  'cont_roof_nw_009',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Church Ranch Roofing',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-4609',
  'https://www.churchranchroofing.com',
  4.8,
  167,
  'church-ranch-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Kipling Heights Roofing
(
  'cont_roof_nw_010',
  'cat_roof_001',
  'neigh_west_arvada_001',
  'Kipling Heights Roofing',
  '8000 Kipling St, Arvada, CO 80005',
  '(303) 555-4610',
  'https://www.kiplingheightsroofing.com',
  4.7,
  145,
  'kipling-heights-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
