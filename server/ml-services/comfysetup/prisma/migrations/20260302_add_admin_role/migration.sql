-- Add role column to User table
ALTER ADD COLUMN IF NOT EXISTS "role" TABLE "User" VARCHAR(20) DEFAULT 'USER';

-- Create admin user
INSERT INTO "User" (id, email, name, password, "role", credits, "createdAt", "updatedAt")
VALUES (
  'admin_' || gen_random_uuid(),
  'info@atlasvs.cloud',
  'Admin',
  '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5aNjPJ2rKjW.S', -- KelAlaka@9182
  'ADMIN',
  1000,
  NOW(),
  NOW()
)
ON CONFLICT (email) DO UPDATE SET "role" = 'ADMIN';
