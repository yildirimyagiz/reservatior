import { prismaManager } from '../../lib/prisma';
import { AIGateway, ParsedIntent } from '../ai/ai-gateway';
import { PropertyType, ListingStatus, ListingType } from '@prisma/client';
import { OmniChannelBroadcaster } from './omni-channel-broadcaster';
import { ChatRelay } from './chat-relay';

export class BotController {
  
  static async processMessage(
    text: string, 
    platform: 'whatsapp' | 'telegram', 
    userId: string, 
    userLanguage: string = 'tr',
    regionCode: string = 'TR'
  ): Promise<{ text: string; inline_keyboard?: any[]; mediaUrl?: string }> {
    
    // 1. Niyet Analizi (Intent Parsing via Gemini AI)
    const aiResult: ParsedIntent = await AIGateway.parseMessage(text, userLanguage);
    console.log(`🤖 AI Intent Detected: ${aiResult.intent}`, aiResult.parameters);

    // 2. Aksiyon Yönetimi (Action Routing)
    switch (aiResult.intent) {
      case 'SEARCH_PROPERTIES':
        return await this.handleSearchProperties(aiResult.parameters, platform, aiResult.detectedLanguage || 'tr', regionCode);
        
      case 'CREATE_LISTING':
        return await this.handleCreateListing(aiResult.parameters, userId, aiResult.detectedLanguage || 'tr', regionCode, aiResult.catalogType, aiResult.localMediaPaths);
        
      case 'SCHEDULE_MEETING':
        return await this.handleScheduleMeeting(aiResult.parameters, userId, aiResult.detectedLanguage || 'tr');
        
      case 'INITIATE_ESCROW':
        return await this.handleInitiateEscrow(aiResult.parameters, aiResult.detectedLanguage || 'tr', regionCode);
        
      case 'CONTACT_SELLER':
        return await this.handleContactSeller(aiResult.parameters, userId, aiResult.detectedLanguage || 'tr', regionCode);
        
      case 'GENERAL_CONVERSATION':
      default:
        return { text: aiResult.replyText || "Size nasıl yardımcı olabilirim?" };
    }
  }

  // --- İLAN ARAMA (KATALOG OLUŞTURMA) ---
  private static async handleSearchProperties(params: any, platform: 'whatsapp'|'telegram', lang: string, regionCode: string) {
    const { city, maxPrice, minBeds, propertyType } = params;
    
    const db = prismaManager.getClient(regionCode);
    const properties = await db.property.findMany({
      where: {
        ...(city ? { city: { contains: city, mode: 'insensitive' } } : {}),
        ...(minBeds ? { bedrooms: { gte: parseInt(minBeds) } } : {}),
        ...(maxPrice ? { listingPrice: { lte: parseFloat(maxPrice) } } : {}),
        ...(propertyType ? { type: propertyType } : {}),
        listingStatus: 'AVAILABLE'
      },
      take: 3,
      orderBy: { listingPrice: 'desc' }
    });

    if (properties.length === 0) {
      return { text: "❌ Maalesef kriterlerinize uygun emlak bulunamadı. Lütfen aramayı genişletin." };
    }

    let responseText = `🎯 *Sizin İçin Bulduğumuz Portföyler:*\n\n`;
    const keyboard = [];
    let mediaUrl = undefined;

    for (let i = 0; i < properties.length; i++) {
      const p = properties[i];
      const priceStr = p.listingPrice ? `${p.currency} ${p.listingPrice.toLocaleString()}` : 'Fiyat Sorunuz';
      
      responseText += `*${i+1}. ${p.name}*\n📍 ${p.city}, ${p.country}\n💰 *${priceStr}*\n🛏️ Oda: ${p.bedrooms || 0}\nID: \`${p.id}\`\n\n`;
      
      if (platform === 'telegram') {
        keyboard.push([
          { text: `📅 ${i+1}. Randevu Al`, callback_data: `meet_${p.id}` },
          { text: `💳 ${i+1}. Escrow Başlat`, callback_data: `escrow_${p.id}` }
        ]);
      }
      
      // İlk bulduğumuz evin fotoğrafını (eğer varsa mock olarak) katalog kapağı yapıyoruz
      if (i === 0 && !mediaUrl) {
        // Gerçek sistemde: const photo = await prisma.propertyPhoto.findFirst({where: {propertyId: p.id}});
        // mediaUrl = photo?.url;
        mediaUrl = "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"; // Mock Lüks Ev Fotoğrafı
      }
    }

    if (platform === 'whatsapp') {
      responseText += `\n_Randevu almak için "1. emlak için randevu al", Ödeme yapmak için "1. emlak için escrow başlat" yazabilirsiniz._`;
    }

    return { text: responseText, inline_keyboard: keyboard.length > 0 ? keyboard : undefined, mediaUrl };
  }

