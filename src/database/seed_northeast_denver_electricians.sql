-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
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
  'Northeast Area',
  'northeast-area',
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
  'Including Central Park (formerly Stapleton), Northfield, and surrounding northeast Denver neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 electricians for Northeast Denver area
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
-- 1. Central Park Electric
(
  'cont_elec_ne_001',
  'cat_elec_001',
  'neigh_northeast_001',
  'Central Park Electric',
  '8801 E Martin Luther King Blvd, Denver, CO 80238',
  '(303) 555-2401',
  'https://www.centralparkelectric.com',
  4.9,
  234,
  'central-park-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northfield Electrical Solutions
(
  'cont_elec_ne_002',
  'cat_elec_001',
  'neigh_northeast_001',
  'Northfield Electrical Solutions',
  '8340 Northfield Blvd, Denver, CO 80238',
  '(303) 555-2402',
  'https://www.northfieldelectrical.com',
  4.8,
  198,
  'northfield-electrical-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Stapleton Electric Experts
(
  'cont_elec_ne_003',
  'cat_elec_001',
  'neigh_northeast_001',
  'Stapleton Electric Experts',
  '7352 E 29th Ave, Denver, CO 80238',
  '(303) 555-2403',
  'https://www.stapletonelectric.com',
  4.7,
  167,
  'stapleton-electric-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Northeast Denver Electric Pros
(
  'cont_elec_ne_004',
  'cat_elec_001',
  'neigh_northeast_001',
  'Northeast Denver Electric Pros',
  '4910 Havana St, Denver, CO 80239',
  '(303) 555-2404',
  'https://www.northeastdenverelectric.com',
  4.8,
  189,
  'northeast-denver-electric-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Quebec Square Electric
(
  'cont_elec_ne_005',
  'cat_elec_001',
  'neigh_northeast_001',
  'Quebec Square Electric',
  '7505 E 35th Ave, Denver, CO 80238',
  '(303) 555-2405',
  'https://www.quebecsquareelectric.com',
  4.6,
  156,
  'quebec-square-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. MLK Boulevard Electric
(
  'cont_elec_ne_006',
  'cat_elec_001',
  'neigh_northeast_001',
  'MLK Boulevard Electric',
  '9100 E Martin Luther King Blvd, Denver, CO 80238',
  '(303) 555-2406',
  'https://www.mlkblvdelectric.com',
  4.9,
  212,
  'mlk-boulevard-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Conservatory Green Electrical
(
  'cont_elec_ne_007',
  'cat_elec_001',
  'neigh_northeast_001',
  'Conservatory Green Electrical',
  '8200 E 49th Pl, Denver, CO 80238',
  '(303) 555-2407',
  'https://www.conservatorygreenelectric.com',
  4.8,
  167,
  'conservatory-green-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Eastbridge Town Center Electric
(
  'cont_elec_ne_008',
  'cat_elec_001',
  'neigh_northeast_001',
  'Eastbridge Town Center Electric',
  '10155 E 29th Dr, Denver, CO 80238',
  '(303) 555-2408',
  'https://www.eastbridgeelectric.com',
  4.7,
  178,
  'eastbridge-town-center-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Green Valley Ranch Electric
(
  'cont_elec_ne_009',
  'cat_elec_001',
  'neigh_northeast_001',
  'Green Valley Ranch Electric',
  '4890 Argonne St, Denver, CO 80249',
  '(303) 555-2409',
  'https://www.greenvalleyelectric.com',
  4.8,
  201,
  'green-valley-ranch-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal Electric
(
  'cont_elec_ne_010',
  'cat_elec_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Electric',
  '5650 Havana St, Denver, CO 80239',
  '(303) 555-2410',
  'https://www.rockymountainarsenalelectric.com',
  4.7,
  182,
  'rocky-mountain-arsenal-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
