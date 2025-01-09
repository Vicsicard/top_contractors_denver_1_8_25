-- Ensure Bathroom Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_bath_001',
  'Bathroom Remodelers',
  'bathroom-remodelers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_east_001',
  'East Denver',
  'east-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Colfax subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_east_colfax_001',
  'reg_east_001',
  'East Colfax',
  'east-colfax',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Colfax neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_east_colfax_001',
  'subreg_east_colfax_001',
  'East Colfax',
  'east-colfax',
  'Including East Colfax corridor and surrounding neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Bathroom Remodelers for East Colfax area
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
-- 1. Colfax Corridor Bath Design
(
  'cont_bath_ec_001',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Colfax Corridor Bath Design',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-8501',
  'https://www.colfaxbath.com',
  4.9,
  178,
  'colfax-corridor-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Bath & Tile
(
  'cont_bath_ec_002',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Mayfair Bath & Tile',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-8502',
  'https://www.mayfairbath.com',
  4.8,
  156,
  'mayfair-bath-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Lowry Bath Masters
(
  'cont_bath_ec_003',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Lowry Bath Masters',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-8503',
  'https://www.lowrybath.com',
  4.7,
  134,
  'lowry-bath-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. East Side Bath Co
(
  'cont_bath_ec_004',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'East Side Bath Co',
  '9000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-8504',
  'https://www.eastsidebath.com',
  4.8,
  167,
  'east-side-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Quebec Bath Studio
(
  'cont_bath_ec_005',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Quebec Bath Studio',
  '7300 E Quebec St, Denver, CO 80237',
  '(303) 555-8505',
  'https://www.quebecbath.com',
  4.9,
  189,
  'quebec-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Montclair Bath Design
(
  'cont_bath_ec_006',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Montclair Bath Design',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-8506',
  'https://www.montclairbath.com',
  4.7,
  145,
  'montclair-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Fitzsimons Bath Co
(
  'cont_bath_ec_007',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Fitzsimons Bath Co',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-8507',
  'https://www.fitzimonsbath.com',
  4.8,
  156,
  'fitzsimons-bath-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Stapleton Bath Studio
(
  'cont_bath_ec_008',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Stapleton Bath Studio',
  '7500 E 29th Ave, Denver, CO 80238',
  '(303) 555-8508',
  'https://www.stapletonbath.com',
  4.6,
  123,
  'stapleton-bath-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Aurora Bath Specialists
(
  'cont_bath_ec_009',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Aurora Bath Specialists',
  '10000 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-8509',
  'https://www.aurorabath.com',
  4.8,
  167,
  'aurora-bath-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Yosemite Bath Design
(
  'cont_bath_ec_010',
  'cat_bath_001',
  'neigh_east_colfax_001',
  'Yosemite Bath Design',
  '8000 E Yosemite St, Denver, CO 80230',
  '(303) 555-8510',
  'https://www.yosemitebath.com',
  4.7,
  145,
  'yosemite-bath-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
