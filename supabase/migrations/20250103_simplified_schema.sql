-- Migration: Simplified Schema (January 3rd, 2025)
-- Description: Restructures database to use 15 fixed subregions with direct contractor relationships

-- Drop existing tables and dependencies
DROP TABLE IF EXISTS contractors CASCADE;
DROP TABLE IF EXISTS neighborhoods CASCADE;
DROP TABLE IF EXISTS subregions CASCADE;
DROP TABLE IF EXISTS regions CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create categories table
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create subregions table
CREATE TABLE subregions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    subregion_name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create contractors table
CREATE TABLE contractors (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    subregion_id UUID NOT NULL REFERENCES subregions(id) ON DELETE CASCADE,
    contractor_name VARCHAR(200) NOT NULL,
    address VARCHAR(500) NOT NULL,
    phone VARCHAR(20) NOT NULL CHECK (phone ~ '^\(\d{3}\) \d{3}-\d{4}$'),
    website VARCHAR(200),
    reviews_avg DECIMAL(2,1) CHECK (reviews_avg >= 1.0 AND reviews_avg <= 5.0),
    reviews_count INTEGER CHECK (reviews_count >= 0),
    slug VARCHAR(200) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX idx_categories_slug ON categories(slug);
CREATE INDEX idx_subregions_slug ON subregions(slug);
CREATE INDEX idx_contractors_category_id ON contractors(category_id);
CREATE INDEX idx_contractors_subregion_id ON contractors(subregion_id);
CREATE INDEX idx_contractors_slug ON contractors(slug);
CREATE INDEX idx_contractors_reviews_avg ON contractors(reviews_avg DESC);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Add updated_at triggers to all tables
CREATE TRIGGER update_categories_updated_at
    BEFORE UPDATE ON categories
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_subregions_updated_at
    BEFORE UPDATE ON subregions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contractors_updated_at
    BEFORE UPDATE ON contractors
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert the 16 trade categories
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

-- Insert the 15 subregions
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

-- Enable Row Level Security (RLS)
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE subregions ENABLE ROW LEVEL SECURITY;
ALTER TABLE contractors ENABLE ROW LEVEL SECURITY;

-- Create security policies
CREATE POLICY "Enable read access for all users" ON categories FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON subregions FOR SELECT USING (true);
CREATE POLICY "Enable read access for all users" ON contractors FOR SELECT USING (true);

-- Only authenticated users can insert/update/delete contractors
CREATE POLICY "Enable insert for authenticated users only" ON contractors 
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');
CREATE POLICY "Enable update for authenticated users only" ON contractors 
    FOR UPDATE USING (auth.role() = 'authenticated');
CREATE POLICY "Enable delete for authenticated users only" ON contractors 
    FOR DELETE USING (auth.role() = 'authenticated');

-- Create view for contractor statistics
CREATE OR REPLACE VIEW contractor_statistics AS
SELECT 
    s.subregion_name,
    COUNT(DISTINCT c.id) as total_contractors,
    COUNT(DISTINCT c.category_id) as unique_trades,
    AVG(c.reviews_avg) as average_rating,
    SUM(c.reviews_count) as total_reviews
FROM subregions s
LEFT JOIN contractors c ON s.id = c.subregion_id
GROUP BY s.id, s.subregion_name
ORDER BY s.subregion_name;

-- Create view for trade category statistics
CREATE OR REPLACE VIEW category_statistics AS
SELECT 
    cat.category_name,
    COUNT(DISTINCT c.id) as total_contractors,
    COUNT(DISTINCT c.subregion_id) as covered_subregions,
    AVG(c.reviews_avg) as average_rating,
    SUM(c.reviews_count) as total_reviews
FROM categories cat
LEFT JOIN contractors c ON cat.id = c.category_id
GROUP BY cat.id, cat.category_name
ORDER BY cat.category_name;
