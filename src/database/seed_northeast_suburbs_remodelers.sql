-- Ensure Home Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_thorn_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn neighborhood exists
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

-- Insert 10 Home Remodelers for Thornton/Northglenn area
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
-- 1. Thornton Design Masters
(
  'cont_remod_nes_001',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Thornton Design Masters',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-7701',
  'https://www.thorntondesignmasters.com',
  4.9,
  178,
  'thornton-design-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Renovation Co
(
  'cont_remod_nes_002',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Northglenn Renovation Co',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-7702',
  'https://www.northglennrenovation.com',
  4.8,
  156,
  'northglenn-renovation-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Design Build
(
  'cont_remod_nes_003',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Washington Street Design Build',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-7703',
  'https://www.washingtonstreetdesign.com',
  4.7,
  134,
  'washington-street-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. 120th Avenue Remodeling
(
  'cont_remod_nes_004',
  'cat_remod_001',
  'neigh_thorn_north_001',
  '120th Avenue Remodeling',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-7704',
  'https://www.120thremodeling.com',
  4.8,
  167,
  '120th-avenue-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Original Thornton Design Studio
(
  'cont_remod_nes_005',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Original Thornton Design Studio',
  '8800 Pearl St, Thornton, CO 80229',
  '(303) 555-7705',
  'https://www.originalthorntondesign.com',
  4.9,
  189,
  'original-thornton-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Huron Street Remodeling
(
  'cont_remod_nes_006',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Huron Street Remodeling',
  '10455 Huron St, Northglenn, CO 80234',
  '(303) 555-7706',
  'https://www.huronstreetremodeling.com',
  4.7,
  145,
  'huron-street-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Grant Park Design Co
(
  'cont_remod_nes_007',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Grant Park Design Co',
  '11701 Grant St, Northglenn, CO 80233',
  '(303) 555-7707',
  'https://www.grantparkdesign.com',
  4.8,
  156,
  'grant-park-design-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Thornton Parkway Renovations
(
  'cont_remod_nes_008',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Thornton Parkway Renovations',
  '8900 Thornton Pkwy, Thornton, CO 80229',
  '(303) 555-7708',
  'https://www.thorntonparkwayrenovations.com',
  4.6,
  123,
  'thornton-parkway-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Webster Lake Design Build
(
  'cont_remod_nes_009',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Webster Lake Design Build',
  '11900 Grant Dr, Northglenn, CO 80233',
  '(303) 555-7709',
  'https://www.websterlakedesign.com',
  4.8,
  167,
  'webster-lake-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Colorado Boulevard Remodeling
(
  'cont_remod_nes_010',
  'cat_remod_001',
  'neigh_thorn_north_001',
  'Colorado Boulevard Remodeling',
  '10650 Colorado Blvd, Thornton, CO 80233',
  '(303) 555-7710',
  'https://www.coloradoblvdremodeling.com',
  4.7,
  145,
  'colorado-boulevard-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
