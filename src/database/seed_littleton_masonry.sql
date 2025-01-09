-- Seed file for Littleton Masonry
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Masonry
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'masonry'
),
-- Get the subregion_id for Littleton
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'littleton'
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
    'Littleton Masonry',
    '1700 Broadway, Denver, CO 80120',
    '(303) 555-1001',
    'https://littleton-masonry.com',
    4.5,
    203,
    'littleton-masonry'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Masonry Experts of Littleton',
    '1601 Blake Street, Denver, CO 80120',
    '(303) 555-1002',
    'https://masonry-experts-of-littleton.com',
    4.6,
    303,
    'masonry-experts-of-littleton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Masonry Littleton',
    '1747 Wynkoop St, Denver, CO 80120',
    '(303) 555-1003',
    'https://professional-masonry-littleton.com',
    4.6,
    188,
    'professional-masonry-littleton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Masonry Company 3',
    '1430 Larimer St, Denver, CO 80120',
    '(303) 555-1004',
    'https://littleton-masonry-company-3.com',
    4.8,
    149,
    'littleton-masonry-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Masonry Company 4',
    '1144 15th St, Denver, CO 80120',
    '(303) 555-1005',
    'https://littleton-masonry-company-4.com',
    4.8,
    280,
    'littleton-masonry-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Masonry Company 5',
    '1001 16th Street Mall, Denver, CO 80120',
    '(303) 555-1006',
    'https://littleton-masonry-company-5.com',
    4.9,
    208,
    'littleton-masonry-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Masonry Company 6',
    '1437 Bannock St, Denver, CO 80120',
    '(303) 555-1007',
    'https://littleton-masonry-company-6.com',
    4.6,
    195,
    'littleton-masonry-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Masonry Company 7',
    '200 E Colfax Ave, Denver, CO 80120',
    '(303) 555-1008',
    'https://littleton-masonry-company-7.com',
    4.6,
    156,
    'littleton-masonry-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Masonry Company 8',
    '1701 Champa St, Denver, CO 80120',
    '(303) 555-1009',
    'https://littleton-masonry-company-8.com',
    4.7,
    175,
    'littleton-masonry-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Masonry Company 9',
    '1801 California St, Denver, CO 80120',
    '(303) 555-1010',
    'https://littleton-masonry-company-9.com',
    4.6,
    184,
    'littleton-masonry-company-9'
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
    AND s.slug = 'littleton'
ORDER BY c.contractor_name;
