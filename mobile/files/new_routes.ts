// ══════════════════════════════════════════════════════════════════════════════
//  routes/agencies.ts — Agency CRUD + members + stats
//  Eklenecek router.ts'e: import { agencyRoutes } from "./routes/agencies";
//  + .use(agencyRoutes)  (CRM bölümüne)
// ══════════════════════════════════════════════════════════════════════════════
import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";

export const agencyRoutes = new Elysia({ prefix: "/agencies" })
  .use(authMiddleware)

  // GET /agencies
  .get("/", async ({ query }) => {
    const { orgId, search, page = "1", limit = "20" } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (search) {
      where.OR = [
        { name: { contains: search, mode: "insensitive" } },
        { email: { contains: search, mode: "insensitive" } },
      ];
    }
    const [data, total] = await Promise.all([
      prisma.agency.findMany({
        where, skip, take: parseInt(limit),
        orderBy: { createdAt: "desc" },
        include: {
          _count: { select: { agentOwners: true } },
        },
      }),
      prisma.agency.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  })

  // POST /agencies
  .post("/", async ({ body, set }) => {
    const agency = await prisma.agency.create({ data: body as any });
    set.status = 201;
    return { data: agency };
  }, {
    body: t.Object({
      name: t.String(),
      ownerId: t.String(),
      email: t.Optional(t.String()),
      phone: t.Optional(t.String()),
      licenseNumber: t.Optional(t.String()),
      address: t.Optional(t.String()),
      website: t.Optional(t.String()),
      logoUrl: t.Optional(t.String()),
    }),
  })

  // GET /agencies/:id
  .get("/:id", async ({ params, set }) => {
    const agency = await prisma.agency.findFirst({
      where: { id: params.id, deletedAt: null },
      include: {
        agentOwners: {
          where: { deletedAt: null },
          select: { id: true, name: true, email: true, status: true, licenseNumber: true, commissionRate: true },
        },
        Users: {
          select: { id: true, name: true, email: true },
        },
        _count: { select: { agentOwners: true } },
      },
    });
    if (!agency) { set.status = 404; return { error: "Ajans bulunamadı" }; }
    return { data: agency };
  })

  // PATCH /agencies/:id
  .patch("/:id", async ({ params, body }) => {
    const agency = await prisma.agency.update({
      where: { id: params.id },
      data: body as any,
    });
    return { data: agency };
  }, {
    body: t.Partial(t.Object({
      name: t.String(), email: t.String(), phone: t.String(),
      address: t.String(), website: t.String(), logoUrl: t.String(),
      licenseNumber: t.String(), description: t.String(),
    })),
  })

  // DELETE /agencies/:id
  .delete("/:id", async ({ params }) => {
    await prisma.agency.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
    return { message: "Ajans silindi" };
  })

  // GET /agencies/:id/agents
  .get("/:id/agents", async ({ params, query }) => {
    const { status } = query as any;
    const where: any = { agencyId: params.id, deletedAt: null };
    if (status) where.status = status;
    const agents = await prisma.agent.findMany({
      where,
      orderBy: { createdAt: "desc" },
    });
    return { data: agents };
  })

  // GET /agencies/:id/stats
  .get("/:id/stats", async ({ params }) => {
    const [agentCount, activeAgents] = await Promise.all([
      prisma.agent.count({ where: { agencyId: params.id, deletedAt: null } }),
      prisma.agent.count({ where: { agencyId: params.id, status: "ACTIVE", deletedAt: null } }),
    ]);
    return {
      data: {
        totalAgents: agentCount,
        activeAgents,
        inactiveAgents: agentCount - activeAgents,
      },
    };
  })

  // GET /agencies/:id/listings
  .get("/:id/listings", async ({ params, query }) => {
    const { status, page = "1", limit = "20" } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    // Get agents of this agency then their assignments → listings
    const agents = await prisma.agent.findMany({
      where: { agencyId: params.id, deletedAt: null },
      select: { id: true },
    });
    const agentIds = agents.map((a) => a.id);
    const where: any = { agentUserId: { in: agentIds }, deletedAt: null };
    const assignments = await prisma.agentAssignment.findMany({
      where, skip, take: parseInt(limit),
      include: { listing: { include: { property: true } } },
      orderBy: { createdAt: "desc" },
    });
    return { data: assignments };
  });


// ══════════════════════════════════════════════════════════════════════════════
//  routes/included-services.ts — IncludedService CRUD
//  Eklenecek router.ts'e: import { includedServiceRoutes } from "./routes/included-services";
//  + .use(includedServiceRoutes)
// ══════════════════════════════════════════════════════════════════════════════
export const includedServiceRoutes = new Elysia({ prefix: "/included-services" })
  .use(authMiddleware)

  // GET /included-services?propertyId=&orgId=&listingId=
  .get("/", async ({ query }) => {
    const { orgId, propertyId, listingId, category, page = "1", limit = "50" } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (propertyId) where.propertyId = propertyId;
    if (listingId) where.listingId = listingId;
    if (category) where.category = category;
    const [data, total] = await Promise.all([
      prisma.includedService.findMany({ where, skip, take: parseInt(limit), orderBy: { createdAt: "desc" } }),
      prisma.includedService.count({ where }),
    ]);
    return { data, total };
  })

  // POST /included-services
  .post("/", async ({ body, userId, set }) => {
    const service = await prisma.includedService.create({
      data: { createdById: userId, ...(body as any) },
    });
    set.status = 201;
    return { data: service };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      description: t.Optional(t.String()),
      category: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      listingId: t.Optional(t.String()),
      isDefault: t.Optional(t.Boolean()),
      iconUrl: t.Optional(t.String()),
    }),
  })

  // GET /included-services/:id
  .get("/:id", async ({ params, set }) => {
    const service = await prisma.includedService.findFirst({ where: { id: params.id, deletedAt: null } });
    if (!service) { set.status = 404; return { error: "Hizmet bulunamadı" }; }
    return { data: service };
  })

  // PATCH /included-services/:id
  .patch("/:id", async ({ params, body }) => {
    const service = await prisma.includedService.update({ where: { id: params.id }, data: body as any });
    return { data: service };
  }, {
    body: t.Partial(t.Object({
      name: t.String(), description: t.String(), category: t.String(),
      isDefault: t.Boolean(), iconUrl: t.String(),
    })),
  })

  // DELETE /included-services/:id
  .delete("/:id", async ({ params }) => {
    await prisma.includedService.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
    return { message: "Hizmet silindi" };
  });


