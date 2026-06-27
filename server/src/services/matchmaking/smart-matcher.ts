import { prisma } from "../../lib/prisma";
import { SocialParsedResult } from "../ai/ai-social-parser";

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
      return; // Ignore noise
    }

    if (parsedResult.intent === "STATUS_UPDATE") {
      // If it's a status update, we find the existing property/lead and update it.
      // Example: Mark as SOLD or CANCELED
      console.log(`[SmartMatcher] Archiving/Updating status for entity based on message: ${parsedResult.summary}`);
      // In a real scenario, we would search by the sender and location/price to find the exact Property
      // await prisma.property.update({ ... status: parsedResult.extractedData.statusUpdateType })
      return;
    }

    if (parsedResult.intent === "DEMAND") {
      // A user is looking for a property
      console.log(`[SmartMatcher] New DEMAND from ${senderPhoneOrId}: ${parsedResult.summary}`);
      
      // 1. Save Demand (Lead)
      // await prisma.lead.create({ ... })

      // 2. Search for existing SUPPLY (Properties)
      const budget = parsedResult.extractedData.budget;
      const city = parsedResult.extractedData.location;

      const matches = await prisma.property.findMany({
        where: {
          // If city is mentioned, filter by city loosely
          ...(city ? { city: { contains: city, mode: "insensitive" } } : {}),
          // Further filtering would go here based on bedrooms, budget, etc.
        },
        take: 3
      });

      if (matches.length > 0) {
        // Send a private message with the match
        await this.sendPrivateMatchMessage(senderPhoneOrId, matches, parsedResult);
      }
    }

    if (parsedResult.intent === "SUPPLY") {
      // A user is offering a property
      console.log(`[SmartMatcher] New SUPPLY from ${senderPhoneOrId}: ${parsedResult.summary}`);
      
      // 1. Save Supply (Property)
      // await prisma.property.create({ ... })

      // 2. Search for existing DEMAND (Leads)
      // In a real app, we would search Leads where budget >= property price and location matches
      
      // 3. Send private message to the Leads that match this supply
      // ...
    }

    // Finally, archive the conversation message so we have a record
    // This assumes the rawMessage has already been saved to SocialInboundMessage
    // We update the intent and status.
    try {
      await prisma.socialInboundMessage.updateMany({
        where: { id: rawMessageId },
        data: {
          intent: parsedResult.intent,
          status: "RESOLVED" // Mark as archived/resolved
        }
      });
    } catch (e) {
      console.warn("Could not archive message, might not exist yet:", e);
    }
  }

  private static async sendPrivateMatchMessage(userId: string, matches: any[], parsedResult: SocialParsedResult) {
    // This function will integrate with your WhatsApp/Telegram sender to send a Direct Message
    console.log(`[SmartMatcher] Sending PRIVATE match message to ${userId}...`);
    
    let messageText = `Merhaba! "${parsedResult.summary}" talebinize uygun harika ilanlar bulduk:\n\n`;
    
    matches.forEach((match, index) => {
      // Create a direct link to the Reservatior website for traffic direction
      const link = `https://reservatior.com/listing/${match.id}`;
      messageText += `${index + 1}. ${match.name} - ${match.city} \nDetaylar: ${link}\n\n`;
    });

    messageText += `İlanlarla ilgilenirseniz hemen rezervasyon yapabilirsiniz!`;

    // 1. Here you would call your WhatsApp bot API or Telegram bot API to send the DM
    // e.g. await WhatsAppClient.sendMessage(userId, messageText);
    
    console.log(`[SmartMatcher] Private Message Sent:\n${messageText}`);
  }
}
