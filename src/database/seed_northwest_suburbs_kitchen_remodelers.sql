-- Ensure Kitchen Remodelers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_kitchen_001',
  'Kitchen Remodelers',
  'kitchen-remodelers',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Northwest Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_nw_suburbs_001',
  'Northwest Suburbs',
  'northwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Westminster/Arvada subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_west_arv_001',
  'reg_nw_suburbs_001',
  'Westminster/Arvada',
  'westminster-arvada',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Westminster/Arvada neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_west_arv_001',
  'subreg_west_arv_001',
  'Westminster/Arvada',
  'westminster-arvada',
  'Including Westminster, Arvada, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Kitchen Remodelers for Westminster/Arvada area
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
-- 1. Westminster Kitchen Design
(
  'cont_kitchen_nw_001',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Westminster Kitchen Design',
  '5453 W 88th Ave, Westminster, CO 80031',
  '(303) 555-9601',
  'https://www.westminsterkitchen.com',
  4.9,
  188,
  'westminster-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Kitchen & Cabinets
(
  'cont_kitchen_nw_002',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Arvada Kitchen & Cabinets',
  '7525 W 57th Ave, Arvada, CO 80002',
  '(303) 555-9602',
  'https://www.arvadakitchen.com',
  4.8,
  166,
  'arvada-kitchen-cabinets',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Kitchen Masters
(
  'cont_kitchen_nw_003',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Olde Town Kitchen Masters',
  '5711 Olde Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-9603',
  'https://www.oldetownkitchen.com',
  4.7,
  144,
  'olde-town-kitchen-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Kitchen Co
(
  'cont_kitchen_nw_004',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Standley Lake Kitchen Co',
  '8900 W 100th Ave, Westminster, CO 80021',
  '(303) 555-9604',
  'https://www.standleylakekitchen.com',
  4.8,
  177,
  'standley-lake-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Promenade Kitchen Studio
(
  'cont_kitchen_nw_005',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Promenade Kitchen Studio',
  '10655 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-9605',
  'https://www.promenadekitchen.com',
  4.9,
  199,
  'promenade-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ralston Valley Kitchen Design
(
  'cont_kitchen_nw_006',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Ralston Valley Kitchen Design',
  '6870 W 52nd Ave, Arvada, CO 80002',
  '(303) 555-9606',
  'https://www.ralstonvalleykitchen.com',
  4.7,
  155,
  'ralston-valley-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Church Ranch Kitchen Co
(
  'cont_kitchen_nw_007',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Church Ranch Kitchen Co',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-9607',
  'https://www.churchranchkitchen.com',
  4.8,
  166,
  'church-ranch-kitchen-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Candelas Kitchen Studio
(
  'cont_kitchen_nw_008',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Candelas Kitchen Studio',
  '9100 W 100th Ave, Westminster, CO 80021',
  '(303) 555-9608',
  'https://www.candelaskitchen.com',
  4.6,
  133,
  'candelas-kitchen-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Wadsworth Kitchen Specialists
(
  'cont_kitchen_nw_009',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Wadsworth Kitchen Specialists',
  '8000 Wadsworth Blvd, Arvada, CO 80003',
  '(303) 555-9609',
  'https://www.wadsworthkitchen.com',
  4.8,
  177,
  'wadsworth-kitchen-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Northwest Kitchen Design
(
  'cont_kitchen_nw_010',
  'cat_kitchen_001',
  'neigh_west_arv_001',
  'Northwest Kitchen Design',
  '7315 W 88th Ave, Westminster, CO 80021',
  '(303) 555-9610',
  'https://www.northwestkitchen.com',
  4.7,
  155,
  'northwest-kitchen-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
