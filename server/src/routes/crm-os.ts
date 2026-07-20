import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { eventBus } from "../core/events/event-bus";
import { DomainEvents } from "../core/events/domain-events";

/**
 * CRM OS — Unified dashboard for contacts, leads, deals, pipeline, interactions.
 */
export const crmOSRoutes = new Elysia({ prefix: "/crm-os" })
  .use(authMiddleware)

  // ─── Dashboard ───────────────────────────────────────────────────────────
  .get(
    "/dashboard",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const [totalContacts, totalLeads, qualifiedLeads, totalDeals, openDeals, wonDeals, lostDeals] =
          await Promise.all([
            prisma.contact.count({ where: { orgId } }),
            prisma.lead.count({ where: { orgId } }),
            prisma.lead.count({ where: { orgId, status: "QUALIFIED" } }),
            prisma.deal.count({ where: { orgId } }),
            prisma.deal.count({ where: { orgId, dealStatus: { notIn: ["CLOSED", "FALLEN_THROUGH", "CANCELLED"] } } }),
            prisma.deal.count({ where: { orgId, dealStatus: "CLOSED" } }),
            prisma.deal.count({ where: { orgId, dealStatus: "FALLEN_THROUGH" } }),
          ]);

        return {
          success: true,
          data: {
            contacts: totalContacts,
            leads: { total: totalLeads, qualified: qualifiedLeads, conversionRate: totalLeads > 0 ? ((qualifiedLeads / totalLeads) * 100).toFixed(1) + "%" : "0%" },
            deals: { total: totalDeals, open: openDeals, won: wonDeals, lost: lostDeals, winRate: (wonDeals + lostDeals) > 0 ? ((wonDeals / (wonDeals + lostDeals)) * 100).toFixed(1) + "%" : "0%" },
          },
        };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["CRM OS"], summary: "CRM dashboard overview" } }
  )

  // ─── Pipeline View ───────────────────────────────────────────────────────
  .get(
    "/pipeline",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const deals = await prisma.deal.groupBy({
          by: ["dealStatus"],
          where: { orgId },
          _count: true,
          _sum: { offerPrice: true },
        });
        const pipelineValue = deals.reduce((sum, d) => sum + Number(d._sum.offerPrice ?? 0), 0);
        return { success: true, data: { stages: deals, totalPipelineValue: pipelineValue } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["CRM OS"], summary: "Deal pipeline by stage" } }
  )

  // ─── Leads ───────────────────────────────────────────────────────────────
  .get(
    "/leads",
    async ({ query, set }) => {
      const { orgId, status, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (status) where.status = status;
        const [leads, total] = await Promise.all([
          prisma.lead.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
          }),
          prisma.lead.count({ where }),
        ]);
        return { success: true, data: { leads, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        status: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["CRM OS"], summary: "List leads" },
    }
  )

  // ─── Lead Qualification ──────────────────────────────────────────────────
  .patch(
    "/leads/:id/qualify",
    async ({ params, body, set }) => {
      const { id } = params;
      const { qualified, reason } = body;
      try {
        const lead = await prisma.lead.update({
          where: { id },
          data: { status: qualified ? "QUALIFIED" : "UNQUALIFIED" },
        });

        const eventName = qualified ? DomainEvents.CRM_LEAD_QUALIFIED : DomainEvents.CRM_LEAD_UNQUALIFIED;
        eventBus.publish(eventName, { leadId: id, qualified, reason, orgId: lead.orgId }, "CRMOS");

        return { success: true, data: lead };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ id: t.String() }),
      body: t.Object({ qualified: t.Boolean(), reason: t.Optional(t.String()) }),
      detail: { tags: ["CRM OS"], summary: "Qualify or disqualify a lead" },
    }
  )

  // ─── Deals ───────────────────────────────────────────────────────────────
  .get(
    "/deals",
    async ({ query, set }) => {
      const { orgId, dealStatus, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (dealStatus) where.dealStatus = dealStatus;
        const [deals, total] = await Promise.all([
          prisma.deal.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
          }),
          prisma.deal.count({ where }),
        ]);
        return { success: true, data: { deals, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        dealStatus: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["CRM OS"], summary: "List deals" },
    }
  )

  // ─── Deal Stage Update ───────────────────────────────────────────────────
  .patch(
    "/deals/:id/stage",
    async ({ params, body, set }) => {
      const { id } = params;
      const { dealStatus } = body;
      try {
        const deal = await prisma.deal.update({ where: { id }, data: { dealStatus: dealStatus as any } });
        eventBus.publish(DomainEvents.CRM_DEAL_STAGE_CHANGED, { dealId: id, dealStatus, orgId: deal.orgId }, "CRMOS");

        if (dealStatus === "CLOSED") eventBus.publish(DomainEvents.CRM_DEAL_WON, { dealId: id, orgId: deal.orgId }, "CRMOS");
        if (dealStatus === "FALLEN_THROUGH") eventBus.publish(DomainEvents.CRM_DEAL_LOST, { dealId: id, orgId: deal.orgId }, "CRMOS");

        return { success: true, data: deal };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ id: t.String() }),
      body: t.Object({ dealStatus: t.String() }),
      detail: { tags: ["CRM OS"], summary: "Update deal status" },
    }
  )

  // ─── Interactions (CommunicationLog) ────────────────────────────────────
  .get(
    "/interactions",
    async ({ query, set }) => {
      const { orgId, ticketId, type, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = {};
        if (ticketId) where.ticketId = ticketId;
        if (type) where.type = type;
        const [interactions, total] = await Promise.all([
          prisma.communicationLog.findMany({
            where,
            skip: (page - 1) * limit,
            take: limit,
            orderBy: { createdAt: "desc" },
          }),
          prisma.communicationLog.count({ where }),
        ]);
        return { success: true, data: { interactions, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        ticketId: t.Optional(t.String()),
        type: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["CRM OS"], summary: "List interactions" },
    }
  )

  // ─── Contacts ────────────────────────────────────────────────────────────
  .get(
    "/contacts",
    async ({ query, set }) => {
      const { orgId, search, page = 1, limit = 20 } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const where: any = { orgId };
        if (search) {
          where.OR = [
            { fullName: { contains: search, mode: "insensitive" } },
            { email: { contains: search, mode: "insensitive" } },
            { phone: { contains: search, mode: "insensitive" } },
          ];
        }
        const [contacts, total] = await Promise.all([
          prisma.contact.findMany({ where, skip: (page - 1) * limit, take: limit, orderBy: { createdAt: "desc" } }),
          prisma.contact.count({ where }),
        ]);
        return { success: true, data: { contacts, total, page, limit } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      query: t.Object({
        orgId: t.String(),
        search: t.Optional(t.String()),
        page: t.Optional(t.Numeric()),
        limit: t.Optional(t.Numeric()),
      }),
      detail: { tags: ["CRM OS"], summary: "Search contacts" },
    }
  )

  // ─── Segments ────────────────────────────────────────────────────────────
  .get(
    "/segments",
    async ({ query, set }) => {
      const { orgId } = query;
      if (!orgId) {
        set.status = 400;
        return { success: false, error: "orgId is required" };
      }
      try {
        const leadsByStatus = await prisma.lead.groupBy({
          by: ["status"],
          where: { orgId },
          _count: true,
        });
        return { success: true, data: { byStatus: leadsByStatus } };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    { query: t.Object({ orgId: t.String() }), detail: { tags: ["CRM OS"], summary: "Lead segments" } }
  );
