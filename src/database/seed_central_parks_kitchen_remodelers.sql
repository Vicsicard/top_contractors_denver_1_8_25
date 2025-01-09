-- Ensure Kitchen Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Central Denver region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_central_001',
  'Central Denver',
  'central-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Central Parks subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_central_parks_001',
  'reg_central_001',
  'Central Parks',
  'central-parks',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Central Parks neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_central_parks_001',
  'subreg_central_parks_001',
  'Central Parks',
  'central-parks',
  'Including City Park, City Park West, Congress Park, and Cheesman Park areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Kitchen Remodelers for Central Parks area
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
-- 1. City Park Kitchen Design
(
  'cont_kitchen_cp_001',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'City Park Kitchen Design',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-9101',
  'https://www.cityparkitchen.com',
  4.9,
  188,
  'city-park-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Kitchen & Cabinets
(
  'cont_kitchen_cp_002',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'Cheesman Park Kitchen & Cabinets',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-9102',
  'https://www.cheesmanparkkitchen.com',
  4.8,
  155,
  'cheesman-park-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Kitchen Masters
(
  'cont_kitchen_cp_003',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'Congress Park Kitchen Masters',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-9103',
  'https://www.congressparkkitchen.com',
  4.7,
  144,
  'congress-park-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Zoo Area Kitchen Co
(
  'cont_kitchen_cp_004',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'Zoo Area Kitchen Co',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-9104',
  'https://www.zooareakitchen.com',
  4.8,
  166,
  'zoo-area-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Kitchen Studio
(
  'cont_kitchen_cp_005',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'Museum District Kitchen Studio',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-9105',
  'https://www.museumdistrictkitchen.com',
  4.9,
  177,
  'museum-district-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Kitchen Design
(
  'cont_kitchen_cp_006',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'Botanic Gardens Kitchen Design',
  '1007 York St, Denver, CO 80206',
  '(303) 555-9106',
  'https://www.botanicgardensskitchen.com',
  4.7,
  133,
  'botanic-gardens-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Kitchen Specialists
(
  'cont_kitchen_cp_007',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'East High Kitchen Specialists',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-9107',
  'https://www.easthighkitchen.com',
  4.8,
  155,
  'east-high-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Kitchen & Design
(
  'cont_kitchen_cp_008',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'City Park West Kitchen & Design',
  '2199 California St, Denver, CO 80205',
  '(303) 555-9108',
  'https://www.cityparkwestkitchen.com',
  4.6,
  122,
  'city-park-west-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Kitchen Design
(
  'cont_kitchen_cp_009',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'Park Avenue Kitchen Design',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-9109',
  'https://www.parkavenuekitchen.com',
  4.8,
  177,
  'park-avenue-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Kitchen Studio
(
  'cont_kitchen_cp_010',
  'cat_kitchen_001',
  'neigh_central_parks_001',
  'Esplanade Kitchen Studio',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-9110',
  'https://www.esplanadekitchen.com',
  4.7,
  144,
  'esplanade-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