  // --- GELEN MESAJLARDAN İLAN OLUŞTURMA (INBOUND LISTING GENERATION) ---
  public static async handleCreateListing(params: any, userId: string, lang: string, regionCode: string = 'TR', catalogType?: string, localMediaPaths?: string[]) {
    const { city, propertyType, price, currency, beds, description } = params;

    // TODO: Gerçek sistemde default orgId dinamik alınmalıdır.
    const mockOrgId = "cm0y111110000000000000000"; 
    
    // Prisma üzerinde yeni bir mülk taslağı (DRAFT) oluştur
    try {
      const db = prismaManager.getClient(regionCode);
      const newProperty = await db.property.create({
        data: {
          name: `${city || 'Bilinmiyor'} - AI Taslak İlan`,
          orgId: mockOrgId,
          region: 'TURKIYE',
          city: city || 'Bilinmiyor',
          country: 'Bilinmiyor',
          addressLine1: 'AI Tarafından Oluşturuldu',
          type: propertyType || PropertyType.DETACHED_HOUSE,
          bedrooms: beds ? parseInt(beds) : null,
          listingPrice: price ? parseFloat(price) : null,
          currency: currency || 'USD',
          listingStatus: ListingStatus.DRAFT,
          listingType: ListingType.SALE,
          notes: JSON.stringify({ aiGenerated: true, originalDescription: description, sourceUserId: userId, catalogType: catalogType || 'second_hand' })
        }
      });

      // Eğer ML ile analiz edilip yerel olarak kaydedilen bir fotoğraf varsa veritabanına ekle
      if (localMediaPaths && localMediaPaths.length > 0) {
        for (const localPath of localMediaPaths) {
          await db.propertyPhoto.create({
            data: {
              propertyId: newProperty.id,
              orgId: mockOrgId,
              url: localPath,
              isPrimary: true
            }
          });
        }
      }

      // Yeni listeleme (ilan) oluşturulduğunda Telegram pazarlama gruplarına otomatik sinyal gönder:
      OmniChannelBroadcaster.broadcastNewListingToTelegram(newProperty.id).catch(err => console.error("Broadcast hatası:", err));

      return { text: `✅ *İlan Taslağınız Oluşturuldu!*\n\nSistemimiz mesajınızı analiz etti ve taslak ilan olarak kaydetti. Danışmanlarımız inceledikten sonra yayına alınacaktır.\n\nTaslak ID: \`${newProperty.id}\`` };
    } catch (error) {
      console.error("Listing creation failed:", error);
      return { text: "❌ İlan taslağı oluşturulurken bir hata meydana geldi." };
    }
  }

