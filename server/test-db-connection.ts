import { PrismaClient } from '@prisma/client';
import { config } from 'dotenv';

config({ path: '.env' });

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: process.env.DATABASE_URL_TR
    }
  }
});

async function testConnection() {
  try {
    console.log('Testing TR database connection...');
    console.log('Connection string:', process.env.DATABASE_URL_TR);
    
    await prisma.$connect();
    console.log('✅ Successfully connected to TR database!');
    
    const result = await prisma.$queryRaw`SELECT version()`;
    console.log('Database version:', result);
    
    await prisma.$disconnect();
    process.exit(0);
  } catch (error) {
    console.error('❌ Connection failed:', error);
    await prisma.$disconnect();
    process.exit(1);
  }
}

testConnection();
