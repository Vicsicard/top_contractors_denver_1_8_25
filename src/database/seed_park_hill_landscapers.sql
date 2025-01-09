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

-- Insert 10 Landscapers for Park Hill area
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
-- 1. Park Hill Garden Masters
(
  'cont_land_ph_001',
  'cat_land_001',
  'neigh_park_hill_001',
  'Park Hill Garden Masters',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-6301',
  'https://www.parkhillgardens.com',
  4.9,
  167,
  'park-hill-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. North Park Hill Landscape Design
(
  'cont_land_ph_002',
  'cat_land_001',
  'neigh_park_hill_001',
  'North Park Hill Landscape Design',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-6302',
  'https://www.northparkhilllandscape.com',
  4.8,
  145,
  'north-park-hill-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. South Park Hill Gardens
(
  'cont_land_ph_003',
  'cat_land_001',
  'neigh_park_hill_001',
  'South Park Hill Gardens',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-6303',
  'https://www.southparkhillgardens.com',
  4.7,
  132,
  'south-park-hill-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Historic Park Hill Landscaping
(
  'cont_land_ph_004',
  'cat_land_001',
  'neigh_park_hill_001',
  'Historic Park Hill Landscaping',
  '2345 Forest St, Denver, CO 80207',
  '(303) 555-6304',
  'https://www.historicparkhilllandscaping.com',
  4.8,
  156,
  'historic-park-hill-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Montview Garden Design
(
  'cont_land_ph_005',
  'cat_land_001',
  'neigh_park_hill_001',
  'Montview Garden Design',
  '2800 Montview Blvd, Denver, CO 80207',
  '(303) 555-6305',
  'https://www.montviewgardens.com',
  4.9,
  178,
  'montview-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 23rd Avenue Gardens
(
  'cont_land_ph_006',
  'cat_land_001',
  'neigh_park_hill_001',
  '23rd Avenue Gardens',
  '4500 E 23rd Ave, Denver, CO 80207',
  '(303) 555-6306',
  'https://www.23rdavenuegardens.com',
  4.7,
  134,
  '23rd-avenue-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Monaco Parkway Landscape Co
(
  'cont_land_ph_007',
  'cat_land_001',
  'neigh_park_hill_001',
  'Monaco Parkway Landscape Co',
  '2900 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-6307',
  'https://www.monacoparkwaylandscape.com',
  4.8,
  145,
  'monaco-parkway-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northeast Park Hill Gardens
(
  'cont_land_ph_008',
  'cat_land_001',
  'neigh_park_hill_001',
  'Northeast Park Hill Gardens',
  '3800 Dahlia St, Denver, CO 80207',
  '(303) 555-6308',
  'https://www.nephillgardens.com',
  4.6,
  123,
  'northeast-park-hill-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Fairfax Garden Studio
(
  'cont_land_ph_009',
  'cat_land_001',
  'neigh_park_hill_001',
  'Fairfax Garden Studio',
  '2600 Fairfax St, Denver, CO 80207',
  '(303) 555-6309',
  'https://www.fairfaxgardens.com',
  4.8,
  156,
  'fairfax-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Eudora Street Landscape Design
(
  'cont_land_ph_010',
  'cat_land_001',
  'neigh_park_hill_001',
  'Eudora Street Landscape Design',
  '2700 Eudora St, Denver, CO 80207',
  '(303) 555-6310',
  'https://www.eudoralandscape.com',
  4.7,
  134,
  'eudora-street-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
