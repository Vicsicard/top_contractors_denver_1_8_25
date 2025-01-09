-- Seed file for Central Parks Area Flooring
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Flooring
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'flooring'
),
-- Get the subregion_id for Central Parks Area
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'central-parks-area'
)
INSERT INTO contractors (
    category_id,
    subregion_id,
    contractor_name,
    address,
    phone,
    website,
    reviews_avg,
    reviews_count,
    slug
) VALUES
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring',
    '8350 Central Park Blvd, Denver, CO 80238',
    '(303) 555-1001',
    'https://central-parks-area-flooring.com',
    4.7,
    282,
    'central-parks-area-flooring'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Flooring Experts of Central Parks Area',
    '7995 E 49th Pl, Denver, CO 80238',
    '(303) 555-1002',
    'https://flooring-experts-of-central-parks-area.com',
    4.7,
    251,
    'flooring-experts-of-central-parks-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Flooring Central Parks Area',
    '2373 Central Park Blvd, Denver, CO 80238',
    '(303) 555-1003',
    'https://professional-flooring-central-parks-area.com',
    4.7,
    226,
    'professional-flooring-central-parks-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring Company 3',
    '7484 E 29th Pl, Denver, CO 80238',
    '(303) 555-1004',
    'https://central-parks-area-flooring-company-3.com',
    4.7,
    310,
    'central-parks-area-flooring-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring Company 4',
    '7351 E 29th Ave, Denver, CO 80238',
    '(303) 555-1005',
    'https://central-parks-area-flooring-company-4.com',
    4.7,
    171,
    'central-parks-area-flooring-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring Company 5',
    '2900 Syracuse St, Denver, CO 80238',
    '(303) 555-1006',
    'https://central-parks-area-flooring-company-5.com',
    4.6,
    240,
    'central-parks-area-flooring-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring Company 6',
    '2373 Central Park Blvd, Denver, CO 80238',
    '(303) 555-1007',
    'https://central-parks-area-flooring-company-6.com',
    4.6,
    317,
    'central-parks-area-flooring-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring Company 7',
    '7711 MLK Blvd, Denver, CO 80238',
    '(303) 555-1008',
    'https://central-parks-area-flooring-company-7.com',
    4.8,
    222,
    'central-parks-area-flooring-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring Company 8',
    '8801 E Lowry Blvd, Denver, CO 80238',
    '(303) 555-1009',
    'https://central-parks-area-flooring-company-8.com',
    4.8,
    278,
    'central-parks-area-flooring-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Flooring Company 9',
    '8370 Northfield Blvd, Denver, CO 80238',
    '(303) 555-1010',
    'https://central-parks-area-flooring-company-9.com',
    4.8,
    191,
    'central-parks-area-flooring-company-9'
);

-- Verify insertion
SELECT 
    c.contractor_name,
    s.subregion_name,
    cat.category_name,
    c.address,
    c.phone,
    c.reviews_avg,
    c.reviews_count
FROM contractors c
JOIN categories cat ON c.category_id = cat.id
JOIN subregions s ON c.subregion_id = s.id
WHERE 
    cat.slug = 'flooring' 
    AND s.slug = 'central-parks-area'
ORDER BY c.contractor_name;
