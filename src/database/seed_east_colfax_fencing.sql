-- Ensure Fencing category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_fencing_001',
  'Fencing',
  'fencing',
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

-- Ensure East Colfax subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_east_colfax_001',
  'reg_east_001',
  'East Colfax',
  'east-colfax',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure East Colfax neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_east_colfax_001',
  'subreg_east_colfax_001',
  'East Colfax',
  'east-colfax',
  'Including East Colfax corridor and surrounding residential areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Fencing contractors for East Colfax area
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
-- 1. East Colfax Fence Works
(
  'cont_fence_ec_001',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'East Colfax Fence Works',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-9501',
  'https://www.eastcolfaxfence.com',
  4.9,
  163,
  'east-colfax-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Fence & Gate
(
  'cont_fence_ec_002',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Mayfair Fence & Gate',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-9502',
  'https://www.mayfairfence.com',
  4.8,
  140,
  'mayfair-fence-gate',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Lowry Fence Masters
(
  'cont_fence_ec_003',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Lowry Fence Masters',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-9503',
  'https://www.lowryfence.com',
  4.7,
  126,
  'lowry-fence-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Quebec Square Fence Solutions
(
  'cont_fence_ec_004',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Quebec Square Fence Solutions',
  '7305 E 35th Ave, Denver, CO 80238',
  '(303) 555-9504',
  'https://www.quebecsquarefence.com',
  4.8,
  153,
  'quebec-square-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Stapleton Fence Co
(
  'cont_fence_ec_005',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Stapleton Fence Co',
  '7351 E 29th Ave, Denver, CO 80238',
  '(303) 555-9505',
  'https://www.stapletonfence.com',
  4.9,
  170,
  'stapleton-fence-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Aurora Border Fence Works
(
  'cont_fence_ec_006',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Aurora Border Fence Works',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-9506',
  'https://www.auroraborderfence.com',
  4.7,
  129,
  'aurora-border-fence-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Fitzsimons Fence Specialists
(
  'cont_fence_ec_007',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Fitzsimons Fence Specialists',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-9507',
  'https://www.fitzsimonsfence.com',
  4.8,
  143,
  'fitzsimons-fence-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Montclair Fence & Design
(
  'cont_fence_ec_008',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Montclair Fence & Design',
  '1200 Ulster St, Denver, CO 80220',
  '(303) 555-9508',
  'https://www.montclairfence.com',
  4.6,
  113,
  'montclair-fence-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Hale Fence Pros
(
  'cont_fence_ec_009',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Hale Fence Pros',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-9509',
  'https://www.halefence.com',
  4.8,
  152,
  'hale-fence-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Central Park Fence Solutions
(
  'cont_fence_ec_010',
  'cat_fencing_001',
  'neigh_east_colfax_001',
  'Central Park Fence Solutions',
  '8801 E Montview Blvd, Denver, CO 80238',
  '(303) 555-9510',
  'https://www.centralparkfence.com',
  4.7,
  127,
  'central-park-fence-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
