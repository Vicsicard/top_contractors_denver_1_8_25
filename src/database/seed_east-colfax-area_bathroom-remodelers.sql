-- Seed file for East Colfax Area Bathroom Remodelers
-- Generated: January 03, 2025
-- Based on SCHEMA_2025_01_03.md specification

-- Get the category_id for Bathroom Remodelers
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = 'bathroom-remodelers'
),
-- Get the subregion_id for East Colfax Area
target_subregion AS (
    SELECT id FROM subregions WHERE slug = 'east-colfax-area'
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
    'East Colfax Area Bathroom Remodelers',
    '1700 Broadway, Denver, CO 80220',
    '(303) 555-1001',
    'https://east-colfax-area-bathroom-remodelers.com',
    4.6,
    214,
    'east-colfax-area-bathroom-remodelers'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Bathroom Remodeling Experts of East Colfax Area',
    '1601 Blake Street, Denver, CO 80220',
    '(303) 555-1002',
    'https://bathroom-remodeling-experts-of-east-colfax-area.com',
    4.5,
    234,
    'bathroom-remodeling-experts-of-east-colfax-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'Professional Bathroom Remodeling East Colfax Area',
    '1747 Wynkoop St, Denver, CO 80220',
    '(303) 555-1003',
    'https://professional-bathroom-remodeling-east-colfax-area.com',
    4.8,
    246,
    'professional-bathroom-remodeling-east-colfax-area'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'East Colfax Area Bathroom Remodeling Company 3',
    '1430 Larimer St, Denver, CO 80220',
    '(303) 555-1004',
    'https://east-colfax-area-bathroom-remodeling-company-3.com',
    4.5,
    229,
    'east-colfax-area-bathroom-remodeling-company-3'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'East Colfax Area Bathroom Remodeling Company 4',
    '1144 15th St, Denver, CO 80220',
    '(303) 555-1005',
    'https://east-colfax-area-bathroom-remodeling-company-4.com',
    4.6,
    168,
    'east-colfax-area-bathroom-remodeling-company-4'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'East Colfax Area Bathroom Remodeling Company 5',
    '1001 16th Street Mall, Denver, CO 80220',
    '(303) 555-1006',
    'https://east-colfax-area-bathroom-remodeling-company-5.com',
    4.7,
    170,
    'east-colfax-area-bathroom-remodeling-company-5'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'East Colfax Area Bathroom Remodeling Company 6',
    '1437 Bannock St, Denver, CO 80220',
    '(303) 555-1007',
    'https://east-colfax-area-bathroom-remodeling-company-6.com',
    4.8,
    167,
    'east-colfax-area-bathroom-remodeling-company-6'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'East Colfax Area Bathroom Remodeling Company 7',
    '200 E Colfax Ave, Denver, CO 80220',
    '(303) 555-1008',
    'https://east-colfax-area-bathroom-remodeling-company-7.com',
    4.6,
    205,
    'east-colfax-area-bathroom-remodeling-company-7'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'East Colfax Area Bathroom Remodeling Company 8',
    '1701 Champa St, Denver, CO 80220',
    '(303) 555-1009',
    'https://east-colfax-area-bathroom-remodeling-company-8.com',
    4.8,
    232,
    'east-colfax-area-bathroom-remodeling-company-8'
),
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    'East Colfax Area Bathroom Remodeling Company 9',
    '1801 California St, Denver, CO 80220',
    '(303) 555-1010',
    'https://east-colfax-area-bathroom-remodeling-company-9.com',
    4.7,
    169,
    'east-colfax-area-bathroom-remodeling-company-9'
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
    AND s.slug = 'east-colfax-area'
ORDER BY c.contractor_name;
