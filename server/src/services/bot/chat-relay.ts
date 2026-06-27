import { prismaManager } from '../../lib/prisma';
import { AIChatRole, AIChatModuleType } from '@prisma/client';
import { AIGateway } from '../ai/ai-gateway';
import { v4 as uuidv4 } from 'uuid';

export class ChatRelay {
  
  /**
   * Initializes a proxy session between a buyer and a seller for a specific listing.
   */
  static async startSession(buyerId: string, listingId: string, regionCode: string = 'TR'): Promise<string> {
    const db = prismaManager.getClient(regionCode);
    
    // Check if an active session already exists for this buyer and listing
    let session = await db.aIChatbotSession.findFirst({
      where: {
        contactId: buyerId,
        listingId: listingId,
        status: 'ACTIVE'
      }
    });

    if (!session) {
      session = await db.aIChatbotSession.create({
        data: {
          sessionId: uuidv4(),
          contactId: buyerId,
          listingId: listingId,
          status: 'ACTIVE',
          startedAt: new Date(),
          lastActivityAt: new Date(),
        }
      });
    }

    return session.sessionId;
  }

  /**
   * Routes a message from the Buyer to the Seller.
   * In a real implementation, this would trigger WhatsApp/Telegram API to send the message to the seller's phone.
   */
  static async relayMessageFromBuyer(sessionId: string, content: string, regionCode: string = 'TR'): Promise<{ success: boolean; sellerMessage: string }> {
    const db = prismaManager.getClient(regionCode);
    
    await db.aIChatMessage.create({
      data: {
        sessionId: sessionId,
        role: AIChatRole.USER,
        content: content,
        moduleType: AIChatModuleType.SALES_ASSISTANT
      }
    });

    await db.aIChatbotSession.update({
      where: { sessionId },
      data: { lastActivityAt: new Date() }
    });

    // TODO: Send to Seller via WhatsApp/Telegram API
    // const sellerPhone = property.owner.phone;
    // await sendWhatsAppMessage(sellerPhone, `Yeni Müşteri Mesajı:\n\n${content}\n\n[Yanıtlamak için alıntılayın]`);

    // Perform AI analysis in the background
    this.analyzeConversation(sessionId, regionCode).catch(err => console.error("AI Analysis Error:", err));

    return { 
      success: true, 
      sellerMessage: `Sistem: Mesajınız satıcıya güvenli kanalımız üzerinden iletildi.` 
    };
  }

  /**
   * Routes a message from the Seller back to the Buyer.
   */
  static async relayMessageFromSeller(sessionId: string, content: string, regionCode: string = 'TR'): Promise<{ success: boolean }> {
    const db = prismaManager.getClient(regionCode);
    
    await db.aIChatMessage.create({
      data: {
        sessionId: sessionId,
        role: AIChatRole.ASSISTANT, // Treating Seller as Assistant to the Buyer
        content: content,
        moduleType: AIChatModuleType.SALES_ASSISTANT
      }
    });

    await db.aIChatbotSession.update({
      where: { sessionId },
      data: { lastActivityAt: new Date() }
    });

    // Perform AI analysis
    this.analyzeConversation(sessionId, regionCode).catch(err => console.error("AI Analysis Error:", err));

    // TODO: Send to Buyer via WhatsApp/Telegram API
    // await sendWhatsAppMessage(buyerPhone, `Satıcı Yanıtı:\n\n${content}`);

    return { success: true };
  }

  /**
   * AI eavesdropping: Analyzes the chat history to detect PII, payment agreement, or security flags.
   */
  private static async analyzeConversation(sessionId: string, regionCode: string) {
    const db = prismaManager.getClient(regionCode);
    const messages = await db.aIChatMessage.findMany({
      where: { sessionId },
      orderBy: { createdAt: 'asc' },
      take: 20
    });

    const historyText = messages.map(m => `${m.role}: ${m.content}`).join('\n');
    
    // Call AI to analyze the context
    const analysis = await AIGateway.analyzeChatContext(historyText);

    if (analysis) {
        // Update the last message with the flags
        const lastMsg = messages[messages.length - 1];
        if (lastMsg) {
            await db.aIChatMessage.update({
                where: { id: lastMsg.id },
                data: {
                    paymentAgreed: analysis.paymentAgreed,
                    securityFlag: analysis.securityFlag,
                    securityReason: analysis.securityReason,
                    piiDetected: analysis.piiDetected
                }
            });

            if (analysis.paymentAgreed) {
                console.log(`🎉 [SESSION ${sessionId}] Ödeme Anlaşması Tespit Edildi! (Escrow Tetiklenebilir)`);
                // Trigger Escrow Link to Buyer automatically...
            }
            if (analysis.securityFlag) {
                console.log(`⚠️ [SESSION ${sessionId}] Güvenlik İhlali: ${analysis.securityReason}`);
                // Alert Admin...
            }
        }
    }
  }
}
