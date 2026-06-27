import { PrismaClient } from "@prisma/client";
import * as crypto from "crypto";
import { AppEvent } from "../events/event-dispatcher";

const prisma = new PrismaClient();

export class WebhookService {
  static async dispatch(event: AppEvent, payload: any, orgId?: string) {
    if (!orgId) {
      // If we don't have an orgId, we can't fetch tenant-specific webhooks.
      // E.g. some system events might not carry orgId directly at the root level.
      // In a real scenario, you'd ensure every payload has an orgId.
      return;
    }

    try {
      const activeWebhooks = await prisma.webhook.findMany({
        where: {
          orgId,
          isActive: true,
          events: {
            hasSome: [event, "*"]
          }
        }
      });

      if (activeWebhooks.length === 0) return;

      const payloadString = JSON.stringify(payload);

      // Fire and forget
      Promise.allSettled(
        activeWebhooks.map(async (webhook) => {
          const signature = crypto
            .createHmac("sha256", webhook.secret)
            .update(payloadString)
            .digest("hex");

          const headers: Record<string, string> = {
            "Content-Type": "application/json",
            "X-Reservatior-Event": event,
            "X-Reservatior-Signature": `sha256=${signature}`,
          };

          if (webhook.headers && typeof webhook.headers === "object") {
            Object.assign(headers, webhook.headers);
          }

          const deliveryStartTime = Date.now();
          let statusCode: number | null = null;
          let responseBody: any = null;
          let errorMsg: string | null = null;

          try {
            const response = await fetch(webhook.url, {
              method: "POST",
              headers,
              body: payloadString,
              signal: AbortSignal.timeout(5000), // 5 seconds timeout
            });

            statusCode = response.status;
            try {
              responseBody = await response.json();
            } catch {
              responseBody = await response.text();
            }

            if (!response.ok) {
              errorMsg = `HTTP Error ${response.status}: ${response.statusText}`;
            }
          } catch (error: any) {
            errorMsg = error.message;
          }

          // Record delivery log
          await prisma.webhookDelivery.create({
            data: {
              orgId,
              webhookId: webhook.id,
              eventType: event,
              payload: payload,
              response: responseBody || {},
              statusCode,
              error: errorMsg,
              deliveredAt: errorMsg ? null : new Date(),
            }
          });

          // Update webhook stats
          await prisma.webhook.update({
            where: { id: webhook.id },
            data: {
              lastTriggeredAt: new Date(),
              failureCount: errorMsg ? { increment: 1 } : webhook.failureCount,
            }
          });

          console.log(`[WebhookService] Dispatched ${event} to ${webhook.url} - Status: ${statusCode || "FAILED"}`);
        })
      );
    } catch (error) {
      console.error(`[WebhookService] Failed to lookup webhooks for event ${event}:`, error);
    }
  }
}
