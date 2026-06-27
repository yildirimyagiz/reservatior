import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function checkData() {
  try {
    console.log("🔍 Checking USA properties in database...");
    const propertyCount = await prisma.property.count({
      where: { region: "USA" }
    });
    console.log(`📊 USA properties found: ${propertyCount}`);

    const properties = await prisma.property.findMany({
      where: { region: "USA" },
      take: 5,
      select: {
        id: true,
        name: true,
        addressLine1: true,
        city: true,
        state: true,
        assessedValue: true,
        propertyTax: true
      }
    });

    console.log("\n📋 Sample USA Properties in DB:");
    properties.forEach((p) => {
      console.log(`- [${p.id}] ${p.name} | ${p.addressLine1}, ${p.city}, ${p.state} | Value: $${p.assessedValue?.toLocaleString()} | Tax: $${p.propertyTax?.toLocaleString()}`);
    });

    // Check tax records count
    if ((prisma as any).uSPublicTaxRecord) {
      const taxRecordCount = await (prisma as any).uSPublicTaxRecord.count();
      console.log(`\n📊 USPublicTaxRecord count: ${taxRecordCount}`);
    } else {
      console.log("\n⚠️ USPublicTaxRecord model not found on current prisma client.");
    }

    // Check assessment count
    if ((prisma as any).uSPropertyAssessment) {
      const assessmentCount = await (prisma as any).uSPropertyAssessment.count();
      console.log(`📊 USPropertyAssessment count: ${assessmentCount}`);
    } else {
      console.log("⚠️ USPropertyAssessment model not found on current prisma client.");
    }

  } catch (error: any) {
    console.error("❌ Error querying database:", error.message);
  } finally {
    await prisma.$disconnect();
  }
}

checkData();
