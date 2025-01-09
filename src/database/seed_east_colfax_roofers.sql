-- Ensure Roofers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_roof_001',
  'Roofers',
  'roofers',
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

-- Insert 10 Roofers for East Colfax area
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
-- 1. East Colfax Roofing Specialists
(
  'cont_roof_ec_001',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'East Colfax Roofing Specialists',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-4501',
  'https://www.eastcolfaxroofing.com',
  4.9,
  189,
  'east-colfax-roofing-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Roofing Co
(
  'cont_roof_ec_002',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Mayfair Roofing Co',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-4502',
  'https://www.mayfairroofing.com',
  4.8,
  167,
  'mayfair-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Lowry Field Roofing
(
  'cont_roof_ec_003',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Lowry Field Roofing',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-4503',
  'https://www.lowryfieldroofing.com',
  4.7,
  145,
  'lowry-field-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Quebec Square Roofing
(
  'cont_roof_ec_004',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Quebec Square Roofing',
  '7305 E 35th Ave, Denver, CO 80238',
  '(303) 555-4504',
  'https://www.quebecsquareroofing.com',
  4.8,
  156,
  'quebec-square-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Stapleton Roofing Solutions
(
  'cont_roof_ec_005',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Stapleton Roofing Solutions',
  '7500 E 29th Ave, Denver, CO 80238',
  '(303) 555-4505',
  'https://www.stapletonroofing.com',
  4.9,
  178,
  'stapleton-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Aurora Boundary Roofing
(
  'cont_roof_ec_006',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Aurora Boundary Roofing',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-4506',
  'https://www.auroraboundaryroofing.com',
  4.7,
  134,
  'aurora-boundary-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Fitzsimons Area Roofing
(
  'cont_roof_ec_007',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Fitzsimons Area Roofing',
  '13123 E 16th Ave, Aurora, CO 80045',
  '(303) 555-4507',
  'https://www.fitzsimonsroofing.com',
  4.8,
  145,
  'fitzsimons-area-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Delmar Parkway Roofing
(
  'cont_roof_ec_008',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Delmar Parkway Roofing',
  '1600 Ulster St, Denver, CO 80220',
  '(303) 555-4508',
  'https://www.delmarparkwayroofing.com',
  4.6,
  123,
  'delmar-parkway-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Yosemite Street Roofing
(
  'cont_roof_ec_009',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Yosemite Street Roofing',
  '1800 Yosemite St, Denver, CO 80220',
  '(303) 555-4509',
  'https://www.yosemiteroofing.com',
  4.8,
  167,
  'yosemite-street-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Monaco Parkway East Roofing
(
  'cont_roof_ec_010',
  'cat_roof_001',
  'neigh_east_colfax_001',
  'Monaco Parkway East Roofing',
  '6000 Monaco St, Commerce City, CO 80022',
  '(303) 555-4510',
  'https://www.monacoparkwayeastroofing.com',
  4.7,
  145,
  'monaco-parkway-east-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
