import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prisma } from "../lib/prisma";

export const hoaRoutes = new Elysia({ prefix: "/hoa" })
  .use(authMiddleware)

  // ── SharedAmenity ─────────────────────────────────────────────────────────────
  .get("/amenities", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, propertyId, type, search } = query as any;
      const skip = (parseInt(page) - 1) * parseInt(limit);
      const where: any = { deletedAt: null };
      if (orgId) where.orgId = orgId;
      if (propertyId) where.propertyId = propertyId;
      if (type) where.type = type;
      if (search) where.name = { contains: search, mode: "insensitive" };
      const [data, total] = await Promise.all([
        prisma.sharedAmenity.findMany({ where, skip, take: parseInt(limit), orderBy: { name: "asc" } }),
        prisma.sharedAmenity.count({ where }),
      ]);
      return { data, total, page: parseInt(page), limit: parseInt(limit) };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .post("/amenities", async ({ body, set }) => {
    try {
      const data = await prisma.sharedAmenity.create({ data: body as any });
      set.status = 201;
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.Optional(t.String()),
      name: t.String(),
      type: t.Optional(t.String()),
      description: t.Optional(t.String()),
      capacity: t.Optional(t.Number()),
      bookable: t.Optional(t.Boolean()),
      operatingHours: t.Optional(t.Any()),
    }),
  })
  .get("/amenities/:id", async ({ params, set }) => {
    try {
      const data = await prisma.sharedAmenity.findFirst({ where: { id: params.id } });
      if (!data) { set.status = 404; return { error: "Ortak alan bulunamadı" }; }
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .patch("/amenities/:id", async ({ params, body, set }) => {
    try {
      const data = await prisma.sharedAmenity.update({ where: { id: params.id }, data: body as any });
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, { body: t.Partial(t.Object({ name: t.String(), type: t.String(), description: t.String(), capacity: t.Number(), bookable: t.Boolean(), operatingHours: t.Any() })) })
  .delete("/amenities/:id", async ({ params, body, set }) => {
    try {
      await prisma.sharedAmenity.update({ where: { id: params.id }, data: body as any });
      return { message: "Ortak alan silindi" };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })

  // ── Facility ──────────────────────────────────────────────────────────────────
  .get("/facilities", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, propertyId, search } = query as any;
      const skip = (parseInt(page) - 1) * parseInt(limit);
      const where: any = { deletedAt: null };
      if (orgId) where.orgId = orgId;
      if (propertyId) where.propertyId = propertyId;
      if (search) where.name = { contains: search, mode: "insensitive" };
      const [data, total] = await Promise.all([
        prisma.facility.findMany({ where, skip, take: parseInt(limit), orderBy: { name: "asc" } }),
        prisma.facility.count({ where }),
      ]);
      return { data, total, page: parseInt(page), limit: parseInt(limit) };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .post("/facilities", async ({ body, set }) => {
    try {
      const data = await prisma.facility.create({ data: body as any });
      set.status = 201;
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.Optional(t.String()),
      name: t.String(),
      type: t.Optional(t.String()),
      floor: t.Optional(t.String()),
      area: t.Optional(t.Number()),
      status: t.Optional(t.String()),
    }),
  })
  .get("/facilities/:id", async ({ params, set }) => {
    try {
      const data = await prisma.facility.findFirst({
        where: { id: params.id, deletedAt: null },
        include: { facilityBlocks: { orderBy: { name: "asc" }, take: 10 } },
      });
      if (!data) { set.status = 404; return { error: "Tesis bulunamadı" }; }
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .patch("/facilities/:id", async ({ params, body, set }) => {
    try {
      const data = await prisma.facility.update({ where: { id: params.id }, data: body as any });
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, { body: t.Partial(t.Object({ name: t.String(), type: t.String(), status: t.String(), floor: t.String(), area: t.Number() })) })
  .delete("/facilities/:id", async ({ params, set }) => {
    try {
      await prisma.facility.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
      return { message: "Tesis silindi" };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })

  // ── FacilityBlock ─────────────────────────────────────────────────────────────
  .get("/facility-blocks", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, facilityId, startDate, endDate } = query as any;
      const skip = (parseInt(page) - 1) * parseInt(limit);
      const where: any = { deletedAt: null };
      if (orgId) where.orgId = orgId;
      if (facilityId) where.facilityId = facilityId;
      if (startDate || endDate) {
        where.startDate = {};
        if (startDate) where.startDate.gte = new Date(startDate);
        if (endDate) where.startDate.lte = new Date(endDate);
      }
      const [data, total] = await Promise.all([
        prisma.facilityBlock.findMany({
          where, skip, take: parseInt(limit),
          orderBy: { name: "asc" },
          include: { facility: true },
        }),
        prisma.facilityBlock.count({ where }),
      ]);
      return { data, total, page: parseInt(page), limit: parseInt(limit) };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .post("/facility-blocks", async ({ body, set }) => {
    try {
      const data = await prisma.facilityBlock.create({ data: body as any });
      set.status = 201;
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, {
    body: t.Object({
      orgId: t.String(),
      facilityId: t.String(),
      startDate: t.String(),
      endDate: t.String(),
      reason: t.Optional(t.String()),
      bookedBy: t.Optional(t.String()),
    }),
  })
  .get("/facility-blocks/:id", async ({ params, set }) => {
    try {
      const data = await prisma.facilityBlock.findFirst({
        where: { id: params.id },
        include: { facility: true },
      });
      if (!data) { set.status = 404; return { error: "Rezervasyon bulunamadı" }; }
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .delete("/facility-blocks/:id", async ({ params, body, set }) => {
    try {
      await prisma.facilityBlock.update({ where: { id: params.id }, data: body as any });
      return { message: "Rezervasyon iptal edildi" };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })

  // ── Increase (aidat artışı) ───────────────────────────────────────────────────
  .get("/increases", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, propertyId, type } = query as any;
      const skip = (parseInt(page) - 1) * parseInt(limit);
      const where: any = { deletedAt: null };
      if (orgId) where.orgId = orgId;
      if (propertyId) where.propertyId = propertyId;
      if (type) where.type = type;
      const [data, total] = await Promise.all([
        prisma.increase.findMany({ where, skip, take: parseInt(limit), orderBy: { effectiveDate: "desc" } }),
        prisma.increase.count({ where }),
      ]);
      return { data, total, page: parseInt(page), limit: parseInt(limit) };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .post("/increases", async ({ body, set }) => {
    try {
      const data = await prisma.increase.create({ data: body as any });
      set.status = 201;
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.Optional(t.String()),
      type: t.String(),
      percentage: t.Optional(t.Number()),
      fixedAmount: t.Optional(t.Number()),
      currency: t.Optional(t.String()),
      effectiveDate: t.String(),
      reason: t.Optional(t.String()),
    }),
  })
  .get("/increases/:id", async ({ params, set }) => {
    try {
      const data = await prisma.increase.findFirst({ where: { id: params.id, deletedAt: null } });
      if (!data) { set.status = 404; return { error: "Artış kaydı bulunamadı" }; }
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .patch("/increases/:id", async ({ params, body, set }) => {
    try {
      const data = await prisma.increase.update({ where: { id: params.id }, data: body as any });
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, { body: t.Partial(t.Object({ percentage: t.Number(), fixedAmount: t.Number(), effectiveDate: t.String(), reason: t.String() })) })
  .delete("/increases/:id", async ({ params, set }) => {
    try {
      await prisma.increase.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
      return { message: "Artış kaydı silindi" };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })

  // ── Discount ──────────────────────────────────────────────────────────────────
  .get("/discounts", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, active, search } = query as any;
      const skip = (parseInt(page) - 1) * parseInt(limit);
      const where: any = { deletedAt: null };
      if (orgId) where.orgId = orgId;
      if (active !== undefined) where.active = active === "true";
      if (search) where.code = { contains: search, mode: "insensitive" };
      const [data, total] = await Promise.all([
        prisma.discount.findMany({ where, skip, take: parseInt(limit), orderBy: { createdAt: "desc" } }),
        prisma.discount.count({ where }),
      ]);
      return { data, total, page: parseInt(page), limit: parseInt(limit) };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .post("/discounts", async ({ body, set }) => {
    try {
      const data = await prisma.discount.create({ data: body as any });
      set.status = 201;
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, {
    body: t.Object({
      orgId: t.String(),
      code: t.String(),
      type: t.String(),
      value: t.Number(),
      active: t.Optional(t.Boolean()),
      expiresAt: t.Optional(t.String()),
      maxUses: t.Optional(t.Number()),
      description: t.Optional(t.String()),
    }),
  })
  .get("/discounts/:id", async ({ params, set }) => {
    try {
      const data = await prisma.discount.findFirst({ where: { id: params.id, deletedAt: null } });
      if (!data) { set.status = 404; return { error: "İndirim bulunamadı" }; }
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .patch("/discounts/:id", async ({ params, body, set }) => {
    try {
      const data = await prisma.discount.update({ where: { id: params.id }, data: body as any });
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, { body: t.Partial(t.Object({ active: t.Boolean(), value: t.Number(), expiresAt: t.String(), maxUses: t.Number(), description: t.String() })) })
  .delete("/discounts/:id", async ({ params, set }) => {
    try {
      await prisma.discount.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
      return { message: "İndirim silindi" };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })

  // ── GiftCard ──────────────────────────────────────────────────────────────────
  .get("/gift-cards", async ({ query, set }) => {
    try {
      const { page = "1", limit = "20", orgId, status } = query as any;
      const skip = (parseInt(page) - 1) * parseInt(limit);
      const where: any = { deletedAt: null };
      if (orgId) where.orgId = orgId;
      if (status) where.status = status;
      const [data, total] = await Promise.all([
        prisma.giftCard.findMany({ where, skip, take: parseInt(limit), orderBy: { createdAt: "desc" } }),
        prisma.giftCard.count({ where }),
      ]);
      return { data, total, page: parseInt(page), limit: parseInt(limit) };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .post("/gift-cards", async ({ body, set }) => {
    try {
      const data = await prisma.giftCard.create({ data: body as any });
      set.status = 201;
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, {
    body: t.Object({
      orgId: t.String(),
      code: t.String(),
      balance: t.Number(),
      currency: t.Optional(t.String()),
      status: t.Optional(t.String()),
      expiresAt: t.Optional(t.String()),
      issuedToId: t.Optional(t.String()),
    }),
  })
  .get("/gift-cards/:id", async ({ params, set }) => {
    try {
      const data = await prisma.giftCard.findFirst({ where: { id: params.id } });
      if (!data) { set.status = 404; return { error: "Hediye kartı bulunamadı" }; }
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  })
  .patch("/gift-cards/:id", async ({ params, body, set }) => {
    try {
      const data = await prisma.giftCard.update({ where: { id: params.id }, data: { ...body } as any });
      return { data };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  }, { body: t.Partial(t.Object({ balance: t.Number(), status: t.String(), expiresAt: t.String() })) })
  .delete("/gift-cards/:id", async ({ params, body, set }) => {
    try {
      await prisma.giftCard.update({ where: { id: params.id }, data: body as any });
      return { message: "Hediye kartı silindi" };
    } catch (e: any) { set.status = 500; return { error: e.message ?? "Sunucu hatası" }; }
  });
