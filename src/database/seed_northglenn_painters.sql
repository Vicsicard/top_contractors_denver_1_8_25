-- Seed file for Northglenn Painters
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Painters
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'painters'
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
    'Northglenn Painters',
    '1700 Broadway, Denver, CO 80233',
    '(303) 555-1001',
    'https://northglenn-painters.com',
    4.6,
    293,
    'northglenn-painters'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Painting Experts of Northglenn',
    '1601 Blake Street, Denver, CO 80233',
    '(303) 555-1002',
    'https://painting-experts-of-northglenn.com',
    4.7,
    269,
    'painting-experts-of-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Painting Northglenn',
    '1747 Wynkoop St, Denver, CO 80233',
    '(303) 555-1003',
    'https://professional-painting-northglenn.com',
    4.7,
    315,
    'professional-painting-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Painting Company 3',
    '1430 Larimer St, Denver, CO 80233',
    '(303) 555-1004',
    'https://northglenn-painting-company-3.com',
    4.6,
    309,
    'northglenn-painting-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Painting Company 4',
    '1144 15th St, Denver, CO 80233',
    '(303) 555-1005',
    'https://northglenn-painting-company-4.com',
    4.8,
    148,
    'northglenn-painting-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Painting Company 5',
    '1001 16th Street Mall, Denver, CO 80233',
    '(303) 555-1006',
    'https://northglenn-painting-company-5.com',
    4.9,
    320,
    'northglenn-painting-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Painting Company 6',
    '1437 Bannock St, Denver, CO 80233',
    '(303) 555-1007',
    'https://northglenn-painting-company-6.com',
    4.8,
    188,
    'northglenn-painting-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Painting Company 7',
    '200 E Colfax Ave, Denver, CO 80233',
    '(303) 555-1008',
    'https://northglenn-painting-company-7.com',
    4.6,
    194,
    'northglenn-painting-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Painting Company 8',
    '1701 Champa St, Denver, CO 80233',
    '(303) 555-1009',
    'https://northglenn-painting-company-8.com',
    4.7,
    262,
    'northglenn-painting-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Painting Company 9',
    '1801 California St, Denver, CO 80233',
    '(303) 555-1010',
    'https://northglenn-painting-company-9.com',
    4.8,
    163,
    'northglenn-painting-company-9'
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
    cat.slug = 'painters' 
    AND s.slug = 'northglenn'
ORDER BY c.contractor_name;
