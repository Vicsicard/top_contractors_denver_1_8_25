-- Combined Seed File for Denver Contractor Directory
-- Generated: January 3rd, 2025
-- This file combines all seed data in the correct order:
-- 1. Categories
-- 2. Subregions
-- 3. All contractor seed files

-- First, ensure we're in a transaction
BEGIN;

-- 1. Seed Categories
INSERT INTO categories (category_name, slug) VALUES
    ('Plumbers', 'plumbers'),
    ('Electricians', 'electricians'),
    ('HVAC', 'hvac'),
    ('Roofers', 'roofers'),
    ('Painters', 'painters'),
    ('Landscapers', 'landscapers'),
    ('Home Remodelers', 'home-remodelers'),
    ('Bathroom Remodelers', 'bathroom-remodelers'),
    ('Kitchen Remodelers', 'kitchen-remodelers'),
    ('Siding & Gutters', 'siding-gutters'),
    ('Masonry', 'masonry'),
    ('Decks', 'decks'),
    ('Flooring', 'flooring'),
    ('Windows', 'windows'),
    ('Fencing', 'fencing'),
    ('Epoxy Garage', 'epoxy-garage');

-- 2. Seed Subregions
INSERT INTO subregions (subregion_name, slug, zip_code) VALUES
    ('Arvada', 'arvada', '80002'),
    ('Aurora', 'aurora', '80012'),
    ('Broomfield', 'broomfield', '80020'),
    ('Central Parks Area', 'central-parks-area', '80238'),
    ('Central Shopping Area', 'central-shopping-area', '80206'),
    ('Denver Tech Center', 'denver-tech-center', '80237'),
    ('Downtown Denver', 'downtown-denver', '80202'),
    ('East Colfax Area', 'east-colfax-area', '80220'),
    ('Lakewood', 'lakewood', '80214'),
    ('Littleton', 'littleton', '80120'),
    ('Northeast Area', 'northeast-area', '80239'),
    ('Northglenn', 'northglenn', '80233'),
    ('Park Hill Area', 'park-hill-area', '80207'),
    ('Thornton', 'thornton', '80229'),
    ('Westminster', 'westminster', '80030');

-- 3. Now include all the generated seed files
-- Arvada
\i seed_arvada_plumbers.sql
\i seed_arvada_electricians.sql
\i seed_arvada_hvac.sql
\i seed_arvada_roofers.sql
\i seed_arvada_painters.sql
\i seed_arvada_landscapers.sql
\i seed_arvada_home-remodelers.sql
\i seed_arvada_bathroom-remodelers.sql
\i seed_arvada_kitchen-remodelers.sql
\i seed_arvada_siding-gutters.sql
\i seed_arvada_masonry.sql
\i seed_arvada_decks.sql
\i seed_arvada_flooring.sql
\i seed_arvada_windows.sql
\i seed_arvada_fencing.sql
\i seed_arvada_epoxy-garage.sql

-- Aurora
\i seed_aurora_plumbers.sql
\i seed_aurora_electricians.sql
\i seed_aurora_hvac.sql
\i seed_aurora_roofers.sql
\i seed_aurora_painters.sql
\i seed_aurora_landscapers.sql
\i seed_aurora_home-remodelers.sql
\i seed_aurora_bathroom-remodelers.sql
\i seed_aurora_kitchen-remodelers.sql
\i seed_aurora_siding-gutters.sql
\i seed_aurora_masonry.sql
\i seed_aurora_decks.sql
\i seed_aurora_flooring.sql
\i seed_aurora_windows.sql
\i seed_aurora_fencing.sql
\i seed_aurora_epoxy-garage.sql

-- Broomfield
\i seed_broomfield_plumbers.sql
\i seed_broomfield_electricians.sql
\i seed_broomfield_hvac.sql
\i seed_broomfield_roofers.sql
\i seed_broomfield_painters.sql
\i seed_broomfield_landscapers.sql
\i seed_broomfield_home-remodelers.sql
\i seed_broomfield_bathroom-remodelers.sql
\i seed_broomfield_kitchen-remodelers.sql
\i seed_broomfield_siding-gutters.sql
\i seed_broomfield_masonry.sql
\i seed_broomfield_decks.sql
\i seed_broomfield_flooring.sql
\i seed_broomfield_windows.sql
\i seed_broomfield_fencing.sql
\i seed_broomfield_epoxy-garage.sql

-- Central Parks Area
\i seed_central-parks-area_plumbers.sql
\i seed_central-parks-area_electricians.sql
\i seed_central-parks-area_hvac.sql
\i seed_central-parks-area_roofers.sql
\i seed_central-parks-area_painters.sql
\i seed_central-parks-area_landscapers.sql
\i seed_central-parks-area_home-remodelers.sql
\i seed_central-parks-area_bathroom-remodelers.sql
\i seed_central-parks-area_kitchen-remodelers.sql
\i seed_central-parks-area_siding-gutters.sql
\i seed_central-parks-area_masonry.sql
\i seed_central-parks-area_decks.sql
\i seed_central-parks-area_flooring.sql
\i seed_central-parks-area_windows.sql
\i seed_central-parks-area_fencing.sql
\i seed_central-parks-area_epoxy-garage.sql

