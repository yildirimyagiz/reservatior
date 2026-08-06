import { Elysia, t } from "elysia";
import { prismaManager } from "../../lib/prisma";
import { eventBus } from "../../core/events/event-bus";
import { DomainEvents } from "../../core/events/domain-events";
import { randomUUID } from "crypto";

export const adsWebhookPlugin = new Elysia({ prefix: '/api/webhooks/ads' })

  // The CRM wedge: converting an AI generated ad click into a Lead
  .post("/lead", async ({ body, set }) => {
    try {
      const { 
        firstName = "Meta", 
        lastName = "Lead", 
        email = "lead@example.com", 
        phone = "555-0199",
        campaignId = "simulated_campaign",
        orgId = "mock-org-123" // In reality, mapped from Ad Account ID
      } = body as any;

      const prisma = prismaManager.getClient('US');
      const correlationId = randomUUID();

      // 1. Create Lead in the DB
      const lead = await prisma.lead.create({
        data: {
          orgId,
          firstName,
          lastName,
          email,
          phone,
          campaignId,
          sourceDetail: "Meta Ads (AI Auto-Gen)",
          status: "NEW", // NEW
        }
      });

      console.log(`[CRM] 🎯 New Lead Captured from Meta Ads: ${lead.id}`);

      // 2. Publish Domain Event
      eventBus.publish(DomainEvents.LEAD_CREATED, {
        leadId: lead.id,
        orgId: lead.orgId,
        campaignId: lead.campaignId
      }, 'CRM', correlationId);

      set.status = 201;
      return { success: true, leadId: lead.id, message: "Lead captured and event published" };
    } catch (error: any) {
      console.error("[CRM] Webhook Error:", error);
      set.status = 500;
      return { success: false, error: error.message };
    }
  })

  // The final closure of the wedge: Lead -> Deal -> Closed
  .post("/:leadId/close-deal", async ({ params, body, set }) => {
    try {
      const { leadId } = params;
      const { price = 500000, commissionRate = 3.0 } = (body as any) || {};

      const prisma = prismaManager.getClient('US');
      const correlationId = randomUUID();

      const lead = await prisma.lead.findUnique({
        where: { id: leadId }
      });

      if (!lead) {
        set.status = 404;
        return { success: false, error: "Lead not found" };
      }

      const commissionAmount = price * (commissionRate / 100);

      // Update Lead to Closed/Won (In a full CRM this would be a Deal entity, but we simulate on Lead)
      await prisma.lead.update({
        where: { id: leadId },
        data: { status: "QUALIFIED" } // Assuming QUALIFIED or a custom status means closed for now
      });

      console.log(`[CRM] 💰 Deal Closed for Lead ${leadId}! Amount: $${price}, Commission: $${commissionAmount}`);

      // Emit Deal Closed Event -> Triggers CommissionPaymentSaga
      eventBus.publish(DomainEvents.DEAL_CLOSED, {
        dealId: `deal_${leadId}`,
        orgId: lead.orgId,
        agentId: lead.assignedToUserId || 'agent_123',
        propertyId: lead.interestedPropertyId || 'prop_123',
        price: price,
        commissionAmount: commissionAmount
      }, 'CRM', correlationId);

      return { success: true, message: "Deal closed, commission saga triggered" };
    } catch (error: any) {
      console.error("[CRM] Deal Close Error:", error);
      set.status = 500;
      return { success: false, error: error.message };
    }
  });
