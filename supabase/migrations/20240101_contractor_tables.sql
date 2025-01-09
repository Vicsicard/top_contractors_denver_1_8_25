-- Create junction tables for many-to-many relationships
CREATE TABLE IF NOT EXISTS contractor_categories (
    contractor_id TEXT REFERENCES contractors(id),
    category_id TEXT REFERENCES categories(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()),
    PRIMARY KEY (contractor_id, category_id)
);

CREATE TABLE IF NOT EXISTS contractor_neighborhoods (
    contractor_id TEXT REFERENCES contractors(id),
    neighborhood_id TEXT REFERENCES neighborhoods(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc'::text, NOW()),
    PRIMARY KEY (contractor_id, neighborhood_id)
);

-- Add indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_contractors_reviews_avg ON contractors(reviews_avg DESC);
CREATE INDEX IF NOT EXISTS idx_contractors_category ON contractor_categories(category_id);
CREATE INDEX IF NOT EXISTS idx_contractors_neighborhood ON contractor_neighborhoods(neighborhood_id);

-- Add full text search capabilities
ALTER TABLE contractors ADD COLUMN IF NOT EXISTS fts tsvector 
    GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(contractor_name, '')), 'A') ||
        setweight(to_tsvector('english', coalesce(address, '')), 'B')
    ) STORED;

CREATE INDEX IF NOT EXISTS contractors_fts_idx ON contractors USING GIN (fts);

-- Update the contractors table with additional fields if needed
ALTER TABLE contractors 
    ADD COLUMN IF NOT EXISTS business_hours JSONB,
    ADD COLUMN IF NOT EXISTS services TEXT[],
    ADD COLUMN IF NOT EXISTS emergency_service BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS years_in_business INTEGER;
