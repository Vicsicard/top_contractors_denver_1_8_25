-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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

-- Insert 10 Painters for Central Parks area
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
-- 1. City Park Painting Co
(
  'cont_paint_cp_001',
  'cat_paint_001',
  'neigh_central_parks_001',
  'City Park Painting Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-5101',
  'https://www.cityparkpainting.com',
  4.9,
  187,
  'city-park-painting-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Cheesman Park Painters
(
  'cont_paint_cp_002',
  'cat_paint_001',
  'neigh_central_parks_001',
  'Cheesman Park Painters',
  '1177 Race St, Denver, CO 80206',
  '(303) 555-5102',
  'https://www.cheesmanparkpainters.com',
  4.8,
  156,
  'cheesman-park-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Congress Park Paint & Design
(
  'cont_paint_cp_003',
  'cat_paint_001',
  'neigh_central_parks_001',
  'Congress Park Paint & Design',
  '2800 E 12th Ave, Denver, CO 80206',
  '(303) 555-5103',
  'https://www.congressparkpainting.com',
  4.7,
  134,
  'congress-park-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Denver Zoo Area Painters
(
  'cont_paint_cp_004',
  'cat_paint_001',
  'neigh_central_parks_001',
  'Denver Zoo Area Painters',
  '2300 Steele St, Denver, CO 80205',
  '(303) 555-5104',
  'https://www.denverzooareapainters.com',
  4.8,
  145,
  'denver-zoo-area-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Museum District Paint Co
(
  'cont_paint_cp_005',
  'cat_paint_001',
  'neigh_central_parks_001',
  'Museum District Paint Co',
  '2001 Colorado Blvd, Denver, CO 80205',
  '(303) 555-5105',
  'https://www.museumdistrictpainting.com',
  4.9,
  176,
  'museum-district-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Botanic Gardens Painters
(
  'cont_paint_cp_006',
  'cat_paint_001',
  'neigh_central_parks_001',
  'Botanic Gardens Painters',
  '1007 York St, Denver, CO 80206',
  '(303) 555-5106',
  'https://www.botanicgardenspainters.com',
  4.7,
  132,
  'botanic-gardens-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East High Paint Solutions
(
  'cont_paint_cp_007',
  'cat_paint_001',
  'neigh_central_parks_001',
  'East High Paint Solutions',
  '1600 City Park Esplanade, Denver, CO 80206',
  '(303) 555-5107',
  'https://www.easthighpainting.com',
  4.8,
  123,
  'east-high-paint-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. City Park West Painters
(
  'cont_paint_cp_008',
  'cat_paint_001',
  'neigh_central_parks_001',
  'City Park West Painters',
  '2199 California St, Denver, CO 80205',
  '(303) 555-5108',
  'https://www.cityparkwestpainters.com',
  4.6,
  112,
  'city-park-west-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Park Avenue Paint Studio
(
  'cont_paint_cp_009',
  'cat_paint_001',
  'neigh_central_parks_001',
  'Park Avenue Paint Studio',
  '1978 Park Ave, Denver, CO 80205',
  '(303) 555-5109',
  'https://www.parkavenuepainting.com',
  4.8,
  156,
  'park-avenue-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Esplanade Paint & Design
(
  'cont_paint_cp_010',
  'cat_paint_001',
  'neigh_central_parks_001',
  'Esplanade Paint & Design',
  '1700 City Park Esplanade, Denver, CO 80206',
  '(303) 555-5110',
  'https://www.esplanadepainting.com',
  4.7,
  134,
  'esplanade-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
