-- Ensure Epoxy Garage category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Southeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_se_suburbs_001',
  'Southeast Suburbs',
  'southeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Aurora/DTC subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_aurora_dtc_001',
  'reg_se_suburbs_001',
  'Aurora/DTC',
  'aurora-dtc',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Aurora/DTC neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_aurora_dtc_001',
  'subreg_aurora_dtc_001',
  'Aurora/DTC',
  'aurora-dtc',
  'Including Aurora, Denver Tech Center, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Epoxy Garage contractors for Aurora/DTC area
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
-- 1. Aurora Epoxy Solutions
(
  'cont_epoxy_se_sub_001',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Aurora Epoxy Solutions',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-7801',
  'https://www.auroraepoxy.com',
  4.9,
  158,
  'aurora-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Garage Coatings
(
  'cont_epoxy_se_sub_002',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'DTC Garage Coatings',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-7802',
  'https://www.dtcepoxy.com',
  4.8,
  143,
  'dtc-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Epoxy Masters
(
  'cont_epoxy_se_sub_003',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Southlands Epoxy Masters',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-7803',
  'https://www.southlandsepoxy.com',
  4.7,
  129,
  'southlands-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Garage Solutions
(
  'cont_epoxy_se_sub_004',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Tech Center Garage Solutions',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-7804',
  'https://www.techcenterepoxy.com',
  4.8,
  148,
  'tech-center-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Cherry Creek State Park Epoxy Pro
(
  'cont_epoxy_se_sub_005',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park Epoxy Pro',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-7805',
  'https://www.cherrycreekepoxy.com',
  4.9,
  161,
  'cherry-creek-state-park-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Hampden South Garage Finishes
(
  'cont_epoxy_se_sub_006',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Hampden South Garage Finishes',
  '7600 E Hampden Ave, Denver, CO 80231',
  '(303) 555-7806',
  'https://www.hampdensouthepoxy.com',
  4.7,
  124,
  'hampden-south-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Centennial Airport Epoxy Specialists
(
  'cont_epoxy_se_sub_007',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Centennial Airport Epoxy Specialists',
  '7800 S Peoria St, Englewood, CO 80112',
  '(303) 555-7807',
  'https://www.centennialairportepoxy.com',
  4.8,
  137,
  'centennial-airport-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Iliff Avenue Garage Coatings
(
  'cont_epoxy_se_sub_008',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Iliff Avenue Garage Coatings',
  '15001 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-7808',
  'https://www.iliffavenueepoxy.com',
  4.6,
  110,
  'iliff-avenue-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Greenwood Plaza Epoxy Pros
(
  'cont_epoxy_se_sub_009',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Greenwood Plaza Epoxy Pros',
  '6300 S Syracuse Way, Centennial, CO 80111',
  '(303) 555-7809',
  'https://www.greenwoodplazaepoxy.com',
  4.8,
  146,
  'greenwood-plaza-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Arapahoe Road Garage Solutions
(
  'cont_epoxy_se_sub_010',
  'cat_epoxy_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Road Garage Solutions',
  '15900 E Arapahoe Rd, Centennial, CO 80016',
  '(303) 555-7810',
  'https://www.arapahoeroadepoxy.com',
  4.7,
  131,
  'arapahoe-road-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
