import { Elysia, t } from 'elysia';
import { prisma } from '../lib/prisma';

export const b2bOnboardingRoutes = new Elysia({ prefix: '/b2b' })
  .get('/corporate-accounts', async ({ query }) => {
    const { orgId } = query as { orgId?: string };
    
    const accounts = await prisma.corporateAccount.findMany({
      where: orgId ? { organizationId: orgId } : undefined,
      include: {
        portfolioBatches: true,
        bulkInvitations: true,
        corporateProperties: true,
        aiPitchDecks: true,
      },
      orderBy: { createdAt: 'desc' },
    });
    
    return accounts;
  })
  .post('/corporate-accounts', async ({ body }) => {
    const account = await prisma.corporateAccount.create({
      data: body as any,
    });
    
    return account;
  })
  .patch('/corporate-accounts/:id', async ({ params, body }) => {
    const account = await prisma.corporateAccount.update({
      where: { id: params.id },
      data: body as any,
    });
    
    return account;
  })
  .post('/portfolio-batches/upload', async ({ body }) => {
    // This would handle file upload to S3 and create portfolio batch
    const batch = await prisma.portfolioBatch.create({
      data: {
        corporateAccountId: (body as any).corporateAccountId,
        batchName: (body as any).batchName || 'Bulk Import',
        batchType: 'bulk_import',
        status: 'PENDING',
        fileName: (body as any).fileName,
        fileSize: (body as any).fileSize,
        fileType: (body as any).fileType,
        totalRows: (body as any).totalRows || 0,
      },
    });
    
    return batch;
  })
  .get('/portfolio-batches', async ({ query }) => {
    const { corporateAccountId } = query as { corporateAccountId?: string };
    
    const batches = await prisma.portfolioBatch.findMany({
      where: corporateAccountId ? { corporateAccountId } : undefined,
      include: {
        corporateProperties: true,
      },
      orderBy: { createdAt: 'desc' },
    });
    
    return batches;
  })
  .get('/portfolio-batches/:id', async ({ params }) => {
    const batch = await prisma.portfolioBatch.findUnique({
      where: { id: params.id },
      include: {
        corporateProperties: true,
      },
    });
    
    return batch;
  })
  .post('/bulk-invitations', async ({ body }) => {
    const invitation = await prisma.bulkInvitation.create({
      data: {
        corporateAccountId: (body as any).corporateAccountId,
        invitedEmail: (body as any).invitedEmail,
        invitedName: (body as any).invitedName,
        role: (body as any).role || 'property_manager',
        magicLinkToken: crypto.randomUUID(),
        magicLinkExpiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000), // 7 days
        status: 'PENDING',
        invitationMessage: (body as any).invitationMessage,
        customWelcomeText: (body as any).customWelcomeText,
        seattlePilotCampaign: (body as any).seattlePilotCampaign || false,
        priorityAccess: (body as any).priorityAccess || false,
        expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      },
    });
    
    return invitation;
  })
  .get('/bulk-invitations', async ({ query }) => {
    const { corporateAccountId } = query as { corporateAccountId?: string };
    
    const invitations = await prisma.bulkInvitation.findMany({
      where: corporateAccountId ? { corporateAccountId } : undefined,
      orderBy: { sentAt: 'desc' },
    });
    
    return invitations;
  })
  .get('/magic-link/validate', async ({ query }) => {
    const { token } = query as { token?: string };
    
    if (!token) {
      return { valid: false };
    }
    
    const invitation = await prisma.bulkInvitation.findUnique({
      where: { magicLinkToken: token },
      include: {
        corporateAccount: {
          include: {
            organization: true,
          },
        },
      },
    });
    
    if (!invitation) {
      return { valid: false };
    }
    
    if (invitation.status !== 'PENDING' || new Date() > invitation.magicLinkExpiresAt) {
      return { valid: false };
    }
    
    return {
      valid: true,
      corporateAccount: invitation.corporateAccount,
    };
  })
  .get('/corporate-properties', async ({ query }) => {
    const { corporateAccountId } = query as { corporateAccountId?: string };
    
    const properties = await prisma.corporateProperty.findMany({
      where: corporateAccountId ? { corporateAccountId } : undefined,
      include: {
        property: true,
        portfolioBatch: true,
      },
      orderBy: { createdAt: 'desc' },
    });
    
    return properties;
  })
  .post('/ai-pitch-decks/generate', async ({ body }) => {
    // This would trigger AI generation of pitch deck
    const pitchDeck = await prisma.aIPitchDeck.create({
      data: {
        corporateAccountId: (body as any).corporateAccountId,
        deckName: (body as any).deckName || 'AI Generated Pitch Deck',
        deckType: (body as any).deckType || 'initial_onboarding',
        executiveSummary: 'Generated by AI',
        portfolioOverview: {},
        financialProjections: {},
        yieldAnalysis: {},
        marketComparison: {},
        status: 'draft',
        deliveryMethod: 'dashboard',
      },
    });
    
    return pitchDeck;
  })
  .get('/ai-pitch-decks', async ({ query }) => {
    const { corporateAccountId } = query as { corporateAccountId?: string };
    
    const pitchDecks = await prisma.aIPitchDeck.findMany({
      where: corporateAccountId ? { corporateAccountId } : undefined,
      orderBy: { generatedAt: 'desc' },
    });
    
    return pitchDecks;
  })
  .get('/corporate-tenant-matches', async ({ query }) => {
    const { corporateAccountId } = query as { corporateAccountId?: string };
    
    const matches = await prisma.corporateTenantMatch.findMany({
      where: corporateAccountId ? { corporateAccountId } : undefined,
      orderBy: { matchScore: 'desc' },
    });
    
    return matches;
  })
  .get('/seattle-pilot/stats', async () => {
    // Mock stats for Seattle pilot
    return {
      totalTargetedAccounts: 10,
      acceptedInvitations: 4,
      pendingInvitations: 6,
      totalPropertiesImported: 1250,
      estimatedRevenue: 4500000,
    };
  });
