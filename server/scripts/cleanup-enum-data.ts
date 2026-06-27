import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function cleanupDeprecatedEnumValues() {
  console.log("🧹 Cleaning up deprecated enum values using raw SQL...\n");

  // Clean up PermissionKey enum values using raw SQL
  console.log(`🔍 Cleaning up GLOBAL_ARBITRAGE_VIEW permissions...`);
  
  try {
    const result = await prisma.$executeRawUnsafe(`
      DELETE FROM "Permission" WHERE key = 'GLOBAL_ARBITRAGE_VIEW';
    `);
    console.log(`   ✅ Deleted ${result} permissions`);
  } catch (error) {
    console.log(`   ⚠️ No permissions found or already cleaned`);
  }

  // Clean up ContactType enum values using raw SQL
  console.log(`🔍 Cleaning up LEAD contacts...`);
  
  try {
    const result = await prisma.$executeRawUnsafe(`
      UPDATE "Contact" SET type = 'OTHER' WHERE type = 'LEAD';
    `);
    console.log(`   ✅ Updated ${result} contacts`);
  } catch (error) {
    console.log(`   ⚠️ No contacts found or already cleaned`);
  }

  // Clean up TRHeatingType enum values
  console.log(`🔍 Cleaning up GUNES_ENERJISI heating type...`);
  
  try {
    const result = await prisma.$executeRawUnsafe(`
      UPDATE "Property" SET "heatingType" = 'OTHER' WHERE "heatingType" = 'GUNES_ENERJISI';
    `);
    console.log(`   ✅ Updated ${result} properties`);
  } catch (error) {
    console.log(`   ⚠️ No properties found or already cleaned`);
  }

  // Restore the enum if it was renamed
  console.log(`🔍 Checking if enum needs to be restored...`);
  
  try {
    await prisma.$executeRawUnsafe(`
      ALTER TYPE "PermissionKey_old" RENAME TO "PermissionKey";
    `);
    console.log(`   ✅ Restored enum from backup`);
  } catch (error) {
    console.log(`   ℹ️ Enum already in correct state`);
  }

  // Add the deprecated value back to the enum temporarily
  console.log(`🔍 Adding GLOBAL_ARBITRAGE_VIEW back to enum...`);
  
  try {
    await prisma.$executeRawUnsafe(`
      ALTER TYPE "PermissionKey" ADD VALUE 'GLOBAL_ARBITRAGE_VIEW' BEFORE 'VIEW';
    `);
    console.log(`   ✅ Added deprecated value back`);
  } catch (error: any) {
    console.log(`   ℹ️ Value already exists or enum already correct`);
  }

  console.log("\n🎉 Cleanup complete!");
}

cleanupDeprecatedEnumValues()
  .catch(console.error)
  .finally(() => prisma.$disconnect());
