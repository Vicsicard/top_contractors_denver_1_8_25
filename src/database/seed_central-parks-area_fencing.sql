-- Seed file for Central Parks Area Fencing
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Fencing
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'fencing'
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
    'Central Parks Area Fencing',
    '8350 Central Park Blvd, Denver, CO 80238',
    '(303) 555-1001',
    'https://central-parks-area-fencing.com',
    4.6,
    238,
    'central-parks-area-fencing'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Fence Experts of Central Parks Area',
    '7995 E 49th Pl, Denver, CO 80238',
    '(303) 555-1002',
    'https://fence-experts-of-central-parks-area.com',
    4.6,
    225,
    'fence-experts-of-central-parks-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Fence Central Parks Area',
    '2373 Central Park Blvd, Denver, CO 80238',
    '(303) 555-1003',
    'https://professional-fence-central-parks-area.com',
    4.8,
    211,
    'professional-fence-central-parks-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Fence Company 3',
    '7484 E 29th Pl, Denver, CO 80238',
    '(303) 555-1004',
    'https://central-parks-area-fence-company-3.com',
    4.6,
    199,
    'central-parks-area-fence-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Fence Company 4',
    '7351 E 29th Ave, Denver, CO 80238',
    '(303) 555-1005',
    'https://central-parks-area-fence-company-4.com',
    4.9,
    292,
    'central-parks-area-fence-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Fence Company 5',
    '2900 Syracuse St, Denver, CO 80238',
    '(303) 555-1006',
    'https://central-parks-area-fence-company-5.com',
    4.8,
    321,
    'central-parks-area-fence-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Fence Company 6',
    '2373 Central Park Blvd, Denver, CO 80238',
    '(303) 555-1007',
    'https://central-parks-area-fence-company-6.com',
    4.6,
    218,
    'central-parks-area-fence-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Fence Company 7',
    '7711 MLK Blvd, Denver, CO 80238',
    '(303) 555-1008',
    'https://central-parks-area-fence-company-7.com',
    4.7,
    208,
    'central-parks-area-fence-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Fence Company 8',
    '8801 E Lowry Blvd, Denver, CO 80238',
    '(303) 555-1009',
    'https://central-parks-area-fence-company-8.com',
    4.7,
    215,
    'central-parks-area-fence-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Parks Area Fence Company 9',
    '8370 Northfield Blvd, Denver, CO 80238',
    '(303) 555-1010',
    'https://central-parks-area-fence-company-9.com',
    4.8,
    278,
    'central-parks-area-fence-company-9'
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
    cat.slug = 'fencing' 
    AND s.slug = 'central-parks-area'
ORDER BY c.contractor_name;
