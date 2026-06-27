import { PrismaClient } from '@prisma/client';

const trDatabaseUrl = process.env.DATABASE_URL_TR || 'postgresql://postgres:1928@localhost:5432/realestate_tr';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: trDatabaseUrl,
    },
  },
});

async function migrateTurkishSchema() {
  try {
    console.log('Analyzing Turkish database schema structure...');
    await prisma.$connect();
    
    // Check if PropertyPhoto table exists and has correct structure
    const tableExists = await prisma.$queryRaw`
      SELECT EXISTS (
        SELECT FROM information_schema.tables 
        WHERE table_name = 'PropertyPhoto'
      );
    `;
    console.log('PropertyPhoto table exists:', tableExists);
    
    // Check current PropertyPhoto structure
    const columns = await prisma.$queryRaw`
      SELECT column_name, data_type, is_nullable
      FROM information_schema.columns 
      WHERE table_name = 'PropertyPhoto' 
      ORDER BY ordinal_position
    `;
    console.log('Current PropertyPhoto structure:', columns);
    
    // Check if foreign key constraint exists
    const constraints = await prisma.$queryRaw`
      SELECT
        tc.constraint_name,
        tc.constraint_type,
        kcu.column_name,
        ccu.table_name AS foreign_table_name,
        ccu.column_name AS foreign_column_name
      FROM information_schema.table_constraints AS tc
      JOIN information_schema.key_column_usage AS kcu
        ON tc.constraint_name = kcu.constraint_name
        AND tc.table_schema = kcu.table_schema
      LEFT JOIN information_schema.constraint_column_usage AS ccu
        ON ccu.constraint_name = tc.constraint_name
        AND ccu.table_schema = tc.table_schema
      WHERE tc.table_name = 'PropertyPhoto'
        AND tc.constraint_type = 'FOREIGN KEY';
    `;
    console.log('PropertyPhoto foreign key constraints:', constraints);
    
    console.log('Schema analysis complete. Manual migration may be required.');
  } catch (error) {
    console.error('Error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

migrateTurkishSchema();
