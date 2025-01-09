-- Create HVAC category
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_hvac_001',
  'HVAC',
  'hvac',
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

-- Ensure Downtown subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_downtown_001',
  'reg_central_001',
  'Downtown Denver',
  'downtown-denver',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Downtown neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_downtown_001',
  'subreg_downtown_001',
  'Downtown Denver',
  'downtown-denver',
  'Including LoDo, Union Station, Central Business District, and Ballpark neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 HVAC contractors for Downtown Denver area
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
-- 1. LoDo HVAC Masters
(
  'cont_hvac_dt_001',
  'cat_hvac_001',
  'neigh_downtown_001',
  'LoDo HVAC Masters',
  '1701 Wynkoop St, Denver, CO 80202',
  '(303) 555-3001',
  'https://www.lodohvacmasters.com',
  4.9,
  234,
  'lodo-hvac-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Union Station Climate Control
(
  'cont_hvac_dt_002',
  'cat_hvac_001',
  'neigh_downtown_001',
  'Union Station Climate Control',
  '1701 Wewatta St, Denver, CO 80202',
  '(303) 555-3002',
  'https://www.unionstationhvac.com',
  4.8,
  198,
  'union-station-climate-control',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Downtown Denver HVAC
(
  'cont_hvac_dt_003',
  'cat_hvac_001',
  'neigh_downtown_001',
  'Downtown Denver HVAC',
  '1437 California St, Denver, CO 80202',
  '(303) 555-3003',
  'https://www.downtowndenverhvac.com',
  4.7,
  167,
  'downtown-denver-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Ballpark District Air Systems
(
  'cont_hvac_dt_004',
  'cat_hvac_001',
  'neigh_downtown_001',
  'Ballpark District Air Systems',
  '2001 Blake St, Denver, CO 80205',
  '(303) 555-3004',
  'https://www.ballparkhvac.com',
  4.8,
  189,
  'ballpark-district-air-systems',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. 16th Street Mall HVAC
(
  'cont_hvac_dt_005',
  'cat_hvac_001',
  'neigh_downtown_001',
  '16th Street Mall HVAC',
  '1001 16th St Mall, Denver, CO 80202',
  '(303) 555-3005',
  'https://www.16thstreethvac.com',
  4.9,
  212,
  '16th-street-mall-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Larimer Square Climate Pros
(
  'cont_hvac_dt_006',
  'cat_hvac_001',
  'neigh_downtown_001',
  'Larimer Square Climate Pros',
  '1430 Larimer St, Denver, CO 80202',
  '(303) 555-3006',
  'https://www.larimersquarehvac.com',
  4.7,
  178,
  'larimer-square-climate-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. CBD Heating & Cooling
(
  'cont_hvac_dt_007',
  'cat_hvac_001',
  'neigh_downtown_001',
  'CBD Heating & Cooling',
  '1700 Broadway, Denver, CO 80202',
  '(303) 555-3007',
  'https://www.cbdhvac.com',
  4.8,
  167,
  'cbd-heating-cooling',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Five Points HVAC Services
(
  'cont_hvac_dt_008',
  'cat_hvac_001',
  'neigh_downtown_001',
  'Five Points HVAC Services',
  '2721 Welton St, Denver, CO 80205',
  '(303) 555-3008',
  'https://www.fivepointshvac.com',
  4.6,
  156,
  'five-points-hvac-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. RiNo Air Solutions
(
  'cont_hvac_dt_009',
  'cat_hvac_001',
  'neigh_downtown_001',
  'RiNo Air Solutions',
  '2955 Brighton Blvd, Denver, CO 80216',
  '(303) 555-3009',
  'https://www.rinohvac.com',
  4.8,
  201,
  'rino-air-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Commons Park HVAC
(
  'cont_hvac_dt_010',
  'cat_hvac_001',
  'neigh_downtown_001',
  'Commons Park HVAC',
  '1550 Platte St, Denver, CO 80202',
  '(303) 555-3010',
  'https://www.commonshvac.com',
  4.7,
  182,
  'commons-park-hvac',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
