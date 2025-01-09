-- Ensure Kitchen Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_ne_suburbs_001',
  'Northeast Suburbs',
  'northeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_thorn_north_001',
  'reg_ne_suburbs_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Thornton/Northglenn neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_thorn_north_001',
  'subreg_thorn_north_001',
  'Thornton/Northglenn',
  'thornton-northglenn',
  'Including Thornton, Northglenn, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Kitchen Remodelers for Thornton/Northglenn area
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
-- 1. Thornton Kitchen Design
(
  'cont_kitchen_nes_001',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Thornton Kitchen Design',
  '8900 Washington St, Thornton, CO 80229',
  '(303) 555-9701',
  'https://www.thorntonkitchen.com',
  4.9,
  188,
  'thornton-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Northglenn Kitchen & Cabinets
(
  'cont_kitchen_nes_002',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Northglenn Kitchen & Cabinets',
  '10701 Melody Dr, Northglenn, CO 80234',
  '(303) 555-9702',
  'https://www.northglennkitchen.com',
  4.8,
  166,
  'northglenn-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Original Thornton Kitchen Masters
(
  'cont_kitchen_nes_003',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Original Thornton Kitchen Masters',
  '8851 Washington St, Thornton, CO 80229',
  '(303) 555-9703',
  'https://www.originalthortonkitchen.com',
  4.7,
  144,
  'original-thornton-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Huron Street Kitchen Co
(
  'cont_kitchen_nes_004',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Huron Street Kitchen Co',
  '10455 Huron St, Northglenn, CO 80234',
  '(303) 555-9704',
  'https://www.huronkitchen.com',
  4.8,
  177,
  'huron-street-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Marketplace Kitchen Studio
(
  'cont_kitchen_nes_005',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Marketplace Kitchen Studio',
  '9950 Grant St, Thornton, CO 80229',
  '(303) 555-9705',
  'https://www.marketplacekitchen.com',
  4.9,
  199,
  'marketplace-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. 120th Avenue Kitchen Design
(
  'cont_kitchen_nes_006',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  '120th Avenue Kitchen Design',
  '1201 E 120th Ave, Thornton, CO 80233',
  '(303) 555-9706',
  'https://www.120thkitchen.com',
  4.7,
  155,
  '120th-avenue-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Washington Street Kitchen Co
(
  'cont_kitchen_nes_007',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Washington Street Kitchen Co',
  '8996 Washington St, Thornton, CO 80229',
  '(303) 555-9707',
  'https://www.washingtonkitchen.com',
  4.8,
  166,
  'washington-street-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Eastlake Kitchen Studio
(
  'cont_kitchen_nes_008',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Eastlake Kitchen Studio',
  '2255 E 104th Ave, Thornton, CO 80233',
  '(303) 555-9708',
  'https://www.eastlakekitchen.com',
  4.6,
  133,
  'eastlake-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Grant Street Kitchen Specialists
(
  'cont_kitchen_nes_009',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Grant Street Kitchen Specialists',
  '11501 Grant St, Northglenn, CO 80233',
  '(303) 555-9709',
  'https://www.grantstreetskitchen.com',
  4.8,
  177,
  'grant-street-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Northeast Kitchen Design
(
  'cont_kitchen_nes_010',
  'cat_kitchen_001',
  'neigh_thorn_north_001',
  'Northeast Kitchen Design',
  '12000 Washington Center Pkwy, Thornton, CO 80241',
  '(303) 555-9710',
  'https://www.northeastkitchen.com',
  4.7,
  155,
  'northeast-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
