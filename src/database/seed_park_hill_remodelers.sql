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

-- Insert 10 Home Remodelers for Park Hill area
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
-- 1. Park Hill Home Design
(
  'cont_remod_ph_001',
  'cat_remod_001',
  'neigh_park_hill_001',
  'Park Hill Home Design',
  '2300 Dahlia St, Denver, CO 80207',
  '(303) 555-7301',
  'https://www.parkhillhomedesign.com',
  4.9,
  167,
  'park-hill-home-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Montview Renovation Co
(
  'cont_remod_ph_002',
  'cat_remod_001',
  'neigh_park_hill_001',
  'Montview Renovation Co',
  '1900 Montview Blvd, Denver, CO 80220',
  '(303) 555-7302',
  'https://www.montviewrenovation.com',
  4.8,
  145,
  'montview-renovation-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Historic Park Hill Remodeling
(
  'cont_remod_ph_003',
  'cat_remod_001',
  'neigh_park_hill_001',
  'Historic Park Hill Remodeling',
  '2200 Kearney St, Denver, CO 80207',
  '(303) 555-7303',
  'https://www.historicparkhillremodeling.com',
  4.7,
  134,
  'historic-park-hill-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. 23rd Avenue Design Build
(
  'cont_remod_ph_004',
  'cat_remod_001',
  'neigh_park_hill_001',
  '23rd Avenue Design Build',
  '3445 E 23rd Ave, Denver, CO 80205',
  '(303) 555-7304',
  'https://www.23rdavedesign.com',
  4.8,
  156,
  '23rd-avenue-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. North Park Hill Renovations
(
  'cont_remod_ph_005',
  'cat_remod_001',
  'neigh_park_hill_001',
  'North Park Hill Renovations',
  '3500 Holly St, Denver, CO 80207',
  '(303) 555-7305',
  'https://www.northparkhillrenovations.com',
  4.9,
  178,
  'north-park-hill-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. South Park Hill Design Studio
(
  'cont_remod_ph_006',
  'cat_remod_001',
  'neigh_park_hill_001',
  'South Park Hill Design Studio',
  '2000 Forest St, Denver, CO 80207',
  '(303) 555-7306',
  'https://www.southparkhilldesign.com',
  4.7,
  123,
  'south-park-hill-design-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Monaco Parkway Remodeling
(
  'cont_remod_ph_007',
  'cat_remod_001',
  'neigh_park_hill_001',
  'Monaco Parkway Remodeling',
  '2500 Monaco Pkwy, Denver, CO 80207',
  '(303) 555-7307',
  'https://www.monacoparkwayremodeling.com',
  4.8,
  145,
  'monaco-parkway-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Fairfax Street Renovations
(
  'cont_remod_ph_008',
  'cat_remod_001',
  'neigh_park_hill_001',
  'Fairfax Street Renovations',
  '2200 Fairfax St, Denver, CO 80207',
  '(303) 555-7308',
  'https://www.fairfaxrenovations.com',
  4.6,
  112,
  'fairfax-street-renovations',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Eudora Design Build
(
  'cont_remod_ph_009',
  'cat_remod_001',
  'neigh_park_hill_001',
  'Eudora Design Build',
  '2300 Eudora St, Denver, CO 80207',
  '(303) 555-7309',
  'https://www.eudoradesignbuild.com',
  4.8,
  167,
  'eudora-design-build',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Krameria Street Remodeling
(
  'cont_remod_ph_010',
  'cat_remod_001',
  'neigh_park_hill_001',
  'Krameria Street Remodeling',
  '2400 Krameria St, Denver, CO 80207',
  '(303) 555-7310',
  'https://www.krameriaremodeling.com',
  4.7,
  134,
  'krameria-street-remodeling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
