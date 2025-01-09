-- Ensure Epoxy Garage category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
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
  'subreg_thor_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_thor_north_001',
  'subreg_thor_north_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Epoxy Garage contractors for Thornton/Northglenn area
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
-- 1. Thornton Epoxy Solutions
(
  'cont_epoxy_ne_sub_001',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Thornton Epoxy Solutions',
  '8901 Washington St, Thornton, CO 80229',
  '(303) 555-7701',
  'https://www.thorntonepoxy.com',
  4.9,
  154,
  'thornton-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Garage Coatings
(
  'cont_epoxy_ne_sub_002',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Northglenn Garage Coatings',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-7702',
  'https://www.northglennepoxy.com',
  4.8,
  139,
  'northglenn-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Original Thornton Epoxy Masters
(
  'cont_epoxy_ne_sub_003',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Original Thornton Epoxy Masters',
  '8851 Pearl St, Thornton, CO 80229',
  '(303) 555-7703',
  'https://www.originalthortonepoxy.com',
  4.7,
  125,
  'original-thornton-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Washington Street Garage Solutions
(
  'cont_epoxy_ne_sub_004',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Washington Street Garage Solutions',
  '9501 Washington St, Thornton, CO 80229',
  '(303) 555-7704',
  'https://www.washingtonstreetepoxy.com',
  4.8,
  144,
  'washington-street-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Huron Street Epoxy Pro
(
  'cont_epoxy_ne_sub_005',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Huron Street Epoxy Pro',
  '10451 Huron St, Northglenn, CO 80234',
  '(303) 555-7705',
  'https://www.huronstreetepoxy.com',
  4.9,
  157,
  'huron-street-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 120th Avenue Garage Finishes
(
  'cont_epoxy_ne_sub_006',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  '120th Avenue Garage Finishes',
  '1201 E 120th Ave, Thornton, CO 80233',
  '(303) 555-7706',
  'https://www.120thavenueepoxy.com',
  4.7,
  120,
  '120th-avenue-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Eastlake Epoxy Specialists
(
  'cont_epoxy_ne_sub_007',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Eastlake Epoxy Specialists',
  '12401 Claude Ct, Northglenn, CO 80241',
  '(303) 555-7707',
  'https://www.eastlakeepoxy.com',
  4.8,
  133,
  'eastlake-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Webster Lake Garage Coatings
(
  'cont_epoxy_ne_sub_008',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Webster Lake Garage Coatings',
  '11701 Community Center Dr, Northglenn, CO 80233',
  '(303) 555-7708',
  'https://www.websterlakeepoxy.com',
  4.6,
  106,
  'webster-lake-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Thornton Parkway Epoxy Pros
(
  'cont_epoxy_ne_sub_009',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Thornton Parkway Epoxy Pros',
  '8801 Thornton Pkwy, Thornton, CO 80229',
  '(303) 555-7709',
  'https://www.thorntonparkwayepoxy.com',
  4.8,
  142,
  'thornton-parkway-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Grant Street Garage Solutions
(
  'cont_epoxy_ne_sub_010',
  'cat_epoxy_001',
  'neigh_thor_north_001',
  'Grant Street Garage Solutions',
  '11701 Grant St, Northglenn, CO 80233',
  '(303) 555-7710',
  'https://www.grantstreetepoxy.com',
  4.7,
  127,
  'grant-street-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
