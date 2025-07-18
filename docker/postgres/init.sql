-- PostgreSQL initialization script for Tiation Rigger
-- Creates database schema and initial data for development

-- Create development database
CREATE DATABASE tiation_rigger_dev;

-- Connect to the database
\c tiation_rigger_dev;

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create schemas
CREATE SCHEMA IF NOT EXISTS rigger;
CREATE SCHEMA IF NOT EXISTS jobs;
CREATE SCHEMA IF NOT EXISTS metrics;
CREATE SCHEMA IF NOT EXISTS auth;

-- Create users table
CREATE TABLE IF NOT EXISTS auth.users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'user',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT true,
    email_verified BOOLEAN DEFAULT false
);

-- Create riggers table
CREATE TABLE IF NOT EXISTS rigger.riggers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    license_number VARCHAR(50) UNIQUE,
    certification_level VARCHAR(50) NOT NULL,
    experience_years INTEGER DEFAULT 0,
    specializations TEXT[],
    location_lat DECIMAL(10,8),
    location_lng DECIMAL(11,8),
    availability_status VARCHAR(20) DEFAULT 'available',
    hourly_rate DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create jobs table
CREATE TABLE IF NOT EXISTS jobs.job_posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employer_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    requirements TEXT[],
    location_address TEXT NOT NULL,
    location_lat DECIMAL(10,8),
    location_lng DECIMAL(11,8),
    start_date DATE NOT NULL,
    end_date DATE,
    hourly_rate DECIMAL(10,2),
    total_budget DECIMAL(12,2),
    status VARCHAR(20) DEFAULT 'open',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create job applications table
CREATE TABLE IF NOT EXISTS jobs.applications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    job_id UUID REFERENCES jobs.job_posts(id) ON DELETE CASCADE,
    rigger_id UUID REFERENCES rigger.riggers(id) ON DELETE CASCADE,
    cover_letter TEXT,
    proposed_rate DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'pending',
    applied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create metrics table
CREATE TABLE IF NOT EXISTS metrics.system_metrics (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    metric_name VARCHAR(100) NOT NULL,
    metric_value DECIMAL(15,4),
    metric_type VARCHAR(50) NOT NULL,
    recorded_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    tags JSONB DEFAULT '{}'
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_users_email ON auth.users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON auth.users(role);
CREATE INDEX IF NOT EXISTS idx_riggers_user_id ON rigger.riggers(user_id);
CREATE INDEX IF NOT EXISTS idx_riggers_availability ON rigger.riggers(availability_status);
CREATE INDEX IF NOT EXISTS idx_jobs_employer_id ON jobs.job_posts(employer_id);
CREATE INDEX IF NOT EXISTS idx_jobs_status ON jobs.job_posts(status);
CREATE INDEX IF NOT EXISTS idx_jobs_location ON jobs.job_posts(location_lat, location_lng);
CREATE INDEX IF NOT EXISTS idx_applications_job_id ON jobs.applications(job_id);
CREATE INDEX IF NOT EXISTS idx_applications_rigger_id ON jobs.applications(rigger_id);
CREATE INDEX IF NOT EXISTS idx_applications_status ON jobs.applications(status);
CREATE INDEX IF NOT EXISTS idx_metrics_name ON metrics.system_metrics(metric_name);
CREATE INDEX IF NOT EXISTS idx_metrics_recorded_at ON metrics.system_metrics(recorded_at);

-- Insert sample data for development
INSERT INTO auth.users (email, password_hash, first_name, last_name, role) VALUES
    ('admin@tiation.com', crypt('admin123', gen_salt('bf')), 'Admin', 'User', 'admin'),
    ('rigger1@example.com', crypt('rigger123', gen_salt('bf')), 'John', 'Rigger', 'rigger'),
    ('employer1@example.com', crypt('employer123', gen_salt('bf')), 'Jane', 'Employer', 'employer');

-- Insert sample rigger data
INSERT INTO rigger.riggers (user_id, license_number, certification_level, experience_years, specializations, hourly_rate)
SELECT 
    u.id,
    'RIG-' || substr(u.id::text, 1, 8),
    'Senior',
    5,
    ARRAY['Tower Crane', 'Mobile Crane', 'Safety'],
    85.00
FROM auth.users u WHERE u.email = 'rigger1@example.com';

-- Insert sample job post
INSERT INTO jobs.job_posts (employer_id, title, description, requirements, location_address, hourly_rate, total_budget)
SELECT 
    u.id,
    'Senior Rigger - Downtown Construction',
    'We need an experienced rigger for a 6-month construction project in downtown. Tower crane experience required.',
    ARRAY['5+ years experience', 'Tower crane certification', 'Safety certification'],
    '123 Main St, Downtown, City',
    80.00,
    25000.00
FROM auth.users u WHERE u.email = 'employer1@example.com';

-- Create triggers for updating timestamps
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON auth.users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_riggers_updated_at BEFORE UPDATE ON rigger.riggers FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_jobs_updated_at BEFORE UPDATE ON jobs.job_posts FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_applications_updated_at BEFORE UPDATE ON jobs.applications FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Grant permissions
GRANT USAGE ON SCHEMA rigger TO tiation_user;
GRANT USAGE ON SCHEMA jobs TO tiation_user;
GRANT USAGE ON SCHEMA metrics TO tiation_user;
GRANT USAGE ON SCHEMA auth TO tiation_user;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA rigger TO tiation_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA jobs TO tiation_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA metrics TO tiation_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA auth TO tiation_user;

-- Success message
SELECT 'Database initialized successfully for Tiation Rigger development environment' AS message;
