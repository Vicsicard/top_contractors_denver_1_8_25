-- Test Queries for Simplified Schema (January 3rd, 2025)

-- 1. Verify categories were inserted
SELECT category_name, slug 
FROM categories 
ORDER BY category_name;

-- 2. Verify subregions were inserted
SELECT subregion_name, slug 
FROM subregions 
ORDER BY subregion_name;

-- 3. Check contractor_statistics view (should be empty but structured)
SELECT * FROM contractor_statistics;

-- 4. Check category_statistics view (should be empty but structured)
SELECT * FROM category_statistics;

-- 5. Test contractor insertion with constraints
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
) 
SELECT 
    (SELECT id FROM categories WHERE slug = 'plumbers'),
    (SELECT id FROM subregions WHERE slug = 'downtown-denver'),
    'Test Plumbing Co.',
    '123 Main St, Denver, CO 80202',
    '(303) 555-1234',
    'https://testplumbing.com',
    4.5,
    100,
    'test-plumbing-co';

-- 6. Verify contractor insertion and relationships
SELECT 
    c.contractor_name,
    cat.category_name,
    s.subregion_name,
    c.phone,
    c.reviews_avg
FROM contractors c
JOIN categories cat ON c.category_id = cat.id
JOIN subregions s ON c.subregion_id = s.id;

-- 7. Test phone number constraint
-- Should fail with constraint violation
INSERT INTO contractors (
    category_id,
    subregion_id,
    contractor_name,
    address,
    phone,  -- Invalid format
    website,
    reviews_avg,
    reviews_count,
    slug
) 
SELECT 
    (SELECT id FROM categories WHERE slug = 'plumbers'),
    (SELECT id FROM subregions WHERE slug = 'downtown-denver'),
    'Bad Phone Plumbing',
    '123 Main St, Denver, CO 80202',
    '555-1234',  -- Wrong format
    'https://badphone.com',
    4.5,
    100,
    'bad-phone-plumbing';

-- 8. Test reviews_avg constraint
-- Should fail with constraint violation
INSERT INTO contractors (
    category_id,
    subregion_id,
    contractor_name,
    address,
    phone,
    website,
    reviews_avg,  -- Invalid rating
    reviews_count,
    slug
) 
SELECT 
    (SELECT id FROM categories WHERE slug = 'plumbers'),
    (SELECT id FROM subregions WHERE slug = 'downtown-denver'),
    'Bad Rating Plumbing',
    '123 Main St, Denver, CO 80202',
    '(303) 555-1234',
    'https://badrating.com',
    6.0,  -- Rating too high
    100,
    'bad-rating-plumbing';

-- 9. Verify statistics views after insertion
SELECT * FROM contractor_statistics 
WHERE total_contractors > 0;

SELECT * FROM category_statistics 
WHERE total_contractors > 0;

-- 10. Clean up test data
DELETE FROM contractors 
WHERE contractor_name = 'Test Plumbing Co.';
