-- Seed file for Westminster Kitchen Remodelers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Kitchen Remodelers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'kitchen-remodelers'
),
-- Get the subregion_id for Westminster
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'westminster'
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
    'Westminster Kitchen Remodelers',
    '1700 Broadway, Denver, CO 80030',
    '(303) 555-1001',
    'https://westminster-kitchen-remodelers.com',
    4.9,
    204,
    'westminster-kitchen-remodelers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Kitchen Remodeling Experts of Westminster',
    '1601 Blake Street, Denver, CO 80030',
    '(303) 555-1002',
    'https://kitchen-remodeling-experts-of-westminster.com',
    4.8,
    243,
    'kitchen-remodeling-experts-of-westminster'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Kitchen Remodeling Westminster',
    '1747 Wynkoop St, Denver, CO 80030',
    '(303) 555-1003',
    'https://professional-kitchen-remodeling-westminster.com',
    4.5,
    226,
    'professional-kitchen-remodeling-westminster'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Kitchen Remodeling Company 3',
    '1430 Larimer St, Denver, CO 80030',
    '(303) 555-1004',
    'https://westminster-kitchen-remodeling-company-3.com',
    4.8,
    320,
    'westminster-kitchen-remodeling-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Kitchen Remodeling Company 4',
    '1144 15th St, Denver, CO 80030',
    '(303) 555-1005',
    'https://westminster-kitchen-remodeling-company-4.com',
    4.6,
    214,
    'westminster-kitchen-remodeling-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Kitchen Remodeling Company 5',
    '1001 16th Street Mall, Denver, CO 80030',
    '(303) 555-1006',
    'https://westminster-kitchen-remodeling-company-5.com',
    4.6,
    217,
    'westminster-kitchen-remodeling-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Kitchen Remodeling Company 6',
    '1437 Bannock St, Denver, CO 80030',
    '(303) 555-1007',
    'https://westminster-kitchen-remodeling-company-6.com',
    4.6,
    254,
    'westminster-kitchen-remodeling-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Kitchen Remodeling Company 7',
    '200 E Colfax Ave, Denver, CO 80030',
    '(303) 555-1008',
    'https://westminster-kitchen-remodeling-company-7.com',
    4.8,
    264,
    'westminster-kitchen-remodeling-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Kitchen Remodeling Company 8',
    '1701 Champa St, Denver, CO 80030',
    '(303) 555-1009',
    'https://westminster-kitchen-remodeling-company-8.com',
    4.5,
    242,
    'westminster-kitchen-remodeling-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Kitchen Remodeling Company 9',
    '1801 California St, Denver, CO 80030',
    '(303) 555-1010',
    'https://westminster-kitchen-remodeling-company-9.com',
    4.8,
    174,
    'westminster-kitchen-remodeling-company-9'
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
    cat.slug = 'kitchen-remodelers' 
    AND s.slug = 'westminster'
ORDER BY c.contractor_name;
