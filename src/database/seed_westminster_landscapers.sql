-- Seed file for Westminster Landscapers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Landscapers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'landscapers'
),
-- Get the subregion_id for Westminster
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'westminster'
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
    'Westminster Landscapers',
    '1700 Broadway, Denver, CO 80030',
    '(303) 555-1001',
    'https://westminster-landscapers.com',
    4.7,
    159,
    'westminster-landscapers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Landscaping Experts of Westminster',
    '1601 Blake Street, Denver, CO 80030',
    '(303) 555-1002',
    'https://landscaping-experts-of-westminster.com',
    4.6,
    182,
    'landscaping-experts-of-westminster'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Landscaping Westminster',
    '1747 Wynkoop St, Denver, CO 80030',
    '(303) 555-1003',
    'https://professional-landscaping-westminster.com',
    4.8,
    255,
    'professional-landscaping-westminster'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Landscaping Company 3',
    '1430 Larimer St, Denver, CO 80030',
    '(303) 555-1004',
    'https://westminster-landscaping-company-3.com',
    4.7,
    227,
    'westminster-landscaping-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Landscaping Company 4',
    '1144 15th St, Denver, CO 80030',
    '(303) 555-1005',
    'https://westminster-landscaping-company-4.com',
    4.8,
    213,
    'westminster-landscaping-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Landscaping Company 5',
    '1001 16th Street Mall, Denver, CO 80030',
    '(303) 555-1006',
    'https://westminster-landscaping-company-5.com',
    4.5,
    277,
    'westminster-landscaping-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Landscaping Company 6',
    '1437 Bannock St, Denver, CO 80030',
    '(303) 555-1007',
    'https://westminster-landscaping-company-6.com',
    4.9,
    177,
    'westminster-landscaping-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Landscaping Company 7',
    '200 E Colfax Ave, Denver, CO 80030',
    '(303) 555-1008',
    'https://westminster-landscaping-company-7.com',
    4.6,
    213,
    'westminster-landscaping-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Landscaping Company 8',
    '1701 Champa St, Denver, CO 80030',
    '(303) 555-1009',
    'https://westminster-landscaping-company-8.com',
    4.8,
    268,
    'westminster-landscaping-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Westminster Landscaping Company 9',
    '1801 California St, Denver, CO 80030',
    '(303) 555-1010',
    'https://westminster-landscaping-company-9.com',
    4.8,
    231,
    'westminster-landscaping-company-9'
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
    cat.slug = 'landscapers' 
    AND s.slug = 'westminster'
ORDER BY c.contractor_name;
