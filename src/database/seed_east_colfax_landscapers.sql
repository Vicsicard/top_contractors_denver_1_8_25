-- Ensure Landscapers category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_land_001',
  'Landscapers',
  'landscapers',
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

-- Insert 10 Landscapers for East Colfax area
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
-- 1. East Colfax Garden Masters
(
  'cont_land_ec_001',
  'cat_land_001',
  'neigh_east_colfax_001',
  'East Colfax Garden Masters',
  '8000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-6501',
  'https://www.eastcolfaxgardens.com',
  4.9,
  167,
  'east-colfax-garden-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Mayfair Landscape Design
(
  'cont_land_ec_002',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Mayfair Landscape Design',
  '1300 Krameria St, Denver, CO 80220',
  '(303) 555-6502',
  'https://www.mayfairlandscape.com',
  4.8,
  145,
  'mayfair-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Lowry Gardens
(
  'cont_land_ec_003',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Lowry Gardens',
  '7581 E Academy Blvd, Denver, CO 80230',
  '(303) 555-6503',
  'https://www.lowrygardens.com',
  4.7,
  132,
  'lowry-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Quebec Street Landscaping
(
  'cont_land_ec_004',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Quebec Street Landscaping',
  '7300 E Quebec St, Denver, CO 80237',
  '(303) 555-6504',
  'https://www.quebecstreetlandscaping.com',
  4.8,
  156,
  'quebec-street-landscaping',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Montclair Garden Design
(
  'cont_land_ec_005',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Montclair Garden Design',
  '1200 Newport St, Denver, CO 80220',
  '(303) 555-6505',
  'https://www.montclairgardens.com',
  4.9,
  178,
  'montclair-garden-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Stapleton Landscape Co
(
  'cont_land_ec_006',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Stapleton Landscape Co',
  '8801 E Montview Blvd, Denver, CO 80238',
  '(303) 555-6506',
  'https://www.stapletonlandscape.com',
  4.7,
  134,
  'stapleton-landscape-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Hale Gardens
(
  'cont_land_ec_007',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Hale Gardens',
  '4200 E 8th Ave, Denver, CO 80220',
  '(303) 555-6507',
  'https://www.halegardens.com',
  4.8,
  145,
  'hale-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Monaco Garden Studio
(
  'cont_land_ec_008',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Monaco Garden Studio',
  '6000 E Colfax Ave, Denver, CO 80220',
  '(303) 555-6508',
  'https://www.monacogardens.com',
  4.6,
  123,
  'monaco-garden-studio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Fitzsimons Landscape Design
(
  'cont_land_ec_009',
  'cat_land_001',
  'neigh_east_colfax_001',
  'Fitzsimons Landscape Design',
  '13001 E 17th Pl, Aurora, CO 80045',
  '(303) 555-6509',
  'https://www.fitzsimonslandscape.com',
  4.8,
  156,
  'fitzsimons-landscape-design',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. East Side Gardens
(
  'cont_land_ec_010',
  'cat_land_001',
  'neigh_east_colfax_001',
  'East Side Gardens',
  '9200 E Colfax Ave, Aurora, CO 80010',
  '(303) 555-6510',
  'https://www.eastsidegardens.com',
  4.7,
  134,
  'east-side-gardens',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
