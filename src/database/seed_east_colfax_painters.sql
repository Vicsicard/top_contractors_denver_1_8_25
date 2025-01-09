-- Ensure Painters category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_paint_001',
  'Painters',
  'painters',
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

-- Insert 10 Painters for East Colfax area
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
-- 1. Colfax Corridor Paint Masters
(
  'cont_paint_ec_001',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Colfax Corridor Paint Masters',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-5501',
  'https://www.colfaxpainting.com',
  4.9,
  167,
  'colfax-corridor-paint-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Paint Co
(
  'cont_paint_ec_002',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Mayfair Paint Co',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-5502',
  'https://www.mayfairpainting.com',
  4.8,
  145,
  'mayfair-paint-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Lowry Field Painters
(
  'cont_paint_ec_003',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Lowry Field Painters',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-5503',
  'https://www.lowryfieldpainting.com',
  4.7,
  132,
  'lowry-field-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. East Side Paint Studio
(
  'cont_paint_ec_004',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'East Side Paint Studio',
  '9000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-5504',
  'https://www.eastsidepainting.com',
  4.8,
  156,
  'east-side-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Quebec Street Painters
(
  'cont_paint_ec_005',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Quebec Street Painters',
  '7300 E Quebec St, Denver, CO 80237',
  '(303) 555-5505',
  'https://www.quebecstpainting.com',
  4.9,
  178,
  'quebec-street-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Monaco Paint & Design
(
  'cont_paint_ec_006',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Monaco Paint & Design',
  '6500 E Monaco Pkwy, Denver, CO 80224',
  '(303) 555-5506',
  'https://www.monacoparkwaypainting.com',
  4.7,
  134,
  'monaco-paint-and-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Yosemite Paint Pros
(
  'cont_paint_ec_007',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Yosemite Paint Pros',
  '8000 E Yosemite St, Denver, CO 80230',
  '(303) 555-5507',
  'https://www.yosemitepainting.com',
  4.8,
  145,
  'yosemite-paint-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Montclair Paint Solutions
(
  'cont_paint_ec_008',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Montclair Paint Solutions',
  '1200 Ulster St, Denver, CO 80220',
  '(303) 555-5508',
  'https://www.montclairpainting.com',
  4.6,
  123,
  'montclair-paint-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Hale Paint Studio
(
  'cont_paint_ec_009',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Hale Paint Studio',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-5509',
  'https://www.halepainting.com',
  4.8,
  156,
  'hale-paint-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Hilltop Painters
(
  'cont_paint_ec_010',
  'cat_paint_001',
  'neigh_east_colfax_001',
  'Hilltop Painters',
  '355 Holly St, Denver, CO 80220',
  '(303) 555-5510',
  'https://www.hilltoppainting.com',
  4.7,
  134,
  'hilltop-painters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
