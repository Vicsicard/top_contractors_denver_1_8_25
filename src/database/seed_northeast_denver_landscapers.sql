-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for Northeast Denver area
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
-- 1. Montbello Garden Masters
(
  'cont_land_ne_001',
  'cat_land_001',
  'neigh_northeast_001',
  'Montbello Garden Masters',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-6401',
  'https://www.montbellogardens.com',
  4.9,
  167,
  'montbello-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Landscape Design
(
  'cont_land_ne_002',
  'cat_land_001',
  'neigh_northeast_001',
  'Green Valley Ranch Landscape Design',
  '18250 E Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-6402',
  'https://www.gvrlandscape.com',
  4.8,
  145,
  'green-valley-ranch-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Gardens
(
  'cont_land_ne_003',
  'cat_land_001',
  'neigh_northeast_001',
  'Gateway Gardens',
  '4800 Tower Rd, Denver, CO 80249',
  '(303) 555-6403',
  'https://www.gatewaygardens.com',
  4.7,
  132,
  'gateway-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Landscaping
(
  'cont_land_ne_004',
  'cat_land_001',
  'neigh_northeast_001',
  'DIA Corridor Landscaping',
  '16000 E 40th Ave, Denver, CO 80239',
  '(303) 555-6404',
  'https://www.diacorridorlandscaping.com',
  4.8,
  156,
  'dia-corridor-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Peña Boulevard Garden Design
(
  'cont_land_ne_005',
  'cat_land_001',
  'neigh_northeast_001',
  'Peña Boulevard Garden Design',
  '16100 E 40th Ave, Denver, CO 80239',
  '(303) 555-6405',
  'https://www.penablvdgardens.com',
  4.9,
  178,
  'pena-boulevard-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Rocky Mountain Arsenal Gardens
(
  'cont_land_ne_006',
  'cat_land_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Gardens',
  '5650 Havana St, Denver, CO 80239',
  '(303) 555-6406',
  'https://www.rmagardens.com',
  4.7,
  134,
  'rocky-mountain-arsenal-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Northeast Commons Landscape Co
(
  'cont_land_ne_007',
  'cat_land_001',
  'neigh_northeast_001',
  'Northeast Commons Landscape Co',
  '5500 Crown Blvd, Denver, CO 80239',
  '(303) 555-6407',
  'https://www.necommonslandscape.com',
  4.8,
  145,
  'northeast-commons-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. First Creek Garden Studio
(
  'cont_land_ne_008',
  'cat_land_001',
  'neigh_northeast_001',
  'First Creek Garden Studio',
  '18601 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-6408',
  'https://www.firstcreekgardens.com',
  4.6,
  123,
  'first-creek-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Chambers Road Landscape Design
(
  'cont_land_ne_009',
  'cat_land_001',
  'neigh_northeast_001',
  'Chambers Road Landscape Design',
  '4500 Chambers Rd, Denver, CO 80239',
  '(303) 555-6409',
  'https://www.chamberslandscape.com',
  4.8,
  156,
  'chambers-road-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Tower Road Gardens
(
  'cont_land_ne_010',
  'cat_land_001',
  'neigh_northeast_001',
  'Tower Road Gardens',
  '18000 Tower Rd, Denver, CO 80249',
  '(303) 555-6410',
  'https://www.towerroadgardens.com',
  4.7,
  134,
  'tower-road-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
