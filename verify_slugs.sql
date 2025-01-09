-- Check all slugs in the database
SELECT 'categories' as table_name, slug, category_name as name FROM categories
UNION ALL
SELECT 'regions' as table_name, slug, region_name as name FROM regions
UNION ALL
SELECT 'subregions' as table_name, slug, subregion_name as name FROM subregions
UNION ALL
SELECT 'neighborhoods' as table_name, slug, neighborhood_name as name FROM neighborhoods
ORDER BY table_name, slug;
