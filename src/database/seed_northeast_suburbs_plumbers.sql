-- Ensure category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_plumber_001',
  'Plumber',
  'plumber',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Suburbs region exists (same as Northwest Suburbs)
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_suburbs_001',
  'Denver Suburbs',
  'denver-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_ne_suburbs_001',
  'reg_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_ne_suburbs_001',
  'subreg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  'Including Thornton, Northglenn, and surrounding areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 plumbers for Northeast Suburbs area
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
-- 1. Thornton Plumbing Experts
(
  'cont_plumb_nes_001',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Thornton Plumbing Experts',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-0801',
  'https://www.thorntonplumbingexperts.com',
  4.9,
  234,
  'thornton-plumbing-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Premier Plumbers
(
  'cont_plumb_nes_002',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Northglenn Premier Plumbers',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-0802',
  'https://www.northglennplumbers.com',
  4.8,
  198,
  'northglenn-premier-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Plumbing
(
  'cont_plumb_nes_003',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Washington Street Plumbing',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-0803',
  'https://www.washingtonstreetplumbing.com',
  4.7,
  167,
  'washington-street-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Original Thornton Plumbing
(
  'cont_plumb_nes_004',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Original Thornton Plumbing',
  '8800 Pearl St, Thornton, CO 80229',
  '(303) 555-0804',
  'https://www.originalthorntonplumbing.com',
  4.8,
  189,
  'original-thornton-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. E.B. Rains Jr. Park Area Plumbing
(
  'cont_plumb_nes_005',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'E.B. Rains Jr. Park Area Plumbing',
  '11701 Community Center Dr, Northglenn, CO 80233',
  '(303) 555-0805',
  'https://www.ebrainsplumbing.com',
  4.6,
  156,
  'eb-rains-park-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Huron Street Plumbing Services
(
  'cont_plumb_nes_006',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Huron Street Plumbing Services',
  '10455 Huron St, Northglenn, CO 80234',
  '(303) 555-0806',
  'https://www.huronstreetplumbing.com',
  4.9,
  212,
  'huron-street-plumbing-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Thornton Town Center Plumbing
(
  'cont_plumb_nes_007',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Thornton Town Center Plumbing',
  '10001 Grant St, Thornton, CO 80229',
  '(303) 555-0807',
  'https://www.thorntontowncenterplumbing.com',
  4.8,
  178,
  'thornton-town-center-plumbing',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northglenn Marketplace Plumbers
(
  'cont_plumb_nes_008',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Northglenn Marketplace Plumbers',
  '10578 Melody Dr, Northglenn, CO 80234',
  '(303) 555-0808',
  'https://www.northglennmarketplaceplumbers.com',
  4.7,
  167,
  'northglenn-marketplace-plumbers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. 120th Avenue Plumbing Pros
(
  'cont_plumb_nes_009',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  '120th Avenue Plumbing Pros',
  '1201 E 120th Ave, Thornton, CO 80233',
  '(303) 555-0809',
  'https://www.120thavenueplumbing.com',
  4.8,
  201,
  '120th-avenue-plumbing-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Carpenter Park Plumbing & Drain
(
  'cont_plumb_nes_010',
  'cat_plumber_001',
  'neigh_ne_suburbs_001',
  'Carpenter Park Plumbing & Drain',
  '11651 Colorado Blvd, Thornton, CO 80233',
  '(303) 555-0810',
  'https://www.carpenterparkplumbing.com',
  4.7,
  182,
  'carpenter-park-plumbing-drain',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
