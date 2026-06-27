-- Create Admin User for AtlasVS
-- Email: info@atlasvs.cloud
-- Password: PasswordLess/11
-- Run this with: psql -h localhost -U postgres -d dbone85 -f create_admin_user.sql

DO $$
DECLARE
    user_id TEXT;
BEGIN
    -- Generate a unique ID
    user_id := 'admin_' || extract(epoch from now())::text;
    
    INSERT INTO "User" (
        id, 
        email, 
        name, 
        password, 
        role, 
        credits,
        "createdAt",
        "updatedAt"
    )
    VALUES (
        user_id,
        'info@atlasvs.cloud',
        'AtlasVS Admin',
        '$2b$12$ClzI1nk.mKY3S9HoK0H8nujb8zDNp9lcm97s9y2H3d9mFmKF1oJT.',
        'ADMIN',
        10000,
        NOW(),
        NOW()
    )
    ON CONFLICT (email) 
    DO UPDATE SET 
        password = EXCLUDED.password,
        role = 'ADMIN',
        name = EXCLUDED.name,
        credits = 10000,
        "updatedAt" = NOW();
    
    RAISE NOTICE '✅ Admin user created/updated successfully!';
    RAISE NOTICE '📧 Email: info@atlasvs.cloud';
    RAISE NOTICE '🔑 Password: PasswordLess/11';
    RAISE NOTICE '🌐 Access: http://localhost:3000/en/admin';
END $$;