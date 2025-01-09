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

-- Insert 10 Roofers for Northeast Denver area
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
-- 1. Montbello Roofing Experts
(
  'cont_roof_ne_001',
  'cat_roof_001',
  'neigh_northeast_001',
  'Montbello Roofing Experts',
  '4880 Chambers Rd, Denver, CO 80239',
  '(303) 555-4401',
  'https://www.montbelloroofing.com',
  4.9,
  176,
  'montbello-roofing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Roofing
(
  'cont_roof_ne_002',
  'cat_roof_001',
  'neigh_northeast_001',
  'Green Valley Ranch Roofing',
  '18501 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-4402',
  'https://www.gvrroofing.com',
  4.8,
  154,
  'green-valley-ranch-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Roofing Solutions
(
  'cont_roof_ne_003',
  'cat_roof_001',
  'neigh_northeast_001',
  'Gateway Roofing Solutions',
  '4655 Peoria St, Denver, CO 80239',
  '(303) 555-4403',
  'https://www.gatewayroofingsolutions.com',
  4.7,
  143,
  'gateway-roofing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Roofing
(
  'cont_roof_ne_004',
  'cat_roof_001',
  'neigh_northeast_001',
  'DIA Corridor Roofing',
  '16001 E 40th Ave, Denver, CO 80239',
  '(303) 555-4404',
  'https://www.diacorridorroofing.com',
  4.8,
  165,
  'dia-corridor-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Tower Road Roofing Co
(
  'cont_roof_ne_005',
  'cat_roof_001',
  'neigh_northeast_001',
  'Tower Road Roofing Co',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-4405',
  'https://www.towerroadroofing.com',
  4.9,
  187,
  'tower-road-roofing-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Peña Boulevard Roofing
(
  'cont_roof_ne_006',
  'cat_roof_001',
  'neigh_northeast_001',
  'Peña Boulevard Roofing',
  '16200 E 40th Ave, Denver, CO 80239',
  '(303) 555-4406',
  'https://www.penablvdroofing.com',
  4.7,
  134,
  'pena-boulevard-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northeast Community Roofing
(
  'cont_roof_ne_007',
  'cat_roof_001',
  'neigh_northeast_001',
  'Northeast Community Roofing',
  '5000 Crown Blvd, Denver, CO 80239',
  '(303) 555-4407',
  'https://www.necommunityroofing.com',
  4.8,
  156,
  'northeast-community-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Far Northeast Roofing Pros
(
  'cont_roof_ne_008',
  'cat_roof_001',
  'neigh_northeast_001',
  'Far Northeast Roofing Pros',
  '18000 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-4408',
  'https://www.farnortheastroofing.com',
  4.6,
  123,
  'far-northeast-roofing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Airport Region Roofing
(
  'cont_roof_ne_009',
  'cat_roof_001',
  'neigh_northeast_001',
  'Airport Region Roofing',
  '15500 E 40th Ave, Denver, CO 80239',
  '(303) 555-4409',
  'https://www.airportregionroofing.com',
  4.8,
  167,
  'airport-region-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Chambers Road Roofing
(
  'cont_roof_ne_010',
  'cat_roof_001',
  'neigh_northeast_001',
  'Chambers Road Roofing',
  '4600 Chambers Rd, Denver, CO 80239',
  '(303) 555-4410',
  'https://www.chambersroadroofing.com',
  4.7,
  145,
  'chambers-road-roofing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
