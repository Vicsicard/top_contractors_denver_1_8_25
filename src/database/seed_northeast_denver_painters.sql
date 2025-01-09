-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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

-- Insert 10 Painters for Northeast Denver area
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
-- 1. Montbello Paint Masters
(
  'cont_paint_ne_001',
  'cat_paint_001',
  'neigh_northeast_001',
  'Montbello Paint Masters',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-5401',
  'https://www.montbellopainting.com',
  4.9,
  167,
  'montbello-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Painters
(
  'cont_paint_ne_002',
  'cat_paint_001',
  'neigh_northeast_001',
  'Green Valley Ranch Painters',
  '18501 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-5402',
  'https://www.gvrpainters.com',
  4.8,
  145,
  'green-valley-ranch-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Paint Co
(
  'cont_paint_ne_003',
  'cat_paint_001',
  'neigh_northeast_001',
  'Gateway Paint Co',
  '4855 N Salida St, Denver, CO 80239',
  '(303) 555-5403',
  'https://www.gatewaypainting.com',
  4.7,
  132,
  'gateway-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. DIA Corridor Painters
(
  'cont_paint_ne_004',
  'cat_paint_001',
  'neigh_northeast_001',
  'DIA Corridor Painters',
  '16001 E 40th Ave, Denver, CO 80239',
  '(303) 555-5404',
  'https://www.diacorridorpainting.com',
  4.8,
  156,
  'dia-corridor-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Tower Road Paint & Design
(
  'cont_paint_ne_005',
  'cat_paint_001',
  'neigh_northeast_001',
  'Tower Road Paint & Design',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-5405',
  'https://www.towerroadpainting.com',
  4.9,
  178,
  'tower-road-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Chambers Paint Studio
(
  'cont_paint_ne_006',
  'cat_paint_001',
  'neigh_northeast_001',
  'Chambers Paint Studio',
  '4600 Chambers Rd, Denver, CO 80239',
  '(303) 555-5406',
  'https://www.chamberspainting.com',
  4.7,
  134,
  'chambers-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Peña Boulevard Painters
(
  'cont_paint_ne_007',
  'cat_paint_001',
  'neigh_northeast_001',
  'Peña Boulevard Painters',
  '16200 E 40th Ave, Denver, CO 80239',
  '(303) 555-5407',
  'https://www.penablvdpainting.com',
  4.8,
  145,
  'pena-boulevard-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Airport Way Paint Pros
(
  'cont_paint_ne_008',
  'cat_paint_001',
  'neigh_northeast_001',
  'Airport Way Paint Pros',
  '16001 E 40th Circle, Denver, CO 80239',
  '(303) 555-5408',
  'https://www.airportwaypainting.com',
  4.6,
  123,
  'airport-way-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. First Creek Paint Co
(
  'cont_paint_ne_009',
  'cat_paint_001',
  'neigh_northeast_001',
  'First Creek Paint Co',
  '18250 E 51st Ave, Denver, CO 80249',
  '(303) 555-5409',
  'https://www.firstcreekpainting.com',
  4.8,
  156,
  'first-creek-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal Painters
(
  'cont_paint_ne_010',
  'cat_paint_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Painters',
  '4800 Telluride St, Denver, CO 80249',
  '(303) 555-5410',
  'https://www.rmapainting.com',
  4.7,
  134,
  'rocky-mountain-arsenal-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
