-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Thornton/Northglenn subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_thorn_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Thornton/Northglenn neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_thorn_north_001',
  'subreg_thorn_north_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 HVAC contractors for Thornton/Northglenn area
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
-- 1. Thornton HVAC Masters
(
  'cont_hvac_nes_001',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Thornton HVAC Masters',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-3701',
  'https://www.thorntonhvac.com',
  4.9,
  234,
  'thornton-hvac-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Air Systems
(
  'cont_hvac_nes_002',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Northglenn Air Systems',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-3702',
  'https://www.northglennhvac.com',
  4.8,
  198,
  'northglenn-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Original Thornton Climate Control
(
  'cont_hvac_nes_003',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Original Thornton Climate Control',
  '8800 N Washington St, Thornton, CO 80229',
  '(303) 555-3703',
  'https://www.originalthorntonhvac.com',
  4.7,
  167,
  'original-thornton-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. 120th Avenue HVAC
(
  'cont_hvac_nes_004',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  '120th Avenue HVAC',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-3704',
  'https://www.120thhvac.com',
  4.8,
  189,
  '120th-avenue-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northeast Metro Climate Pros
(
  'cont_hvac_nes_005',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Northeast Metro Climate Pros',
  '11900 Washington Center Pkwy, Thornton, CO 80241',
  '(303) 555-3705',
  'https://www.nemetrohvac.com',
  4.9,
  212,
  'northeast-metro-climate-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Webster Lake HVAC
(
  'cont_hvac_nes_006',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Webster Lake HVAC',
  '12300 Grant Dr, Northglenn, CO 80241',
  '(303) 555-3706',
  'https://www.websterlakehvac.com',
  4.7,
  178,
  'webster-lake-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Huron Street Air Solutions
(
  'cont_hvac_nes_007',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Huron Street Air Solutions',
  '10455 N Huron St, Northglenn, CO 80234',
  '(303) 555-3707',
  'https://www.huronstreethvac.com',
  4.8,
  167,
  'huron-street-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Eastlake HVAC Services
(
  'cont_hvac_nes_008',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Eastlake HVAC Services',
  '12500 Claude Ct, Northglenn, CO 80241',
  '(303) 555-3708',
  'https://www.eastlakehvac.com',
  4.6,
  156,
  'eastlake-hvac-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Thornton Town Center Climate Services
(
  'cont_hvac_nes_009',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Thornton Town Center Climate Services',
  '10001 Grant St, Thornton, CO 80229',
  '(303) 555-3709',
  'https://www.thorntontowncenterhvac.com',
  4.8,
  201,
  'thornton-town-center-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Washington Street HVAC Specialists
(
  'cont_hvac_nes_010',
  'cat_hvac_001',
  'neigh_thorn_north_001',
  'Washington Street HVAC Specialists',
  '9400 N Washington St, Thornton, CO 80229',
  '(303) 555-3710',
  'https://www.washingtonstreethvac.com',
  4.7,
  182,
  'washington-street-hvac-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
