-- Seed file for Aurora Epoxy Garage
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Epoxy Garage
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'epoxy-garage'
),
-- Get the subregion_id for Aurora
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'aurora'
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
    'Aurora Epoxy Garage',
    '1700 Broadway, Denver, CO 80012',
    '(303) 555-1001',
    'https://aurora-epoxy-garage.com',
    4.5,
    320,
    'aurora-epoxy-garage'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Epoxy Garage Experts of Aurora',
    '1601 Blake Street, Denver, CO 80012',
    '(303) 555-1002',
    'https://epoxy-garage-experts-of-aurora.com',
    4.6,
    181,
    'epoxy-garage-experts-of-aurora'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Epoxy Garage Aurora',
    '1747 Wynkoop St, Denver, CO 80012',
    '(303) 555-1003',
    'https://professional-epoxy-garage-aurora.com',
    4.6,
    187,
    'professional-epoxy-garage-aurora'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Epoxy Garage Company 3',
    '1430 Larimer St, Denver, CO 80012',
    '(303) 555-1004',
    'https://aurora-epoxy-garage-company-3.com',
    4.8,
    158,
    'aurora-epoxy-garage-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Epoxy Garage Company 4',
    '1144 15th St, Denver, CO 80012',
    '(303) 555-1005',
    'https://aurora-epoxy-garage-company-4.com',
    4.5,
    305,
    'aurora-epoxy-garage-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Epoxy Garage Company 5',
    '1001 16th Street Mall, Denver, CO 80012',
    '(303) 555-1006',
    'https://aurora-epoxy-garage-company-5.com',
    4.7,
    212,
    'aurora-epoxy-garage-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Epoxy Garage Company 6',
    '1437 Bannock St, Denver, CO 80012',
    '(303) 555-1007',
    'https://aurora-epoxy-garage-company-6.com',
    4.9,
    267,
    'aurora-epoxy-garage-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Epoxy Garage Company 7',
    '200 E Colfax Ave, Denver, CO 80012',
    '(303) 555-1008',
    'https://aurora-epoxy-garage-company-7.com',
    4.7,
    162,
    'aurora-epoxy-garage-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Epoxy Garage Company 8',
    '1701 Champa St, Denver, CO 80012',
    '(303) 555-1009',
    'https://aurora-epoxy-garage-company-8.com',
    4.5,
    150,
    'aurora-epoxy-garage-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Aurora Epoxy Garage Company 9',
    '1801 California St, Denver, CO 80012',
    '(303) 555-1010',
    'https://aurora-epoxy-garage-company-9.com',
    4.5,
    188,
    'aurora-epoxy-garage-company-9'
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
    cat.slug = 'epoxy-garage' 
    AND s.slug = 'aurora'
ORDER BY c.contractor_name;
