-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Denver region exists (same as previous)
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
  'east-colfax-area',
  'Including East Colfax corridor and surrounding residential areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for East Colfax area
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
-- 1. East Colfax Plumbing Specialists
(
  'cont_plumb_ec_001',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'East Colfax Plumbing Specialists',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-0601',
  'https://www.eastcolfaxplumbing.com',
  4.8,
  187,
  'east-colfax-plumbing-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Plumbing Solutions
(
  'cont_plumb_ec_002',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Mayfair Plumbing Solutions',
  '1375 Krameria St, Denver, CO 80220',
  '(303) 555-0602',
  'https://www.mayfairplumbing.com',
  4.9,
  201,
  'mayfair-plumbing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Drain Experts
(
  'cont_plumb_ec_003',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Montclair Drain Experts',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-0603',
  'https://www.montclairdrains.com',
  4.7,
  167,
  'montclair-drain-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Aurora Border Plumbing
(
  'cont_plumb_ec_004',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Aurora Border Plumbing',
  '9800 E Colfax Ave, Denver, CO 80220',
  '(303) 555-0604',
  'https://www.auroraborderplumbing.com',
  4.8,
  178,
  'aurora-border-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Lowry Field Plumbing Services
(
  'cont_plumb_ec_005',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Lowry Field Plumbing Services',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-0605',
  'https://www.lowryfieldplumbing.com',
  4.6,
  156,
  'lowry-field-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Yosemite Street Plumbing
(
  'cont_plumb_ec_006',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Yosemite Street Plumbing',
  '7300 E Colfax Ave, Denver, CO 80220',
  '(303) 555-0606',
  'https://www.yosemiteplumbing.com',
  4.9,
  189,
  'yosemite-street-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Side Emergency Plumbers
(
  'cont_plumb_ec_007',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'East Side Emergency Plumbers',
  '8500 E Colfax Ave, Denver, CO 80220',
  '(303) 555-0607',
  'https://www.eastsideplumbers.com',
  4.8,
  198,
  'east-side-emergency-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Syracuse Street Plumbing Pros
(
  'cont_plumb_ec_008',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Syracuse Street Plumbing Pros',
  '1600 Syracuse St, Denver, CO 80220',
  '(303) 555-0608',
  'https://www.syracusestreetplumbing.com',
  4.7,
  167,
  'syracuse-street-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Ulster Street Plumbing & Drain
(
  'cont_plumb_ec_009',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Ulster Street Plumbing & Drain',
  '1500 Ulster St, Denver, CO 80220',
  '(303) 555-0609',
  'https://www.ulsterplumbing.com',
  4.8,
  176,
  'ulster-street-plumbing-drain',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Monaco Parkway East Plumbing
(
  'cont_plumb_ec_010',
  'cat_plumber_001',
  'neigh_east_colfax_001',
  'Monaco Parkway East Plumbing',
  '6500 E Colfax Ave, Denver, CO 80220',
  '(303) 555-0610',
  'https://www.monacoparkwayeastplumbing.com',
  4.7,
  182,
  'monaco-parkway-east-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
