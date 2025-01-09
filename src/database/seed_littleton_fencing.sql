-- Seed file for Littleton Fencing
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Fencing
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'fencing'
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
    'Littleton Fencing',
    '1700 Broadway, Denver, CO 80120',
    '(303) 555-1001',
    'https://littleton-fencing.com',
    4.9,
    322,
    'littleton-fencing'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Fence Experts of Littleton',
    '1601 Blake Street, Denver, CO 80120',
    '(303) 555-1002',
    'https://fence-experts-of-littleton.com',
    4.5,
    271,
    'fence-experts-of-littleton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Fence Littleton',
    '1747 Wynkoop St, Denver, CO 80120',
    '(303) 555-1003',
    'https://professional-fence-littleton.com',
    4.8,
    159,
    'professional-fence-littleton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Fence Company 3',
    '1430 Larimer St, Denver, CO 80120',
    '(303) 555-1004',
    'https://littleton-fence-company-3.com',
    4.8,
    215,
    'littleton-fence-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Fence Company 4',
    '1144 15th St, Denver, CO 80120',
    '(303) 555-1005',
    'https://littleton-fence-company-4.com',
    4.6,
    189,
    'littleton-fence-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Fence Company 5',
    '1001 16th Street Mall, Denver, CO 80120',
    '(303) 555-1006',
    'https://littleton-fence-company-5.com',
    4.7,
    310,
    'littleton-fence-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Fence Company 6',
    '1437 Bannock St, Denver, CO 80120',
    '(303) 555-1007',
    'https://littleton-fence-company-6.com',
    4.6,
    312,
    'littleton-fence-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Fence Company 7',
    '200 E Colfax Ave, Denver, CO 80120',
    '(303) 555-1008',
    'https://littleton-fence-company-7.com',
    4.8,
    146,
    'littleton-fence-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Fence Company 8',
    '1701 Champa St, Denver, CO 80120',
    '(303) 555-1009',
    'https://littleton-fence-company-8.com',
    4.8,
    248,
    'littleton-fence-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Littleton Fence Company 9',
    '1801 California St, Denver, CO 80120',
    '(303) 555-1010',
    'https://littleton-fence-company-9.com',
    4.7,
    221,
    'littleton-fence-company-9'
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
    cat.slug = 'fencing' 
    AND s.slug = 'littleton'
ORDER BY c.contractor_name;
