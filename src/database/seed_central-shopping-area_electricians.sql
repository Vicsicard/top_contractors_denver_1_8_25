-- Seed file for Central Shopping Area Electricians
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Electricians
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'electricians'
),
-- Get the subregion_id for Central Shopping Area
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'central-shopping-area'
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
    'Central Shopping Area Electricians',
    '1700 Broadway, Denver, CO 80206',
    '(303) 555-1001',
    'https://central-shopping-area-electricians.com',
    4.5,
    274,
    'central-shopping-area-electricians'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Electrical Experts of Central Shopping Area',
    '1601 Blake Street, Denver, CO 80206',
    '(303) 555-1002',
    'https://electrical-experts-of-central-shopping-area.com',
    4.6,
    310,
    'electrical-experts-of-central-shopping-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Electrical Central Shopping Area',
    '1747 Wynkoop St, Denver, CO 80206',
    '(303) 555-1003',
    'https://professional-electrical-central-shopping-area.com',
    4.7,
    253,
    'professional-electrical-central-shopping-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Electrical Company 3',
    '1430 Larimer St, Denver, CO 80206',
    '(303) 555-1004',
    'https://central-shopping-area-electrical-company-3.com',
    4.7,
    204,
    'central-shopping-area-electrical-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Electrical Company 4',
    '1144 15th St, Denver, CO 80206',
    '(303) 555-1005',
    'https://central-shopping-area-electrical-company-4.com',
    4.6,
    188,
    'central-shopping-area-electrical-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Electrical Company 5',
    '1001 16th Street Mall, Denver, CO 80206',
    '(303) 555-1006',
    'https://central-shopping-area-electrical-company-5.com',
    4.9,
    277,
    'central-shopping-area-electrical-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Electrical Company 6',
    '1437 Bannock St, Denver, CO 80206',
    '(303) 555-1007',
    'https://central-shopping-area-electrical-company-6.com',
    4.6,
    247,
    'central-shopping-area-electrical-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Electrical Company 7',
    '200 E Colfax Ave, Denver, CO 80206',
    '(303) 555-1008',
    'https://central-shopping-area-electrical-company-7.com',
    4.5,
    267,
    'central-shopping-area-electrical-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Electrical Company 8',
    '1701 Champa St, Denver, CO 80206',
    '(303) 555-1009',
    'https://central-shopping-area-electrical-company-8.com',
    4.8,
    215,
    'central-shopping-area-electrical-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Electrical Company 9',
    '1801 California St, Denver, CO 80206',
    '(303) 555-1010',
    'https://central-shopping-area-electrical-company-9.com',
    4.7,
    300,
    'central-shopping-area-electrical-company-9'
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
    cat.slug = 'electricians' 
    AND s.slug = 'central-shopping-area'
ORDER BY c.contractor_name;
