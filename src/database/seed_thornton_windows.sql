-- Seed file for Thornton Windows
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Windows
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'windows'
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
    'Thornton Windows',
    '1700 Broadway, Denver, CO 80229',
    '(303) 555-1001',
    'https://thornton-windows.com',
    4.6,
    246,
    'thornton-windows'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Window Experts of Thornton',
    '1601 Blake Street, Denver, CO 80229',
    '(303) 555-1002',
    'https://window-experts-of-thornton.com',
    4.5,
    187,
    'window-experts-of-thornton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Window Thornton',
    '1747 Wynkoop St, Denver, CO 80229',
    '(303) 555-1003',
    'https://professional-window-thornton.com',
    4.8,
    308,
    'professional-window-thornton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Window Company 3',
    '1430 Larimer St, Denver, CO 80229',
    '(303) 555-1004',
    'https://thornton-window-company-3.com',
    4.6,
    258,
    'thornton-window-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Window Company 4',
    '1144 15th St, Denver, CO 80229',
    '(303) 555-1005',
    'https://thornton-window-company-4.com',
    4.8,
    275,
    'thornton-window-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Window Company 5',
    '1001 16th Street Mall, Denver, CO 80229',
    '(303) 555-1006',
    'https://thornton-window-company-5.com',
    4.7,
    305,
    'thornton-window-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Window Company 6',
    '1437 Bannock St, Denver, CO 80229',
    '(303) 555-1007',
    'https://thornton-window-company-6.com',
    4.9,
    180,
    'thornton-window-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Window Company 7',
    '200 E Colfax Ave, Denver, CO 80229',
    '(303) 555-1008',
    'https://thornton-window-company-7.com',
    4.9,
    170,
    'thornton-window-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Window Company 8',
    '1701 Champa St, Denver, CO 80229',
    '(303) 555-1009',
    'https://thornton-window-company-8.com',
    4.6,
    190,
    'thornton-window-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Window Company 9',
    '1801 California St, Denver, CO 80229',
    '(303) 555-1010',
    'https://thornton-window-company-9.com',
    4.6,
    219,
    'thornton-window-company-9'
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
    cat.slug = 'windows' 
    AND s.slug = 'thornton'
ORDER BY c.contractor_name;
