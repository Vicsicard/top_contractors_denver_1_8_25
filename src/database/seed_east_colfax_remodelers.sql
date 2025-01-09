-- Ensure Home Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_remod_001',
  'Home Remodelers',
  'home-remodelers',
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
  'Including East Colfax corridor and surrounding residential areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Home Remodelers for East Colfax area
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
-- 1. Colfax Corridor Design
(
  'cont_remod_ec_001',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Colfax Corridor Design',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7501',
  'https://www.colfaxcorridordesign.com',
  4.9,
  178,
  'colfax-corridor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Remodeling Co
(
  'cont_remod_ec_002',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Mayfair Remodeling Co',
  '1300 Ivy St, Denver, CO 80220',
  '(303) 555-7502',
  'https://www.mayfairremodeling.com',
  4.8,
  145,
  'mayfair-remodeling-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. East Side Design Build
(
  'cont_remod_ec_003',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'East Side Design Build',
  '7100 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7503',
  'https://www.eastsidedesignbuild.com',
  4.7,
  134,
  'east-side-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Quebec Street Renovations
(
  'cont_remod_ec_004',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Quebec Street Renovations',
  '7300 Quebec St, Commerce City, CO 80022',
  '(303) 555-7504',
  'https://www.quebecstrenovations.com',
  4.8,
  156,
  'quebec-street-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Lowry Design Studio
(
  'cont_remod_ec_005',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Lowry Design Studio',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-7505',
  'https://www.lowrydesignstudio.com',
  4.9,
  167,
  'lowry-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Monaco Parkway Remodeling
(
  'cont_remod_ec_006',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Monaco Parkway Remodeling',
  '6500 Monaco St, Commerce City, CO 80022',
  '(303) 555-7506',
  'https://www.monacoparkwayremodel.com',
  4.7,
  123,
  'monaco-parkway-remodeling-ec',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Stapleton Design Co
(
  'cont_remod_ec_007',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Stapleton Design Co',
  '7700 E 29th Ave, Denver, CO 80238',
  '(303) 555-7507',
  'https://www.stapletondesignco.com',
  4.8,
  145,
  'stapleton-design-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Aurora Border Renovations
(
  'cont_remod_ec_008',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Aurora Border Renovations',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-7508',
  'https://www.auroraborderrenovations.com',
  4.6,
  112,
  'aurora-border-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Fitzsimons Design Build
(
  'cont_remod_ec_009',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Fitzsimons Design Build',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-7509',
  'https://www.fitzsimonsdesign.com',
  4.8,
  167,
  'fitzsimons-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Yosemite Street Remodeling
(
  'cont_remod_ec_010',
  'cat_remod_001',
  'neigh_east_colfax_001',
  'Yosemite Street Remodeling',
  '7400 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7510',
  'https://www.yosemiteremodeling.com',
  4.7,
  134,
  'yosemite-street-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
