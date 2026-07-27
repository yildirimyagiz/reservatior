/**
 * Decision Engine API Routes
 * Phase 5 — Autonomous Decision Engine
 *
 * POST /decision/invoke        → Main decision dispatcher
 * POST /decision/investment     → Investment advice
 * POST /decision/pricing        → Pricing strategy
 * POST /decision/match          → Property + Agent smart match
 * POST /decision/portfolio      → Portfolio rebalance
 * GET  /decision/market-entry   → Market entry recommendation
 */

import { Elysia, t } from 'elysia';
import { decisionEngine } from '../decision/decision-engine';
import { randomUUID } from 'crypto';

export const decisionRoutes = new Elysia({ prefix: '/decision' })

  /**
   * Main dispatcher — routes to the correct engine based on type
   */
  .post('/invoke', async ({ body, set }) => {
    try {
      const requestId = randomUUID();
      const output = await decisionEngine.decide({
        requestId,
        type: body.type as any,
        context: body.context ?? {},
        constraints: body.constraints as any,
      });
      return { success: true, data: output };
    } catch (err: any) {
      set.status = 500;
      return { success: false, message: err.message };
    }
  }, {
    body: t.Object({
      type: t.String(),
      context: t.Optional(t.Object({
        userId: t.Optional(t.String()),
        agentId: t.Optional(t.String()),
        propertyId: t.Optional(t.String()),
        countryIsoCode: t.Optional(t.String()),
        citySlug: t.Optional(t.String()),
        portfolioId: t.Optional(t.String()),
      })),
      constraints: t.Optional(t.Object({
        budget: t.Optional(t.Object({
          min: t.Optional(t.Number()),
          max: t.Optional(t.Number()),
          currency: t.Optional(t.String()),
        })),
        timeline: t.Optional(t.Union([t.Literal('SHORT'), t.Literal('MEDIUM'), t.Literal('LONG')])),
        riskTolerance: t.Optional(t.String()),
        goal: t.Optional(t.String()),
        preferredPropertyTypes: t.Optional(t.Array(t.String())),
        preferredLocations: t.Optional(t.Array(t.String())),
      })),
    }),
    detail: {
      tags: ['Decision Engine'],
      summary: 'Invoke autonomous decision engine',
    },
  })

  /**
   * Investment advice shortcut
   */
  .post('/investment', async ({ body, set }) => {
    try {
      const output = await decisionEngine.decide({
        requestId: randomUUID(),
        type: 'INVESTMENT_ADVICE',
        context: {
          userId: body.userId,
          countryIsoCode: body.countryIsoCode,
          citySlug: body.citySlug,
        },
        constraints: {
          budget: body.budget,
          goal: body.goal as any,
          riskTolerance: body.riskTolerance as any,
          timeline: body.timeline as any,
        },
      });
      return { success: true, data: output };
    } catch (err: any) {
      set.status = 500;
      return { success: false, message: err.message };
    }
  }, {
    body: t.Object({
      userId: t.Optional(t.String()),
      countryIsoCode: t.Optional(t.String()),
      citySlug: t.Optional(t.String()),
      budget: t.Optional(t.Object({
        min: t.Optional(t.Number()),
        max: t.Optional(t.Number()),
        currency: t.Optional(t.String()),
      })),
      goal: t.Optional(t.String()),
      riskTolerance: t.Optional(t.String()),
      timeline: t.Optional(t.Union([t.Literal('SHORT'), t.Literal('MEDIUM'), t.Literal('LONG')])),
    }),
    detail: {
      tags: ['Decision Engine'],
      summary: 'Get investment advice',
    },
  })

  /**
   * Pricing strategy for a property
   */
  .post('/pricing', async ({ body, set }) => {
    try {
      const output = await decisionEngine.decide({
        requestId: randomUUID(),
        type: 'PRICING_STRATEGY',
        context: {
          propertyId: body.propertyId,
        },
      });
      return { success: true, data: output };
    } catch (err: any) {
      set.status = 500;
      return { success: false, message: err.message };
    }
  }, {
    body: t.Object({
      propertyId: t.String(),
    }),
    detail: {
      tags: ['Decision Engine'],
      summary: 'Get pricing strategy for a property',
    },
  })

  /**
   * Smart property + agent match
   */
  .post('/match', async ({ body, set }) => {
    try {
      const output = await decisionEngine.decide({
        requestId: randomUUID(),
        type: 'PROPERTY_MATCH',
        context: {
          userId: body.userId,
          countryIsoCode: body.countryIsoCode,
          citySlug: body.citySlug,
        },
        constraints: {
          budget: body.budget,
          preferredPropertyTypes: body.preferredPropertyTypes,
          riskTolerance: body.riskTolerance as any,
        },
      });
      return { success: true, data: output };
    } catch (err: any) {
      set.status = 500;
      return { success: false, message: err.message };
    }
  }, {
    body: t.Object({
      userId: t.Optional(t.String()),
      countryIsoCode: t.Optional(t.String()),
      citySlug: t.Optional(t.String()),
      budget: t.Optional(t.Object({
        min: t.Optional(t.Number()),
        max: t.Optional(t.Number()),
      })),
      preferredPropertyTypes: t.Optional(t.Array(t.String())),
      riskTolerance: t.Optional(t.String()),
    }),
    detail: {
      tags: ['Decision Engine'],
      summary: 'Smart property + agent matching',
    },
  })

  /**
   * Portfolio review & rebalance
   */
  .post('/portfolio', async ({ body, set }) => {
    try {
      const output = await decisionEngine.decide({
        requestId: randomUUID(),
        type: 'PORTFOLIO_REVIEW',
        context: {
          userId: body.userId,
          portfolioId: body.portfolioId,
        },
      });
      return { success: true, data: output };
    } catch (err: any) {
      set.status = 500;
      return { success: false, message: err.message };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      portfolioId: t.Optional(t.String()),
    }),
    detail: {
      tags: ['Decision Engine'],
      summary: 'Portfolio rebalance recommendation',
    },
  })

  /**
   * Market entry recommendation
   */
  .get('/market-entry', async ({ query, set }) => {
    try {
      const output = await decisionEngine.decide({
        requestId: randomUUID(),
        type: 'MARKET_ENTRY',
        context: {
          countryIsoCode: query.countryIsoCode,
          citySlug: query.citySlug,
          userId: query.userId,
        },
      });
      return { success: true, data: output };
    } catch (err: any) {
      set.status = 500;
      return { success: false, message: err.message };
    }
  }, {
    query: t.Object({
      countryIsoCode: t.String(),
      citySlug: t.String(),
      userId: t.Optional(t.String()),
    }),
    detail: {
      tags: ['Decision Engine'],
      summary: 'Market entry / exit recommendation',
    },
  });
