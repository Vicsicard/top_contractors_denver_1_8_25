-- Template for generating seed files (Created: January 3rd, 2025)
-- Replace placeholders:
-- {TRADE} - The trade category (e.g., 'plumbers', 'electricians')
-- {SUBREGION} - The subregion slug (e.g., 'downtown-denver', 'central-parks-area')
-- {TRADE_DISPLAY} - Display name for trade (e.g., 'Plumbing', 'Electrical')
-- {SUBREGION_DISPLAY} - Display name for subregion (e.g., 'Downtown Denver', 'Central Parks Area')
-- {ZIP} - Local ZIP code for the subregion

-- Get the category_id for the trade
WITH trade_category AS (
    SELECT id FROM categories WHERE slug = '{TRADE}'
),
-- Get the subregion_id
target_subregion AS (
    SELECT id FROM subregions WHERE slug = '{SUBREGION}'
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
-- 1. Main {TRADE_DISPLAY} Company
(
    (SELECT id FROM trade_category),
    (SELECT id FROM target_subregion),
    '{SUBREGION_DISPLAY} {TRADE_DISPLAY}',
    '1234 Main Street, Denver, CO {ZIP}',
    '(303) 555-1001',
    'https://{subregion-slug}-{trade}.com',
    4.8,
    324,
    '{subregion-slug}-{trade}'
),
-- Add 9 more contractors following similar pattern

-- Verification query
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
    cat.slug = '{TRADE}' 
    AND s.slug = '{SUBREGION}'
ORDER BY c.contractor_name;

-- Common street names by subregion:
-- Downtown Denver: Broadway, Blake St, Wynkoop St, Larimer St, 16th St, 15th St, Bannock St, Colfax Ave
-- Central Parks Area: Central Park Blvd, Martin Luther King Blvd, Syracuse St, Uinta St
-- Aurora: Havana St, Peoria St, Alameda Ave, Mississippi Ave
-- [Add more as needed]

-- Phone number format: (303) 555-XXXX
-- Reviews range: 4.5 - 4.9
-- Review counts range: 145 - 324
-- Website format: https://businessname.com (lowercase, hyphenated)
-- Slug format: business-name-with-hyphens
