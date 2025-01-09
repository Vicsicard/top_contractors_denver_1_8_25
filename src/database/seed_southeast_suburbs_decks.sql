-- Ensure Decks category exists
INSERT INTO categories (id, category_name, slug, created_at, updated_at)
VALUES (
  'cat_decks_001',
  'Decks',
  'decks',
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

-- Insert 10 Deck contractors for Aurora/DTC area
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
-- 1. Aurora Deck Works
(
  'cont_decks_ses_001',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Aurora Deck Works',
  '15151 E Alameda Pkwy, Aurora, CO 80012',
  '(303) 555-9801',
  'https://www.auroradecks.com',
  4.9,
  188,
  'aurora-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 2. DTC Deck & Patio
(
  'cont_decks_ses_002',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'DTC Deck & Patio',
  '8000 E Belleview Ave, Greenwood Village, CO 80111',
  '(303) 555-9802',
  'https://www.dtcdecks.com',
  4.8,
  166,
  'dtc-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 3. Tech Center Deck Masters
(
  'cont_decks_ses_003',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Tech Center Deck Masters',
  '5600 DTC Pkwy, Greenwood Village, CO 80111',
  '(303) 555-9803',
  'https://www.techcenterdecks.com',
  4.7,
  144,
  'tech-center-deck-masters',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 4. Southlands Deck Solutions
(
  'cont_decks_ses_004',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Southlands Deck Solutions',
  '6155 S Main St, Aurora, CO 80016',
  '(303) 555-9804',
  'https://www.southlandsdecks.com',
  4.8,
  177,
  'southlands-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 5. Cherry Creek State Park Deck Co
(
  'cont_decks_ses_005',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Cherry Creek State Park Deck Co',
  '4201 S Parker Rd, Aurora, CO 80014',
  '(303) 555-9805',
  'https://www.cherrycreekdecks.com',
  4.9,
  199,
  'cherry-creek-state-park-deck-co',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 6. Hampden South Deck Works
(
  'cont_decks_ses_006',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Hampden South Deck Works',
  '7400 E Hampden Ave, Denver, CO 80231',
  '(303) 555-9806',
  'https://www.hampdensouthdecks.com',
  4.7,
  155,
  'hampden-south-deck-works',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 7. Greenwood Village Deck Specialists
(
  'cont_decks_ses_007',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Greenwood Village Deck Specialists',
  '6300 S Syracuse Way, Centennial, CO 80111',
  '(303) 555-9807',
  'https://www.greenwooddecks.com',
  4.8,
  166,
  'greenwood-village-deck-specialists',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 8. Iliff Square Deck & Patio
(
  'cont_decks_ses_008',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Iliff Square Deck & Patio',
  '2295 S Chambers Rd, Aurora, CO 80014',
  '(303) 555-9808',
  'https://www.iliffsquaredecks.com',
  4.6,
  133,
  'iliff-square-deck-patio',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 9. Southeast Deck Pros
(
  'cont_decks_ses_009',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Southeast Deck Pros',
  '15900 E Briarwood Cir, Aurora, CO 80016',
  '(303) 555-9809',
  'https://www.southeastdeckpros.com',
  4.8,
  177,
  'southeast-deck-pros',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
-- 10. Arapahoe Deck Solutions
(
  'cont_decks_ses_010',
  'cat_decks_001',
  'neigh_aurora_dtc_001',
  'Arapahoe Deck Solutions',
  '6972 S Vine St, Centennial, CO 80122',
  '(303) 555-9810',
  'https://www.arapahoedecks.com',
  4.7,
  155,
  'arapahoe-deck-solutions',
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
)
ON CONFLICT (id) DO UPDATE SET
  reviews_avg = EXCLUDED.reviews_avg,
  reviews_count = EXCLUDED.reviews_count,
  updated_at = CURRENT_TIMESTAMP;
