-- Seed file for Lakewood HVAC
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for HVAC
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'hvac'
),
-- Get the subregion_id for Lakewood
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'lakewood'
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
    'Lakewood HVAC',
    '1700 Broadway, Denver, CO 80214',
    '(303) 555-1001',
    'https://lakewood-hvac.com',
    4.8,
    253,
    'lakewood-hvac'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'HVAC Experts of Lakewood',
    '1601 Blake Street, Denver, CO 80214',
    '(303) 555-1002',
    'https://hvac-experts-of-lakewood.com',
    4.8,
    167,
    'hvac-experts-of-lakewood'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional HVAC Lakewood',
    '1747 Wynkoop St, Denver, CO 80214',
    '(303) 555-1003',
    'https://professional-hvac-lakewood.com',
    4.9,
    236,
    'professional-hvac-lakewood'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Lakewood HVAC Company 3',
    '1430 Larimer St, Denver, CO 80214',
    '(303) 555-1004',
    'https://lakewood-hvac-company-3.com',
    4.6,
    301,
    'lakewood-hvac-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Lakewood HVAC Company 4',
    '1144 15th St, Denver, CO 80214',
    '(303) 555-1005',
    'https://lakewood-hvac-company-4.com',
    4.8,
    213,
    'lakewood-hvac-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Lakewood HVAC Company 5',
    '1001 16th Street Mall, Denver, CO 80214',
    '(303) 555-1006',
    'https://lakewood-hvac-company-5.com',
    4.8,
    170,
    'lakewood-hvac-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Lakewood HVAC Company 6',
    '1437 Bannock St, Denver, CO 80214',
    '(303) 555-1007',
    'https://lakewood-hvac-company-6.com',
    4.7,
    223,
    'lakewood-hvac-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Lakewood HVAC Company 7',
    '200 E Colfax Ave, Denver, CO 80214',
    '(303) 555-1008',
    'https://lakewood-hvac-company-7.com',
    4.8,
    289,
    'lakewood-hvac-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Lakewood HVAC Company 8',
    '1701 Champa St, Denver, CO 80214',
    '(303) 555-1009',
    'https://lakewood-hvac-company-8.com',
    4.6,
    288,
    'lakewood-hvac-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Lakewood HVAC Company 9',
    '1801 California St, Denver, CO 80214',
    '(303) 555-1010',
    'https://lakewood-hvac-company-9.com',
    4.7,
    300,
    'lakewood-hvac-company-9'
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
    cat.slug = 'hvac' 
    AND s.slug = 'lakewood'
ORDER BY c.contractor_name;
