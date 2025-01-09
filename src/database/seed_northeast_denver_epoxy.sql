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

-- Ensure Northeast Denver subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_northeast_001',
  'reg_east_001',
  'Northeast Denver',
  'northeast-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_northeast_001',
  'subreg_northeast_001',
  'Northeast Denver',
  'northeast-denver',
  'Including Montbello, Green Valley Ranch, and Gateway areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Epoxy Garage contractors for Northeast Denver area
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
-- 1. Montbello Epoxy Solutions
(
  'cont_epoxy_ne_001',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'Montbello Epoxy Solutions',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-7401',
  'https://www.montbelloepoxy.com',
  4.9,
  152,
  'montbello-epoxy-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Garage Coatings
(
  'cont_epoxy_ne_002',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'Green Valley Ranch Garage Coatings',
  '18501 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-7402',
  'https://www.gvranchepoxy.com',
  4.8,
  138,
  'green-valley-ranch-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Epoxy Masters
(
  'cont_epoxy_ne_003',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'Gateway Epoxy Masters',
  '4855 N Salida St, Denver, CO 80239',
  '(303) 555-7403',
  'https://www.gatewayepoxy.com',
  4.7,
  124,
  'gateway-epoxy-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Garage Solutions
(
  'cont_epoxy_ne_004',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'DIA Corridor Garage Solutions',
  '16001 E 40th Ave, Denver, CO 80239',
  '(303) 555-7404',
  'https://www.diacorridorepoxy.com',
  4.8,
  143,
  'dia-corridor-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Tower Road Epoxy Pro
(
  'cont_epoxy_ne_005',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'Tower Road Epoxy Pro',
  '18890 E 47th Ave, Denver, CO 80249',
  '(303) 555-7405',
  'https://www.towerroadepoxy.com',
  4.9,
  156,
  'tower-road-epoxy-pro',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Peña Boulevard Garage Finishes
(
  'cont_epoxy_ne_006',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'Peña Boulevard Garage Finishes',
  '16200 E 40th Ave, Denver, CO 80239',
  '(303) 555-7406',
  'https://www.penablvdepoxy.com',
  4.7,
  119,
  'pena-boulevard-garage-finishes',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Rocky Mountain Arsenal Epoxy Specialists
(
  'cont_epoxy_ne_007',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Epoxy Specialists',
  '4800 Telluride St, Denver, CO 80249',
  '(303) 555-7407',
  'https://www.rmarsenalepoxy.com',
  4.8,
  132,
  'rocky-mountain-arsenal-epoxy-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Chambers Road Garage Coatings
(
  'cont_epoxy_ne_008',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'Chambers Road Garage Coatings',
  '4500 Chambers Rd, Denver, CO 80239',
  '(303) 555-7408',
  'https://www.chambersroadepoxy.com',
  4.6,
  105,
  'chambers-road-garage-coatings',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. First Creek Epoxy Pros
(
  'cont_epoxy_ne_009',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'First Creek Epoxy Pros',
  '18601 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-7409',
  'https://www.firstcreekepoxy.com',
  4.8,
  141,
  'first-creek-epoxy-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. High Point Garage Solutions
(
  'cont_epoxy_ne_010',
  'cat_epoxy_001',
  'neigh_northeast_001',
  'High Point Garage Solutions',
  '6500 N Tower Rd, Denver, CO 80249',
  '(303) 555-7410',
  'https://www.highpointepoxy.com',
  4.7,
  126,
  'high-point-garage-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
