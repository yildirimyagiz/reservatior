import Elysia, { t } from "elysia";
import { prisma as db } from "../lib/prisma";

export const commissionPolicyRoutes = new Elysia({ prefix: "/api/commission-policy" })

  .get(
    "/policies/:orgId/:countryCode",
    async ({ params, set }) => {
      try {
        const [commissionPolicy, settlementPolicy, pricingPolicy] = await Promise.all([
          db.commissionPolicy.findMany({
            where: { orgId: params.orgId, countryCode: params.countryCode, isActive: true, deletedAt: null },
            orderBy: { effectiveFrom: "desc" },
            take: 1,
          }),
          db.settlementPolicy.findMany({
            where: { orgId: params.orgId, countryCode: params.countryCode, isActive: true, deletedAt: null },
            orderBy: { effectiveFrom: "desc" },
            take: 1,
          }),
          db.pricingPolicy.findMany({
            where: { orgId: params.orgId, countryCode: params.countryCode, isActive: true, deletedAt: null },
            orderBy: { effectiveFrom: "desc" },
            take: 1,
          }),
        ]);

        return {
          success: true,
          data: {
            commissionPolicy: commissionPolicy[0] || null,
            settlementPolicy: settlementPolicy[0] || null,
            pricingPolicy: pricingPolicy[0] || null,
          },
        };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ orgId: t.String(), countryCode: t.String() }),
      detail: { summary: "Get active policies for org+cou ntry", tags: ["Commission Policy"] },
    }
  )

  .post(
    "/commission-policy",
    async ({ body, set }) => {
      try {
        const policy = await db.commissionPolicy.create({
          data: {
            orgId: body.orgId,
            countryCode: body.countryCode,
            agentType: body.agentType,
            platformRate: body.platformRate,
            partnerRate: body.partnerRate,
            settlementTiming: body.settlementTiming,
            maxInstallments: body.maxInstallments,
            defaultInstallments: body.defaultInstallments,
            installmentInterest: body.installmentInterest,
            minCommission: body.minCommission,
            maxCommission: body.maxCommission,
            requiresApproval: body.requiresApproval,
            approvalThreshold: body.approvalThreshold,
            isActive: body.isActive,
            effectiveFrom: body.effectiveFrom ? new Date(body.effectiveFrom) : new Date(),
            effectiveUntil: body.effectiveUntil ? new Date(body.effectiveUntil) : null,
          },
        });
        return { success: true, data: policy };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        orgId: t.String(),
        countryCode: t.String(),
        agentType: t.Optional(t.String()),
        platformRate: t.Number(),
        partnerRate: t.Number(),
        settlementTiming: t.String(),
        maxInstallments: t.Integer(),
        defaultInstallments: t.Integer(),
        installmentInterest: t.Number(),
        minCommission: t.Optional(t.Number()),
        maxCommission: t.Optional(t.Number()),
        requiresApproval: t.Boolean(),
        approvalThreshold: t.Optional(t.Number()),
        isActive: t.Boolean(),
        effectiveFrom: t.Optional(t.String()),
        effectiveUntil: t.Optional(t.String()),
      }),
      detail: { summary: "Create commission policy", tags: ["Commission Policy"] },
    }
  )

  .put(
    "/commission-policy/:id",
    async ({ params, body, set }) => {
      try {
        const policy = await db.commissionPolicy.update({
          where: { id: params.id },
          data: body,
        });
        return { success: true, data: policy };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ id: t.String() }),
      body: t.Partial(
        t.Object({
          platformRate: t.Number(),
          partnerRate: t.Number(),
          settlementTiming: t.String(),
          maxInstallments: t.Integer(),
          defaultInstallments: t.Integer(),
          installmentInterest: t.Number(),
          isActive: t.Boolean(),
          effectiveUntil: t.Optional(t.String()),
        })
      ),
      detail: { summary: "Update commission policy", tags: ["Commission Policy"] },
    }
  )

  .post(
    "/settlement-policy",
    async ({ body, set }) => {
      try {
        const policy = await db.settlementPolicy.create({
          data: {
            orgId: body.orgId,
            name: body.name,
            countryCode: body.countryCode,
            settlementType: body.settlementType,
            upfrontPercent: body.upfrontPercent,
            installmentCount: body.installmentCount,
            installmentFrequency: body.installmentFrequency,
            interestRate: body.interestRate,
            earlySettlementDiscount: body.earlySettlementDiscount,
            earlySettlementDays: body.earlySettlementDays,
            latePenaltyRate: body.latePenaltyRate,
            lateGraceDays: body.lateGraceDays,
            minCommissionAmount: body.minCommissionAmount,
            minInstallmentAmount: body.minInstallmentAmount,
            isActive: body.isActive,
            effectiveFrom: body.effectiveFrom ? new Date(body.effectiveFrom) : new Date(),
            effectiveUntil: body.effectiveUntil ? new Date(body.effectiveUntil) : null,
          },
        });
        return { success: true, data: policy };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        orgId: t.String(),
        name: t.String(),
        countryCode: t.String(),
        settlementType: t.String(),
        upfrontPercent: t.Number(),
        installmentCount: t.Integer(),
        installmentFrequency: t.String(),
        interestRate: t.Number(),
        earlySettlementDiscount: t.Number(),
        earlySettlementDays: t.Integer(),
        latePenaltyRate: t.Number(),
        lateGraceDays: t.Integer(),
        minCommissionAmount: t.Optional(t.Number()),
        minInstallmentAmount: t.Optional(t.Number()),
        isActive: t.Boolean(),
        effectiveFrom: t.Optional(t.String()),
        effectiveUntil: t.Optional(t.String()),
      }),
      detail: { summary: "Create settlement policy", tags: ["Commission Policy"] },
    }
  )

  .post(
    "/pricing-policy",
    async ({ body, set }) => {
      try {
        const policy = await db.pricingPolicy.create({
          data: {
            orgId: body.orgId,
            name: body.name,
            countryCode: body.countryCode,
            maxDiscountPct: body.maxDiscountPct,
            minPriceFloor: body.minPriceFloor,
            strategy: body.strategy,
            minAdjustmentPct: body.minAdjustmentPct,
            maxAdjustmentPct: body.maxAdjustmentPct,
            adjustmentFrequency: body.adjustmentFrequency,
            highSeasonMultiplier: body.highSeasonMultiplier,
            lowSeasonMultiplier: body.lowSeasonMultiplier,
            aiOptimizationEnabled: body.aiOptimizationEnabled,
            minConfidenceThreshold: body.minConfidenceThreshold,
            isActive: body.isActive,
            effectiveFrom: body.effectiveFrom ? new Date(body.effectiveFrom) : new Date(),
            effectiveUntil: body.effectiveUntil ? new Date(body.effectiveUntil) : null,
          },
        });
        return { success: true, data: policy };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        orgId: t.String(),
        name: t.String(),
        countryCode: t.String(),
        maxDiscountPct: t.Number(),
        minPriceFloor: t.Optional(t.Number()),
        strategy: t.String(),
        minAdjustmentPct: t.Number(),
        maxAdjustmentPct: t.Number(),
        adjustmentFrequency: t.String(),
        highSeasonMultiplier: t.Number(),
        lowSeasonMultiplier: t.Number(),
        aiOptimizationEnabled: t.Boolean(),
        minConfidenceThreshold: t.Optional(t.Number()),
        isActive: t.Boolean(),
        effectiveFrom: t.Optional(t.String()),
        effectiveUntil: t.Optional(t.String()),
      }),
      detail: { summary: "Create pricing policy", tags: ["Commission Policy"] },
    }
  )

  .get(
    "/list/:orgId",
    async ({ params, set }) => {
      try {
        const [commissionPolicies, settlementPolicies, pricingPolicies] = await Promise.all([
          db.commissionPolicy.findMany({ where: { orgId: params.orgId, deletedAt: null }, orderBy: { createdAt: "desc" } }),
          db.settlementPolicy.findMany({ where: { orgId: params.orgId, deletedAt: null }, orderBy: { createdAt: "desc" } }),
          db.pricingPolicy.findMany({ where: { orgId: params.orgId, deletedAt: null }, orderBy: { createdAt: "desc" } }),
        ]);
        return {
          success: true,
          data: { commissionPolicies, settlementPolicies, pricingPolicies },
        };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ orgId: t.String() }),
      detail: { summary: "List all policies for org", tags: ["Commission Policy"] },
    }
  )

  .delete(
    "/:id",
    async ({ params, set }) => {
      try {
        await db.commissionPolicy.update({ where: { id: params.id }, data: { deletedAt: new Date() } });
        await db.settlementPolicy.update({ where: { id: params.id }, data: { deletedAt: new Date() } }).catch(() => {});
        await db.pricingPolicy.update({ where: { id: params.id }, data: { deletedAt: new Date() } }).catch(() => {});
        return { success: true };
      } catch (error: any) {
        set.status = 400;
        return { success: false, error: error.message };
      }
    },
    {
      params: t.Object({ id: t.String() }),
      detail: { summary: "Soft-delete policy by ID", tags: ["Commission Policy"] },
    }
  );
