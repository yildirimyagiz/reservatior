import { GoogleGenerativeAI } from "@google/generative-ai";
import { prismaManager } from "../../lib/prisma";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export interface GeminiOpsAuditResult {
  b2b: {
    tr: { title: string; body: string };
    en: { title: string; body: string };
    urgency: "INFO" | "WARNING" | "CRITICAL";
  };
  b2c: {
    tr: { title: string; body: string };
    en: { title: string; body: string };
    urgency: "INFO" | "WARNING" | "CRITICAL";
  };
  chatMessage: {
    tr: string;
    en: string;
  };
  recommendedAction: string;
}

export class GeminiOpsNotificationCoordinator {
  
  /**
   * Helper to execute prompts on gemini-2.5-flash and return typed audit results
   */
  private static async executeOpsPrompt(prompt: string, fallback: GeminiOpsAuditResult): Promise<GeminiOpsAuditResult> {
    if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
      console.warn("⚠️ Using Mock AI responses (Gemini key not configured or is default mock key)");
      return fallback;
    }

    try {
      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });
      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      return JSON.parse(text) as GeminiOpsAuditResult;
    } catch (error) {
      console.error("❌ GeminiOpsNotificationCoordinator Error, using fallback:", error);
      return fallback;
    }
  }

  /**
   * Track Physical Inspection GPS Verification failures or status changes
   */
  static async trackTaskGPS(taskId: string, region?: string | null): Promise<GeminiOpsAuditResult | null> {
    const db = prismaManager.getClient(region);
    
    try {
      const task = await db.task.findUnique({
        where: { id: taskId },
        include: { property: true, reservation: true }
      });

      if (!task) {
        console.error(`Task ${taskId} not found`);
        return null;
      }

      // If task is not finished or coordinates are verified, skip AI warning
      if (task.status !== "DONE") {
        return null;
      }

      const prompt = `
        You are the Reservatior AI Security Auditor.
        Review the following physical stay inspection task:
        
        Task Title: "${task.title}"
        Task Description: "${task.description || "N/A"}"
        Property: "${task.property?.name || "Unknown Property"}"
        Property Geolocation: Latitude: ${task.property?.lat || "N/A"}, Longitude: ${task.property?.lng || "N/A"}
        Inspector Geolocation: Latitude: ${task.gpsLatitude || "N/A"}, Longitude: ${task.gpsLongitude || "N/A"}
        GPS Match Verified: ${task.gpsVerified}
        Photo Metadata Location Match: ${task.photoLocationMatch}

        Audit Issue: The inspector has completed this task, but GPS verification or photo metadata match has failed. The inspector was not physically at the property or the photo was taken elsewhere.
        
        Generate a professional B2B warning for the hosting company/real estate agency, a mild B2C warning for the guest/travel agency, and a chat log message.
        
        Return ONLY valid JSON matching this schema:
        {
          "b2b": {
            "tr": { "title": "İşlem Uyarısı: Fiziki Denetim GPS Doğrulaması Başarısız", "body": "..." },
            "en": { "title": "Audit Alert: Physical Inspection GPS Verification Failed", "body": "..." },
            "urgency": "CRITICAL"
          },
          "b2c": {
            "tr": { "title": "Rezervasyon Durum Bilgisi", "body": "..." },
            "en": { "title": "Reservation Status Update", "body": "..." },
            "urgency": "WARNING"
          },
          "chatMessage": {
            "tr": "Fiziki denetim tamamlandı ancak konum doğrulanamadı. Yetkili onayı bekleniyor.",
            "en": "Physical inspection completed but location could not be verified. Pending coordinator approval."
          },
          "recommendedAction": "verify_gps"
        }
      `;

      const fallback: GeminiOpsAuditResult = {
        b2b: {
          tr: {
            title: "Fiziki Denetim GPS Konum Uyarısı",
            body: `"${task.title}" başlıklı denetim tamamlandı ancak müfettişin koordinatları mülk konumuyla uyuşmamaktadır. Lütfen doğruluğunu inceleyin.`
          },
          en: {
            title: "Physical Inspection GPS Location Alert",
            body: `Inspection task "${task.title}" was completed but the inspector's coordinates do not match the property location. Please review.`
          },
          urgency: "CRITICAL"
        },
        b2c: {
          tr: {
            title: "Konaklama Hazırlık Durumu",
            body: "Giriş öncesi son hazırlık denetimleri tamamlanıyor."
          },
          en: {
            title: "Property Preparation Status",
            body: "Final pre-stay checks are currently being processed."
          },
          urgency: "INFO"
        },
        chatMessage: {
          tr: "Fiziki kontrol konumu uyuşmuyor. Manuel denetim tetiklendi.",
          en: "Physical check geolocation mismatch. Manual audit triggered."
        },
        recommendedAction: "verify_gps"
      };

      const auditResult = await this.executeOpsPrompt(prompt, fallback);

      // Create B2B Notification record in DB
      await db.notification.create({
        data: {
          orgId: task.orgId,
          userId: task.assignedToUserId || task.createdBy,
          title: auditResult.b2b.tr.title,
          body: auditResult.b2b.tr.body,
          status: "QUEUED",
          data: {
            auditResult: auditResult as any,
            sourceType: "TASK",
            sourceId: taskId,
            category: "AI_OPS_AUDIT"
          }
        }
      });

      // Write System Chat message if reservation exists
      if (task.reservationId) {
        await db.message.create({
          data: {
            orgId: task.orgId,
            body: auditResult.chatMessage.tr,
            senderType: "USER", // Mock system or admin agent sender type
            subject: "AI Operations Audit Logs",
            threadId: task.reservationId,
            aiPriority: auditResult.b2b.urgency
          }
        });
      }

      return auditResult;
    } catch (err) {
      console.error("Error running trackTaskGPS:", err);
      return null;
    }
  }

  /**
   * Track KBS Police/Gendarmerie log failures
   */
  static async trackKbsStatus(logId: string, region?: string | null): Promise<GeminiOpsAuditResult | null> {
    const db = prismaManager.getClient(region);

    try {
      const log = await db.kbsReportLog.findUnique({
        where: { id: logId },
        include: { reservation: true }
      });

      if (!log) {
        console.error(`KBS log ${logId} not found`);
        return null;
      }

      if (log.status !== "FAILED") {
        return null;
      }

      const prompt = `
        You are the Reservatior KBS (Kimlik Bildirim Sistemi) Integration Compliance Officer.
        Review the failed registration log details:
        
        Guest Name: "${log.guestName}"
        Document Number: "${log.documentNumber}"
        KBS Response Code: "${log.responseCode || "N/A"}"
        KBS Error Message: "${log.errorMessage || "N/A"}"
        Reservation ID: "${log.reservationId}"

        Audit Issue: The police/gendarmerie ID registration failed. This is a critical legal compliance failure which must be corrected immediately.
        
        Generate a critical B2B notification warning the property manager or host, a B2C instruction notification asking the traveler to verify their identity documents, and a system message.
        
        Return ONLY valid JSON matching this schema:
        {
          "b2b": {
            "tr": { "title": "KRİTİK: KBS Kimlik Bildirim Hatası", "body": "..." },
            "en": { "title": "CRITICAL: KBS Identity Registration Failed", "body": "..." },
            "urgency": "CRITICAL"
          },
          "b2c": {
            "tr": { "title": "Önemli: Kimlik Bilgilerinizi Güncelleyin", "body": "..." },
            "en": { "title": "Important: Update Your Identity Documents", "body": "..." },
            "urgency": "CRITICAL"
          },
          "chatMessage": {
            "tr": "Emniyet KBS bildirimi başarısız oldu. Lütfen konuk pasaport veya T.C. kimlik numaralarını kontrol edin.",
            "en": "KBS police registration failed. Please review guest passports or national ID numbers."
          },
          "recommendedAction": "update_document"
        }
      `;

      const fallback: GeminiOpsAuditResult = {
        b2b: {
          tr: {
            title: "KRİTİK: Emniyet KBS Kimlik Bildirim Hatası",
            body: `Konuk "${log.guestName}" için emniyet kimlik bildirimi başarısız oldu. Hata: ${log.errorMessage || "Yanıt kodu: " + log.responseCode}. Lütfen belgeleri hemen güncelleyin.`
          },
          en: {
            title: "CRITICAL: Police KBS Identity Registration Error",
            body: `Identity report for guest "${log.guestName}" failed. Error: ${log.errorMessage || "Response: " + log.responseCode}. Please update ID details immediately.`
          },
          urgency: "CRITICAL"
        },
        b2c: {
          tr: {
            title: "Lütfen Kimlik Bilgilerinizi Doğrulayın",
            body: "Yasal gereklilikler sebebiyle giriş belgesi doğrulamanızda bir hata tespit edildi. Lütfen kimlik/pasaport bilgilerinizi güncelleyin."
          },
          en: {
            title: "Please Verify Your Identity Details",
            body: "We detected an issue verifying your passport/identity document for check-in compliance. Please re-enter your details."
          },
          urgency: "CRITICAL"
        },
        chatMessage: {
          tr: "KBS Kimlik Bildirimi başarısız oldu. Güvenlik ve yasal uyum için düzeltme gerekiyor.",
          en: "KBS Identity reporting failed. Immediate compliance correction required."
        },
        recommendedAction: "update_document"
      };

      const auditResult = await this.executeOpsPrompt(prompt, fallback);

      // Create B2B Notification
      await db.notification.create({
        data: {
          orgId: log.orgId,
          title: auditResult.b2b.tr.title,
          body: auditResult.b2b.tr.body,
          status: "QUEUED",
          data: {
            auditResult: auditResult as any,
            sourceType: "KBS_LOG",
            sourceId: logId,
            category: "AI_OPS_AUDIT"
          }
        }
      });

      // Write Chat logs
      await db.message.create({
        data: {
          orgId: log.orgId,
          body: auditResult.chatMessage.tr,
          senderType: "USER",
          subject: "KBS Compliance Error Log",
          threadId: log.reservationId,
          aiPriority: "CRITICAL"
        }
      });

      return auditResult;
    } catch (err) {
      console.error("Error running trackKbsStatus:", err);
      return null;
    }
  }

  /**
   * Track EscrowAccount changes (blockage, release, dispute)
   */
  static async trackEscrowChange(escrowId: string, region?: string | null): Promise<GeminiOpsAuditResult | null> {
    const db = prismaManager.getClient(region);

    try {
      const escrow = await db.escrowAccount.findUnique({
        where: { id: escrowId },
        include: { reservation: true }
      });

      if (!escrow) {
        console.error(`Escrow Account ${escrowId} not found`);
        return null;
      }

      const prompt = `
        You are the Reservatior B2B FinTech Arbitrage and Escrow Officer.
        Review the escrow status update:
        
        Escrow ID: "${escrow.id}"
        Reservation ID: "${escrow.reservationId}"
        Escrow Amount: "${escrow.totalAmount} ${escrow.currency}"
        Escrow Current Status: "${escrow.status}"
        Bank Blockage Code: "${escrow.obBlockId || "N/A"}"
        Bank Name: "${escrow.bankName || "N/A"}"
        Open Banking Status: "${escrow.obStatus || "N/A"}"

        Generate an update notification for the Host, the Agency, and a chat record explaining payment holding/payout state.
        
        Return ONLY valid JSON matching this schema:
        {
          "b2b": {
            "tr": { "title": "Banka Ödeme/Bloke Güncellemesi", "body": "..." },
            "en": { "title": "Bank Payment/Blockage Update", "body": "..." },
            "urgency": "INFO"
          },
          "b2c": {
            "tr": { "title": "Ödeme Güvence Alındı", "body": "..." },
            "en": { "title": "Payment Secured in Escrow", "body": "..." },
            "urgency": "INFO"
          },
          "chatMessage": {
            "tr": "Ödeme escrow hesabında güvenceye alınmıştır. Bloke durumu güncellendi.",
            "en": "Payment secured in escrow. Blockage status updated."
          },
          "recommendedAction": "check_escrow"
        }
      `;

      const fallback: GeminiOpsAuditResult = {
        b2b: {
          tr: {
            title: `B2B Escrow Bloke Bilgisi: ${escrow.status}`,
            body: `Rezervasyon ${escrow.reservationId} için ${escrow.totalAmount} ${escrow.currency} tutarındaki ödeme, ${escrow.bankName || "TCMB escrow"} nezdinde bloke edildi. Bloke durumu: ${escrow.status}.`
          },
          en: {
            title: `B2B Escrow Payout State: ${escrow.status}`,
            body: `Payment of ${escrow.totalAmount} ${escrow.currency} for reservation ${escrow.reservationId} is locked in ${escrow.bankName || "escrow bank"}. Status: ${escrow.status}.`
          },
          urgency: "INFO"
        },
        b2c: {
          tr: {
            title: "Ödemeniz Escrow Güvencesinde",
            body: "Konaklama bedeliniz mülk sahibine aktarılmadan önce rezervasyon güvencesi için bloke hesabında kilitlenmiştir."
          },
          en: {
            title: "Your Payment is Protected by Escrow",
            body: "Your booking payment has been safely placed in our escrow blockage account before disbursement."
          },
          urgency: "INFO"
        },
        chatMessage: {
          tr: `Escrow bloke güncellendi: ${escrow.status}. Referans: ${escrow.obBlockId || "N/A"}`,
          en: `Escrow blockage status: ${escrow.status}. Reference: ${escrow.obBlockId || "N/A"}`
        },
        recommendedAction: "check_escrow"
      };

      const auditResult = await this.executeOpsPrompt(prompt, fallback);

      // Create B2B Notification
      await db.notification.create({
        data: {
          orgId: escrow.orgId,
          title: auditResult.b2b.tr.title,
          body: auditResult.b2b.tr.body,
          status: "QUEUED",
          data: {
            auditResult: auditResult as any,
            sourceType: "ESCROW",
            sourceId: escrowId,
            category: "AI_OPS_AUDIT"
          }
        }
      });

      // Write Chat logs
      await db.message.create({
        data: {
          orgId: escrow.orgId,
          body: auditResult.chatMessage.tr,
          senderType: "USER",
          subject: "Escrow Status History Log",
          threadId: escrow.reservationId,
          aiPriority: "INFO"
        }
      });

      return auditResult;
    } catch (err) {
      console.error("Error running trackEscrowChange:", err);
      return null;
    }
  }

  /**
   * Track Host Penalties or Relocation Costs
   */
  static async trackHostPenalty(penaltyId: string, region?: string | null): Promise<GeminiOpsAuditResult | null> {
    const db = prismaManager.getClient(region);

    try {
      const penalty = await db.hostPenalty.findUnique({
        where: { id: penaltyId },
        include: { reservation: true }
      });

      if (!penalty) {
        console.error(`Host Penalty ${penaltyId} not found`);
        return null;
      }

      const prompt = `
        You are the Reservatior Host Penalty and Quality Compliance Officer.
        Review the penalty log details:
        
        Penalty ID: "${penalty.id}"
        Penalty Amount: "${penalty.penaltyAmount} ${penalty.currency}"
        Relocation Cost: "${penalty.relocationCost || "0.00"} ${penalty.currency}"
        Notes/Reason: "${penalty.notes || "N/A"}"
        Penalty Status: "${penalty.status}"

        Audit Issue: A penalty has been charged to the host/agency due to check-in failure, compliance failure, or guest relocation.
        
        Generate a warning notification for the Host (B2B) explaining the charge and deduction from escrow, a message for the Agency, and a chat record.
        
        Return ONLY valid JSON matching this schema:
        {
          "b2b": {
            "tr": { "title": "UYARI: Ev Sahibi Cezası Tanımlandı", "body": "..." },
            "en": { "title": "WARNING: Host Penalty Applied", "body": "..." },
            "urgency": "WARNING"
          },
          "b2c": {
            "tr": { "title": "Rezervasyon Telafi Bilgisi", "body": "..." },
            "en": { "title": "Reservation Relocation Information", "body": "..." },
            "urgency": "INFO"
          },
          "chatMessage": {
            "tr": "Kurallara uyulmaması nedeniyle ceza kesildi ve escrow hesabından kesinti planlandı.",
            "en": "Penalty charged due to non-compliance. Deduction from escrow account scheduled."
          },
          "recommendedAction": "dispute_penalty"
        }
      `;

      const fallback: GeminiOpsAuditResult = {
        b2b: {
          tr: {
            title: "Ev Sahibi Cezası Bildirimi",
            body: `Rezervasyon ${penalty.reservationId} için ${penalty.penaltyAmount} ${penalty.currency} ceza yansıtılmıştır. Durum: ${penalty.status}. Gerekçe: ${penalty.notes || "Belirtilmemiş"}.`
          },
          en: {
            title: "Host Penalty Logged",
            body: `A penalty of ${penalty.penaltyAmount} ${penalty.currency} has been applied for reservation ${penalty.reservationId}. Status: ${penalty.status}. Details: ${penalty.notes || "None"}.`
          },
          urgency: "WARNING"
        },
        b2c: {
          tr: {
            title: "Rezervasyon Telafi Desteği",
            body: "Girişte yaşanan sorunlar nedeniyle ek destek ve telafi süreçleri başlatıldı."
          },
          en: {
            title: "Booking Compensation Support",
            body: "Compensation and support processes have been initiated due to check-in difficulties."
          },
          urgency: "INFO"
        },
        chatMessage: {
          tr: `Ev sahibi cezası uygulandı: ${penalty.penaltyAmount} ${penalty.currency}. Nedeni: ${penalty.notes || "Yok"}`,
          en: `Host penalty applied: ${penalty.penaltyAmount} ${penalty.currency}. Reason: ${penalty.notes || "None"}`
        },
        recommendedAction: "dispute_penalty"
      };

      const auditResult = await this.executeOpsPrompt(prompt, fallback);

      // Create B2B Notification
      await db.notification.create({
        data: {
          orgId: penalty.orgId,
          title: auditResult.b2b.tr.title,
          body: auditResult.b2b.tr.body,
          status: "QUEUED",
          data: {
            auditResult: auditResult as any,
            sourceType: "HOST_PENALTY",
            sourceId: penaltyId,
            category: "AI_OPS_AUDIT"
          }
        }
      });

      // Write Chat logs
      await db.message.create({
        data: {
          orgId: penalty.orgId,
          body: auditResult.chatMessage.tr,
          senderType: "USER",
          subject: "Host Quality Penalty Log",
          threadId: penalty.reservationId,
          aiPriority: "WARNING"
        }
      });

      return auditResult;
    } catch (err) {
      console.error("Error running trackHostPenalty:", err);
      return null;
    }
  }
}
