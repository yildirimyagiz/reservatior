import { prismaManager } from "../../lib/prisma";
import { SocialParsedResult } from "../ai/ai-social-parser";
import { RealtorAcquisitionEngine } from "./realtor-acquisition";

// Detect region from phone number prefix
function getRegionFromPhone(phone: string): string {
  const clean = phone.replace(/\D/g, "");
  if (clean.startsWith("971")) return "AE";
  return "TR";
}

export class SmartMatcher {
  /**
   * Processes an incoming parsed message and attempts to find a match.
   * Archiving and private messaging logic is integrated here.
   */
  static async processParsedMessage(
    senderPhoneOrId: string,
    parsedResult: SocialParsedResult,
    rawMessageId: string
  ) {
    if (parsedResult.intent === "NOISE") {
      console.log(`[SmartMatcher] Message parsed as NOISE, ignoring.`);
      return { success: false, reason: "Noise" };
    }

    const countryCode = getRegionFromPhone(senderPhoneOrId);
    const prisma = prismaManager.getClient(countryCode);
    const orgId = `org_whatsapp_${countryCode.toLowerCase()}`;

    if (parsedResult.intent === "STATUS_UPDATE") {
      console.log(`[SmartMatcher] Archiving/Updating status for entity based on message: ${parsedResult.summary}`);
      
      // Try to find the raw message and archive it
      try {
        await prisma.socialInboundMessage.updateMany({
          where: { id: rawMessageId },
          data: {
            intent: parsedResult.intent,
            status: "IGNORED" as any
          }
        });
      } catch (e) {
        // Safe to ignore if not exists
      }
      return { success: true, action: "status_update" };
    }

    if (parsedResult.intent === "DEMAND") {
      console.log(`[SmartMatcher] New DEMAND from ${senderPhoneOrId}: ${parsedResult.summary}`);
      
      // 1. Clean and save the demand as a Lead
      const budget = parsedResult.extractedData.budget ? parsedResult.extractedData.budget : null;
      const bedrooms = parsedResult.extractedData.bedrooms || null;
      const txType = parsedResult.extractedData.transactionType || "RENT";
      const location = parsedResult.extractedData.location || "";
      const projects = parsedResult.extractedData.projects || [];

      let lead = null;
      try {
        lead = await prisma.lead.create({
          data: {
            orgId: orgId,
            phone: senderPhoneOrId,
            notes: JSON.stringify({
              aiParsed: true,
              summary: parsedResult.summary,
              projects: projects,
              bedrooms: bedrooms,
              transactionType: txType,
              location: location,
              originalMessageId: rawMessageId,
            }),
            budget: budget,
            timeline: "WhatsApp Inbound Demand",
            firstName: "WhatsApp Group",
            lastName: "User",
          }
        });
        console.log(`[SmartMatcher] Saved demand as Lead ID: ${lead.id}`);
      } catch (leadErr: any) {
        console.error("❌ Error saving lead:", leadErr.message);
      }

      // 2. Query properties matching the demand criteria
      const searchConditions: any = {
        listingStatus: "AVAILABLE",
        listingType: txType as any,
      };

      if (bedrooms) {
        searchConditions.bedrooms = bedrooms;
      }

      // Project matching query structure
      if (projects.length > 0) {
        searchConditions.OR = projects.flatMap(p => [
          { name: { contains: p, mode: "insensitive" as const } },
          { notes: { contains: p, mode: "insensitive" as const } },
          { addressLine1: { contains: p, mode: "insensitive" as const } }
        ]);
      } else if (location) {
        searchConditions.OR = [
          { city: { contains: location, mode: "insensitive" as const } },
          { addressLine1: { contains: location, mode: "insensitive" as const } },
          { notes: { contains: location, mode: "insensitive" as const } }
        ];
      }

      const matches = await prisma.property.findMany({
        where: searchConditions,
        take: 5
      });

      console.log(`[SmartMatcher] Found ${matches.length} matching properties in the ${countryCode} database.`);

      if (matches.length > 0) {
        // Send a private match message
        await this.sendPrivateMatchMessage(senderPhoneOrId, matches, parsedResult);
      }

      // 3. Realtor Acquisition matching & dispatch
      if (lead) {
        await RealtorAcquisitionEngine.findAndInviteScrapedAgents(parsedResult, lead.id, countryCode);
      }

      // 3. Archive the message
      try {
        await prisma.socialInboundMessage.updateMany({
          where: { id: rawMessageId },
          data: {
            intent: parsedResult.intent,
            status: "LEAD_CREATED" as any,
            leadId: lead?.id,
          }
        });
      } catch (e) {
        // Ignore archive issue
      }

      return { success: true, matches: matches.map(m => m.id), leadId: lead?.id };
    }

    if (parsedResult.intent === "SUPPLY") {
      console.log(`[SmartMatcher] New SUPPLY from ${senderPhoneOrId}: ${parsedResult.summary}`);
      // In a supply flow, we would register the property and query matching leads (demands)
      return { success: true, action: "supply" };
    }

    return { success: false, reason: "Unhandled intent" };
  }

  private static async sendPrivateMatchMessage(userId: string, matches: any[], parsedResult: SocialParsedResult) {
    console.log(`[SmartMatcher] Sending PRIVATE match message to ${userId}...`);
    
    let messageText = `Merhaba! WhatsApp grubunda paylaştığınız "${parsedResult.summary}" talebinize uygun olarak veri tabanımızda eşleşen ilanlar bulduk:\n\n`;
    
    matches.forEach((match, index) => {
      const priceStr = match.listingPrice ? `${match.listingPrice.toLocaleString()} ${match.currency}` : "Fiyat Sorunuz";
      const link = `http://localhost:3001/property/${match.id}`; // Local dashboard link
      messageText += `🔹 ${index + 1}. *${match.name}*\n📍 Konum: ${match.addressLine1 || match.city}\n💰 Fiyat: ${priceStr}\n🛏️ Oda Sayısı: ${match.bedrooms || 'Belirtilmemiş'}\n🔗 Detaylar: ${link}\n\n`;
    });

    messageText += `İlginizi çeken bir portföy olursa doğrudan bu hat üzerinden veya platformumuzdan rezervasyon talebi başlatabilirsiniz!`;
    
    console.log("=========================================");
    console.log(`📡 [OUTBOUND WHATSAPP MESSAGE TO ${userId}]:`);
    console.log(messageText);
    console.log("=========================================");
  }
}