-- Central Shopping Area
\i seed_central-shopping-area_plumbers.sql
\i seed_central-shopping-area_electricians.sql
\i seed_central-shopping-area_hvac.sql
\i seed_central-shopping-area_roofers.sql
\i seed_central-shopping-area_painters.sql
\i seed_central-shopping-area_landscapers.sql
\i seed_central-shopping-area_home-remodelers.sql
\i seed_central-shopping-area_bathroom-remodelers.sql
\i seed_central-shopping-area_kitchen-remodelers.sql
\i seed_central-shopping-area_siding-gutters.sql
\i seed_central-shopping-area_masonry.sql
\i seed_central-shopping-area_decks.sql
\i seed_central-shopping-area_flooring.sql
\i seed_central-shopping-area_windows.sql
\i seed_central-shopping-area_fencing.sql
\i seed_central-shopping-area_epoxy-garage.sql

-- Denver Tech Center
\i seed_denver-tech-center_plumbers.sql
\i seed_denver-tech-center_electricians.sql
\i seed_denver-tech-center_hvac.sql
\i seed_denver-tech-center_roofers.sql
\i seed_denver-tech-center_painters.sql
\i seed_denver-tech-center_landscapers.sql
\i seed_denver-tech-center_home-remodelers.sql
\i seed_denver-tech-center_bathroom-remodelers.sql
\i seed_denver-tech-center_kitchen-remodelers.sql
\i seed_denver-tech-center_siding-gutters.sql
\i seed_denver-tech-center_masonry.sql
\i seed_denver-tech-center_decks.sql
\i seed_denver-tech-center_flooring.sql
\i seed_denver-tech-center_windows.sql
\i seed_denver-tech-center_fencing.sql
\i seed_denver-tech-center_epoxy-garage.sql

-- Downtown Denver
\i seed_downtown-denver_plumbers.sql
\i seed_downtown-denver_electricians.sql
\i seed_downtown-denver_hvac.sql
\i seed_downtown-denver_roofers.sql
\i seed_downtown-denver_painters.sql
\i seed_downtown-denver_landscapers.sql
\i seed_downtown-denver_home-remodelers.sql
\i seed_downtown-denver_bathroom-remodelers.sql
\i seed_downtown-denver_kitchen-remodelers.sql
\i seed_downtown-denver_siding-gutters.sql
\i seed_downtown-denver_masonry.sql
\i seed_downtown-denver_decks.sql
\i seed_downtown-denver_flooring.sql
\i seed_downtown-denver_windows.sql
\i seed_downtown-denver_fencing.sql
\i seed_downtown-denver_epoxy-garage.sql

-- East Colfax Area
\i seed_east-colfax-area_plumbers.sql
\i seed_east-colfax-area_electricians.sql
\i seed_east-colfax-area_hvac.sql
\i seed_east-colfax-area_roofers.sql
\i seed_east-colfax-area_painters.sql
\i seed_east-colfax-area_landscapers.sql
\i seed_east-colfax-area_home-remodelers.sql
\i seed_east-colfax-area_bathroom-remodelers.sql
\i seed_east-colfax-area_kitchen-remodelers.sql
\i seed_east-colfax-area_siding-gutters.sql
\i seed_east-colfax-area_masonry.sql
\i seed_east-colfax-area_decks.sql
\i seed_east-colfax-area_flooring.sql
\i seed_east-colfax-area_windows.sql
\i seed_east-colfax-area_fencing.sql
\i seed_east-colfax-area_epoxy-garage.sql

-- Lakewood
\i seed_lakewood_plumbers.sql
\i seed_lakewood_electricians.sql
\i seed_lakewood_hvac.sql
\i seed_lakewood_roofers.sql
\i seed_lakewood_painters.sql
\i seed_lakewood_landscapers.sql
\i seed_lakewood_home-remodelers.sql
\i seed_lakewood_bathroom-remodelers.sql
\i seed_lakewood_kitchen-remodelers.sql
\i seed_lakewood_siding-gutters.sql
\i seed_lakewood_masonry.sql
\i seed_lakewood_decks.sql
\i seed_lakewood_flooring.sql
\i seed_lakewood_windows.sql
\i seed_lakewood_fencing.sql
\i seed_lakewood_epoxy-garage.sql