// ══════════════════════════════════════════════════════════════════════════════
//  routes/extra-charges.ts — ExtraCharge CRUD
//  Eklenecek router.ts'e: import { extraChargeRoutes } from "./routes/extra-charges";
//  + .use(extraChargeRoutes)
// ══════════════════════════════════════════════════════════════════════════════
export const extraChargeRoutes = new Elysia({ prefix: "/extra-charges" })
  .use(authMiddleware)

  // GET /extra-charges?reservationId=&orgId=
  .get("/", async ({ query }) => {
    const { orgId, reservationId, bookingId, page = "1", limit = "50" } = query as any;
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (reservationId) where.reservationId = reservationId;
    if (bookingId) where.bookingId = bookingId;
    const data = await prisma.extraCharge.findMany({ where, orderBy: { createdAt: "desc" } });
    return { data };
  })

  // POST /extra-charges
  .post("/", async ({ body, userId, set }) => {
    const charge = await prisma.extraCharge.create({
      data: { createdById: userId, ...(body as any) },
    });
    set.status = 201;
    return { data: charge };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      amount: t.Number(),
      currency: t.Optional(t.String()),
      chargeType: t.Optional(t.String()),  // e.g. CLEANING, DAMAGE, LATE_CHECKOUT
      reservationId: t.Optional(t.String()),
      bookingId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      isRefundable: t.Optional(t.Boolean()),
      notes: t.Optional(t.String()),
    }),
  })

  // PATCH /extra-charges/:id
  .patch("/:id", async ({ params, body }) => {
    const charge = await prisma.extraCharge.update({ where: { id: params.id }, data: body as any });
    return { data: charge };
  }, {
    body: t.Partial(t.Object({
      name: t.String(), amount: t.Number(), chargeType: t.String(),
      isRefundable: t.Boolean(), notes: t.String(), status: t.String(),
    })),
  })

  // DELETE /extra-charges/:id
  .delete("/:id", async ({ params }) => {
    await prisma.extraCharge.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
    return { message: "Ücret silindi" };
  });


