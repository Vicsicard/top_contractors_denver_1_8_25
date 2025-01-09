-- Create initial schema for contractor directory

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Categories table
CREATE TABLE IF NOT EXISTS categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Regions table
CREATE TABLE IF NOT EXISTS regions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    region_name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Subregions table
CREATE TABLE IF NOT EXISTS subregions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    region_id UUID NOT NULL REFERENCES regions(id),
    subregion_name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Neighborhoods table
CREATE TABLE IF NOT EXISTS neighborhoods (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    subregion_id UUID NOT NULL REFERENCES subregions(id),
    neighborhood_name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Contractors table
CREATE TABLE IF NOT EXISTS contractors (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id UUID NOT NULL REFERENCES categories(id),
    neighborhood_id UUID NOT NULL REFERENCES neighborhoods(id),
    contractor_name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL CHECK (phone ~ '^\(\d{3}\) \d{3}-\d{4}$'),
    website VARCHAR(255),
    reviews_avg DECIMAL(2,1) CHECK (reviews_avg >= 1.0 AND reviews_avg <= 5.0),
    reviews_count INTEGER CHECK (reviews_count >= 0),
    slug VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

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

CREATE TRIGGER update_regions_updated_at
    BEFORE UPDATE ON regions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_subregions_updated_at
    BEFORE UPDATE ON subregions
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_neighborhoods_updated_at
    BEFORE UPDATE ON neighborhoods
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_contractors_updated_at
    BEFORE UPDATE ON contractors
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert initial data

-- Categories
INSERT INTO categories (category_name, slug) VALUES
('Plumbers', 'plumbers'),
('Electricians', 'electricians'),
('HVAC', 'hvac'),
('Roofers', 'roofers'),
('Painters', 'painters');

-- Regions
INSERT INTO regions (region_name, slug) VALUES
('Central Denver', 'central-denver'),
('East Denver', 'east-denver'),
('Northwest Suburbs', 'northwest-suburbs'),
('Northeast Suburbs', 'northeast-suburbs'),
('Southeast Suburbs', 'southeast-suburbs');

-- Subregions for Central Denver
WITH central_denver AS (
    SELECT id FROM regions WHERE slug = 'central-denver'
)
INSERT INTO subregions (region_id, subregion_name, slug) VALUES
((SELECT id FROM central_denver), 'Downtown Area', 'downtown-area'),
((SELECT id FROM central_denver), 'Central Parks Area', 'central-parks-area'),
((SELECT id FROM central_denver), 'Central Shopping Area', 'central-shopping-area');

-- Neighborhoods for Central Denver subregions
WITH downtown_area AS (
    SELECT id FROM subregions WHERE slug = 'downtown-area'
),
central_parks AS (
    SELECT id FROM subregions WHERE slug = 'central-parks-area'
),
central_shopping AS (
    SELECT id FROM subregions WHERE slug = 'central-shopping-area'
)
INSERT INTO neighborhoods (subregion_id, neighborhood_name, slug, description) VALUES
((SELECT id FROM downtown_area), 'Downtown Denver', 'downtown-denver', 'The heart of Denver''s business and entertainment district'),
((SELECT id FROM central_parks), 'Central Parks Area', 'central-parks-area', 'Beautiful residential area with numerous parks and green spaces'),
((SELECT id FROM central_shopping), 'Central Shopping Area', 'central-shopping-area', 'Prime shopping and retail district with various amenities');
