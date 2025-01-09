-- Ensure Siding & Gutters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_siding_001',
  'Siding & Gutters',
  'siding-gutters',
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

-- Insert 10 Siding & Gutters contractors for East Colfax area
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
-- 1. East Colfax Siding & Gutters
(
  'cont_siding_ec_001',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'East Colfax Siding & Gutters',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7501',
  'https://www.eastcolfaxsiding.com',
  4.9,
  182,
  'east-colfax-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Exteriors
(
  'cont_siding_ec_002',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Mayfair Exteriors',
  '1400 Krameria St, Denver, CO 80220',
  '(303) 555-7502',
  'https://www.mayfairexteriors.com',
  4.8,
  165,
  'mayfair-exteriors',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Gutter Masters
(
  'cont_siding_ec_003',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Montclair Gutter Masters',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-7503',
  'https://www.montclairgutter.com',
  4.7,
  143,
  'montclair-gutter-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Lowry Field Siding Solutions
(
  'cont_siding_ec_004',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Lowry Field Siding Solutions',
  '7600 E Academy Blvd, Denver, CO 80230',
  '(303) 555-7504',
  'https://www.lowryfieldsiding.com',
  4.8,
  176,
  'lowry-field-siding-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Quebec Street Gutter Co
(
  'cont_siding_ec_005',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Quebec Street Gutter Co',
  '7300 E Quebec St, Denver, CO 80230',
  '(303) 555-7505',
  'https://www.quebecgutter.com',
  4.9,
  195,
  'quebec-street-gutter-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Hale Siding & Gutters
(
  'cont_siding_ec_006',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Hale Siding & Gutters',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-7506',
  'https://www.halesiding.com',
  4.7,
  134,
  'hale-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Side Exterior Specialists
(
  'cont_siding_ec_007',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'East Side Exterior Specialists',
  '9000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7507',
  'https://www.eastsideexteriors.com',
  4.8,
  156,
  'east-side-exterior-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Aurora Border Siding & Gutters
(
  'cont_siding_ec_008',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Aurora Border Siding & Gutters',
  '9800 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7508',
  'https://www.aurorabordersiding.com',
  4.6,
  122,
  'aurora-border-siding-gutters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Monaco Gutter Pros
(
  'cont_siding_ec_009',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Monaco Gutter Pros',
  '6000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7509',
  'https://www.monacogutterpros.com',
  4.8,
  167,
  'monaco-gutter-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rose Medical Siding
(
  'cont_siding_ec_010',
  'cat_siding_001',
  'neigh_east_colfax_001',
  'Rose Medical Siding',
  '4567 E 9th Ave, Denver, CO 80220',
  '(303) 555-7510',
  'https://www.rosemedicalsiding.com',
  4.7,
  145,
  'rose-medical-siding',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
