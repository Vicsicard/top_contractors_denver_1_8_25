-- Seed file for Northglenn Plumbers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Plumbers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'plumbers'
),
-- Get the subregion_id for Northglenn
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'northglenn'
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
    'Northglenn Plumbers',
    '1700 Broadway, Denver, CO 80233',
    '(303) 555-1001',
    'https://northglenn-plumbers.com',
    4.8,
    315,
    'northglenn-plumbers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Plumbing Experts of Northglenn',
    '1601 Blake Street, Denver, CO 80233',
    '(303) 555-1002',
    'https://plumbing-experts-of-northglenn.com',
    4.6,
    159,
    'plumbing-experts-of-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Plumbing Northglenn',
    '1747 Wynkoop St, Denver, CO 80233',
    '(303) 555-1003',
    'https://professional-plumbing-northglenn.com',
    4.6,
    147,
    'professional-plumbing-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Plumbing Company 3',
    '1430 Larimer St, Denver, CO 80233',
    '(303) 555-1004',
    'https://northglenn-plumbing-company-3.com',
    4.7,
    272,
    'northglenn-plumbing-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Plumbing Company 4',
    '1144 15th St, Denver, CO 80233',
    '(303) 555-1005',
    'https://northglenn-plumbing-company-4.com',
    4.7,
    293,
    'northglenn-plumbing-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Plumbing Company 5',
    '1001 16th Street Mall, Denver, CO 80233',
    '(303) 555-1006',
    'https://northglenn-plumbing-company-5.com',
    4.8,
    240,
    'northglenn-plumbing-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Plumbing Company 6',
    '1437 Bannock St, Denver, CO 80233',
    '(303) 555-1007',
    'https://northglenn-plumbing-company-6.com',
    4.8,
    254,
    'northglenn-plumbing-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Plumbing Company 7',
    '200 E Colfax Ave, Denver, CO 80233',
    '(303) 555-1008',
    'https://northglenn-plumbing-company-7.com',
    4.7,
    205,
    'northglenn-plumbing-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Plumbing Company 8',
    '1701 Champa St, Denver, CO 80233',
    '(303) 555-1009',
    'https://northglenn-plumbing-company-8.com',
    4.5,
    256,
    'northglenn-plumbing-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Plumbing Company 9',
    '1801 California St, Denver, CO 80233',
    '(303) 555-1010',
    'https://northglenn-plumbing-company-9.com',
    4.9,
    180,
    'northglenn-plumbing-company-9'
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
    AND s.slug = 'northglenn'
ORDER BY c.contractor_name;
