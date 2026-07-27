import { Elysia, t } from 'elysia';
import { prisma } from '../lib/prisma';

export const prospectIntelligenceRoutes = new Elysia({ prefix: '/prospect-intelligence' })
  .get('/stats', async ({ query }) => {
    const { orgId } = query as { orgId?: string };
    
    const [totalProspects, analyzedProspects, opportunityDistribution, urgencyDistribution, avgScores] = await Promise.all([
      prisma.propertyProspect.count(),
      prisma.propertyProspect.count({ where: { aiAnalyzed: true } }),
      prisma.propertyProspect.groupBy({
        by: ['opportunityTier'],
        _count: true,
      }),
      prisma.propertyProspect.groupBy({
        by: ['acquisitionUrgency'],
        _count: true,
      }),
      prisma.propertyProspect.aggregate({
        _avg: {
          acquisitionScore: true,
          valuationScore: true,
          ownerConfidence: true,
          marketOpportunityScore: true,
        },
      }),
    ]);
    
    const opportunityMap = {
      LOW_POTENTIAL: 0,
      MONITOR: 0,
      HIGH_POTENTIAL: 0,
      PREMIUM: 0,
    };
    
    opportunityDistribution.forEach(item => {
      opportunityMap[item.opportunityTier as keyof typeof opportunityMap] = item._count;
    });
    
    const urgencyMap = {
      LOW: 0,
      MEDIUM: 0,
      HIGH: 0,
      IMMEDIATE: 0,
    };
    
    urgencyDistribution.forEach(item => {
      urgencyMap[item.acquisitionUrgency as keyof typeof urgencyMap] = item._count;
    });
    
    return {
      totalProspects,
      analyzedProspects,
      opportunityDistribution: opportunityMap,
      urgencyDistribution: urgencyMap,
      avgAcquisitionScore: avgScores._avg.acquisitionScore || 0,
      avgValuationScore: avgScores._avg.valuationScore || 0,
      avgOwnerConfidence: avgScores._avg.ownerConfidence || 0,
      avgMarketOpportunityScore: avgScores._avg.marketOpportunityScore || 0,
    };
  })
  .get('/prospects', async ({ query }) => {
    const { opportunityTier, acquisitionUrgency, minScore } = query as {
      opportunityTier?: string;
      acquisitionUrgency?: string;
      minScore?: string;
    };
    
    const where: any = {};
    
    if (opportunityTier) {
      where.opportunityTier = opportunityTier;
    }
    
    if (acquisitionUrgency) {
      where.acquisitionUrgency = acquisitionUrgency;
    }
    
    if (minScore) {
      where.acquisitionScore = { gte: parseFloat(minScore) };
    }
    
    const prospects = await prisma.propertyProspect.findMany({
      where,
      orderBy: { overallPriority: 'desc' },
      take: 100,
    });
    
    return prospects;
  })
  .get('/prospects/:id', async ({ params }) => {
    const prospect = await prisma.propertyProspect.findUnique({
      where: { id: params.id },
      include: {
        property: true,
        ownerProfile: true,
        agentProfile: true,
        valuation: true,
        consent: true,
      },
    });
    
    return prospect;
  })
  .patch('/prospects/:id/score', async ({ params, body }) => {
    const { acquisitionScore, valuationScore, ownerConfidence, marketOpportunityScore } = body as {
      acquisitionScore?: number;
      valuationScore?: number;
      ownerConfidence?: number;
      marketOpportunityScore?: number;
    };
    
    const overallPriority = (
      (acquisitionScore || 0) * 0.4 +
      (valuationScore || 0) * 0.3 +
      (ownerConfidence || 0) * 0.2 +
      (marketOpportunityScore || 0) * 0.1
    );
    
    const prospect = await prisma.propertyProspect.update({
      where: { id: params.id },
      data: {
        acquisitionScore,
        valuationScore,
        ownerConfidence,
        marketOpportunityScore,
        overallPriority,
      },
    });
    
    return prospect;
  });