  // --- GOOGLE DRIVE KATALOĞUNDAN PROJE OLUŞTURMA ---
  public static async handleCreateProjectFromCatalog(params: any, userId: string, regionCode: string = 'TR') {
    const { projectName, description, address, projectType } = params;
    
    // Gerçek sistemde dinamik organizasyon kimliği alınmalı
    const mockOrgId = "cm0y111110000000000000000"; 
    
    try {
      const db = prismaManager.getClient(regionCode);
      const newProject = await db.project.create({
        data: {
          name: projectName || 'Yeni Katalog Projesi',
          orgId: mockOrgId,
          description: description || 'AI tarafından Google Drive kataloğundan otomatik çekildi.',
          address: address || 'Bilinmiyor',
          projectType: projectType || 'RESIDENTIAL',
          status: 'PLANNING'
        }
      });

      return { text: `✅ *Proje Kataloğu Başarıyla İşlendi!*\n\nYeni Proje: *${newProject.name}*\nAdres: ${newProject.address}\nID: \`${newProject.id}\`\n\nSistem bu projeyi TR veritabanına Taslak (PLANNING) durumunda ekledi.` };
    } catch (error) {
      console.error("Project creation from catalog failed:", error);
      return { text: "❌ Proje kataloğu işlenirken bir hata meydana geldi." };
    }
  }

  // --- TOPLANTI / RANDEVU PLANLAMA ---
  private static async handleScheduleMeeting(params: any, userId: string, lang: string) {
    const { propertyId, requestedDate } = params;
    
    if (!propertyId) {
      return { text: "📅 Hangi emlak için randevu almak istiyorsunuz? Lütfen Emlak ID'sini belirtin." };
    }

    // Gerçek sistemde Appointment tablosuna yazılacak.
    return { text: `📅 *Randevu Talebiniz Alındı!*\n\nEmlak ID: \`${propertyId}\`\nTarih: ${requestedDate || 'En kısa sürede'}\n\nDanışmanımız sizinle iletişime geçerek takvimi onaylayacaktır.` };
  }

  // --- ÖDEME / ESCROW KOORDİNASYONU ---
  private static async handleInitiateEscrow(params: any, lang: string, regionCode: string) {
    const { propertyId } = params;
    
    if (!propertyId) {
      return { text: "💳 Hangi emlak için ödeme sürecini başlatmak istiyorsunuz? Lütfen Emlak ID'sini belirtin." };
    }

    const db = prismaManager.getClient(regionCode);
    const property = await db.property.findUnique({ where: { id: propertyId } });
    if (!property) return { text: "❌ Belirtilen ID ile emlak bulunamadı." };

    const priceStr = property.listingPrice ? `${property.currency} ${property.listingPrice.toLocaleString()}` : 'Belirsiz';

    const mockEscrowId = `ESC-${Math.floor(100000 + Math.random() * 900000)}`;

    return {
      text: `🛡️ *TRUSTLINK ESCROW BAŞLATILDI*\n\nEmlak: *${property.name}*\nTutar: *${priceStr}*\nEscrow ID: \`${mockEscrowId}\`\n\nRezervasyon bedelini yatırmak için TrustLink Sanal IBAN (QNB Finansbank) veya TRC20 Kripto ağımızı kullanabilirsiniz.\n\n🔗 Ödeme Linki: https://app.trustlink.global/checkout/${mockEscrowId}`
    };
  }

  // --- SATICI İLE GÜVENLİ İLETİŞİM (CHAT RELAY) ---
  private static async handleContactSeller(params: any, userId: string, lang: string, regionCode: string) {
    const { propertyId, messageContent } = params;

    if (!propertyId) {
      return { text: "💬 Hangi emlak için mesaj göndermek istiyorsunuz? Lütfen Emlak ID'sini belirtin." };
    }

    if (!messageContent) {
      return { text: "📝 Lütfen satıcıya iletmek istediğiniz mesajı yazın." };
    }

    // 1. Yeni veya mevcut oturumu başlat
    const sessionId = await ChatRelay.startSession(userId, propertyId, regionCode);

    // 2. Mesajı Proxy üzerinden satıcıya ilet (Veritabanına yazar)
    const relayResult = await ChatRelay.relayMessageFromBuyer(sessionId, messageContent, regionCode);

    return { 
      text: `✅ *Mesajınız Satıcıya İletildi!*\n\nSistem güvenliğiniz için satıcıyla doğrudan numaranızı paylaşmadık. Satıcı yanıt verdiğinde bu sohbet üzerinden bildirim alacaksınız.\n\nMesajınız: _"${messageContent}"_`
    };
  }
}
