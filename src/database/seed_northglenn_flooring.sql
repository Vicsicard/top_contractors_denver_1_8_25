-- Seed file for Northglenn Flooring
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Flooring
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'flooring'
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
    'Northglenn Flooring',
    '1700 Broadway, Denver, CO 80233',
    '(303) 555-1001',
    'https://northglenn-flooring.com',
    4.8,
    254,
    'northglenn-flooring'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Flooring Experts of Northglenn',
    '1601 Blake Street, Denver, CO 80233',
    '(303) 555-1002',
    'https://flooring-experts-of-northglenn.com',
    4.8,
    185,
    'flooring-experts-of-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Flooring Northglenn',
    '1747 Wynkoop St, Denver, CO 80233',
    '(303) 555-1003',
    'https://professional-flooring-northglenn.com',
    4.8,
    161,
    'professional-flooring-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Flooring Company 3',
    '1430 Larimer St, Denver, CO 80233',
    '(303) 555-1004',
    'https://northglenn-flooring-company-3.com',
    4.6,
    247,
    'northglenn-flooring-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Flooring Company 4',
    '1144 15th St, Denver, CO 80233',
    '(303) 555-1005',
    'https://northglenn-flooring-company-4.com',
    4.6,
    226,
    'northglenn-flooring-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Flooring Company 5',
    '1001 16th Street Mall, Denver, CO 80233',
    '(303) 555-1006',
    'https://northglenn-flooring-company-5.com',
    4.9,
    158,
    'northglenn-flooring-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Flooring Company 6',
    '1437 Bannock St, Denver, CO 80233',
    '(303) 555-1007',
    'https://northglenn-flooring-company-6.com',
    4.8,
    233,
    'northglenn-flooring-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Flooring Company 7',
    '200 E Colfax Ave, Denver, CO 80233',
    '(303) 555-1008',
    'https://northglenn-flooring-company-7.com',
    4.6,
    279,
    'northglenn-flooring-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Flooring Company 8',
    '1701 Champa St, Denver, CO 80233',
    '(303) 555-1009',
    'https://northglenn-flooring-company-8.com',
    4.8,
    165,
    'northglenn-flooring-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Flooring Company 9',
    '1801 California St, Denver, CO 80233',
    '(303) 555-1010',
    'https://northglenn-flooring-company-9.com',
    4.6,
    273,
    'northglenn-flooring-company-9'
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
    AND s.slug = 'northglenn'
ORDER BY c.contractor_name;
