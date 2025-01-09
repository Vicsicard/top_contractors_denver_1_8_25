-- Seed file for Northglenn Epoxy Garage
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Epoxy Garage
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'epoxy-garage'
),
-- Get the subregion_id for Northglenn
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'northglenn'
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
    'Northglenn Epoxy Garage',
    '1700 Broadway, Denver, CO 80233',
    '(303) 555-1001',
    'https://northglenn-epoxy-garage.com',
    4.6,
    253,
    'northglenn-epoxy-garage'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Epoxy Garage Experts of Northglenn',
    '1601 Blake Street, Denver, CO 80233',
    '(303) 555-1002',
    'https://epoxy-garage-experts-of-northglenn.com',
    4.7,
    168,
    'epoxy-garage-experts-of-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Epoxy Garage Northglenn',
    '1747 Wynkoop St, Denver, CO 80233',
    '(303) 555-1003',
    'https://professional-epoxy-garage-northglenn.com',
    4.8,
    213,
    'professional-epoxy-garage-northglenn'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Epoxy Garage Company 3',
    '1430 Larimer St, Denver, CO 80233',
    '(303) 555-1004',
    'https://northglenn-epoxy-garage-company-3.com',
    4.6,
    265,
    'northglenn-epoxy-garage-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Epoxy Garage Company 4',
    '1144 15th St, Denver, CO 80233',
    '(303) 555-1005',
    'https://northglenn-epoxy-garage-company-4.com',
    4.7,
    324,
    'northglenn-epoxy-garage-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Epoxy Garage Company 5',
    '1001 16th Street Mall, Denver, CO 80233',
    '(303) 555-1006',
    'https://northglenn-epoxy-garage-company-5.com',
    4.9,
    272,
    'northglenn-epoxy-garage-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Epoxy Garage Company 6',
    '1437 Bannock St, Denver, CO 80233',
    '(303) 555-1007',
    'https://northglenn-epoxy-garage-company-6.com',
    4.6,
    308,
    'northglenn-epoxy-garage-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Epoxy Garage Company 7',
    '200 E Colfax Ave, Denver, CO 80233',
    '(303) 555-1008',
    'https://northglenn-epoxy-garage-company-7.com',
    4.8,
    222,
    'northglenn-epoxy-garage-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Epoxy Garage Company 8',
    '1701 Champa St, Denver, CO 80233',
    '(303) 555-1009',
    'https://northglenn-epoxy-garage-company-8.com',
    4.8,
    185,
    'northglenn-epoxy-garage-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Northglenn Epoxy Garage Company 9',
    '1801 California St, Denver, CO 80233',
    '(303) 555-1010',
    'https://northglenn-epoxy-garage-company-9.com',
    4.7,
    213,
    'northglenn-epoxy-garage-company-9'
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
    AND s.slug = 'northglenn'
ORDER BY c.contractor_name;
