-- Seed file for Park Hill Area Painters
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Painters
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'painters'
),
-- Get the subregion_id for Park Hill Area
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'park-hill-area'
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
    'Park Hill Area Painters',
    '1700 Broadway, Denver, CO 80207',
    '(303) 555-1001',
    'https://park-hill-area-painters.com',
    4.8,
    159,
    'park-hill-area-painters'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Painting Experts of Park Hill Area',
    '1601 Blake Street, Denver, CO 80207',
    '(303) 555-1002',
    'https://painting-experts-of-park-hill-area.com',
    4.5,
    284,
    'painting-experts-of-park-hill-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Painting Park Hill Area',
    '1747 Wynkoop St, Denver, CO 80207',
    '(303) 555-1003',
    'https://professional-painting-park-hill-area.com',
    4.6,
    268,
    'professional-painting-park-hill-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Park Hill Area Painting Company 3',
    '1430 Larimer St, Denver, CO 80207',
    '(303) 555-1004',
    'https://park-hill-area-painting-company-3.com',
    4.7,
    298,
    'park-hill-area-painting-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Park Hill Area Painting Company 4',
    '1144 15th St, Denver, CO 80207',
    '(303) 555-1005',
    'https://park-hill-area-painting-company-4.com',
    4.8,
    263,
    'park-hill-area-painting-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Park Hill Area Painting Company 5',
    '1001 16th Street Mall, Denver, CO 80207',
    '(303) 555-1006',
    'https://park-hill-area-painting-company-5.com',
    4.9,
    204,
    'park-hill-area-painting-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Park Hill Area Painting Company 6',
    '1437 Bannock St, Denver, CO 80207',
    '(303) 555-1007',
    'https://park-hill-area-painting-company-6.com',
    4.6,
    302,
    'park-hill-area-painting-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Park Hill Area Painting Company 7',
    '200 E Colfax Ave, Denver, CO 80207',
    '(303) 555-1008',
    'https://park-hill-area-painting-company-7.com',
    4.9,
    197,
    'park-hill-area-painting-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Park Hill Area Painting Company 8',
    '1701 Champa St, Denver, CO 80207',
    '(303) 555-1009',
    'https://park-hill-area-painting-company-8.com',
    4.6,
    177,
    'park-hill-area-painting-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Park Hill Area Painting Company 9',
    '1801 California St, Denver, CO 80207',
    '(303) 555-1010',
    'https://park-hill-area-painting-company-9.com',
    4.6,
    293,
    'park-hill-area-painting-company-9'
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
    AND s.slug = 'park-hill-area'
ORDER BY c.contractor_name;
