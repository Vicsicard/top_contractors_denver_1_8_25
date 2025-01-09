-- Seed file for Broomfield Painters
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Painters
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'painters'
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
    'Broomfield Painters',
    '1700 Broadway, Denver, CO 80020',
    '(303) 555-1001',
    'https://broomfield-painters.com',
    4.6,
    265,
    'broomfield-painters'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Painting Experts of Broomfield',
    '1601 Blake Street, Denver, CO 80020',
    '(303) 555-1002',
    'https://painting-experts-of-broomfield.com',
    4.7,
    179,
    'painting-experts-of-broomfield'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Painting Broomfield',
    '1747 Wynkoop St, Denver, CO 80020',
    '(303) 555-1003',
    'https://professional-painting-broomfield.com',
    4.9,
    202,
    'professional-painting-broomfield'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Painting Company 3',
    '1430 Larimer St, Denver, CO 80020',
    '(303) 555-1004',
    'https://broomfield-painting-company-3.com',
    4.9,
    210,
    'broomfield-painting-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Painting Company 4',
    '1144 15th St, Denver, CO 80020',
    '(303) 555-1005',
    'https://broomfield-painting-company-4.com',
    4.8,
    278,
    'broomfield-painting-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Painting Company 5',
    '1001 16th Street Mall, Denver, CO 80020',
    '(303) 555-1006',
    'https://broomfield-painting-company-5.com',
    4.5,
    223,
    'broomfield-painting-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Painting Company 6',
    '1437 Bannock St, Denver, CO 80020',
    '(303) 555-1007',
    'https://broomfield-painting-company-6.com',
    4.7,
    298,
    'broomfield-painting-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Painting Company 7',
    '200 E Colfax Ave, Denver, CO 80020',
    '(303) 555-1008',
    'https://broomfield-painting-company-7.com',
    4.5,
    214,
    'broomfield-painting-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Painting Company 8',
    '1701 Champa St, Denver, CO 80020',
    '(303) 555-1009',
    'https://broomfield-painting-company-8.com',
    4.7,
    297,
    'broomfield-painting-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Broomfield Painting Company 9',
    '1801 California St, Denver, CO 80020',
    '(303) 555-1010',
    'https://broomfield-painting-company-9.com',
    4.9,
    234,
    'broomfield-painting-company-9'
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
    AND s.slug = 'broomfield'
ORDER BY c.contractor_name;
