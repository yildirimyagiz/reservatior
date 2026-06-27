import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { reservationService } from "../services/reservation";
import { 
  ReservationPlainInputCreate, 
  ReservationPlainInputUpdate 
} from "../../generated/prismabox/Reservation";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";
import { MarketplaceEngine } from "../services/ai/marketplace-engine";
import { regionMiddleware } from "../middleware/region";

export const reservationRoutes = new Elysia({ prefix: "/reservation" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /reservation
   * Retrieves all Reservation with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return reservationService.withDB(db as any).getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /reservation
   * Creates a new Reservation.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await reservationService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: ReservationPlainInputCreate
  })

  /**
   * GET /reservation/:id
   * Retrieves a single Reservation by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await reservationService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Reservation not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const dbClient = db as any;
      const oldData = await reservationService.withDB(dbClient).getById(params.id);
      
      if (!oldData) {
        set.status = 404;
        return { error: "Reservation not found" };
      }

      // --- 1. POSTPONEMENT & AVAILABILITY LOGIC ---
      const isDateChange = 
        (body.checkInDate && new Date(body.checkInDate).getTime() !== new Date(oldData.checkInDate).getTime()) ||
        (body.checkOutDate && new Date(body.checkOutDate).getTime() !== new Date(oldData.checkOutDate).getTime());

      if (isDateChange) {
        // If dates change, we force HOST APPROVAL to prevent unapproved price hikes
        body.status = "PENDING_HOST_APPROVAL";
        
        // Audit log for postponement request
        await dbClient.auditLog.create({
          data: {
            action: "RESERVATION_POSTPONED",
            entityType: "Reservation",
            entityId: params.id,
            details: `Tenant requested date change to ${body.checkInDate} - ${body.checkOutDate}. Status set to PENDING_HOST_APPROVAL.`,
            orgId: oldData.orgId
          }
        });
      }

      const data = await reservationService.withDB(dbClient).update(params.id, body);

      // --- 2. CANCELLATION FAILOVER & ESCROW REFUND LOGIC ---
      if (data.status !== oldData.status && data.status === 'CANCELLED') {
        // Find alternative properties if it's a local property
        if (data.propertyId) {
          const property = await dbClient.property.findUnique({ where: { id: data.propertyId } });
          if (property) {
            const failover = await MarketplaceEngine.executeFailoverRouting(
              data.propertyId,
              property.city || "Unknown",
              Number(data.totalAmount)
            );

            // Audit log the failover triggering
            await dbClient.auditLog.create({
              data: {
                action: "FAILOVER_TRIGGERED",
                entityType: "Reservation",
                entityId: params.id,
                details: `Reservation cancelled. Failover AI found ${failover.alternatives.length} alternatives.`,
                orgId: oldData.orgId
              }
            });

            // Handle Escrow Refund 
            const escrow = await dbClient.escrowAccount.findUnique({ where: { reservationId: params.id } });
            if (escrow && escrow.status === 'FUNDED') {
              // We must refund the tenant due to commission differences
              await dbClient.escrowAccount.update({
                where: { id: escrow.id },
                data: { status: 'REFUNDED', releasedAt: new Date() }
              });

              await dbClient.auditLog.create({
                data: {
                  action: "ESCROW_REFUNDED",
                  entityType: "EscrowAccount",
                  entityId: escrow.id,
                  details: `Escrow amount ${escrow.totalAmount} refunded to tenant due to property cancellation/failover.`,
                  orgId: oldData.orgId
                }
              });
            }

            // Here we would typically attach the `failover.alternatives` to the response
            // so the frontend can display them immediately.
            (data as any).failoverAlternatives = failover.alternatives;
          }
        }
      }

      // --- ML Feedback Loops ---
      if (oldData && data.status !== oldData.status) {
        // 1. Local Properties (B2C)
        if (data.propertyId) {
          if (data.status === 'CANCELLED') {
            MLBridgeService.sendFeedback("pricing-bandit", "RESERVATION_CANCELLED", -1.0, { propertyId: data.propertyId }).catch(console.error);
            MLBridgeService.sendFeedback("rank-failover", "PROPERTY_ISSUE_SUSPECTED", -1.0, { propertyId: data.propertyId }).catch(console.error);
          } else if (data.status === 'CONFIRMED') {
            MLBridgeService.sendFeedback("pricing-bandit", "RESERVATION_CONFIRMED", +1.0, { propertyId: data.propertyId }).catch(console.error);
          }
        }
        
        // 2. B2B Hotel Demand
        if (data.hotelId) {
          if (data.status === 'CONFIRMED') {
            MLBridgeService.sendFeedback("b2b-demand-model", "HOTEL_BOOKED", +1.0, { hotelId: data.hotelId }).catch(console.error);
          } else if (data.status === 'CANCELLED') {
            MLBridgeService.sendFeedback("b2b-demand-model", "HOTEL_CANCELLED", -1.0, { hotelId: data.hotelId }).catch(console.error);
          }
        }
      }
      
      return { data };
    } catch (e: any) {
      set.status = 404;
      return { error: e.message || "Reservation not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: ReservationPlainInputUpdate
  })

  /**
   * DELETE /reservation/:id
   * Deletes a Reservation.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await reservationService.withDB(db as any).delete(params.id);
      return { success: true, message: "Reservation deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Reservation not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
