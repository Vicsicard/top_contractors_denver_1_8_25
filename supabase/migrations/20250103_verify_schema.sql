-- Verify categories were inserted correctly
SELECT category_name, slug 
FROM categories 
ORDER BY category_name;

-- Verify subregions were inserted correctly
SELECT subregion_name, slug 
FROM subregions 
ORDER BY subregion_name;

-- Verify successful contractor insertion
SELECT 
    c.contractor_name,
    cat.category_name,
    s.subregion_name,
    c.phone,
    c.reviews_avg
FROM contractors c
JOIN categories cat ON c.category_id = cat.id
JOIN subregions s ON c.subregion_id = s.id
WHERE c.contractor_name = 'Test Plumbing Co.';

-- View current statistics
SELECT * FROM contractor_statistics 
WHERE total_contractors > 0;

-- Verify constraints are active
SELECT
    conname as constraint_name,
    contype as constraint_type,
    pg_get_constraintdef(oid) as constraint_definition
FROM pg_constraint
WHERE conrelid = 'contractors'::regclass
ORDER BY conname;
