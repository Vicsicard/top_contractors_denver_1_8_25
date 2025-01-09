-- Seed file for Northeast Area Home Remodelers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Home Remodelers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'home-remodelers'
),
-- Get the subregion_id for Northeast Area
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'northeast-area'
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
    'Northeast Area Home Remodelers',
    '1700 Broadway, Denver, CO 80239',
    '(303) 555-1001',
    'https://northeast-area-home-remodelers.com',
    4.8,
    233,
    'northeast-area-home-remodelers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Home Remodeling Experts of Northeast Area',
    '1601 Blake Street, Denver, CO 80239',
    '(303) 555-1002',
    'https://home-remodeling-experts-of-northeast-area.com',
    4.5,
    194,
    'home-remodeling-experts-of-northeast-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Home Remodeling Northeast Area',
    '1747 Wynkoop St, Denver, CO 80239',
    '(303) 555-1003',
    'https://professional-home-remodeling-northeast-area.com',
    4.8,
    209,
    'professional-home-remodeling-northeast-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northeast Area Home Remodeling Company 3',
    '1430 Larimer St, Denver, CO 80239',
    '(303) 555-1004',
    'https://northeast-area-home-remodeling-company-3.com',
    4.8,
    192,
    'northeast-area-home-remodeling-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northeast Area Home Remodeling Company 4',
    '1144 15th St, Denver, CO 80239',
    '(303) 555-1005',
    'https://northeast-area-home-remodeling-company-4.com',
    4.6,
    172,
    'northeast-area-home-remodeling-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northeast Area Home Remodeling Company 5',
    '1001 16th Street Mall, Denver, CO 80239',
    '(303) 555-1006',
    'https://northeast-area-home-remodeling-company-5.com',
    4.9,
    244,
    'northeast-area-home-remodeling-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northeast Area Home Remodeling Company 6',
    '1437 Bannock St, Denver, CO 80239',
    '(303) 555-1007',
    'https://northeast-area-home-remodeling-company-6.com',
    4.6,
    162,
    'northeast-area-home-remodeling-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northeast Area Home Remodeling Company 7',
    '200 E Colfax Ave, Denver, CO 80239',
    '(303) 555-1008',
    'https://northeast-area-home-remodeling-company-7.com',
    4.8,
    168,
    'northeast-area-home-remodeling-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northeast Area Home Remodeling Company 8',
    '1701 Champa St, Denver, CO 80239',
    '(303) 555-1009',
    'https://northeast-area-home-remodeling-company-8.com',
    4.9,
    224,
    'northeast-area-home-remodeling-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northeast Area Home Remodeling Company 9',
    '1801 California St, Denver, CO 80239',
    '(303) 555-1010',
    'https://northeast-area-home-remodeling-company-9.com',
    4.9,
    220,
    'northeast-area-home-remodeling-company-9'
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
    cat.slug = 'home-remodelers' 
    AND s.slug = 'northeast-area'
ORDER BY c.contractor_name;
