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

-- Insert 10 Home Remodelers for Northeast Denver area
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
-- 1. Montbello Home Design
(
  'cont_remod_ne_001',
  'cat_remod_001',
  'neigh_northeast_001',
  'Montbello Home Design',
  '4685 Peoria St, Denver, CO 80239',
  '(303) 555-7401',
  'https://www.montbellohomedesign.com',
  4.9,
  167,
  'montbello-home-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Green Valley Ranch Remodeling
(
  'cont_remod_ne_002',
  'cat_remod_001',
  'neigh_northeast_001',
  'Green Valley Ranch Remodeling',
  '18500 Green Valley Ranch Blvd, Denver, CO 80249',
  '(303) 555-7402',
  'https://www.gvrremodeling.com',
  4.8,
  145,
  'green-valley-ranch-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Gateway Design Build
(
  'cont_remod_ne_003',
  'cat_remod_001',
  'neigh_northeast_001',
  'Gateway Design Build',
  '16300 E 40th Ave, Denver, CO 80239',
  '(303) 555-7403',
  'https://www.gatewaydesignbuild.com',
  4.7,
  134,
  'gateway-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Tower Road Renovations
(
  'cont_remod_ne_004',
  'cat_remod_001',
  'neigh_northeast_001',
  'Tower Road Renovations',
  '4500 Tower Rd, Denver, CO 80249',
  '(303) 555-7404',
  'https://www.towerroadrenovations.com',
  4.8,
  156,
  'tower-road-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. DIA Corridor Design Studio
(
  'cont_remod_ne_005',
  'cat_remod_001',
  'neigh_northeast_001',
  'DIA Corridor Design Studio',
  '16001 E 40th Circle, Aurora, CO 80011',
  '(303) 555-7405',
  'https://www.diacorridordesign.com',
  4.9,
  178,
  'dia-corridor-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Chambers Road Remodeling
(
  'cont_remod_ne_006',
  'cat_remod_001',
  'neigh_northeast_001',
  'Chambers Road Remodeling',
  '4600 Chambers Rd, Denver, CO 80239',
  '(303) 555-7406',
  'https://www.chambersroadremodeling.com',
  4.7,
  123,
  'chambers-road-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Peña Boulevard Design Co
(
  'cont_remod_ne_007',
  'cat_remod_001',
  'neigh_northeast_001',
  'Peña Boulevard Design Co',
  '16200 E 48th Ave, Denver, CO 80239',
  '(303) 555-7407',
  'https://www.penablvddesign.com',
  4.8,
  145,
  'pena-boulevard-design-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Far Northeast Renovations
(
  'cont_remod_ne_008',
  'cat_remod_001',
  'neigh_northeast_001',
  'Far Northeast Renovations',
  '5500 Crown Blvd, Denver, CO 80239',
  '(303) 555-7408',
  'https://www.farnortheastrenovations.com',
  4.6,
  112,
  'far-northeast-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Airport Way Design Build
(
  'cont_remod_ne_009',
  'cat_remod_001',
  'neigh_northeast_001',
  'Airport Way Design Build',
  '16901 E 48th Ave, Denver, CO 80249',
  '(303) 555-7409',
  'https://www.airportwaydesign.com',
  4.8,
  167,
  'airport-way-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal Remodeling
(
  'cont_remod_ne_010',
  'cat_remod_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Remodeling',
  '4800 Telluride St, Denver, CO 80249',
  '(303) 555-7410',
  'https://www.arsenalremodeling.com',
  4.7,
  134,
  'rocky-mountain-arsenal-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
