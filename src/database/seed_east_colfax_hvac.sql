-- Ensure HVAC category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
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
  'East Colfax',
  'east-colfax',
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

-- Insert 10 HVAC contractors for East Colfax area
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
-- 1. East Colfax HVAC Masters
(
  'cont_hvac_ec_001',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'East Colfax HVAC Masters',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-3501',
  'https://www.eastcolfaxhvac.com',
  4.9,
  234,
  'east-colfax-hvac-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Air Systems
(
  'cont_hvac_ec_002',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'Mayfair Air Systems',
  '1400 Krameria St, Denver, CO 80220',
  '(303) 555-3502',
  'https://www.mayfairhvac.com',
  4.8,
  198,
  'mayfair-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Climate Control
(
  'cont_hvac_ec_003',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'Montclair Climate Control',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-3503',
  'https://www.montclairhvac.com',
  4.7,
  167,
  'montclair-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Hale HVAC Services
(
  'cont_hvac_ec_004',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'Hale HVAC Services',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-3504',
  'https://www.halehvac.com',
  4.8,
  189,
  'hale-hvac-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. South Park Hill Climate Pros
(
  'cont_hvac_ec_005',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'South Park Hill Climate Pros',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-3505',
  'https://www.southparkhillhvac.com',
  4.9,
  212,
  'south-park-hill-climate-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Quebec Street HVAC
(
  'cont_hvac_ec_006',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'Quebec Street HVAC',
  '7400 E Colfax Ave, Denver, CO 80220',
  '(303) 555-3506',
  'https://www.quebecstreethvac.com',
  4.7,
  178,
  'quebec-street-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Lowry Air Solutions
(
  'cont_hvac_ec_007',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'Lowry Air Solutions',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-3507',
  'https://www.lowryhvac.com',
  4.8,
  167,
  'lowry-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Aurora Border HVAC
(
  'cont_hvac_ec_008',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'Aurora Border HVAC',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-3508',
  'https://www.auroraborderhvac.com',
  4.6,
  156,
  'aurora-border-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. East Side Climate Services
(
  'cont_hvac_ec_009',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'East Side Climate Services',
  '6500 E Colfax Ave, Denver, CO 80220',
  '(303) 555-3509',
  'https://www.eastsidehvac.com',
  4.8,
  201,
  'east-side-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Monaco HVAC Specialists
(
  'cont_hvac_ec_010',
  'cat_hvac_001',
  'neigh_east_colfax_001',
  'Monaco HVAC Specialists',
  '5800 E Colfax Ave, Denver, CO 80220',
  '(303) 555-3510',
  'https://www.monacohvac.com',
  4.7,
  182,
  'monaco-hvac-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
