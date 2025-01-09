-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_ne_suburbs_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn Area',
  'thornton-northglenn-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Northeast Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_ne_suburbs_001',
  'subreg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 electricians for Northeast Suburbs area
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
-- 1. Thornton Electric Masters
(
  'cont_elec_ne_sub_001',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Thornton Electric Masters',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-2701',
  'https://www.thorntonelectric.com',
  4.9,
  234,
  'thornton-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Electrical Solutions
(
  'cont_elec_ne_sub_002',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Northglenn Electrical Solutions',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-2702',
  'https://www.northglennelectrical.com',
  4.8,
  198,
  'northglenn-electrical-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Washington Street Electric
(
  'cont_elec_ne_sub_003',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Washington Street Electric',
  '9400 Washington St, Thornton, CO 80229',
  '(303) 555-2703',
  'https://www.washingtonstreetelectric.com',
  4.7,
  167,
  'washington-street-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Original Thornton Electric
(
  'cont_elec_ne_sub_004',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Original Thornton Electric',
  '8800 N Washington St, Thornton, CO 80229',
  '(303) 555-2704',
  'https://www.originalthorntonelectric.com',
  4.8,
  189,
  'original-thornton-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Huron Street Electrical
(
  'cont_elec_ne_sub_005',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Huron Street Electrical',
  '10650 Huron St, Northglenn, CO 80234',
  '(303) 555-2705',
  'https://www.huronstreetelectric.com',
  4.6,
  156,
  'huron-street-electrical',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. E.B. Rains Electric
(
  'cont_elec_ne_sub_006',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'E.B. Rains Electric',
  '11701 Community Center Dr, Northglenn, CO 80233',
  '(303) 555-2706',
  'https://www.ebrainselectric.com',
  4.9,
  212,
  'eb-rains-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Thornton Town Center Electric
(
  'cont_elec_ne_sub_007',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Thornton Town Center Electric',
  '10001 Grant St, Thornton, CO 80229',
  '(303) 555-2707',
  'https://www.thorntontowncenterelectric.com',
  4.8,
  167,
  'thornton-town-center-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Northglenn Marketplace Electric
(
  'cont_elec_ne_sub_008',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Northglenn Marketplace Electric',
  '10578 Melody Dr, Northglenn, CO 80234',
  '(303) 555-2708',
  'https://www.northglennmarketplaceelectric.com',
  4.7,
  178,
  'northglenn-marketplace-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. 120th Avenue Electric
(
  'cont_elec_ne_sub_009',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  '120th Avenue Electric',
  '1200 E 120th Ave, Thornton, CO 80233',
  '(303) 555-2709',
  'https://www.120thavenueelectric.com',
  4.8,
  201,
  '120th-avenue-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Thornton Parkway Electric
(
  'cont_elec_ne_sub_010',
  'cat_elec_001',
  'neigh_ne_suburbs_001',
  'Thornton Parkway Electric',
  '8900 Thornton Pkwy, Thornton, CO 80229',
  '(303) 555-2710',
  'https://www.thorntonparkwayelectric.com',
  4.7,
  182,
  'thornton-parkway-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
