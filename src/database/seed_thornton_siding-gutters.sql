-- Seed file for Thornton Siding & Gutters
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Siding & Gutters
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'siding-gutters'
),
-- Get the subregion_id for Thornton
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'thornton'
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
    'Thornton Siding & Gutters',
    '1700 Broadway, Denver, CO 80229',
    '(303) 555-1001',
    'https://thornton-siding-and-gutters.com',
    4.6,
    207,
    'thornton-siding-and-gutters'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Siding & Gutters Experts of Thornton',
    '1601 Blake Street, Denver, CO 80229',
    '(303) 555-1002',
    'https://siding-and-gutters-experts-of-thornton.com',
    4.8,
    181,
    'siding-and-gutters-experts-of-thornton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Siding & Gutters Thornton',
    '1747 Wynkoop St, Denver, CO 80229',
    '(303) 555-1003',
    'https://professional-siding-and-gutters-thornton.com',
    4.5,
    232,
    'professional-siding-and-gutters-thornton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Siding & Gutters Company 3',
    '1430 Larimer St, Denver, CO 80229',
    '(303) 555-1004',
    'https://thornton-siding-and-gutters-company-3.com',
    4.8,
    238,
    'thornton-siding-and-gutters-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Siding & Gutters Company 4',
    '1144 15th St, Denver, CO 80229',
    '(303) 555-1005',
    'https://thornton-siding-and-gutters-company-4.com',
    4.6,
    206,
    'thornton-siding-and-gutters-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Siding & Gutters Company 5',
    '1001 16th Street Mall, Denver, CO 80229',
    '(303) 555-1006',
    'https://thornton-siding-and-gutters-company-5.com',
    4.7,
    159,
    'thornton-siding-and-gutters-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Siding & Gutters Company 6',
    '1437 Bannock St, Denver, CO 80229',
    '(303) 555-1007',
    'https://thornton-siding-and-gutters-company-6.com',
    4.9,
    149,
    'thornton-siding-and-gutters-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Siding & Gutters Company 7',
    '200 E Colfax Ave, Denver, CO 80229',
    '(303) 555-1008',
    'https://thornton-siding-and-gutters-company-7.com',
    4.9,
    273,
    'thornton-siding-and-gutters-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Siding & Gutters Company 8',
    '1701 Champa St, Denver, CO 80229',
    '(303) 555-1009',
    'https://thornton-siding-and-gutters-company-8.com',
    4.9,
    274,
    'thornton-siding-and-gutters-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Siding & Gutters Company 9',
    '1801 California St, Denver, CO 80229',
    '(303) 555-1010',
    'https://thornton-siding-and-gutters-company-9.com',
    4.8,
    238,
    'thornton-siding-and-gutters-company-9'
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
    cat.slug = 'siding-gutters' 
    AND s.slug = 'thornton'
ORDER BY c.contractor_name;
