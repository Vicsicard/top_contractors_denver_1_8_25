-- Seed file for Arvada Bathroom Remodelers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Bathroom Remodelers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'bathroom-remodelers'
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
    'Arvada Bathroom Remodelers',
    '1700 Broadway, Denver, CO 80002',
    '(303) 555-1001',
    'https://arvada-bathroom-remodelers.com',
    4.5,
    163,
    'arvada-bathroom-remodelers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Bathroom Remodeling Experts of Arvada',
    '1601 Blake Street, Denver, CO 80002',
    '(303) 555-1002',
    'https://bathroom-remodeling-experts-of-arvada.com',
    4.7,
    205,
    'bathroom-remodeling-experts-of-arvada'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Bathroom Remodeling Arvada',
    '1747 Wynkoop St, Denver, CO 80002',
    '(303) 555-1003',
    'https://professional-bathroom-remodeling-arvada.com',
    4.9,
    286,
    'professional-bathroom-remodeling-arvada'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Bathroom Remodeling Company 3',
    '1430 Larimer St, Denver, CO 80002',
    '(303) 555-1004',
    'https://arvada-bathroom-remodeling-company-3.com',
    4.8,
    312,
    'arvada-bathroom-remodeling-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Bathroom Remodeling Company 4',
    '1144 15th St, Denver, CO 80002',
    '(303) 555-1005',
    'https://arvada-bathroom-remodeling-company-4.com',
    4.7,
    151,
    'arvada-bathroom-remodeling-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Bathroom Remodeling Company 5',
    '1001 16th Street Mall, Denver, CO 80002',
    '(303) 555-1006',
    'https://arvada-bathroom-remodeling-company-5.com',
    4.7,
    183,
    'arvada-bathroom-remodeling-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Bathroom Remodeling Company 6',
    '1437 Bannock St, Denver, CO 80002',
    '(303) 555-1007',
    'https://arvada-bathroom-remodeling-company-6.com',
    4.5,
    191,
    'arvada-bathroom-remodeling-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Bathroom Remodeling Company 7',
    '200 E Colfax Ave, Denver, CO 80002',
    '(303) 555-1008',
    'https://arvada-bathroom-remodeling-company-7.com',
    4.7,
    317,
    'arvada-bathroom-remodeling-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Bathroom Remodeling Company 8',
    '1701 Champa St, Denver, CO 80002',
    '(303) 555-1009',
    'https://arvada-bathroom-remodeling-company-8.com',
    4.8,
    230,
    'arvada-bathroom-remodeling-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Arvada Bathroom Remodeling Company 9',
    '1801 California St, Denver, CO 80002',
    '(303) 555-1010',
    'https://arvada-bathroom-remodeling-company-9.com',
    4.7,
    210,
    'arvada-bathroom-remodeling-company-9'
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
    cat.slug = 'bathroom-remodelers' 
    AND s.slug = 'arvada'
ORDER BY c.contractor_name;
