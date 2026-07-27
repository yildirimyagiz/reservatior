import { Elysia, t } from 'elysia';
import { prisma } from '../lib/prisma';

export const consentOSRoutes = new Elysia({ prefix: '/consent-os' })
  .get('/stats', async ({ query }) => {
    const { orgId } = query as { orgId?: string };
    
    const [totalConsents, activeConsents, revokedConsents, pendingConsents, byEntityType, byChannel, complianceStats] = await Promise.all([
      prisma.consent.count(),
      prisma.consent.count({ where: { status: 'ACTIVE' } }),
      prisma.consent.count({ where: { status: 'REVOKED' } }),
      prisma.consent.count({ where: { status: 'PENDING' } }),
      prisma.consent.groupBy({
        by: ['entityType'],
        _count: true,
      }),
      prisma.consent.groupBy({
        by: ['consentChannel'],
        _count: true,
      }),
      prisma.consent.aggregate({
        _count: {
          gdprConsent: true,
          ccpaOptOut: true,
          kvkkConsent: true,
        },
        where: {
          gdprConsent: true,
        },
      }),
    ]);
    
    const entityMap = {
      USER: 0,
      PROPERTY_PROSPECT: 0,
      OWNER_PROFILE: 0,
      AGENT_PROFILE: 0,
      PROPERTY: 0,
      ORGANIZATION: 0,
    };
    
    byEntityType.forEach((item: any) => {
      entityMap[item.entityType as keyof typeof entityMap] = item._count;
    });
    
    const channelMap = {
      email: 0,
      sms: 0,
      whatsapp: 0,
      ads: 0,
      aiCommunication: 0,
    };
    
    byChannel.forEach((item: any) => {
      const channel = item.consentChannel.toLowerCase();
      if (channel in channelMap) {
        channelMap[channel as keyof typeof channelMap] = item._count;
      }
    });
    
    return {
      totalConsents,
      activeConsents,
      revokedConsents,
      pendingConsents,
      byEntityType: entityMap,
      byChannel: channelMap,
      gdprCompliant: complianceStats._count.gdprConsent || 0,
      ccpaOptOut: await prisma.consent.count({ where: { ccpaOptOut: true } }),
      kvkkCompliant: await prisma.consent.count({ where: { kvkkConsent: true } }),
    };
  })
  .get('/consents', async ({ query }) => {
    const { entityType, status, channel } = query as {
      entityType?: string;
      status?: string;
      channel?: string;
    };
    
    const where: any = {};
    
    if (entityType) {
      where.entityType = entityType;
    }
    
    if (status) {
      where.status = status;
    }
    
    if (channel) {
      where.consentChannel = channel;
    }
    
    const consents = await prisma.consent.findMany({
      where,
      orderBy: { grantedAt: 'desc' },
      take: 100,
    });
    
    return consents;
  })
  .get('/consents/:id', async ({ params }) => {
    const consent = await prisma.consent.findUnique({
      where: { id: params.id },
      include: {
        user: true,
        propertyProspect: true,
        ownerProfile: true,
        agentProfile: true,
      },
    });
    
    return consent;
  })
  .post('/consents', async ({ body }) => {
    const {
      entityId,
      entityType,
      consentType,
      consentPurpose,
      consentChannel,
      consentMethod,
      gdprConsent,
      ccpaOptOut,
      kvkkConsent,
      emailConsent,
      phoneConsent,
      smsConsent,
      whatsappConsent,
      adsConsent,
      aiCommunicationConsent,
    } = body as any;
    
    const consent = await prisma.consent.create({
      data: {
        entityId,
        entityType,
        consentType,
        consentPurpose,
        consentChannel,
        consentMethod,
        gdprConsent: gdprConsent || false,
        ccpaOptOut: ccpaOptOut || false,
        kvkkConsent: kvkkConsent || false,
        emailConsent: emailConsent || false,
        phoneConsent: phoneConsent || false,
        smsConsent: smsConsent || false,
        whatsappConsent: whatsappConsent || false,
        adsConsent: adsConsent || false,
        aiCommunicationConsent: aiCommunicationConsent || false,
        status: 'ACTIVE',
      },
    });
    
    return consent;
  })
  .patch('/consents/:id/revoke', async ({ params, body }) => {
    const { revocationReason, revocationMethod } = body as {
      revocationReason?: string;
      revocationMethod?: string;
    };
    
    const consent = await prisma.consent.update({
      where: { id: params.id },
      data: {
        status: 'REVOKED',
        revokedAt: new Date(),
        revocationReason,
        revocationMethod,
      },
    });
    
    return consent;
  });
