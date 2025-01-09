-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southeast Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_se_suburbs_001',
  'Southeast Suburbs',
  'southeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southeast Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_se_suburbs_001',
  'reg_se_suburbs_001',
  'Aurora/DTC Area',
  'aurora-dtc-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southeast Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_se_suburbs_001',
  'subreg_se_suburbs_001',
  'Aurora/DTC',
  'aurora-dtc',
  'Including Aurora, Denver Tech Center (DTC), and surrounding areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 electricians for Southeast Suburbs area
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
-- 1. Aurora Electric Masters
(
  'cont_elec_se_001',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Aurora Electric Masters',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-2801',
  'https://www.auroraelectric.com',
  4.9,
  234,
  'aurora-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Electrical Solutions
(
  'cont_elec_se_002',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'DTC Electrical Solutions',
  '5075 S Syracuse St, Denver, CO 80237',
  '(303) 555-2802',
  'https://www.dtcelectrical.com',
  4.8,
  198,
  'dtc-electrical-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Southlands Electric Experts
(
  'cont_elec_se_003',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Southlands Electric Experts',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-2803',
  'https://www.southlandselectric.com',
  4.7,
  167,
  'southlands-electric-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tech Center Electric Pros
(
  'cont_elec_se_004',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Tech Center Electric Pros',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-2804',
  'https://www.techcenterelectric.com',
  4.8,
  189,
  'tech-center-electric-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Cherry Creek State Park Electric
(
  'cont_elec_se_005',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Cherry Creek State Park Electric',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-2805',
  'https://www.cherrycreekparkelectric.com',
  4.6,
  156,
  'cherry-creek-state-park-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Greenwood Village Electric
(
  'cont_elec_se_006',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Greenwood Village Electric',
  '6300 S Syracuse Way, Greenwood Village, CO 80111',
  '(303) 555-2806',
  'https://www.greenwoodvillageelectric.com',
  4.9,
  212,
  'greenwood-village-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Hampden South Electric
(
  'cont_elec_se_007',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Hampden South Electric',
  '7600 E Hampden Ave, Denver, CO 80231',
  '(303) 555-2807',
  'https://www.hampdensouthelectric.com',
  4.8,
  167,
  'hampden-south-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Aurora Town Center Electric
(
  'cont_elec_se_008',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Aurora Town Center Electric',
  '14200 E Alameda Ave, Aurora, CO 80012',
  '(303) 555-2808',
  'https://www.auroratowncenterelectric.com',
  4.7,
  178,
  'aurora-town-center-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Inverness Electric
(
  'cont_elec_se_009',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Inverness Electric',
  '155 Inverness Dr W, Englewood, CO 80112',
  '(303) 555-2809',
  'https://www.invernesselectric.com',
  4.8,
  201,
  'inverness-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Arapahoe Crossing Electric
(
  'cont_elec_se_010',
  'cat_elec_001',
  'neigh_se_suburbs_001',
  'Arapahoe Crossing Electric',
  '6616 S Parker Rd, Aurora, CO 80016',
  '(303) 555-2810',
  'https://www.arapahoecrossingelectric.com',
  4.7,
  182,
  'arapahoe-crossing-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