-- Littleton
\i seed_littleton_plumbers.sql
\i seed_littleton_electricians.sql
\i seed_littleton_hvac.sql
\i seed_littleton_roofers.sql
\i seed_littleton_painters.sql
\i seed_littleton_landscapers.sql
\i seed_littleton_home-remodelers.sql
\i seed_littleton_bathroom-remodelers.sql
\i seed_littleton_kitchen-remodelers.sql
\i seed_littleton_siding-gutters.sql
\i seed_littleton_masonry.sql
\i seed_littleton_decks.sql
\i seed_littleton_flooring.sql
\i seed_littleton_windows.sql
\i seed_littleton_fencing.sql
\i seed_littleton_epoxy-garage.sql

-- Northeast Area
\i seed_northeast-area_plumbers.sql
\i seed_northeast-area_electricians.sql
\i seed_northeast-area_hvac.sql
\i seed_northeast-area_roofers.sql
\i seed_northeast-area_painters.sql
\i seed_northeast-area_landscapers.sql
\i seed_northeast-area_home-remodelers.sql
\i seed_northeast-area_bathroom-remodelers.sql
\i seed_northeast-area_kitchen-remodelers.sql
\i seed_northeast-area_siding-gutters.sql
\i seed_northeast-area_masonry.sql
\i seed_northeast-area_decks.sql
\i seed_northeast-area_flooring.sql
\i seed_northeast-area_windows.sql
\i seed_northeast-area_fencing.sql
\i seed_northeast-area_epoxy-garage.sql

-- Northglenn
\i seed_northglenn_plumbers.sql
\i seed_northglenn_electricians.sql
\i seed_northglenn_hvac.sql
\i seed_northglenn_roofers.sql
\i seed_northglenn_painters.sql
\i seed_northglenn_landscapers.sql
\i seed_northglenn_home-remodelers.sql
\i seed_northglenn_bathroom-remodelers.sql
\i seed_northglenn_kitchen-remodelers.sql
\i seed_northglenn_siding-gutters.sql
\i seed_northglenn_masonry.sql
\i seed_northglenn_decks.sql
\i seed_northglenn_flooring.sql
\i seed_northglenn_windows.sql
\i seed_northglenn_fencing.sql
\i seed_northglenn_epoxy-garage.sql

-- Park Hill Area
\i seed_park-hill-area_plumbers.sql
\i seed_park-hill-area_electricians.sql
\i seed_park-hill-area_hvac.sql
\i seed_park-hill-area_roofers.sql
\i seed_park-hill-area_painters.sql
\i seed_park-hill-area_landscapers.sql
\i seed_park-hill-area_home-remodelers.sql
\i seed_park-hill-area_bathroom-remodelers.sql
\i seed_park-hill-area_kitchen-remodelers.sql
\i seed_park-hill-area_siding-gutters.sql
\i seed_park-hill-area_masonry.sql
\i seed_park-hill-area_decks.sql
\i seed_park-hill-area_flooring.sql
\i seed_park-hill-area_windows.sql
\i seed_park-hill-area_fencing.sql
\i seed_park-hill-area_epoxy-garage.sql

-- Thornton
\i seed_thornton_plumbers.sql
\i seed_thornton_electricians.sql
\i seed_thornton_hvac.sql
\i seed_thornton_roofers.sql
\i seed_thornton_painters.sql
\i seed_thornton_landscapers.sql
\i seed_thornton_home-remodelers.sql
\i seed_thornton_bathroom-remodelers.sql
\i seed_thornton_kitchen-remodelers.sql
\i seed_thornton_siding-gutters.sql
\i seed_thornton_masonry.sql
\i seed_thornton_decks.sql
\i seed_thornton_flooring.sql
\i seed_thornton_windows.sql
\i seed_thornton_fencing.sql
\i seed_thornton_epoxy-garage.sql

-- Westminster
\i seed_westminster_plumbers.sql
\i seed_westminster_electricians.sql
\i seed_westminster_hvac.sql
\i seed_westminster_roofers.sql
\i seed_westminster_painters.sql
\i seed_westminster_landscapers.sql
\i seed_westminster_home-remodelers.sql
\i seed_westminster_bathroom-remodelers.sql
\i seed_westminster_kitchen-remodelers.sql
\i seed_westminster_siding-gutters.sql
\i seed_westminster_masonry.sql
\i seed_westminster_decks.sql
\i seed_westminster_flooring.sql
\i seed_westminster_windows.sql
\i seed_westminster_fencing.sql
\i seed_westminster_epoxy-garage.sql

-- Verify the total counts
SELECT COUNT(*) as total_contractors FROM contractors;
SELECT subregion_name, COUNT(*) as contractor_count 
FROM contractors c 
JOIN subregions s ON c.subregion_id = s.id 
GROUP BY subregion_name 
ORDER BY subregion_name;
SELECT category_name, COUNT(*) as contractor_count 
FROM contractors c 
JOIN categories cat ON c.category_id = cat.id 
GROUP BY category_name 
ORDER BY category_name;

COMMIT;
