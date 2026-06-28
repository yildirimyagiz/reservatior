import "dotenv/config";
import { prismaManager } from "../src/lib/prisma";
import { AISocialParser } from "../src/services/ai/ai-social-parser";
import { SmartMatcher } from "../src/services/matchmaking/smart-matcher";
import { PropertyType, ListingStatus, ListingType, PropertyCategory } from "@prisma/client";

async function main() {
  const countryCode = "TR";
  const prisma = prismaManager.getClient(countryCode);
  const orgId = `org_whatsapp_${countryCode.toLowerCase()}`;

  console.log("🟢 1. Seeding Mock Properties for Testing Matchmaking...");
  
  // Seed matching organization
  await prisma.organization.upsert({
    where: { id: orgId },
    update: {},
    create: {
      id: orgId,
      name: "WhatsApp TR Scraped",
      type: "AGENCY",
      region: "TR",
      defaultCurrency: "TRY",
    }
  });

  // Create a scraped Agent/User
  const scrapedUser = await prisma.user.upsert({
    where: { email: "hasan.tas@reservatior.com" },
    update: {},
    create: {
      email: "hasan.tas@reservatior.com",
      name: "Hasan Taş",
      phone: "905329998877",
      locale: "tr-TR",
    }
  });

  // Property A: Vadi Teras (Matching)
  await prisma.property.upsert({
    where: { id: "wa_test_vadi_teras" },
    update: {
      listingStatus: ListingStatus.AVAILABLE,
      listingType: ListingType.RENT,
      bedrooms: 4,
      listingPrice: 85000,
      createdBy: scrapedUser.id,
    },
    create: {
      id: "wa_test_vadi_teras",
      orgId: orgId,
      name: "Vadi Teras A Blok 4+1 Kiralık Daire",
      type: PropertyType.APARTMENT,
      propertyCategory: PropertyCategory.RESIDENTIAL,
      listingType: ListingType.RENT,
      listingStatus: ListingStatus.AVAILABLE,
      region: "TR",
      currency: "TRY",
      addressLine1: "Vadi Teras, Cendere Vadisi",
      city: "İstanbul",
      country: "TR",
      bedrooms: 4,
      listingPrice: 85000,
      notes: "Expat aileler için son derece uygun, lüks eşyalı havuz manzaralı daire.",
      createdBy: scrapedUser.id,
    }
  });

  // Property B: Vadi Park (Matching)
  await prisma.property.upsert({
    where: { id: "wa_test_vadi_park" },
    update: {
      listingStatus: ListingStatus.AVAILABLE,
      listingType: ListingType.RENT,
      bedrooms: 4,
      listingPrice: 95000,
      createdBy: scrapedUser.id,
    },
    create: {
      id: "wa_test_vadi_park",
      orgId: orgId,
      name: "Vadi Park Konutları 4+1 Lüks Daire",
      type: PropertyType.APARTMENT,
      propertyCategory: PropertyCategory.RESIDENTIAL,
      listingType: ListingType.RENT,
      listingStatus: ListingStatus.AVAILABLE,
      region: "TR",
      currency: "TRY",
      addressLine1: "Vadi Park, Ayazağa",
      city: "İstanbul",
      country: "TR",
      bedrooms: 4,
      listingPrice: 95000,
      notes: "Vadi Park projesinin en geniş kiralık dairelerinden biri.",
      createdBy: scrapedUser.id,
    }
  });

  // Property C: Vadi Park 2+1 (Not matching bedrooms)
  await prisma.property.upsert({
    where: { id: "wa_test_vadi_park_2" },
    update: {
      listingStatus: ListingStatus.AVAILABLE,
      listingType: ListingType.RENT,
      bedrooms: 2,
      listingPrice: 50000,
    },
    create: {
      id: "wa_test_vadi_park_2",
      orgId: orgId,
      name: "Vadi Park Konutları 2+1 Kiralık Daire",
      type: PropertyType.APARTMENT,
      propertyCategory: PropertyCategory.RESIDENTIAL,
      listingType: ListingType.RENT,
      listingStatus: ListingStatus.AVAILABLE,
      region: "TR",
      currency: "TRY",
      addressLine1: "Vadi Park, Ayazağa",
      city: "İstanbul",
      country: "TR",
      bedrooms: 2,
      listingPrice: 50000,
      notes: "Genç çiftler için ideal 2+1 kiralık daire.",
    }
  });

  // Property D: Anthill 4+1 (Not matching project)
  await prisma.property.upsert({
    where: { id: "wa_test_anthill_4_1" },
    update: {
      listingStatus: ListingStatus.AVAILABLE,
      listingType: ListingType.RENT,
      bedrooms: 4,
      listingPrice: 120000,
    },
    create: {
      id: "wa_test_anthill_4_1",
      orgId: orgId,
      name: "Anthill Residence 4+1 Kiralık Lüks Daire",
      type: PropertyType.APARTMENT,
      propertyCategory: PropertyCategory.RESIDENTIAL,
      listingType: ListingType.RENT,
      listingStatus: ListingStatus.AVAILABLE,
      region: "TR",
      currency: "TRY",
      addressLine1: "Anthill A Blok, Bomonti",
      city: "İstanbul",
      country: "TR",
      bedrooms: 4,
      listingPrice: 120000,
      notes: "Eşsiz boğaz manzaralı Anthill A Blok kiralık daire.",
    }
  });

  console.log("✅ Seed finished.");

  // Create Inbound Message record first to simulate it being recorded
  const inboundMessageId = "msg_wa_test_demand_123";
  const userMessage = "Merhaba herkese. Vadi Teras ve Vadi Park projelerinde 4 + 1 kiralık arayışım mevcut. Yabancı Expat bir müşteri için arıyoruz. Portföyünde olan dönüş sağlayabilirse memnun olurum.";
  const senderPhone = "+905321112233";

  // Create mock social inbound message
  // First check if socialAccount exists
  let socialAccount = await prisma.socialAccount.findFirst();
  if (!socialAccount) {
    socialAccount = await prisma.socialAccount.create({
      data: {
        id: "sa_whatsapp_tr",
        orgId: orgId,
        platform: "WHATSAPP",
        accountId: "sa_whatsapp_tr_account",
        accessToken: "sa_whatsapp_tr_token",
        accountName: "WhatsApp TR Group Listener",
      }
    });
  }

  await prisma.socialInboundMessage.upsert({
    where: { id: inboundMessageId },
    update: {
      messageText: userMessage,
      status: "PENDING",
      isLeadConverted: false,
    },
    create: {
      id: inboundMessageId,
      orgId: orgId,
      socialAccountId: socialAccount.id,
      externalMessageId: inboundMessageId,
      externalSenderId: senderPhone,
      senderName: "Yağız Yıldırım",
      channel: "WHATSAPP",
      messageText: userMessage,
      receivedAt: new Date(),
    }
  });

  console.log(`\n💬 2. Simulating Incoming Message: "${userMessage}"`);
  
  // Parse
  console.log("🧠 3. Analyzing message with Gemini AI (AISocialParser)...");
  const parsed = await AISocialParser.parseMessage(userMessage);
  console.log("📊 Extraction Results:\n", JSON.stringify(parsed, null, 2));

  // Match
  console.log("\n⚡ 4. Processing and Matching Inbound Demand (SmartMatcher)...");
  const matchResult = await SmartMatcher.processParsedMessage(senderPhone, parsed, inboundMessageId);
  console.log("\n🏁 Matcher Result Status:", matchResult);

  if (matchResult.success && matchResult.matches) {
    console.log("\n🎯 Matching properties found IDs:", matchResult.matches);
    
    // Retrieve lead
    const lead = await prisma.lead.findUnique({
      where: { id: matchResult.leadId }
    });
    console.log("\n📋 Saved Lead details in DB:\n", JSON.stringify(lead, null, 2));
  }
}

main()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
