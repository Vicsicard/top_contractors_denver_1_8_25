-- Seed file for Downtown Denver Plumbers (Created: January 3rd, 2025)
-- This file adds 10 plumbers to the Downtown Denver subregion

-- Get the category_id for plumbers
WITH plumbers AS (
    SELECT id FROM categories WHERE slug = 'plumbers'
),
-- Get the subregion_id for downtown denver
downtown AS (
    SELECT id FROM subregions WHERE slug = 'downtown-denver'
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
-- 1. Mile High Plumbing Solutions
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Mile High Plumbing Solutions',
    '1700 Broadway, Denver, CO 80202',
    '(303) 555-1001',
    'https://milehighplumbing.com',
    4.8,
    324,
    'mile-high-plumbing-solutions'
),
-- 2. Downtown Denver Plumbers
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Downtown Denver Plumbers',
    '1601 Blake Street, Denver, CO 80202',
    '(303) 555-1002',
    'https://downtowndenverplumbers.com',
    4.7,
    289,
    'downtown-denver-plumbers'
),
-- 3. LoDo Plumbing Experts
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'LoDo Plumbing Experts',
    '1747 Wynkoop St, Denver, CO 80202',
    '(303) 555-1003',
    'https://lodoplumbing.com',
    4.9,
    156,
    'lodo-plumbing-experts'
),
-- 4. Union Station Plumbing
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Union Station Plumbing',
    '1701 Wynkoop St, Denver, CO 80202',
    '(303) 555-1004',
    'https://unionstationplumbing.com',
    4.6,
    198,
    'union-station-plumbing'
),
-- 5. 16th Street Plumbers
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    '16th Street Plumbers',
    '1001 16th Street Mall, Denver, CO 80202',
    '(303) 555-1005',
    'https://16thstreetplumbers.com',
    4.5,
    267,
    '16th-street-plumbers'
),
-- 6. Larimer Square Plumbing
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Larimer Square Plumbing',
    '1430 Larimer St, Denver, CO 80202',
    '(303) 555-1006',
    'https://larimerplumbing.com',
    4.7,
    178,
    'larimer-square-plumbing'
),
-- 7. Denver Financial District Plumbing
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Denver Financial District Plumbing',
    '1144 15th St, Denver, CO 80202',
    '(303) 555-1007',
    'https://denverfinancialplumbing.com',
    4.8,
    145,
    'denver-financial-district-plumbing'
),
-- 8. Ballpark Neighborhood Plumbers
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Ballpark Neighborhood Plumbers',
    '2001 Blake St, Denver, CO 80205',
    '(303) 555-1008',
    'https://ballparkplumbers.com',
    4.6,
    234,
    'ballpark-neighborhood-plumbers'
),
-- 9. Capitol Hill Plumbing Services
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Capitol Hill Plumbing Services',
    '200 E Colfax Ave, Denver, CO 80203',
    '(303) 555-1009',
    'https://capitolhillplumbing.com',
    4.7,
    312,
    'capitol-hill-plumbing-services'
),
-- 10. Civic Center Plumbing Co
(
    (SELECT id FROM plumbers),
    (SELECT id FROM downtown),
    'Civic Center Plumbing Co',
    '1437 Bannock St, Denver, CO 80202',
    '(303) 555-1010',
    'https://civicenterplumbing.com',
    4.8,
    189,
    'civic-center-plumbing-co'
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
    cat.slug = 'plumbers' 
    AND s.slug = 'downtown-denver'
ORDER BY c.contractor_name;
