-- Ensure Epoxy Garage category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_epoxy_001',
  'Epoxy Garage',
  'epoxy-garage',
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

-- Insert 10 Epoxy Garage contractors for East Colfax area
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
-- 1. East Colfax Epoxy Solutions
(
  'cont_epoxy_ec_001',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'East Colfax Epoxy Solutions',
  '8001 E Colfax Ave, Denver, CO 80220',
  '(303) 555-7501',
  'https://www.eastcolfaxepoxy.com',
  4.9,
  148,
  'east-colfax-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Garage Coatings
(
  'cont_epoxy_ec_002',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Mayfair Garage Coatings',
  '1400 Krameria St, Denver, CO 80220',
  '(303) 555-7502',
  'https://www.mayfairepoxy.com',
  4.8,
  135,
  'mayfair-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Epoxy Masters
(
  'cont_epoxy_ec_003',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Montclair Epoxy Masters',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-7503',
  'https://www.montclairepoxy.com',
  4.7,
  121,
  'montclair-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Lowry Field Garage Solutions
(
  'cont_epoxy_ec_004',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Lowry Field Garage Solutions',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-7504',
  'https://www.lowryfieldepoxy.com',
  4.8,
  140,
  'lowry-field-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Hale Epoxy Pro
(
  'cont_epoxy_ec_005',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Hale Epoxy Pro',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-7505',
  'https://www.haleepoxy.com',
  4.9,
  153,
  'hale-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Quebec Street Garage Finishes
(
  'cont_epoxy_ec_006',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Quebec Street Garage Finishes',
  '7300 E Quebec St, Denver, CO 80237',
  '(303) 555-7506',
  'https://www.quebecstreetepoxy.com',
  4.7,
  116,
  'quebec-street-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Fitzsimons Epoxy Specialists
(
  'cont_epoxy_ec_007',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Fitzsimons Epoxy Specialists',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-7507',
  'https://www.fitzsimonsepoxy.com',
  4.8,
  129,
  'fitzsimons-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Delmar Parkway Garage Coatings
(
  'cont_epoxy_ec_008',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Delmar Parkway Garage Coatings',
  '1500 Delmar Pkwy, Aurora, CO 80010',
  '(303) 555-7508',
  'https://www.delmarparkwayepoxy.com',
  4.6,
  102,
  'delmar-parkway-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Aurora Heights Epoxy Pros
(
  'cont_epoxy_ec_009',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Aurora Heights Epoxy Pros',
  '9801 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-7509',
  'https://www.auroraheightsepoxy.com',
  4.8,
  138,
  'aurora-heights-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Stanley Marketplace Garage Solutions
(
  'cont_epoxy_ec_010',
  'cat_epoxy_001',
  'neigh_east_colfax_001',
  'Stanley Marketplace Garage Solutions',
  '2501 Dallas St, Aurora, CO 80010',
  '(303) 555-7510',
  'https://www.stanleymarketepoxy.com',
  4.7,
  123,
  'stanley-marketplace-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
