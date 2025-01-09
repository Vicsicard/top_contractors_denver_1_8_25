-- Ensure Masonry category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_masonry_001',
  'Masonry',
  'masonry',
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
  'Including East Colfax corridor and surrounding neighborhoods',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Masonry contractors for East Colfax area
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
-- 1. East Colfax Masonry Works
(
  'cont_masonry_ec_001',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'East Colfax Masonry Works',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-8501',
  'https://www.eastcolfaxmasonry.com',
  4.9,
  188,
  'east-colfax-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Stone & Brick
(
  'cont_masonry_ec_002',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Mayfair Stone & Brick',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-8502',
  'https://www.mayfairstone.com',
  4.8,
  166,
  'mayfair-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Montclair Brick Masters
(
  'cont_masonry_ec_003',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Montclair Brick Masters',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-8503',
  'https://www.montclairbrick.com',
  4.7,
  144,
  'montclair-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Lowry Stone Solutions
(
  'cont_masonry_ec_004',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Lowry Stone Solutions',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-8504',
  'https://www.lowrystone.com',
  4.8,
  177,
  'lowry-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Quebec Street Masonry Co
(
  'cont_masonry_ec_005',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Quebec Street Masonry Co',
  '7300 E Quebec St, Denver, CO 80237',
  '(303) 555-8505',
  'https://www.quebecstreetmasonry.com',
  4.9,
  198,
  'quebec-street-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Yosemite Stone Works
(
  'cont_masonry_ec_006',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Yosemite Stone Works',
  '1300 Yosemite St, Denver, CO 80220',
  '(303) 555-8506',
  'https://www.yosemitestone.com',
  4.7,
  155,
  'yosemite-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. East Side Masonry Specialists
(
  'cont_masonry_ec_007',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'East Side Masonry Specialists',
  '9000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-8507',
  'https://www.eastsidemasonry.com',
  4.8,
  166,
  'east-side-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Aurora Border Stone & Brick
(
  'cont_masonry_ec_008',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Aurora Border Stone & Brick',
  '9800 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-8508',
  'https://www.auroraborderstone.com',
  4.6,
  133,
  'aurora-border-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Fitzsimons Masonry Pros
(
  'cont_masonry_ec_009',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Fitzsimons Masonry Pros',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-8509',
  'https://www.fitzsimonsmasonry.com',
  4.8,
  177,
  'fitzsimons-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Stapleton Edge Stone Solutions
(
  'cont_masonry_ec_010',
  'cat_masonry_001',
  'neigh_east_colfax_001',
  'Stapleton Edge Stone Solutions',
  '7500 E 29th Ave, Denver, CO 80238',
  '(303) 555-8510',
  'https://www.stapletonedgestone.com',
  4.7,
  155,
  'stapleton-edge-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
