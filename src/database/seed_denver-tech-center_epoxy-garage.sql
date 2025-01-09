-- Seed file for Denver Tech Center Epoxy Garage
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Epoxy Garage
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'epoxy-garage'
),
-- Get the subregion_id for Denver Tech Center
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'denver-tech-center'
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
    'Denver Tech Center Epoxy Garage',
    '1700 Broadway, Denver, CO 80237',
    '(303) 555-1001',
    'https://denver-tech-center-epoxy-garage.com',
    4.5,
    229,
    'denver-tech-center-epoxy-garage'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Epoxy Garage Experts of Denver Tech Center',
    '1601 Blake Street, Denver, CO 80237',
    '(303) 555-1002',
    'https://epoxy-garage-experts-of-denver-tech-center.com',
    4.7,
    320,
    'epoxy-garage-experts-of-denver-tech-center'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Epoxy Garage Denver Tech Center',
    '1747 Wynkoop St, Denver, CO 80237',
    '(303) 555-1003',
    'https://professional-epoxy-garage-denver-tech-center.com',
    4.7,
    215,
    'professional-epoxy-garage-denver-tech-center'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Denver Tech Center Epoxy Garage Company 3',
    '1430 Larimer St, Denver, CO 80237',
    '(303) 555-1004',
    'https://denver-tech-center-epoxy-garage-company-3.com',
    4.5,
    268,
    'denver-tech-center-epoxy-garage-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Denver Tech Center Epoxy Garage Company 4',
    '1144 15th St, Denver, CO 80237',
    '(303) 555-1005',
    'https://denver-tech-center-epoxy-garage-company-4.com',
    4.6,
    169,
    'denver-tech-center-epoxy-garage-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Denver Tech Center Epoxy Garage Company 5',
    '1001 16th Street Mall, Denver, CO 80237',
    '(303) 555-1006',
    'https://denver-tech-center-epoxy-garage-company-5.com',
    4.8,
    276,
    'denver-tech-center-epoxy-garage-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Denver Tech Center Epoxy Garage Company 6',
    '1437 Bannock St, Denver, CO 80237',
    '(303) 555-1007',
    'https://denver-tech-center-epoxy-garage-company-6.com',
    4.6,
    300,
    'denver-tech-center-epoxy-garage-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Denver Tech Center Epoxy Garage Company 7',
    '200 E Colfax Ave, Denver, CO 80237',
    '(303) 555-1008',
    'https://denver-tech-center-epoxy-garage-company-7.com',
    4.7,
    297,
    'denver-tech-center-epoxy-garage-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Denver Tech Center Epoxy Garage Company 8',
    '1701 Champa St, Denver, CO 80237',
    '(303) 555-1009',
    'https://denver-tech-center-epoxy-garage-company-8.com',
    4.7,
    148,
    'denver-tech-center-epoxy-garage-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Denver Tech Center Epoxy Garage Company 9',
    '1801 California St, Denver, CO 80237',
    '(303) 555-1010',
    'https://denver-tech-center-epoxy-garage-company-9.com',
    4.8,
    166,
    'denver-tech-center-epoxy-garage-company-9'
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
    AND s.slug = 'denver-tech-center'
ORDER BY c.contractor_name;
