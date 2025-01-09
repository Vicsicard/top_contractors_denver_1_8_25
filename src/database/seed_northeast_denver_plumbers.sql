-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Denver region exists 
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_northeast_001',
  'Northeast Denver',
  'northeast-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Denver subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_northeast_001',
  'reg_northeast_001',
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
  'Northeast Area',
  'northeast-area',
  'Including Montbello, Green Valley Ranch, and Gateway neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Northeast Denver area
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
-- 1. Central Park Plumbing & Heating
(
  'cont_plumb_ne_001',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Central Park Plumbing & Heating',
  '8801 E Martin Luther King Blvd, Denver, CO 80238',
  '(303) 555-0501',
  'https://www.centralparkplumbingdenver.com',
  4.9,
  234,
  'central-park-plumbing-heating',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northfield Plumbing Solutions
(
  'cont_plumb_ne_002',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Northfield Plumbing Solutions',
  '8340 Northfield Blvd, Denver, CO 80238',
  '(303) 555-0502',
  'https://www.northfieldplumbing.com',
  4.8,
  187,
  'northfield-plumbing-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Stapleton Drain Experts
(
  'cont_plumb_ne_003',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Stapleton Drain Experts',
  '7352 E 29th Ave, Denver, CO 80238',
  '(303) 555-0503',
  'https://www.stapletondrainexperts.com',
  4.7,
  167,
  'stapleton-drain-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Northeast Denver Plumbing Pros
(
  'cont_plumb_ne_004',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Northeast Denver Plumbing Pros',
  '4910 Havana St, Denver, CO 80239',
  '(303) 555-0504',
  'https://www.northeastdenverplumbing.com',
  4.8,
  198,
  'northeast-denver-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Quebec Square Plumbers
(
  'cont_plumb_ne_005',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Quebec Square Plumbers',
  '7505 E 35th Ave, Denver, CO 80238',
  '(303) 555-0505',
  'https://www.quebecsquareplumbers.com',
  4.6,
  156,
  'quebec-square-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. MLK Boulevard Plumbing Services
(
  'cont_plumb_ne_006',
  'cat_plumber_001',
  'neigh_northeast_001',
  'MLK Boulevard Plumbing Services',
  '9100 E Martin Luther King Blvd, Denver, CO 80238',
  '(303) 555-0506',
  'https://www.mlkblvdplumbing.com',
  4.9,
  178,
  'mlk-boulevard-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Conservatory Green Plumbing
(
  'cont_plumb_ne_007',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Conservatory Green Plumbing',
  '8200 E 49th Pl, Denver, CO 80238',
  '(303) 555-0507',
  'https://www.conservatorygreenplumbing.com',
  4.8,
  189,
  'conservatory-green-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Eastbridge Town Center Plumbing
(
  'cont_plumb_ne_008',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Eastbridge Town Center Plumbing',
  '10155 E 29th Dr, Denver, CO 80238',
  '(303) 555-0508',
  'https://www.eastbridgeplumbing.com',
  4.7,
  167,
  'eastbridge-town-center-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Green Valley Ranch Plumbers
(
  'cont_plumb_ne_009',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Green Valley Ranch Plumbers',
  '4890 Argonne St, Denver, CO 80249',
  '(303) 555-0509',
  'https://www.greenvalleyplumbers.com',
  4.8,
  201,
  'green-valley-ranch-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Mountain Arsenal Plumbing
(
  'cont_plumb_ne_010',
  'cat_plumber_001',
  'neigh_northeast_001',
  'Rocky Mountain Arsenal Plumbing',
  '5650 Havana St, Denver, CO 80239',
  '(303) 555-0510',
  'https://www.rockymountainarsenalplumbing.com',
  4.7,
  176,
  'rocky-mountain-arsenal-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
