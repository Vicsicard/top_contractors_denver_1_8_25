-- Ensure Electrician category exists (same as previous)
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_elec_001',
  'Electrician',
  'electrician',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southwest Suburbs region
INSERT INTO regions (id, region_name, slug, created_at, updated_at)
VALUES (
  'reg_sw_suburbs_001',
  'Southwest Suburbs',
  'southwest-suburbs',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southwest Suburbs subregion
INSERT INTO subregions (id, region_id, subregion_name, slug, created_at, updated_at)
VALUES (
  'subreg_sw_suburbs_001',
  'reg_sw_suburbs_001',
  'Littleton/Lakewood Area',
  'littleton-lakewood-area',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Create Southwest Suburbs neighborhood
INSERT INTO neighborhoods (id, subregion_id, neighborhood_name, slug, description, created_at, updated_at)
VALUES (
  'neigh_sw_suburbs_001',
  'subreg_sw_suburbs_001',
  'Littleton/Lakewood',
  'littleton-lakewood',
  'Including Littleton, Lakewood, and surrounding areas',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
) ON CONFLICT (id) DO NOTHING;

-- Insert 10 electricians for Southwest Suburbs area
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
-- 1. Littleton Electric Masters
(
  'cont_elec_sw_001',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Littleton Electric Masters',
  '2255 W Berry Ave, Littleton, CO 80120',
  '(303) 555-2901',
  'https://www.littletonelectric.com',
  4.9,
  234,
  'littleton-electric-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. Lakewood Electrical Solutions
(
  'cont_elec_sw_002',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Lakewood Electrical Solutions',
  '7155 W Colfax Ave, Lakewood, CO 80214',
  '(303) 555-2902',
  'https://www.lakewoodelectrical.com',
  4.8,
  198,
  'lakewood-electrical-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Belmar Electric Experts
(
  'cont_elec_sw_003',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Belmar Electric Experts',
  '464 S Teller St, Lakewood, CO 80226',
  '(303) 555-2903',
  'https://www.belmarelectric.com',
  4.7,
  167,
  'belmar-electric-experts',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Downtown Littleton Electric
(
  'cont_elec_sw_004',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Downtown Littleton Electric',
  '2450 W Main St, Littleton, CO 80120',
  '(303) 555-2904',
  'https://www.downtownlittletonelectric.com',
  4.8,
  189,
  'downtown-littleton-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Union Boulevard Electric
(
  'cont_elec_sw_005',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Union Boulevard Electric',
  '88 Union Blvd, Lakewood, CO 80228',
  '(303) 555-2905',
  'https://www.unionblvdelectric.com',
  4.6,
  156,
  'union-boulevard-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Ken Caryl Electric
(
  'cont_elec_sw_006',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Ken Caryl Electric',
  '7940 Shaffer Pkwy, Littleton, CO 80127',
  '(303) 555-2906',
  'https://www.kencarylelectric.com',
  4.9,
  212,
  'ken-caryl-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Green Mountain Electric
(
  'cont_elec_sw_007',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Green Mountain Electric',
  '13123 W Alameda Pkwy, Lakewood, CO 80228',
  '(303) 555-2907',
  'https://www.greenmountainelectric.com',
  4.8,
  167,
  'green-mountain-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Southwest Plaza Electric
(
  'cont_elec_sw_008',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Southwest Plaza Electric',
  '8501 W Bowles Ave, Littleton, CO 80123',
  '(303) 555-2908',
  'https://www.southwestplazaelectric.com',
  4.7,
  178,
  'southwest-plaza-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Federal Center Electric
(
  'cont_elec_sw_009',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Federal Center Electric',
  '11000 W 6th Ave, Lakewood, CO 80215',
  '(303) 555-2909',
  'https://www.federalcenterelectric.com',
  4.8,
  201,
  'federal-center-electric',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Columbine Electric Services
(
  'cont_elec_sw_010',
  'cat_elec_001',
  'neigh_sw_suburbs_001',
  'Columbine Electric Services',
  '6738 W Coal Mine Ave, Littleton, CO 80123',
  '(303) 555-2910',
  'https://www.columbineelectric.com',
  4.7,
  182,
  'columbine-electric-services',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
