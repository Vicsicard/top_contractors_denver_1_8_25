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

-- Create Northeast Denver subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_northeast_001',
  'reg_east_001',
  'Northeast Denver',
  'northeast-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Denver neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_northeast_001',
  'subreg_northeast_001',
  'Northeast Denver',
  'northeast-denver',
  'Including Montbello, Green Valley Ranch, and Gateway neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 HVAC contractors for Northeast Denver area
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
-- 1. Montbello HVAC Experts
(
  'cont_hvac_ne_001',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Montbello HVAC Experts',
  '4800 Peoria St, Denver, CO 80239',
  '(303) 555-3401',
  'https://www.montbellohvac.com',
  4.9,
  234,
  'montbello-hvac-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Air Systems
(
  'cont_hvac_ne_002',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Green Valley Ranch Air Systems',
  '18500 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-3402',
  'https://www.gvrhvac.com',
  4.8,
  198,
  'green-valley-ranch-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Climate Control
(
  'cont_hvac_ne_003',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Gateway Climate Control',
  '4600 Pena Blvd, Denver, CO 80239',
  '(303) 555-3403',
  'https://www.gatewayhvac.com',
  4.7,
  167,
  'gateway-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Area HVAC Services
(
  'cont_hvac_ne_004',
  'cat_hvac_001',
  'neigh_northeast_001',
  'DIA Area HVAC Services',
  '16100 E 40th Ave, Denver, CO 80239',
  '(303) 555-3404',
  'https://www.diahvac.com',
  4.8,
  189,
  'dia-area-hvac-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northeast Denver Climate Pros
(
  'cont_hvac_ne_005',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Northeast Denver Climate Pros',
  '5000 Crown Blvd, Denver, CO 80239',
  '(303) 555-3405',
  'https://www.northeastdenverhvac.com',
  4.9,
  212,
  'northeast-denver-climate-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Tower Road HVAC
(
  'cont_hvac_ne_006',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Tower Road HVAC',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-3406',
  'https://www.towerroadhvac.com',
  4.7,
  178,
  'tower-road-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Chambers Road Air Solutions
(
  'cont_hvac_ne_007',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Chambers Road Air Solutions',
  '4200 Chambers Rd, Denver, CO 80239',
  '(303) 555-3407',
  'https://www.chambersrdhvac.com',
  4.8,
  167,
  'chambers-road-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Airport Way HVAC
(
  'cont_hvac_ne_008',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Airport Way HVAC',
  '16900 E 32nd Ave, Aurora, CO 80011',
  '(303) 555-3408',
  'https://www.airportwayhvac.com',
  4.6,
  156,
  'airport-way-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Far Northeast Climate Services
(
  'cont_hvac_ne_009',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Far Northeast Climate Services',
  '5500 Havana St, Denver, CO 80239',
  '(303) 555-3409',
  'https://www.farnortheasthvac.com',
  4.8,
  201,
  'far-northeast-climate-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal HVAC
(
  'cont_hvac_ne_010',
  'cat_hvac_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal HVAC',
  '4800 Havana St, Denver, CO 80239',
  '(303) 555-3410',
  'https://www.rmadenver-hvac.com',
  4.7,
  182,
  'rocky-mountain-arsenal-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
