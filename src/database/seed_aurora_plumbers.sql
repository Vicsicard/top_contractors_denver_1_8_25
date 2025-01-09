-- Seed file for Aurora Plumbers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Plumbers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'plumbers'
),
-- Get the subregion_id for Aurora
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'aurora'
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
    'Aurora Plumbers',
    '1700 Broadway, Denver, CO 80012',
    '(303) 555-1001',
    'https://aurora-plumbers.com',
    4.7,
    176,
    'aurora-plumbers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Plumbing Experts of Aurora',
    '1601 Blake Street, Denver, CO 80012',
    '(303) 555-1002',
    'https://plumbing-experts-of-aurora.com',
    4.7,
    220,
    'plumbing-experts-of-aurora'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Plumbing Aurora',
    '1747 Wynkoop St, Denver, CO 80012',
    '(303) 555-1003',
    'https://professional-plumbing-aurora.com',
    4.7,
    218,
    'professional-plumbing-aurora'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Plumbing Company 3',
    '1430 Larimer St, Denver, CO 80012',
    '(303) 555-1004',
    'https://aurora-plumbing-company-3.com',
    4.8,
    294,
    'aurora-plumbing-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Plumbing Company 4',
    '1144 15th St, Denver, CO 80012',
    '(303) 555-1005',
    'https://aurora-plumbing-company-4.com',
    4.5,
    236,
    'aurora-plumbing-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Plumbing Company 5',
    '1001 16th Street Mall, Denver, CO 80012',
    '(303) 555-1006',
    'https://aurora-plumbing-company-5.com',
    4.7,
    244,
    'aurora-plumbing-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Plumbing Company 6',
    '1437 Bannock St, Denver, CO 80012',
    '(303) 555-1007',
    'https://aurora-plumbing-company-6.com',
    4.6,
    216,
    'aurora-plumbing-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Plumbing Company 7',
    '200 E Colfax Ave, Denver, CO 80012',
    '(303) 555-1008',
    'https://aurora-plumbing-company-7.com',
    4.6,
    210,
    'aurora-plumbing-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Plumbing Company 8',
    '1701 Champa St, Denver, CO 80012',
    '(303) 555-1009',
    'https://aurora-plumbing-company-8.com',
    4.8,
    289,
    'aurora-plumbing-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Plumbing Company 9',
    '1801 California St, Denver, CO 80012',
    '(303) 555-1010',
    'https://aurora-plumbing-company-9.com',
    4.7,
    160,
    'aurora-plumbing-company-9'
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
    AND s.slug = 'aurora'
ORDER BY c.contractor_name;
