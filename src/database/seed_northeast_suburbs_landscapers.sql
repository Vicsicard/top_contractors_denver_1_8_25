-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for Thornton/Northglenn area
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
-- 1. Thornton Garden Masters
(
  'cont_land_nes_001',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Thornton Garden Masters',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-6701',
  'https://www.thorntongardens.com',
  4.9,
  167,
  'thornton-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Landscape Design
(
  'cont_land_nes_002',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Northglenn Landscape Design',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-6702',
  'https://www.northglennlandscape.com',
  4.8,
  145,
  'northglenn-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Gardens
(
  'cont_land_nes_003',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Washington Street Gardens',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-6703',
  'https://www.washingtonstreetgardens.com',
  4.7,
  132,
  'washington-street-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Huron Street Landscaping
(
  'cont_land_nes_004',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Huron Street Landscaping',
  '10450 Huron St, Northglenn, CO 80234',
  '(303) 555-6704',
  'https://www.huronstreetlandscaping.com',
  4.8,
  156,
  'huron-street-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northeast Garden Design
(
  'cont_land_nes_005',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Northeast Garden Design',
  '12000 Colorado Blvd, Thornton, CO 80241',
  '(303) 555-6705',
  'https://www.northeastgardendesign.com',
  4.9,
  178,
  'northeast-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Eastlake Landscape Co
(
  'cont_land_nes_006',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Eastlake Landscape Co',
  '2200 E 124th Ave, Thornton, CO 80241',
  '(303) 555-6706',
  'https://www.eastlakelandscape.com',
  4.7,
  134,
  'eastlake-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Grant Park Gardens
(
  'cont_land_nes_007',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Grant Park Gardens',
  '11701 Grant St, Northglenn, CO 80233',
  '(303) 555-6707',
  'https://www.grantparkgardens.com',
  4.8,
  145,
  'grant-park-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Thornton Trail Garden Studio
(
  'cont_land_nes_008',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Thornton Trail Garden Studio',
  '13500 Holly St, Thornton, CO 80241',
  '(303) 555-6708',
  'https://www.thorntontrailgardens.com',
  4.6,
  123,
  'thornton-trail-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. 120th Avenue Landscape Design
(
  'cont_land_nes_009',
  'cat_land_001',
  'neigh_thorn_north_001',
  '120th Avenue Landscape Design',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-6709',
  'https://www.120thlandscape.com',
  4.8,
  156,
  '120th-avenue-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Webster Lake Gardens
(
  'cont_land_nes_010',
  'cat_land_001',
  'neigh_thorn_north_001',
  'Webster Lake Gardens',
  '11701 Webster St, Northglenn, CO 80233',
  '(303) 555-6710',
  'https://www.websterlakegardens.com',
  4.7,
  134,
  'webster-lake-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
