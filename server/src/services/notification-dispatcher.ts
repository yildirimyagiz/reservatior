import { prismaManager } from "../lib/prisma";

/**
 * NotificationDispatcher
 * 
 * Processes undelivered notifications from the database and dispatches them
 * via the appropriate channel (email, push, SMS). For now, it logs dispatch
 * actions and marks notifications as delivered. In production, integrate 
 * with SendGrid (email), Firebase FCM (push), or Twilio (SMS).
 */
export class NotificationDispatcher {

  /**
   * Process all undelivered notifications and dispatch them.
   * Called by the nightly cron job or can be triggered manually.
   */
  static async processUndeliveredNotifications(): Promise<{
    processed: number;
    emailsSent: number;
    pushSent: number;
    failed: number;
  }> {
    const db = prismaManager.getClient();
    let processed = 0;
    let emailsSent = 0;
    let pushSent = 0;
    let failed = 0;

    try {
      // Find all unread notifications created in the last 24 hours that haven't been dispatched
      const pendingNotifications = await db.notification.findMany({
        where: {
          status: "QUEUED",
          createdAt: {
            gte: new Date(Date.now() - 24 * 60 * 60 * 1000)
          }
        },
        include: {
          user: {
            select: { id: true, email: true, name: true }
          }
        },
        take: 200, // Process in batches
        orderBy: { createdAt: "asc" }
      });

      for (const notification of pendingNotifications) {
        try {
          const user = notification.user;
          if (!user?.email) continue;

          // Determine dispatch channel based on notification type
          const isUrgent = notification.ruleKey === "ALERT" || notification.title.includes("Urgent");

          // --- EMAIL DISPATCH ---
          if (user.email) {
            await NotificationDispatcher.sendEmail(
              user.email,
              notification.title || "Reservatior Notification",
              notification.body || ""
            );
            emailsSent++;
          }

          // --- PUSH NOTIFICATION DISPATCH ---
          // Check if user has a registered mobile device
          const devices = await db.mobileDevice.findMany({
            where: { userId: user.id, isActive: true },
            select: { deviceToken: true, deviceType: true }
          }).catch(() => []);

          if (devices.length > 0 && isUrgent) {
            for (const device of devices) {
              if (device.deviceToken) {
                await NotificationDispatcher.sendPush(
                  device.deviceToken,
                  notification.title || "Reservatior",
                  notification.body || "",
                  device.deviceType || "ios"
                );
                pushSent++;
              }
            }
          }

          // Mark notification as SENT
          await db.notification.update({
            where: { id: notification.id },
            data: { status: "SENT", sentAt: new Date() }
          });

          processed++;
        } catch (err) {
          console.error(`[DISPATCHER] Failed to dispatch notification ${notification.id}:`, err);
          // Mark notification as FAILED
          await db.notification.update({
            where: { id: notification.id },
            data: { status: "FAILED" }
          }).catch(() => {});
          failed++;
        }
      }

      console.log(`[DISPATCHER] Processed ${processed} notifications. Emails: ${emailsSent}, Push: ${pushSent}, Failed: ${failed}`);
    } catch (error) {
      console.error("[DISPATCHER] Notification processing failed:", error);
    }

    return { processed, emailsSent, pushSent, failed };
  }

  /**
   * Send an email notification.
   * In production: Replace with SendGrid/Resend/AWS SES integration.
   */
  static async sendEmail(to: string, subject: string, body: string): Promise<boolean> {
    // Production: Use SendGrid or similar
    // import sgMail from "@sendgrid/mail";
    // sgMail.setApiKey(process.env.SENDGRID_API_KEY!);
    // await sgMail.send({ to, from: "notifications@reservatior.com", subject, text: body });

    console.log(`[EMAIL] → ${to} | Subject: "${subject}" | Body: ${body.substring(0, 80)}...`);

    // Log the dispatch attempt
    const db = prismaManager.getClient();
    try {
      let orgId = "system";
      const firstOrg = await db.organization.findFirst({ select: { id: true } });
      if (firstOrg) {
        orgId = firstOrg.id;
      }
      await db.auditLog.create({
        data: {
          action: "NOTIFICATION_EMAIL_SENT",
          entityType: "Notification",
          entityId: to,
          newValues: { details: `Email sent to ${to}: "${subject}"` },
          orgId: orgId
        }
      });
    } catch (e) { /* ignore audit failures */ }

    return true;
  }

  /**
   * Send a push notification to a mobile device.
   * In production: Replace with Firebase FCM / APNs integration.
   */
  static async sendPush(
    pushToken: string, 
    title: string, 
    body: string, 
    platform: string
  ): Promise<boolean> {
    // Production: Use Firebase Admin SDK
    // import { getMessaging } from "firebase-admin/messaging";
    // await getMessaging().send({ token: pushToken, notification: { title, body } });

    console.log(`[PUSH:${platform.toUpperCase()}] → Token: ${pushToken.substring(0, 20)}... | "${title}"`);
    return true;
  }

  /**
   * Get notification delivery statistics for a given time range.
   */
  static async getDeliveryStats(hoursBack: number = 24): Promise<{
    total: number;
    read: number;
    unread: number;
    readRate: string;
  }> {
    const db = prismaManager.getClient();
    const since = new Date(Date.now() - hoursBack * 60 * 60 * 1000);

    const total = await db.notification.count({
      where: { createdAt: { gte: since } }
    });

    const read = await db.notification.count({
      where: { createdAt: { gte: since }, status: "READ" }
    });

    return {
      total,
      read,
      unread: total - read,
      readRate: total > 0 ? `${((read / total) * 100).toFixed(1)}%` : "0%"
    };
  }
}
