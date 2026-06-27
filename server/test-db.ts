import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient({
  datasourceUrl: "postgresql://postgres:1928@localhost:5432/realestate_tr"
})

async function main() {
  const result = await prisma.$queryRaw`SELECT 1;`
  console.log('Database connection successful:', result)
}

main()
  .catch((e) => {
    console.error('Database connection failed:', e)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
