-- Ensure Home Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
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

-- Insert 10 Home Remodelers for Westminster/Arvada area
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
-- 1. Westminster Design Masters
(
  'cont_remod_nw_001',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Westminster Design Masters',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-7601',
  'https://www.westminsterdesignmasters.com',
  4.9,
  189,
  'westminster-design-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Olde Town Arvada Remodeling
(
  'cont_remod_nw_002',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Olde Town Arvada Remodeling',
  '7525 Grandview Ave, Arvada, CO 80002',
  '(303) 555-7602',
  'https://www.oldetownremodeling.com',
  4.8,
  156,
  'olde-town-arvada-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Standley Lake Design Build
(
  'cont_remod_nw_003',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Standley Lake Design Build',
  '8900 W 100th Ave, Westminster, CO 80021',
  '(303) 555-7603',
  'https://www.standleylakedesign.com',
  4.7,
  134,
  'standley-lake-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Wadsworth Renovation Co
(
  'cont_remod_nw_004',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Wadsworth Renovation Co',
  '6700 Wadsworth Blvd, Arvada, CO 80003',
  '(303) 555-7604',
  'https://www.wadsworthrenovation.com',
  4.8,
  167,
  'wadsworth-renovation-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Promenade Design Studio
(
  'cont_remod_nw_005',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Promenade Design Studio',
  '10601 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-7605',
  'https://www.promenadedesignstudio.com',
  4.9,
  178,
  'promenade-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ralston Valley Remodeling
(
  'cont_remod_nw_006',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Ralston Valley Remodeling',
  '7600 Ralston Rd, Arvada, CO 80002',
  '(303) 555-7606',
  'https://www.ralstonvalleyremodeling.com',
  4.7,
  145,
  'ralston-valley-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Church Ranch Design Co
(
  'cont_remod_nw_007',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Church Ranch Design Co',
  '10400 Westminster Blvd, Westminster, CO 80021',
  '(303) 555-7607',
  'https://www.churchranchdesign.com',
  4.8,
  156,
  'church-ranch-design-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Kipling Heights Renovations
(
  'cont_remod_nw_008',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Kipling Heights Renovations',
  '8000 Kipling St, Arvada, CO 80005',
  '(303) 555-7608',
  'https://www.kiplingheightsrenovations.com',
  4.6,
  123,
  'kipling-heights-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Federal Heights Design Build
(
  'cont_remod_nw_009',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Federal Heights Design Build',
  '9200 Federal Blvd, Westminster, CO 80031',
  '(303) 555-7609',
  'https://www.federalheightsdesign.com',
  4.8,
  167,
  'federal-heights-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Sheridan Boulevard Remodeling
(
  'cont_remod_nw_010',
  'cat_remod_001',
  'neigh_west_arv_001',
  'Sheridan Boulevard Remodeling',
  '7800 Sheridan Blvd, Arvada, CO 80003',
  '(303) 555-7610',
  'https://www.sheridanremodeling.com',
  4.7,
  145,
  'sheridan-boulevard-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