// ══════════════════════════════════════════════════════════════════════════════
//  routes/tenants.ts — Tenant management
//  Eklenecek router.ts'e: import { tenantRoutes } from "./routes/tenants";
//  + .use(tenantRoutes) (Transactions bölümüne)
// ══════════════════════════════════════════════════════════════════════════════
export const tenantRoutes = new Elysia({ prefix: "/tenants" })
  .use(authMiddleware)

  // GET /tenants
  .get("/", async ({ query }) => {
    const { orgId, status, search, page = "1", limit = "20" } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (status) where.status = status;
    if (search) {
      where.OR = [
        { name: { contains: search, mode: "insensitive" } },
        { email: { contains: search, mode: "insensitive" } },
      ];
    }
    const [data, total] = await Promise.all([
      prisma.tenant.findMany({ where, skip, take: parseInt(limit), orderBy: { createdAt: "desc" } }),
      prisma.tenant.count({ where }),
    ]);
    return { data, total, page: parseInt(page), limit: parseInt(limit) };
  })

  // POST /tenants
  .post("/", async ({ body, set }) => {
    const tenant = await prisma.tenant.create({ data: body as any });
    set.status = 201;
    return { data: tenant };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      email: t.Optional(t.String()),
      phone: t.Optional(t.String()),
      nationalId: t.Optional(t.String()),
      userId: t.Optional(t.String()),
    }),
  })

  // GET /tenants/:id
  .get("/:id", async ({ params, set }) => {
    const tenant = await prisma.tenant.findFirst({
      where: { id: params.id, deletedAt: null },
    });
    if (!tenant) { set.status = 404; return { error: "Kiracı bulunamadı" }; }
    return { data: tenant };
  })

  // PATCH /tenants/:id
  .patch("/:id", async ({ params, body }) => {
    const tenant = await prisma.tenant.update({ where: { id: params.id }, data: body as any });
    return { data: tenant };
  }, {
    body: t.Partial(t.Object({
      name: t.String(), email: t.String(), phone: t.String(),
      nationalId: t.String(), status: t.String(),
    })),
  })

  // GET /tenants/:id/leases
  .get("/:id/leases", async ({ params }) => {
    const leases = await prisma.lease.findMany({
      where: { tenantId: params.id, deletedAt: null },
      orderBy: { startDate: "desc" },
      include: { property: true, rentSchedules: { take: 5, orderBy: { dueDate: "desc" } } },
    });
    return { data: leases };
  })

  // GET /tenants/:id/payments
  .get("/:id/payments", async ({ params, query }) => {
    const { page = "1", limit = "20" } = query as any;
    const skip = (parseInt(page) - 1) * parseInt(limit);
    const payments = await prisma.payment.findMany({
      where: { tenantId: params.id },
      orderBy: { createdAt: "desc" },
      skip, take: parseInt(limit),
    });
    return { data: payments };
  })

  // GET /tenants/:id/maintenance
  .get("/:id/maintenance", async ({ params }) => {
    const workOrders = await prisma.maintenanceWorkOrder.findMany({
      where: { reportedByUserId: params.id, deletedAt: null },
      orderBy: { createdAt: "desc" },
      include: { property: true },
    });
    return { data: workOrders };
  });


// ══════════════════════════════════════════════════════════════════════════════
//  routes/pricing-rules.ts — PricingRule & Discount CRUD
//  Eklenecek router.ts'e: import { pricingRuleRoutes } from "./routes/pricing-rules";
//  + .use(pricingRuleRoutes)
// ══════════════════════════════════════════════════════════════════════════════
export const pricingRuleRoutes = new Elysia({ prefix: "/pricing-rules" })
  .use(authMiddleware)

  // GET /pricing-rules?listingId=&orgId=
  .get("/", async ({ query }) => {
    const { orgId, listingId, propertyId, isActive } = query as any;
    const where: any = { deletedAt: null };
    if (orgId) where.orgId = orgId;
    if (listingId) where.listingId = listingId;
    if (propertyId) where.propertyId = propertyId;
    if (isActive !== undefined) where.isActive = isActive === "true";
    const data = await prisma.pricingRule.findMany({ where, orderBy: { createdAt: "desc" } });
    return { data };
  })

  // POST /pricing-rules
  .post("/", async ({ body, set }) => {
    const rule = await prisma.pricingRule.create({ data: body as any });
    set.status = 201;
    return { data: rule };
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      ruleType: t.String(),       // SEASONAL | WEEKEND | MIN_STAY | DISCOUNT | LAST_MINUTE
      listingId: t.Optional(t.String()),
      propertyId: t.Optional(t.String()),
      adjustmentType: t.String(), // PERCENT | FIXED
      adjustmentValue: t.Number(),
      minStayNights: t.Optional(t.Number()),
      startDate: t.Optional(t.String()),
      endDate: t.Optional(t.String()),
      daysOfWeek: t.Optional(t.Array(t.Number())),
      priority: t.Optional(t.Number()),
      isActive: t.Optional(t.Boolean()),
    }),
  })

  // PATCH /pricing-rules/:id
  .patch("/:id", async ({ params, body }) => {
    const rule = await prisma.pricingRule.update({ where: { id: params.id }, data: body as any });
    return { data: rule };
  }, {
    body: t.Partial(t.Object({
      name: t.String(), adjustmentValue: t.Number(), isActive: t.Boolean(),
      startDate: t.String(), endDate: t.String(), priority: t.Number(),
    })),
  })

  // DELETE /pricing-rules/:id
  .delete("/:id", async ({ params }) => {
    await prisma.pricingRule.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
    return { message: "Kural silindi" };
  });
