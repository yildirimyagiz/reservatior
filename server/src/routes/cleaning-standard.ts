import { Elysia, t } from "elysia";
import { CleaningVerifier } from "../services/cleaning-verifier";
import { InspectionReporter } from "../services/inspection-reporter";
import { CompensationEngine } from "../services/compensation-engine";
import { prisma } from "../lib/prisma";

export const cleaningStandardRoutes = new Elysia({ prefix: "/cleaning-standard" })

  .post("/verify", async ({ body, set }) => {
    try {
      const { orgId, propertyId, bookingId, photos } = body as any;
      if (!orgId || !propertyId || !photos?.length) {
        set.status = 400;
        return { error: "orgId, propertyId, and photos array required" };
      }
      const result = await CleaningVerifier.analyzePhotos(orgId, propertyId, bookingId, photos);
      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.String(),
      bookingId: t.Optional(t.String()),
      photos: t.Array(t.Object({
        checkpoint: t.String(),
        base64: t.String(),
      })),
    }),
  })

  .get("/last-inspection/:propertyId", async ({ params, set }) => {
    try {
      const record = await CleaningVerifier.getLastInspection(params.propertyId);
      if (!record) {
        set.status = 404;
        return { error: "No inspection found" };
      }
      return { success: true, data: record };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    params: t.Object({ propertyId: t.String() }),
  })

  .post("/inspection", async ({ body, set }) => {
    try {
      const report = await InspectionReporter.submitReport(body as any);
      return { success: true, data: report };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      propertyId: t.String(),
      agentId: t.String(),
      items: t.Array(t.Object({
        id: t.String(),
        label: t.String(),
        result: t.Union([t.Literal("pass"), t.Literal("fail")]),
        notes: t.String(),
      })),
      location: t.Object({ lat: t.Number(), lng: t.Number() }),
      score: t.Number(),
    }),
  })

  .get("/inspections/:orgId", async ({ params }) => {
    const reports = await InspectionReporter.getRecentInspections(params.orgId);
    return { success: true, data: reports };
  }, {
    params: t.Object({ orgId: t.String() }),
  })

  .post("/compensation", async ({ body, set }) => {
    try {
      const result = await CompensationEngine.processIssue(body as any);
      return { success: true, data: result };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      orgId: t.String(),
      bookingId: t.String(),
      propertyId: t.String(),
      issueType: t.String(),
      description: t.String(),
      reportedBy: t.String(),
    }),
  })

  .get("/compensation/:orgId", async ({ params }) => {
    const history = await CompensationEngine.getCompensationHistory(params.orgId);
    return { success: true, data: history };
  }, {
    params: t.Object({ orgId: t.String() }),
  })

  .post("/smartlock/gate", async ({ body, set }) => {
    try {
      const { bookingId, orgId, propertyId } = body as any;

      const lastCleaning = await prisma.propertyCompliance.findFirst({
        where: { propertyId, type: "CLEANING", status: "passed" },
        orderBy: { createdAt: "desc" },
      });

      if (!lastCleaning) {
        set.status = 403;
        return {
          success: false,
          gateOpen: false,
          error: "Cleaning verification required before access code generation",
        };
      }

      const accessCode = await prisma.accessCode.create({
        data: {
          orgId,
          smartLockId: propertyId,
          reservationId: bookingId,
          code: Math.random().toString(36).slice(2, 8).toUpperCase(),
          name: "Guest Access",
          status: "ACTIVE",
          startsAt: new Date(),
          endsAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
        },
      });

      return {
        success: true,
        gateOpen: true,
        data: {
          accessCode: accessCode.code,
          cleaningPassedAt: lastCleaning.createdAt,
          cleaningScore: (lastCleaning.data as any)?.analysis?.overall_score || 100,
        },
      };
    } catch (error: any) {
      set.status = 500;
      return { success: false, error: error.message };
    }
  }, {
    body: t.Object({
      bookingId: t.String(),
      orgId: t.String(),
      propertyId: t.String(),
    }),
  });
