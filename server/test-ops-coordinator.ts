import 'dotenv/config';
import { prisma } from './src/lib/prisma';
import { GeminiOpsNotificationCoordinator } from './src/services/ai/gemini-ops-coordinator';

async function testOpsCoordinator() {
  console.log("🚀 Testing Gemini Operations Coordinator...");
  
  // 1. Create/Retrieve mock organization
  let org = await prisma.organization.findFirst();
  if (!org) {
    org = await prisma.organization.create({
      data: {
        id: "tr_residence_org",
        name: "Test B2B Agency Org",
        slug: "test-b2b",
      }
    });
  }

  // 2. Create/Retrieve mock reservation
  let reservation = await prisma.reservation.findFirst();
  if (!reservation) {
    // We need contact and listing
    let contact = await prisma.contact.findFirst();
    if (!contact) {
      contact = await prisma.contact.create({
        data: {
          orgId: org.id,
          firstName: "John",
          lastName: "Doe",
          email: "john@example.com",
          phone: "+905551112233"
        }
      });
    }
    let listing = await prisma.listing.findFirst();
    if (!listing) {
       // listing needs properties etc. Let's find property first
       let property = await prisma.property.findFirst();
       if (!property) {
         property = await prisma.property.create({
           data: {
             orgId: org.id,
             name: "Luxury B2B Residence",
             lat: 41.0082,
             lng: 28.9784, // Istanbul
             address: "Fatih, Istanbul",
             city: "Istanbul",
             country: "Turkey"
           }
         });
       }
       listing = await prisma.listing.create({
         data: {
           orgId: org.id,
           propertyId: property.id,
           title: "Luxury B2B Penthouse Listing",
           status: "ACTIVE"
         }
       });
    }

    const prop = await prisma.property.findFirst();
    reservation = await prisma.reservation.create({
      data: {
        orgId: org.id,
        listingId: listing.id,
        contactId: contact.id,
        propertyId: prop?.id,
        checkInDate: new Date(),
        checkOutDate: new Date(Date.now() + 86400000 * 3),
        guestCount: 2,
        nightlyRate: 150.00,
        cleaningFee: 30.00,
        totalAmount: 480.00,
        currency: "USD",
        status: "CONFIRMED",
        paymentStatus: "PAID"
      }
    });
  }

  // 3. Test Task GPS mismatch
  console.log("\n--- Testing Task GPS Mismatch ---");
  const task = await prisma.task.create({
    data: {
      orgId: org.id,
      reservationId: reservation.id,
      propertyId: reservation.propertyId,
      type: "INSPECTION",
      status: "DONE",
      title: "Pre-Stay Physical Inspection",
      description: "Verify property cleanliness and keylock functions.",
      gpsLatitude: 40.9, // Offset from 41.0082 (mismatch!)
      gpsLongitude: 29.1,
      gpsVerified: false,
      photoLocationMatch: false
    }
  });

  const taskResult = await GeminiOpsNotificationCoordinator.trackTaskGPS(task.id, "US");
  console.log("GPS Audit Result:", JSON.stringify(taskResult, null, 2));

  // 4. Test KBS Failure Log
  console.log("\n--- Testing KBS Failure ---");
  const kbsLog = await prisma.kbsReportLog.create({
    data: {
      orgId: org.id,
      reservationId: reservation.id,
      guestName: "John Doe",
      documentNumber: "A12345678",
      status: "FAILED",
      responseCode: "503",
      errorMessage: "Kimlik doğrulama servisi yanıt vermiyor veya TC kimlik numarası bulunamadı."
    }
  });

  const kbsResult = await GeminiOpsNotificationCoordinator.trackKbsStatus(kbsLog.id, "US");
  console.log("KBS Audit Result:", JSON.stringify(kbsResult, null, 2));

  // 5. Test Escrow Payment holding
  console.log("\n--- Testing Escrow holding ---");
  const escrow = await prisma.escrowAccount.create({
    data: {
      orgId: org.id,
      reservationId: reservation.id,
      totalAmount: 480.00,
      depositAmount: 100.00,
      currency: "USD",
      status: "HOLDING",
      bankName: "TCMB Escrow Custody Hub",
      obBlockId: "block_consent_889922",
      obStatus: "LOCKED"
    }
  });

  const escrowResult = await GeminiOpsNotificationCoordinator.trackEscrowChange(escrow.id, "US");
  console.log("Escrow Audit Result:", JSON.stringify(escrowResult, null, 2));

  // 6. Test Host Penalty
  console.log("\n--- Testing Host Penalty ---");
  const penalty = await prisma.hostPenalty.create({
    data: {
      orgId: org.id,
      reservationId: reservation.id,
      penaltyAmount: 120.00,
      relocationCost: 80.00,
      currency: "USD",
      status: "PENDING",
      notes: "Denetimde ortaya çıkan eksiklikler nedeniyle acente relocation maliyeti kesintisi."
    }
  });

  const penaltyResult = await GeminiOpsNotificationCoordinator.trackHostPenalty(penalty.id, "US");
  console.log("Host Penalty Audit Result:", JSON.stringify(penaltyResult, null, 2));

  // Clean up test logs/tasks/etc. to avoid polluting database
  console.log("\n🧹 Cleaning up test records...");
  await prisma.hostPenalty.delete({ where: { id: penalty.id } });
  await prisma.escrowAccount.delete({ where: { id: escrow.id } });
  await prisma.kbsReportLog.delete({ where: { id: kbsLog.id } });
  await prisma.task.delete({ where: { id: task.id } });
  console.log("✨ Test finished successfully!");
}

testOpsCoordinator().catch(err => {
  console.error("❌ Test execution failed:", err);
  process.exit(1);
});
