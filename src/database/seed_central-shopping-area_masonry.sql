-- Seed file for Central Shopping Area Masonry
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Masonry
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'masonry'
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
    'Central Shopping Area Masonry',
    '1700 Broadway, Denver, CO 80206',
    '(303) 555-1001',
    'https://central-shopping-area-masonry.com',
    4.5,
    176,
    'central-shopping-area-masonry'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Masonry Experts of Central Shopping Area',
    '1601 Blake Street, Denver, CO 80206',
    '(303) 555-1002',
    'https://masonry-experts-of-central-shopping-area.com',
    4.5,
    226,
    'masonry-experts-of-central-shopping-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Masonry Central Shopping Area',
    '1747 Wynkoop St, Denver, CO 80206',
    '(303) 555-1003',
    'https://professional-masonry-central-shopping-area.com',
    4.7,
    167,
    'professional-masonry-central-shopping-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Masonry Company 3',
    '1430 Larimer St, Denver, CO 80206',
    '(303) 555-1004',
    'https://central-shopping-area-masonry-company-3.com',
    4.6,
    255,
    'central-shopping-area-masonry-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Masonry Company 4',
    '1144 15th St, Denver, CO 80206',
    '(303) 555-1005',
    'https://central-shopping-area-masonry-company-4.com',
    4.8,
    199,
    'central-shopping-area-masonry-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Masonry Company 5',
    '1001 16th Street Mall, Denver, CO 80206',
    '(303) 555-1006',
    'https://central-shopping-area-masonry-company-5.com',
    4.5,
    324,
    'central-shopping-area-masonry-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Masonry Company 6',
    '1437 Bannock St, Denver, CO 80206',
    '(303) 555-1007',
    'https://central-shopping-area-masonry-company-6.com',
    4.5,
    312,
    'central-shopping-area-masonry-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Masonry Company 7',
    '200 E Colfax Ave, Denver, CO 80206',
    '(303) 555-1008',
    'https://central-shopping-area-masonry-company-7.com',
    4.7,
    255,
    'central-shopping-area-masonry-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Masonry Company 8',
    '1701 Champa St, Denver, CO 80206',
    '(303) 555-1009',
    'https://central-shopping-area-masonry-company-8.com',
    4.8,
    206,
    'central-shopping-area-masonry-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Central Shopping Area Masonry Company 9',
    '1801 California St, Denver, CO 80206',
    '(303) 555-1010',
    'https://central-shopping-area-masonry-company-9.com',
    4.7,
    169,
    'central-shopping-area-masonry-company-9'
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
    cat.slug = 'masonry' 
    AND s.slug = 'central-shopping-area'
ORDER BY c.contractor_name;
