-- Seed file for Central Shopping Area Plumbers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Plumbers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'plumbers'
),
-- Get the subregion_id for Central Shopping Area
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'central-shopping-area'
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
    'Central Shopping Area Plumbers',
    '1700 Broadway, Denver, CO 80206',
    '(303) 555-1001',
    'https://central-shopping-area-plumbers.com',
    4.6,
    260,
    'central-shopping-area-plumbers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Plumbing Experts of Central Shopping Area',
    '1601 Blake Street, Denver, CO 80206',
    '(303) 555-1002',
    'https://plumbing-experts-of-central-shopping-area.com',
    4.5,
    255,
    'plumbing-experts-of-central-shopping-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Plumbing Central Shopping Area',
    '1747 Wynkoop St, Denver, CO 80206',
    '(303) 555-1003',
    'https://professional-plumbing-central-shopping-area.com',
    4.6,
    184,
    'professional-plumbing-central-shopping-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Plumbing Company 3',
    '1430 Larimer St, Denver, CO 80206',
    '(303) 555-1004',
    'https://central-shopping-area-plumbing-company-3.com',
    4.9,
    295,
    'central-shopping-area-plumbing-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Plumbing Company 4',
    '1144 15th St, Denver, CO 80206',
    '(303) 555-1005',
    'https://central-shopping-area-plumbing-company-4.com',
    4.8,
    256,
    'central-shopping-area-plumbing-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Plumbing Company 5',
    '1001 16th Street Mall, Denver, CO 80206',
    '(303) 555-1006',
    'https://central-shopping-area-plumbing-company-5.com',
    4.8,
    161,
    'central-shopping-area-plumbing-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Plumbing Company 6',
    '1437 Bannock St, Denver, CO 80206',
    '(303) 555-1007',
    'https://central-shopping-area-plumbing-company-6.com',
    4.6,
    294,
    'central-shopping-area-plumbing-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Plumbing Company 7',
    '200 E Colfax Ave, Denver, CO 80206',
    '(303) 555-1008',
    'https://central-shopping-area-plumbing-company-7.com',
    4.8,
    202,
    'central-shopping-area-plumbing-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Plumbing Company 8',
    '1701 Champa St, Denver, CO 80206',
    '(303) 555-1009',
    'https://central-shopping-area-plumbing-company-8.com',
    4.8,
    217,
    'central-shopping-area-plumbing-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Plumbing Company 9',
    '1801 California St, Denver, CO 80206',
    '(303) 555-1010',
    'https://central-shopping-area-plumbing-company-9.com',
    4.7,
    150,
    'central-shopping-area-plumbing-company-9'
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
    cat.slug = 'plumbers' 
    AND s.slug = 'central-shopping-area'
ORDER BY c.contractor_name;
