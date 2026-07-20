import { Elysia, t } from "elysia";
import { maintenanceScheduleService } from "../services/maintenance-schedule-service";
import { vendorRatingService } from "../services/vendor-rating-service";
import { propertyInspectionService } from "../services/property-inspection-service";
import { cleaningScheduleService } from "../services/cleaning-schedule-service";
import { serviceProviderService } from "../services/service-provider-service";

export const operationsOSRoutes = new Elysia({ prefix: "/operations-os" })

  .get("/dashboard", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }

      const [overdueMaintenance, upcomingInspections, upcomingCleaning, topVendors] = await Promise.all([
        maintenanceScheduleService.getOverdue(orgId).catch(() => []),
        propertyInspectionService.getUpcoming(orgId).catch(() => []),
        cleaningScheduleService.getUpcoming(orgId).catch(() => []),
        vendorRatingService.getTopRated(orgId, 5).catch(() => []),
      ]);

      return {
        success: true,
        data: { overdueMaintenance, upcomingInspections, upcomingCleaning, topVendors },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Operations OS Dashboard", tags: ["Operations OS"] },
  })

  .get("/maintenance", async ({ query, set }) => {
    try {
      const { orgId, page, limit } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await maintenanceScheduleService.getByOrg(orgId, {
        skip: ((parseInt(page as string) || 1) - 1) * (parseInt(limit as string) || 20),
        take: parseInt(limit as string) || 20,
      });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
    }),
    detail: { summary: "List Maintenance Schedules", tags: ["Operations OS"] },
  })

  .post("/maintenance", async ({ body, set }) => {
    try {
      const data = await maintenanceScheduleService.create(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.String(),
      title: t.String(),
      description: t.Optional(t.String()),
      scheduledDate: t.Optional(t.String()),
      priority: t.Optional(t.String()),
      vendorId: t.Optional(t.String()),
    }),
    detail: { summary: "Create Maintenance Schedule", tags: ["Operations OS"] },
  })

  .get("/maintenance/:id", async ({ params, set }) => {
    try {
      const data = await maintenanceScheduleService.getById(params.id);
      if (!data) { set.status = 404; return { error: "Maintenance schedule not found" }; }
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    detail: { summary: "Get Maintenance Schedule", tags: ["Operations OS"] },
  })

  .post("/maintenance/:id/complete", async ({ params, body, set }) => {
    try {
      const data = await maintenanceScheduleService.completeMaintenance(params.id, body as any);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      cost: t.Optional(t.Number()),
      notes: t.Optional(t.String()),
    }),
    detail: { summary: "Complete Maintenance", tags: ["Operations OS"] },
  })

  .get("/maintenance/overdue", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await maintenanceScheduleService.getOverdue(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Overdue Maintenance", tags: ["Operations OS"] },
  })

  .get("/maintenance/property/:propertyId", async ({ params, set }) => {
    try {
      const data = await maintenanceScheduleService.getByProperty(params.propertyId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
    detail: { summary: "Get Maintenance by Property", tags: ["Operations OS"] },
  })

  .get("/vendor-ratings/:vendorId", async ({ params, set }) => {
    try {
      const data = await vendorRatingService.getRatings(params.vendorId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ vendorId: t.String() }),
    detail: { summary: "Get Vendor Rating Summary", tags: ["Operations OS"] },
  })

  .get("/vendor-ratings/:vendorId/list", async ({ params, set }) => {
    try {
      const data = await vendorRatingService.getByVendor(params.vendorId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ vendorId: t.String() }),
    detail: { summary: "List Vendor Ratings", tags: ["Operations OS"] },
  })

  .post("/vendor-ratings", async ({ body, set }) => {
    try {
      const data = await vendorRatingService.create(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      vendorId: t.String(),
      rating: t.Number(),
      review: t.Optional(t.String()),
      userId: t.Optional(t.String()),
    }),
    detail: { summary: "Rate a Vendor", tags: ["Operations OS"] },
  })

  .get("/inspections", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await propertyInspectionService.getByOrg(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Inspections", tags: ["Operations OS"] },
  })

  .get("/inspections/upcoming", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await propertyInspectionService.getUpcoming(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Upcoming Inspections", tags: ["Operations OS"] },
  })

  .post("/inspections", async ({ body, set }) => {
    try {
      const data = await propertyInspectionService.create(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.String(),
      inspectionType: t.String(),
      scheduledDate: t.Optional(t.String()),
      inspectorId: t.Optional(t.String()),
    }),
    detail: { summary: "Schedule Inspection", tags: ["Operations OS"] },
  })

  .post("/inspections/:id/complete", async ({ params, body, set }) => {
    try {
      const data = await propertyInspectionService.completeInspection(params.id, body as any);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: t.Object({
      result: t.Optional(t.String()),
      notes: t.Optional(t.String()),
    }),
    detail: { summary: "Complete Inspection", tags: ["Operations OS"] },
  })

  .get("/cleaning", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await cleaningScheduleService.getByOrg(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "List Cleaning Schedules", tags: ["Operations OS"] },
  })

  .get("/cleaning/upcoming", async ({ query, set }) => {
    try {
      const { orgId } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await cleaningScheduleService.getUpcoming(orgId);
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({ orgId: t.String() }),
    detail: { summary: "Get Upcoming Cleanings", tags: ["Operations OS"] },
  })

  .post("/cleaning", async ({ body, set }) => {
    try {
      const data = await cleaningScheduleService.create(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.String(),
      scheduledDate: t.Optional(t.String()),
      cleanerId: t.Optional(t.String()),
      notes: t.Optional(t.String()),
    }),
    detail: { summary: "Schedule Cleaning", tags: ["Operations OS"] },
  })

  .get("/service-providers", async ({ query, set }) => {
    try {
      const { orgId, category } = query;
      if (!orgId) { set.status = 400; return { error: "orgId is required" }; }
      const data = await serviceProviderService.getByOrg(orgId, { category: category as string });
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    query: t.Object({
      orgId: t.String(),
      category: t.Optional(t.String()),
    }),
    detail: { summary: "List Service Providers", tags: ["Operations OS"] },
  })

  .post("/service-providers", async ({ body, set }) => {
    try {
      const data = await serviceProviderService.register(body as any);
      set.status = 201;
      return { success: true, data };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      name: t.String(),
      category: t.String(),
      phone: t.Optional(t.String()),
      email: t.Optional(t.String()),
      rating: t.Optional(t.Number()),
    }),
    detail: { summary: "Register Service Provider", tags: ["Operations OS"] },
  });
