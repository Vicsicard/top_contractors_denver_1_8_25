-- Seed file for Thornton Landscapers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Landscapers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'landscapers'
),
-- Get the subregion_id for Thornton
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'thornton'
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
    'Thornton Landscapers',
    '1700 Broadway, Denver, CO 80229',
    '(303) 555-1001',
    'https://thornton-landscapers.com',
    4.8,
    319,
    'thornton-landscapers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Landscaping Experts of Thornton',
    '1601 Blake Street, Denver, CO 80229',
    '(303) 555-1002',
    'https://landscaping-experts-of-thornton.com',
    4.7,
    286,
    'landscaping-experts-of-thornton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Landscaping Thornton',
    '1747 Wynkoop St, Denver, CO 80229',
    '(303) 555-1003',
    'https://professional-landscaping-thornton.com',
    4.6,
    219,
    'professional-landscaping-thornton'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Landscaping Company 3',
    '1430 Larimer St, Denver, CO 80229',
    '(303) 555-1004',
    'https://thornton-landscaping-company-3.com',
    4.5,
    305,
    'thornton-landscaping-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Landscaping Company 4',
    '1144 15th St, Denver, CO 80229',
    '(303) 555-1005',
    'https://thornton-landscaping-company-4.com',
    4.8,
    181,
    'thornton-landscaping-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Landscaping Company 5',
    '1001 16th Street Mall, Denver, CO 80229',
    '(303) 555-1006',
    'https://thornton-landscaping-company-5.com',
    4.6,
    221,
    'thornton-landscaping-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Landscaping Company 6',
    '1437 Bannock St, Denver, CO 80229',
    '(303) 555-1007',
    'https://thornton-landscaping-company-6.com',
    4.9,
    156,
    'thornton-landscaping-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Landscaping Company 7',
    '200 E Colfax Ave, Denver, CO 80229',
    '(303) 555-1008',
    'https://thornton-landscaping-company-7.com',
    4.9,
    231,
    'thornton-landscaping-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Landscaping Company 8',
    '1701 Champa St, Denver, CO 80229',
    '(303) 555-1009',
    'https://thornton-landscaping-company-8.com',
    4.6,
    320,
    'thornton-landscaping-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Thornton Landscaping Company 9',
    '1801 California St, Denver, CO 80229',
    '(303) 555-1010',
    'https://thornton-landscaping-company-9.com',
    4.8,
    246,
    'thornton-landscaping-company-9'
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
    AND s.slug = 'thornton'
ORDER BY c.contractor_name;
