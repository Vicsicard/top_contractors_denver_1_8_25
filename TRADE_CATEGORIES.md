# Trade Categories SQL Editor

Use this SQL to update the trade categories in the database. Copy and paste these commands into your Supabase SQL editor.

```sql
-- First, let's view the current categories
SELECT * FROM categories ORDER BY category_name;

-- To update existing categories, use UPDATE statements like:
UPDATE categories
SET category_name = 'New Name'
WHERE id = 'category-id';

-- To add new categories, use INSERT statements like:
INSERT INTO categories (category_name, slug)
VALUES 
('Category Name', 'category-slug');

-- To delete categories, use DELETE statements like:
DELETE FROM categories
WHERE category_name = 'Category to Delete';

-- Example of a complete update:
BEGIN;

-- Clear existing categories (if needed)
-- TRUNCATE categories CASCADE;

-- Insert all categories
INSERT INTO categories (category_name, slug)
VALUES 
('Bathroom Remodelers', 'bathroom-remodelers'),
('Carpenters', 'carpenters'),
('Concrete Contractors', 'concrete-contractors'),
('Decks', 'decks'),
('Door Contractors', 'door-contractors'),
('Drywall Contractors', 'drywall-contractors'),
('Electricians', 'electricians'),
('Epoxy Garage', 'epoxy-garage'),
('Fence Contractors', 'fence-contractors'),
('Fencing', 'fencing'),
('Flooring', 'flooring'),
('Flooring Contractors', 'flooring-contractors'),
('General Contractors', 'general-contractors'),
('Home Remodelers', 'home-remodelers'),
('HVAC', 'hvac'),
('HVAC Contractors', 'hvac-contractors'),
('Kitchen Remodelers', 'kitchen-remodelers'),
('Landscapers', 'landscapers'),
('Masonry', 'masonry'),
('Painters', 'painters'),
('Plumbers', 'plumbers'),
('Roofers', 'roofers'),
('Siding & Gutters', 'siding-gutters'),
('Window Contractors', 'window-contractors'),
('Windows', 'windows')
ON CONFLICT (slug) 
DO UPDATE SET 
  category_name = EXCLUDED.category_name,
  updated_at = CURRENT_TIMESTAMP;

COMMIT;
```

## Notes
1. The `slug` field is used in URLs and should be URL-friendly (lowercase, no spaces, etc.)
2. The `ON CONFLICT` clause ensures we don't create duplicates if the category already exists
3. Make sure to review the categories before running any DELETE or TRUNCATE commands
4. The categories are ordered alphabetically for easy reference

## Current Categories in Database
Based on the build output, these are the categories currently in your database:
```
1. Bathroom Remodelers
2. Carpenters
3. Concrete Contractors
4. Decks
5. Door Contractors
6. Drywall Contractors
7. Electricians
8. Epoxy Garage
9. Fence Contractors
10. Fencing
11. Flooring
12. Flooring Contractors
13. General Contractors
14. Home Remodelers
15. HVAC
16. HVAC Contractors
17. Kitchen Remodelers
18. Landscapers
19. Masonry
20. Painters
21. Plumbers
22. Roofers
23. Siding & Gutters
24. Window Contractors
25. Windows
```

Please review these categories and let me know if you'd like to make any changes. You can:
1. Add new categories
2. Remove existing categories
3. Rename categories
4. Reorder categories (though they'll typically be displayed alphabetically)
