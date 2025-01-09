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

-- Ensure Park Hill subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_park_hill_001',
  'reg_east_001',
  'Park Hill',
  'park-hill',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Park Hill neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_park_hill_001',
  'subreg_park_hill_001',
  'Park Hill',
  'park-hill',
  'Including North Park Hill, South Park Hill, and Northeast Park Hill areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Painters for Park Hill area
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
-- 1. Park Hill Paint Masters
(
  'cont_paint_ph_001',
  'cat_paint_001',
  'neigh_park_hill_001',
  'Park Hill Paint Masters',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-5301',
  'https://www.parkhillpainting.com',
  4.9,
  167,
  'park-hill-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Painters
(
  'cont_paint_ph_002',
  'cat_paint_001',
  'neigh_park_hill_001',
  'North Park Hill Painters',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-5302',
  'https://www.northparkhillpainters.com',
  4.8,
  145,
  'north-park-hill-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Paint Co
(
  'cont_paint_ph_003',
  'cat_paint_001',
  'neigh_park_hill_001',
  'South Park Hill Paint Co',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-5303',
  'https://www.southparkhillpainting.com',
  4.7,
  132,
  'south-park-hill-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Historic Park Hill Painters
(
  'cont_paint_ph_004',
  'cat_paint_001',
  'neigh_park_hill_001',
  'Historic Park Hill Painters',
  '2345 Forest St, Denver, CO 80207',
  '(303) 555-5304',
  'https://www.historicparkhillpainting.com',
  4.8,
  156,
  'historic-park-hill-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Montview Paint & Design
(
  'cont_paint_ph_005',
  'cat_paint_001',
  'neigh_park_hill_001',
  'Montview Paint & Design',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-5305',
  'https://www.montviewpainting.com',
  4.9,
  178,
  'montview-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 23rd Avenue Painters
(
  'cont_paint_ph_006',
  'cat_paint_001',
  'neigh_park_hill_001',
  '23rd Avenue Painters',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-5306',
  'https://www.23rdavenuepainters.com',
  4.7,
  134,
  '23rd-avenue-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Monaco Paint Studio
(
  'cont_paint_ph_007',
  'cat_paint_001',
  'neigh_park_hill_001',
  'Monaco Paint Studio',
  '2900 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-5307',
  'https://www.monacopainting.com',
  4.8,
  145,
  'monaco-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northeast Park Hill Painters
(
  'cont_paint_ph_008',
  'cat_paint_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Painters',
  '3800 Dahlia St, Denver, CO 80207',
  '(303) 555-5308',
  'https://www.nephillpainters.com',
  4.6,
  123,
  'northeast-park-hill-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Fairfax Paint Pros
(
  'cont_paint_ph_009',
  'cat_paint_001',
  'neigh_park_hill_001',
  'Fairfax Paint Pros',
  '2600 Fairfax St, Denver, CO 80207',
  '(303) 555-5309',
  'https://www.fairfaxpainting.com',
  4.8,
  156,
  'fairfax-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Eudora Street Painters
(
  'cont_paint_ph_010',
  'cat_paint_001',
  'neigh_park_hill_001',
  'Eudora Street Painters',
  '2700 Eudora St, Denver, CO 80207',
  '(303) 555-5310',
  'https://www.eudorapainting.com',
  4.7,
  134,
  'eudora-street-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
