import { PrismaClient, RentalServicePlanStatus, RentalPayerType } from "@prisma/client";

/**
 * Migration: legacy active leases → RentalServicePlan + Escrow + TenantProfile.
 *
 * Idempotent: skips leases that already have a rentalServicePlan, so it can be
 * re-run safely. Run with `bun run scripts/migrate-rental-plans.ts`.
 */
const prisma = new PrismaClient();

async function main() {
  console.log("Starting migration of active leases to RentalServicePlans...");

  const leases = await prisma.lease.findMany({
    where: { status: "ACTIVE", isActive: true, rentalServicePlan: null },
    include: { listing: true },
  });

  console.log(`Found ${leases.length} active leases without a RentalServicePlan`);

  let created = 0;
  let skipped = 0;

  for (const lease of leases) {
    try {
      const propertyId = lease.listing?.propertyId;
      const orgId = lease.orgId;
      if (!orgId) {
        skipped++;
        console.log(`  skip lease ${lease.id}: no orgId`);
        continue;
      }

      const result = await prisma.$transaction(async (tx) => {
        // 1. RentalServicePlan (scope LEASE)
        const plan = await tx.rentalServicePlan.create({
          data: {
            scope: "LEASE",
            orgId,
            leaseId: lease.id,
            tenantId: lease.tenantId,
            propertyId,
            currency: lease.currency,
            status: RentalServicePlanStatus.ACTIVE,
            effectiveFrom: lease.startDate,
            effectiveTo: lease.endDate,
            metadata: { migratedFrom: "lease", migrationVersion: 1 },
          },
        });

        // 2. Escrow account
        await tx.rentalEscrowAccount.create({
          data: {
            orgId,
            rentalPlanId: plan.id,
            balance: 0,
            heldAmount: 0,
            currency: lease.currency,
            status: "OPEN",
            releaseDate: new Date(Date.now() + 3 * 24 * 3600 * 1000),
          },
        });

        // 3. TenantFinancialProfile if missing
        const existingProfile = await tx.tenantFinancialProfile.findUnique({
          where: { tenantId: lease.tenantId },
        });
        if (!existingProfile) {
          await tx.tenantFinancialProfile.create({
            data: {
              tenantId: lease.tenantId,
              orgId,
              reliabilityScore: 50,
              riskLevel: "MEDIUM",
              lastCalculatedAt: new Date(),
            },
          });
        }

        // 4. Seed scheduled payments for the lease term
        const monthlyRent = Number(lease.rent);
        const cursor = new Date(lease.startDate);
        const end = new Date(lease.endDate);
        let monthIndex = 0;
        while (cursor <= end && monthIndex < 120) {
          const scheduledDate = new Date(cursor);
          scheduledDate.setDate(Math.min(scheduledDate.getDate(), 28));
          await tx.rentalPayment.create({
            data: {
              orgId,
              rentalPlanId: plan.id,
              payerType: RentalPayerType.TENANT,
              amount: monthlyRent,
              feeAmount: Math.round(monthlyRent * 0.035 * 100) / 100,
              protectionAmount: Math.round(monthlyRent * 0.02 * 100) / 100,
              feeRate: 0.035,
              currency: lease.currency,
              status: "SCHEDULED",
              scheduledDate,
              idempotencyKey: `migrated_${lease.id}_${monthIndex}_${scheduledDate.toISOString().slice(0, 10)}`,
            },
          });
          cursor.setMonth(cursor.getMonth() + 1);
          monthIndex++;
        }

        return plan;
      });

      console.log(`  ✔ plan created for lease ${lease.id} → ${result.id}`);
      created++;
    } catch (err) {
      skipped++;
      console.error(`  ✖ failed for lease ${lease.id}:`, (err as Error).message);
    }
  }

  console.log(`\nMigration complete. Created: ${created}, Skipped/Failed: ${skipped}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
