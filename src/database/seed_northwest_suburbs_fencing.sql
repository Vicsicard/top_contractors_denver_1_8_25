-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
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

-- Insert 10 Fencing contractors for Westminster/Arvada area
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
-- 1. Westminster Fence Works
(
  'cont_fence_nw_001',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Westminster Fence Works',
  '7301 Federal Blvd, Westminster, CO 80030',
  '(303) 555-9601',
  'https://www.westminsterfence.com',
  4.9,
  169,
  'westminster-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Arvada Fence & Gate
(
  'cont_fence_nw_002',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Arvada Fence & Gate',
  '5700 Wadsworth Blvd, Arvada, CO 80002',
  '(303) 555-9602',
  'https://www.arvadafence.com',
  4.8,
  144,
  'arvada-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Olde Town Fence Masters
(
  'cont_fence_nw_003',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Olde Town Fence Masters',
  '7525 Grandview Ave, Arvada, CO 80002',
  '(303) 555-9603',
  'https://www.oldetownfence.com',
  4.7,
  130,
  'olde-town-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Standley Lake Fence Solutions
(
  'cont_fence_nw_004',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Standley Lake Fence Solutions',
  '8900 W 88th Ave, Westminster, CO 80021',
  '(303) 555-9604',
  'https://www.standleylakefence.com',
  4.8,
  157,
  'standley-lake-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Northwest Corridor Fence Co
(
  'cont_fence_nw_005',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Northwest Corridor Fence Co',
  '10600 Westminster Blvd, Westminster, CO 80020',
  '(303) 555-9605',
  'https://www.nwcorridorfence.com',
  4.9,
  174,
  'northwest-corridor-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ralston Valley Fence Works
(
  'cont_fence_nw_006',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Ralston Valley Fence Works',
  '6700 Ralston Rd, Arvada, CO 80002',
  '(303) 555-9606',
  'https://www.ralstonvalleyfence.com',
  4.7,
  133,
  'ralston-valley-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Church Ranch Fence Specialists
(
  'cont_fence_nw_007',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Church Ranch Fence Specialists',
  '10050 Church Ranch Way, Westminster, CO 80021',
  '(303) 555-9607',
  'https://www.churchranchfence.com',
  4.8,
  147,
  'church-ranch-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Candelas Fence & Design
(
  'cont_fence_nw_008',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Candelas Fence & Design',
  '9100 Candelas Pkwy, Arvada, CO 80007',
  '(303) 555-9608',
  'https://www.candelasfence.com',
  4.6,
  117,
  'candelas-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Promenade Fence Pros
(
  'cont_fence_nw_009',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Promenade Fence Pros',
  '10801 Town Center Dr, Westminster, CO 80020',
  '(303) 555-9609',
  'https://www.promenadefence.com',
  4.8,
  156,
  'promenade-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Rocky Flats Fence Solutions
(
  'cont_fence_nw_010',
  'cat_fencing_001',
  'neigh_west_arv_001',
  'Rocky Flats Fence Solutions',
  '8000 Indiana St, Arvada, CO 80007',
  '(303) 555-9610',
  'https://www.rockyflatsfence.com',
  4.7,
  131,
  'rocky-flats-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
