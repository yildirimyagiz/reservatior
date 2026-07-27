import { Elysia, t } from 'elysia';
import { prisma } from '../lib/prisma';

export const marketingOSRoutes = new Elysia({ prefix: '/marketing-os' })
  .get('/stats', async ({ query }) => {
    const { orgId } = query as { orgId?: string };
    
    const [totalRules, activeRules, pausedRules, aggregateStats] = await Promise.all([
      prisma.campaignAutomationRule.count(),
      prisma.campaignAutomationRule.count({ where: { status: 'ACTIVE' } }),
      prisma.campaignAutomationRule.count({ where: { status: 'PAUSED' } }),
      prisma.campaignAutomationRule.aggregate({
        _sum: {
          totalCampaignsGenerated: true,
          totalSpend: true,
          totalConversions: true,
        },
        _avg: {
          totalConversions: true,
        },
      }),
    ]);
    
    const totalCampaignsGenerated = aggregateStats._sum.totalCampaignsGenerated || 0;
    const totalSpend = aggregateStats._sum.totalSpend || 0;
    const totalConversions = aggregateStats._sum.totalConversions || 0;
    const avgConversionRate = totalCampaignsGenerated > 0 
      ? (totalConversions / totalCampaignsGenerated) * 100 
      : 0;
    const avgCostPerAcquisition = totalConversions > 0 
      ? totalSpend / totalConversions 
      : 0;
    
    return {
      totalRules,
      activeRules,
      pausedRules,
      totalCampaignsGenerated,
      totalSpend,
      totalConversions,
      avgConversionRate,
      avgCostPerAcquisition,
    };
  })
  .get('/rules', async ({ query }) => {
    const { status, triggerType } = query as {
      status?: string;
      triggerType?: string;
    };
    
    const where: any = {};
    
    if (status) {
      where.status = status;
    }
    
    if (triggerType) {
      where.triggerType = triggerType;
    }
    
    const rules = await prisma.campaignAutomationRule.findMany({
      where,
      orderBy: { lastExecutedAt: 'desc' },
      take: 100,
    });
    
    return rules;
  })
  .get('/rules/:id', async ({ params }) => {
    const rule = await prisma.campaignAutomationRule.findUnique({
      where: { id: params.id },
    });
    
    return rule;
  })
  .post('/rules', async ({ body }) => {
    const {
      orgId,
      name,
      description,
      triggerType,
      triggerConditions,
      targetEntityType,
      targetFilters,
      campaignType,
      campaignObjective,
      budget,
      duration,
      googleAdsEnabled,
      metaAdsEnabled,
      tiktokAdsEnabled,
      autoGenerateCreative,
      creativeTemplate,
      autoBuildAudience,
      audienceCriteria,
      executionDelay,
      executionFrequency,
      requireConsent,
      consentType,
      minConversionRate,
      maxCostPerAcquisition,
    } = body as any;
    
    const rule = await prisma.campaignAutomationRule.create({
      data: {
        orgId,
        name,
        description,
        triggerType,
        triggerConditions,
        targetEntityType,
        targetFilters,
        campaignType,
        campaignObjective,
        budget,
        duration,
        googleAdsEnabled: googleAdsEnabled || false,
        metaAdsEnabled: metaAdsEnabled || false,
        tiktokAdsEnabled: tiktokAdsEnabled || false,
        autoGenerateCreative: autoGenerateCreative || false,
        creativeTemplate,
        autoBuildAudience: autoBuildAudience || false,
        audienceCriteria,
        executionDelay,
        executionFrequency,
        requireConsent: requireConsent !== false,
        consentType,
        minConversionRate,
        maxCostPerAcquisition,
        status: 'ACTIVE',
      },
    });
    
    return rule;
  })
  .patch('/rules/:id', async ({ params, body }) => {
    const rule = await prisma.campaignAutomationRule.update({
      where: { id: params.id },
      data: body as any,
    });
    
    return rule;
  })
  .patch('/rules/:id/status', async ({ params, body }) => {
    const { status } = body as { status: string };
    
    const rule = await prisma.campaignAutomationRule.update({
      where: { id: params.id },
      data: { status },
    });
    
    return rule;
  });
