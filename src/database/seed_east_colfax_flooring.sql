-- Ensure Flooring category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_flooring_001',
  'Flooring',
  'flooring',
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

-- Insert 10 Flooring contractors for East Colfax area
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
-- 1. East Colfax Flooring Works
(
  'cont_floor_ec_001',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'East Colfax Flooring Works',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7501',
  'https://www.eastcolfaxflooring.com',
  4.9,
  175,
  'east-colfax-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Floor & Tile
(
  'cont_floor_ec_002',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Mayfair Floor & Tile',
  '1400 Krameria St, Denver, CO 80220',
  '(303) 555-7502',
  'https://www.mayfairflooring.com',
  4.8,
  153,
  'mayfair-floor-tile',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Floor Masters
(
  'cont_floor_ec_003',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Montclair Floor Masters',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-7503',
  'https://www.montclairflooring.com',
  4.7,
  138,
  'montclair-floor-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Lowry Flooring Solutions
(
  'cont_floor_ec_004',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Lowry Flooring Solutions',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-7504',
  'https://www.lowryflooring.com',
  4.8,
  165,
  'lowry-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Aurora Boulevard Floor Co
(
  'cont_floor_ec_005',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Aurora Boulevard Floor Co',
  '9801 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-7505',
  'https://www.aurorablvdflooring.com',
  4.9,
  182,
  'aurora-boulevard-floor-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Fitzsimons Flooring Works
(
  'cont_floor_ec_006',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Fitzsimons Flooring Works',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-7506',
  'https://www.fitzsimonsflooring.com',
  4.7,
  142,
  'fitzsimons-flooring-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Stapleton Floor Specialists
(
  'cont_floor_ec_007',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Stapleton Floor Specialists',
  '7351 E 29th Ave, Denver, CO 80238',
  '(303) 555-7507',
  'https://www.stapletonflooring.com',
  4.8,
  156,
  'stapleton-floor-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Hale Floor & Design
(
  'cont_floor_ec_008',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Hale Floor & Design',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-7508',
  'https://www.haleflooring.com',
  4.6,
  125,
  'hale-floor-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Quebec Street Floor Pros
(
  'cont_floor_ec_009',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Quebec Street Floor Pros',
  '7305 E 35th Ave, Denver, CO 80238',
  '(303) 555-7509',
  'https://www.quebecstreetflooring.com',
  4.8,
  164,
  'quebec-street-floor-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Yosemite Flooring Solutions
(
  'cont_floor_ec_010',
  'cat_flooring_001',
  'neigh_east_colfax_001',
  'Yosemite Flooring Solutions',
  '1200 Yosemite St, Denver, CO 80220',
  '(303) 555-7510',
  'https://www.yosemiteflooring.com',
  4.7,
  140,
  'yosemite-flooring-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
