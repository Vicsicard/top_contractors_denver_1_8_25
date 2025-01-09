-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
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

-- Insert 10 Roofers for Thornton/Northglenn area
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
-- 1. Thornton Premier Roofing
(
  'cont_roof_ne_sub_001',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Thornton Premier Roofing',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-4701',
  'https://www.thorntonpremierroofing.com',
  4.9,
  189,
  'thornton-premier-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Roofing Experts
(
  'cont_roof_ne_sub_002',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Northglenn Roofing Experts',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-4702',
  'https://www.northglennroofing.com',
  4.8,
  167,
  'northglenn-roofing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Roofing
(
  'cont_roof_ne_sub_003',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Washington Street Roofing',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-4703',
  'https://www.washingtonstreetroofing.com',
  4.7,
  145,
  'washington-street-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Original Thornton Roofing
(
  'cont_roof_ne_sub_004',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Original Thornton Roofing',
  '8800 N Washington St, Thornton, CO 80229',
  '(303) 555-4704',
  'https://www.originalthorntonroofing.com',
  4.8,
  156,
  'original-thornton-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 120th Avenue Roofing Co
(
  'cont_roof_ne_sub_005',
  'cat_roof_001',
  'neigh_thorn_north_001',
  '120th Avenue Roofing Co',
  '1001 E 120th Ave, Thornton, CO 80233',
  '(303) 555-4705',
  'https://www.120thaveroofing.com',
  4.9,
  178,
  '120th-avenue-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Huron Street Roofing Solutions
(
  'cont_roof_ne_sub_006',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Huron Street Roofing Solutions',
  '10650 Huron St, Northglenn, CO 80234',
  '(303) 555-4706',
  'https://www.huronstreetroofing.com',
  4.7,
  134,
  'huron-street-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Thornton Town Center Roofing
(
  'cont_roof_ne_sub_007',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Thornton Town Center Roofing',
  '10001 Grant St, Thornton, CO 80229',
  '(303) 555-4707',
  'https://www.thorntontowncenterroofing.com',
  4.8,
  145,
  'thornton-town-center-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Webster Lake Roofing
(
  'cont_roof_ne_sub_008',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Webster Lake Roofing',
  '12301 Claude Ct, Northglenn, CO 80241',
  '(303) 555-4708',
  'https://www.websterlakeroofing.com',
  4.6,
  123,
  'webster-lake-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Eastlake Roofing Pros
(
  'cont_roof_ne_sub_009',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'Eastlake Roofing Pros',
  '12500 Claude Ct, Northglenn, CO 80241',
  '(303) 555-4709',
  'https://www.eastlakeroofing.com',
  4.8,
  167,
  'eastlake-roofing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. North Metro Roofing
(
  'cont_roof_ne_sub_010',
  'cat_roof_001',
  'neigh_thorn_north_001',
  'North Metro Roofing',
  '11900 Washington Center Pkwy, Thornton, CO 80233',
  '(303) 555-4710',
  'https://www.northmetroroofing.com',
  4.7,
  145,
  'north-metro-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
