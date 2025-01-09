-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumber',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Suburbs region exists (same as previous)
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_suburbs_001',
  'Denver Suburbs',
  'denver-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southeast Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_se_suburbs_001',
  'reg_suburbs_001',
  'Southeast Suburbs',
  'southeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southeast Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_se_suburbs_001',
  'subreg_se_suburbs_001',
  'Southeast Suburbs',
  'southeast-suburbs',
  'Including Aurora, Denver Tech Center (DTC), and surrounding areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Southeast Suburbs area
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
-- 1. DTC Premier Plumbing
(
  'cont_plumb_ses_001',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'DTC Premier Plumbing',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-0901',
  'https://www.dtcpremierplumbing.com',
  4.9,
  256,
  'dtc-premier-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Aurora Central Plumbers
(
  'cont_plumb_ses_002',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Aurora Central Plumbers',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-0902',
  'https://www.auroracentralplumbers.com',
  4.8,
  198,
  'aurora-central-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Tech Center Drain Experts
(
  'cont_plumb_ses_003',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Tech Center Drain Experts',
  '8400 E Crescent Pkwy, Greenwood Village, CO 80111',
  '(303) 555-0903',
  'https://www.techcenterdrains.com',
  4.7,
  167,
  'tech-center-drain-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southlands Mall Area Plumbing
(
  'cont_plumb_ses_004',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Southlands Mall Area Plumbing',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-0904',
  'https://www.southlandsplumbing.com',
  4.8,
  189,
  'southlands-mall-area-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Cherry Creek Reservoir Plumbing
(
  'cont_plumb_ses_005',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Cherry Creek Reservoir Plumbing',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-0905',
  'https://www.cherrycreekreservoirplumbing.com',
  4.9,
  212,
  'cherry-creek-reservoir-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Belleview Tech Center Plumbing
(
  'cont_plumb_ses_006',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Belleview Tech Center Plumbing',
  '7900 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-0906',
  'https://www.belleviewtechplumbing.com',
  4.7,
  178,
  'belleview-tech-center-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Aurora Town Center Plumbing
(
  'cont_plumb_ses_007',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Aurora Town Center Plumbing',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-0907',
  'https://www.auroratowncenterplumbing.com',
  4.8,
  167,
  'aurora-town-center-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Inverness Business Park Plumbers
(
  'cont_plumb_ses_008',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Inverness Business Park Plumbers',
  '155 Inverness Dr W, Englewood, CO 80112',
  '(303) 555-0908',
  'https://www.invernessbusinessplumbers.com',
  4.6,
  156,
  'inverness-business-park-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Hampden South Plumbing Services
(
  'cont_plumb_ses_009',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Hampden South Plumbing Services',
  '3600 S Syracuse St, Denver, CO 80237',
  '(303) 555-0909',
  'https://www.hampdensouthplumbing.com',
  4.8,
  201,
  'hampden-south-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Arapahoe Crossing Plumbing
(
  'cont_plumb_ses_010',
  'cat_plumber_001',
  'neigh_se_suburbs_001',
  'Arapahoe Crossing Plumbing',
  '6616 S Parker Rd, Aurora, CO 80016',
  '(303) 555-0910',
  'https://www.arapahoecrossingplumbing.com',
  4.7,
  182,
  'arapahoe-crossing-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
