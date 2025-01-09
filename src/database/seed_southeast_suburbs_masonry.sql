-- Ensure Masonry category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_masonry_001',
  'Masonry',
  'masonry',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Southeast Suburbs region exists
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_se_suburbs_001',
  'Southeast Suburbs',
  'southeast-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Aurora/DTC subregion exists
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_aurora_dtc_001',
  'reg_se_suburbs_001',
  'Aurora/DTC',
  'aurora-dtc',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Ensure Aurora/DTC neighborhood exists
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_aurora_dtc_001',
  'subreg_aurora_dtc_001',
  'Aurora/DTC',
  'aurora-dtc',
  'Including Aurora, Denver Tech Center, and surrounding communities',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 Masonry contractors for Aurora/DTC area
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
-- 1. Aurora Masonry Works
(
  'cont_masonry_ses_001',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Aurora Masonry Works',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-8801',
  'https://www.auroramasonry.com',
  4.9,
  188,
  'aurora-masonry-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Stone & Brick
(
  'cont_masonry_ses_002',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'DTC Stone & Brick',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-8802',
  'https://www.dtcstone.com',
  4.8,
  166,
  'dtc-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Hampden Brick Masters
(
  'cont_masonry_ses_003',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Hampden Brick Masters',
  '10355 E Hampden Ave, Aurora, CO 80014',
  '(303) 555-8803',
  'https://www.hampdenbrick.com',
  4.7,
  144,
  'hampden-brick-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Parker Road Stone Solutions
(
  'cont_masonry_ses_004',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Parker Road Stone Solutions',
  '16901 E Quincy Ave, Aurora, CO 80015',
  '(303) 555-8804',
  'https://www.parkerroadstone.com',
  4.8,
  177,
  'parker-road-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Tech Center Masonry Co
(
  'cont_masonry_ses_005',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Tech Center Masonry Co',
  '7900 E Union Ave, Denver, CO 80237',
  '(303) 555-8805',
  'https://www.techcentermasonry.com',
  4.9,
  198,
  'tech-center-masonry-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Iliff Stone Works
(
  'cont_masonry_ses_006',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Iliff Stone Works',
  '15200 E Iliff Ave, Aurora, CO 80014',
  '(303) 555-8806',
  'https://www.iliffstone.com',
  4.7,
  155,
  'iliff-stone-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Southeast Masonry Specialists
(
  'cont_masonry_ses_007',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Southeast Masonry Specialists',
  '6780 S Liverpool St, Aurora, CO 80016',
  '(303) 555-8807',
  'https://www.southeastmasonry.com',
  4.8,
  166,
  'southeast-masonry-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Arapahoe Stone & Brick
(
  'cont_masonry_ses_008',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Stone & Brick',
  '6972 S Vine St, Centennial, CO 80122',
  '(303) 555-8808',
  'https://www.arapahoestone.com',
  4.6,
  133,
  'arapahoe-stone-brick',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Southlands Masonry Pros
(
  'cont_masonry_ses_009',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Southlands Masonry Pros',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-8809',
  'https://www.southlandsmasonry.com',
  4.8,
  177,
  'southlands-masonry-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Belleview Stone Solutions
(
  'cont_masonry_ses_010',
  'cat_masonry_001',
  'neigh_aurora_dtc_001',
  'Belleview Stone Solutions',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-8810',
  'https://www.belleviewstone.com',
  4.7,
  155,
  'belleview-stone-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
