-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northwest Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_nw_suburbs_001',
  'Northwest Suburbs',
  'northwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Westminster/Arvada subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_west_arv_001',
  'reg_nw_suburbs_001',
  'Westminster/Arvada',
  'westminster-arvada',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Westminster/Arvada neighborhood
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

-- Insert 10 HVAC contractors for Westminster/Arvada area
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
-- 1. Westminster HVAC Experts
(
  'cont_hvac_nw_001',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Westminster HVAC Experts',
  '7301 Federal Blvd, Westminster, CO 80030',
  '(303) 555-3601',
  'https://www.westminsterhvac.com',
  4.9,
  234,
  'westminster-hvac-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Air Systems
(
  'cont_hvac_nw_002',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Arvada Air Systems',
  '5700 Wadsworth Bypass, Arvada, CO 80002',
  '(303) 555-3602',
  'https://www.arvadahvac.com',
  4.8,
  198,
  'arvada-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Climate Control
(
  'cont_hvac_nw_003',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Olde Town Climate Control',
  '5600 Olde Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-3603',
  'https://www.oldetownhvac.com',
  4.7,
  167,
  'olde-town-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake HVAC
(
  'cont_hvac_nw_004',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Standley Lake HVAC',
  '8900 W 88th Ave, Westminster, CO 80021',
  '(303) 555-3604',
  'https://www.standleylakehvac.com',
  4.8,
  189,
  'standley-lake-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northwest Metro Climate Pros
(
  'cont_hvac_nw_005',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Northwest Metro Climate Pros',
  '7600 W 80th Ave, Arvada, CO 80003',
  '(303) 555-3605',
  'https://www.nwmetrohvac.com',
  4.9,
  212,
  'northwest-metro-climate-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ralston Valley HVAC
(
  'cont_hvac_nw_006',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Ralston Valley HVAC',
  '6700 W 72nd Ave, Arvada, CO 80003',
  '(303) 555-3606',
  'https://www.ralstonvalleyhvac.com',
  4.7,
  178,
  'ralston-valley-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Church Ranch Air Solutions
(
  'cont_hvac_nw_007',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Church Ranch Air Solutions',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-3607',
  'https://www.churchranchhvac.com',
  4.8,
  167,
  'church-ranch-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Sheridan Boulevard HVAC
(
  'cont_hvac_nw_008',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Sheridan Boulevard HVAC',
  '5150 Sheridan Blvd, Arvada, CO 80002',
  '(303) 555-3608',
  'https://www.sheridanblvdhvac.com',
  4.6,
  156,
  'sheridan-boulevard-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Candelas Climate Services
(
  'cont_hvac_nw_009',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Candelas Climate Services',
  '9100 Candelas Pkwy, Arvada, CO 80007',
  '(303) 555-3609',
  'https://www.candelashvac.com',
  4.8,
  201,
  'candelas-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Promenade HVAC Specialists
(
  'cont_hvac_nw_010',
  'cat_hvac_001',
  'neigh_west_arv_001',
  'Promenade HVAC Specialists',
  '10801 Town Center Dr, Westminster, CO 80021',
  '(303) 555-3610',
  'https://www.promenadehvac.com',
  4.7,
  182,
  'promenade-hvac-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
