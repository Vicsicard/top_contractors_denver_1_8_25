-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
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

-- Create East Colfax subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_east_colfax_001',
  'reg_east_001',
  'East Colfax Area',
  'east-colfax-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create East Colfax neighborhood
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

-- Insert 10 electricians for East Colfax area
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
-- 1. East Colfax Electric Masters
(
  'cont_elec_ec_001',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'East Colfax Electric Masters',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-2501',
  'https://www.eastcolfaxelectric.com',
  4.9,
  234,
  'east-colfax-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Electrical Solutions
(
  'cont_elec_ec_002',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Mayfair Electrical Solutions',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-2502',
  'https://www.mayfairelectrical.com',
  4.8,
  198,
  'mayfair-electrical-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Electric Experts
(
  'cont_elec_ec_003',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Montclair Electric Experts',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-2503',
  'https://www.montclairelectric.com',
  4.7,
  167,
  'montclair-electric-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Hale Electric Pros
(
  'cont_elec_ec_004',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Hale Electric Pros',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-2504',
  'https://www.haleelectric.com',
  4.8,
  189,
  'hale-electric-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Lowry Field Electric
(
  'cont_elec_ec_005',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Lowry Field Electric',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-2505',
  'https://www.lowryfieldelectric.com',
  4.6,
  156,
  'lowry-field-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Aurora Boundary Electric
(
  'cont_elec_ec_006',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Aurora Boundary Electric',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-2506',
  'https://www.auroraboundaryelectric.com',
  4.9,
  212,
  'aurora-boundary-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Side Electrical Services
(
  'cont_elec_ec_007',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'East Side Electrical Services',
  '7100 E Colfax Ave, Denver, CO 80220',
  '(303) 555-2507',
  'https://www.eastsideelectrical.com',
  4.8,
  167,
  'east-side-electrical-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Fitzsimons Electric
(
  'cont_elec_ec_008',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Fitzsimons Electric',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-2508',
  'https://www.fitzsimonselectric.com',
  4.7,
  178,
  'fitzsimons-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Quebec Street Electric
(
  'cont_elec_ec_009',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Quebec Street Electric',
  '7300 E Quebec St, Denver, CO 80237',
  '(303) 555-2509',
  'https://www.quebecstreetelectric.com',
  4.8,
  201,
  'quebec-street-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Yosemite Electric Services
(
  'cont_elec_ec_010',
  'cat_elec_001',
  'neigh_east_colfax_001',
  'Yosemite Electric Services',
  '8000 E Yosemite St, Denver, CO 80230',
  '(303) 555-2510',
  'https://www.yosemiteelectric.com',
  4.7,
  182,
  'yosemite-electric-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
