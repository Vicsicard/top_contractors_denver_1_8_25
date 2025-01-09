-- Seed file for Aurora Electricians
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Electricians
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'electricians'
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
    'Aurora Electricians',
    '1700 Broadway, Denver, CO 80012',
    '(303) 555-1001',
    'https://aurora-electricians.com',
    4.5,
    313,
    'aurora-electricians'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Electrical Experts of Aurora',
    '1601 Blake Street, Denver, CO 80012',
    '(303) 555-1002',
    'https://electrical-experts-of-aurora.com',
    4.7,
    219,
    'electrical-experts-of-aurora'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Electrical Aurora',
    '1747 Wynkoop St, Denver, CO 80012',
    '(303) 555-1003',
    'https://professional-electrical-aurora.com',
    4.6,
    175,
    'professional-electrical-aurora'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Electrical Company 3',
    '1430 Larimer St, Denver, CO 80012',
    '(303) 555-1004',
    'https://aurora-electrical-company-3.com',
    4.6,
    302,
    'aurora-electrical-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Electrical Company 4',
    '1144 15th St, Denver, CO 80012',
    '(303) 555-1005',
    'https://aurora-electrical-company-4.com',
    4.8,
    175,
    'aurora-electrical-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Electrical Company 5',
    '1001 16th Street Mall, Denver, CO 80012',
    '(303) 555-1006',
    'https://aurora-electrical-company-5.com',
    4.7,
    304,
    'aurora-electrical-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Electrical Company 6',
    '1437 Bannock St, Denver, CO 80012',
    '(303) 555-1007',
    'https://aurora-electrical-company-6.com',
    4.5,
    200,
    'aurora-electrical-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Electrical Company 7',
    '200 E Colfax Ave, Denver, CO 80012',
    '(303) 555-1008',
    'https://aurora-electrical-company-7.com',
    4.6,
    275,
    'aurora-electrical-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Electrical Company 8',
    '1701 Champa St, Denver, CO 80012',
    '(303) 555-1009',
    'https://aurora-electrical-company-8.com',
    4.5,
    232,
    'aurora-electrical-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Electrical Company 9',
    '1801 California St, Denver, CO 80012',
    '(303) 555-1010',
    'https://aurora-electrical-company-9.com',
    4.8,
    314,
    'aurora-electrical-company-9'
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
    cat.slug = 'electricians' 
    AND s.slug = 'aurora'
ORDER BY c.contractor_name;
