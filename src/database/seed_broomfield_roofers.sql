-- Seed file for Broomfield Roofers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Roofers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'roofers'
),
-- Get the subregion_id for Broomfield
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'broomfield'
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
    'Broomfield Roofers',
    '1700 Broadway, Denver, CO 80020',
    '(303) 555-1001',
    'https://broomfield-roofers.com',
    4.8,
    304,
    'broomfield-roofers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Roofing Experts of Broomfield',
    '1601 Blake Street, Denver, CO 80020',
    '(303) 555-1002',
    'https://roofing-experts-of-broomfield.com',
    4.7,
    315,
    'roofing-experts-of-broomfield'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Roofing Broomfield',
    '1747 Wynkoop St, Denver, CO 80020',
    '(303) 555-1003',
    'https://professional-roofing-broomfield.com',
    4.9,
    247,
    'professional-roofing-broomfield'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Roofing Company 3',
    '1430 Larimer St, Denver, CO 80020',
    '(303) 555-1004',
    'https://broomfield-roofing-company-3.com',
    4.8,
    283,
    'broomfield-roofing-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Roofing Company 4',
    '1144 15th St, Denver, CO 80020',
    '(303) 555-1005',
    'https://broomfield-roofing-company-4.com',
    4.7,
    178,
    'broomfield-roofing-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Roofing Company 5',
    '1001 16th Street Mall, Denver, CO 80020',
    '(303) 555-1006',
    'https://broomfield-roofing-company-5.com',
    4.8,
    311,
    'broomfield-roofing-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Roofing Company 6',
    '1437 Bannock St, Denver, CO 80020',
    '(303) 555-1007',
    'https://broomfield-roofing-company-6.com',
    4.8,
    287,
    'broomfield-roofing-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Roofing Company 7',
    '200 E Colfax Ave, Denver, CO 80020',
    '(303) 555-1008',
    'https://broomfield-roofing-company-7.com',
    4.6,
    149,
    'broomfield-roofing-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Roofing Company 8',
    '1701 Champa St, Denver, CO 80020',
    '(303) 555-1009',
    'https://broomfield-roofing-company-8.com',
    4.5,
    212,
    'broomfield-roofing-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Roofing Company 9',
    '1801 California St, Denver, CO 80020',
    '(303) 555-1010',
    'https://broomfield-roofing-company-9.com',
    4.8,
    149,
    'broomfield-roofing-company-9'
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
    cat.slug = 'roofers' 
    AND s.slug = 'broomfield'
ORDER BY c.contractor_name;
