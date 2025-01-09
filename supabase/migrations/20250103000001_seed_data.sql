-- Seed file for initial data (Created: January 3rd, 2025)
-- This file adds categories, subregions, and contractors

-- Insert categories
INSERT INTO categories (category_name, slug) VALUES
('Bathroom Remodelers', 'bathroom-remodelers'),
('Decks', 'decks'),
('Electricians', 'electricians'),
('Epoxy Garage', 'epoxy-garage'),
('Fencing', 'fencing'),
('Flooring', 'flooring'),
('Home Remodelers', 'home-remodelers'),
('HVAC', 'hvac'),
('Kitchen Remodelers', 'kitchen-remodelers'),
('Landscapers', 'landscapers'),
('Masonry', 'masonry'),
('Painters', 'painters'),
('Plumbers', 'plumbers'),
('Roofers', 'roofers'),
('Siding & Gutters', 'siding-gutters'),
('Windows', 'windows');

-- Insert subregions
INSERT INTO subregions (subregion_name, slug) VALUES
('Arvada', 'arvada'),
('Aurora', 'aurora'),
('Broomfield', 'broomfield'),
('Central Parks Area', 'central-parks-area'),
('Central Shopping Area', 'central-shopping-area'),
('Denver Tech Center', 'denver-tech-center'),
('Downtown Denver', 'downtown-denver'),
('East Colfax Area', 'east-colfax-area'),
('Lakewood', 'lakewood'),
('Littleton', 'littleton'),
('Northeast Area', 'northeast-area'),
('Northglenn', 'northglenn'),
('Park Hill Area', 'park-hill-area'),
('Thornton', 'thornton'),
('Westminster', 'westminster');

-- Insert Downtown Denver Plumbers
WITH plumbers AS (
    SELECT id FROM categories WHERE slug = 'plumbers'
),
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

-- Insert Downtown Denver Electricians
WITH electricians AS (
    SELECT id FROM categories WHERE slug = 'electricians'
),
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
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Downtown Denver Electric',
    '1700 17th Street, Denver, CO 80202',
    '(303) 555-2001',
    'https://downtowndenverelectric.com',
    4.8,
    312,
    'downtown-denver-electric'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'LoDo Electrical Services',
    '1601 Wazee St, Denver, CO 80202',
    '(303) 555-2002',
    'https://lodoelectrical.com',
    4.7,
    278,
    'lodo-electrical-services'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Union Station Electric Co',
    '1735 19th St, Denver, CO 80202',
    '(303) 555-2003',
    'https://unionstationelectric.com',
    4.9,
    189,
    'union-station-electric-co'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Mile High Electrical Solutions',
    '1401 17th St, Denver, CO 80202',
    '(303) 555-2004',
    'https://milehighelectrical.com',
    4.6,
    234,
    'mile-high-electrical-solutions'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Larimer Square Electric',
    '1430 Larimer St, Denver, CO 80202',
    '(303) 555-2005',
    'https://larimersquareelectric.com',
    4.7,
    167,
    'larimer-square-electric'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    '16th Street Electricians',
    '1001 16th Street Mall, Denver, CO 80202',
    '(303) 555-2006',
    'https://16thstreetelectric.com',
    4.8,
    245,
    '16th-street-electricians'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Denver Financial District Electric',
    '1144 15th St, Denver, CO 80202',
    '(303) 555-2007',
    'https://denverfinancialelectric.com',
    4.7,
    198,
    'denver-financial-district-electric'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Ballpark Electric Experts',
    '2001 Blake St, Denver, CO 80205',
    '(303) 555-2008',
    'https://ballparkelectric.com',
    4.8,
    276,
    'ballpark-electric-experts'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Capitol Hill Electric Services',
    '200 E Colfax Ave, Denver, CO 80203',
    '(303) 555-2009',
    'https://capitolhillelectric.com',
    4.6,
    289,
    'capitol-hill-electric-services'
),
(
    (SELECT id FROM electricians),
    (SELECT id FROM downtown),
    'Civic Center Electrical Co',
    '1437 Bannock St, Denver, CO 80202',
    '(303) 555-2010',
    'https://civiccenterelectric.com',
    4.7,
    223,
    'civic-center-electrical-co'
);
