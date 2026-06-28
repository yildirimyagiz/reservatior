import { prismaManager } from "../../lib/prisma";
import { SocialParsedResult } from "../ai/ai-social-parser";

export class RealtorAcquisitionEngine {
  /**
   * Scans scraped listings and historical lead postings to find non-registered agents
   * who have matching properties or are active in the target projects/neighborhoods.
   * Generates highly-targeted invite messages dispatching the lead to them.
   */
  static async findAndInviteScrapedAgents(
    parsedResult: SocialParsedResult,
    leadId: string,
    countryCode: string = "TR"
  ) {
    console.log(`🚀 [RealtorAcquisitionEngine] Starting Agent Matching & Acquisition for Lead ID: ${leadId}`);
    
    const prisma = prismaManager.getClient(countryCode);
    const orgId = `org_whatsapp_${countryCode.toLowerCase()}`;

    const projects = parsedResult.extractedData.projects || [];
    const bedrooms = parsedResult.extractedData.bedrooms || null;
    const txType = parsedResult.extractedData.transactionType || "RENT";
    const location = parsedResult.extractedData.location || "";

    if (projects.length === 0 && !location) {
      console.log(`[RealtorAcquisitionEngine] No projects or location specified. Skipping agent search.`);
      return [];
    }

    // 1. Query properties in placeholder/scraped organizations
    // These represent properties scraped from WhatsApp where the owner hasn't signed up yet.
    const searchConditions: any = {
      orgId: orgId, // Only target scraped listings organization
      listingType: txType as any,
    };

    if (bedrooms) {
      searchConditions.bedrooms = bedrooms;
    }

    if (projects.length > 0) {
      searchConditions.OR = projects.flatMap(p => [
        { name: { contains: p, mode: "insensitive" as const } },
        { notes: { contains: p, mode: "insensitive" as const } }
      ]);
    } else {
      searchConditions.OR = [
        { city: { contains: location, mode: "insensitive" as const } },
        { addressLine1: { contains: location, mode: "insensitive" as const } }
      ];
    }

    const matchedScrapedProperties = await prisma.property.findMany({
      where: searchConditions,
      select: {
        id: true,
        name: true,
        city: true,
        bedrooms: true,
        notes: true,
        createdBy: true, // Links to mock User generated during import
      },
      take: 10
    });

    console.log(`[RealtorAcquisitionEngine] Found ${matchedScrapedProperties.length} scraped properties matching criteria.`);

    const dispatches: any[] = [];

    // 2. Loop through matched properties and resolve the owner User/Contact info
    for (const prop of matchedScrapedProperties) {
      if (!prop.createdBy) continue;

      const user = await prisma.user.findUnique({
        where: { id: prop.createdBy }
      });

      if (!user || !user.phone) continue;

      // Check if this user has already registered or is still a WhatsApp scraped lead
      // (scraped users have email domain @reservatior.com)
      const isScrapedUser = user.email.endsWith("@reservatior.com");
      if (!isScrapedUser) {
        // Registered users are handled by direct dispatch in SmartMatcher
        continue;
      }

      // Generate personalized transactional lead hook message
      const agentName = user.name || "Değerli Meslektaşımız";
      const projectMatched = projects.find(p => prop.name.toLowerCase().includes(p.toLowerCase())) || projects[0] || prop.city;
      
      const inviteLink = `https://app.reservatior.com/invite/vip-tr?leadId=${leadId}&propertyId=${prop.id}`;
      const inviteMessage = `Değerli Meslektaşımız ${agentName}, 👋

WhatsApp gruplarında paylaştığınız *${prop.name}* ilanınız ile az önce platformumuza düşen hazır bir expat müşteri talebini eşleştirdik!

🎯 *Müşteri Arayışı:*
• Proje/Bölge: ${projectMatched}
• Oda Sayısı: ${bedrooms || 'Belirtilmemiş'}+1
• İşlem Tipi: ${txType === 'RENT' ? 'Kiralık' : 'Satılık'}
• Müşteri Durumu: Hazır Expat Müşteri (Taksitli Depozito & 0 Depozito Güvencesi)

Bu hazır müşteriyi portföyünüze yönlendirmek ve işlemi platformumuz üzerinden tamamlayıp hak ettiğiniz komisyonu güvenceye almak için hemen erken erişim hesabınızı aktifleştirin:
🔗 ${inviteLink}

Birlikte büyümek ve kazanmak dileğiyle. 🚀
*Reservatior Türkiye*`;

      // Log dispatch task into database as a Realtor Acquisition Lead
      try {
        const dispatchLead = await prisma.lead.create({
          data: {
            orgId: orgId,
            firstName: agentName,
            lastName: "(Acquisition Candidate)",
            phone: user.phone,
            status: "CONTACTED",
            sourceDetail: `Match Hook Invite (Buyer Lead ID: ${leadId})`,
            notes: JSON.stringify({
              inviteMessage,
              originalBuyerLeadId: leadId,
              matchedPropertyId: prop.id,
              scrapedAgentUserId: user.id,
              projectMatched,
            })
          }
        });

        console.log(`[RealtorAcquisitionEngine] Created Acquisition Lead ID: ${dispatchLead.id} for agent ${user.phone}`);
        
        dispatches.push({
          phone: user.phone,
          message: inviteMessage,
          leadId: dispatchLead.id,
        });

        // In a production system, here we would trigger the SMS/WhatsApp API:
        // await WhatsAppClient.sendMessage(user.phone, inviteMessage);
      } catch (dispatchErr: any) {
        console.error("❌ Failed to log lead dispatch:", dispatchErr.message);
      }
    }

    return dispatches;
  }
}
