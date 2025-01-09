-- Seed file for Arvada Landscapers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Landscapers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'landscapers'
),
-- Get the subregion_id for Arvada
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'arvada'
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
    'Arvada Landscapers',
    '1700 Broadway, Denver, CO 80002',
    '(303) 555-1001',
    'https://arvada-landscapers.com',
    4.7,
    260,
    'arvada-landscapers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Landscaping Experts of Arvada',
    '1601 Blake Street, Denver, CO 80002',
    '(303) 555-1002',
    'https://landscaping-experts-of-arvada.com',
    4.7,
    179,
    'landscaping-experts-of-arvada'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Landscaping Arvada',
    '1747 Wynkoop St, Denver, CO 80002',
    '(303) 555-1003',
    'https://professional-landscaping-arvada.com',
    4.6,
    248,
    'professional-landscaping-arvada'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Landscaping Company 3',
    '1430 Larimer St, Denver, CO 80002',
    '(303) 555-1004',
    'https://arvada-landscaping-company-3.com',
    4.8,
    269,
    'arvada-landscaping-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Landscaping Company 4',
    '1144 15th St, Denver, CO 80002',
    '(303) 555-1005',
    'https://arvada-landscaping-company-4.com',
    4.5,
    203,
    'arvada-landscaping-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Landscaping Company 5',
    '1001 16th Street Mall, Denver, CO 80002',
    '(303) 555-1006',
    'https://arvada-landscaping-company-5.com',
    4.5,
    320,
    'arvada-landscaping-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Landscaping Company 6',
    '1437 Bannock St, Denver, CO 80002',
    '(303) 555-1007',
    'https://arvada-landscaping-company-6.com',
    4.7,
    163,
    'arvada-landscaping-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Landscaping Company 7',
    '200 E Colfax Ave, Denver, CO 80002',
    '(303) 555-1008',
    'https://arvada-landscaping-company-7.com',
    4.7,
    308,
    'arvada-landscaping-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Landscaping Company 8',
    '1701 Champa St, Denver, CO 80002',
    '(303) 555-1009',
    'https://arvada-landscaping-company-8.com',
    4.8,
    174,
    'arvada-landscaping-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Landscaping Company 9',
    '1801 California St, Denver, CO 80002',
    '(303) 555-1010',
    'https://arvada-landscaping-company-9.com',
    4.9,
    155,
    'arvada-landscaping-company-9'
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
    AND s.slug = 'arvada'
ORDER BY c.contractor_name;
