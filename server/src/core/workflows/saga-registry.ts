/**
 * Saga Registry
 * Central registration point for ALL sagas + startup recovery mechanism.
 *
 * Usage in index.ts:
 *   import { initAllSagas } from './core/workflows/saga-registry';
 *   await initAllSagas();
 *
 * Recovery:
 *   On startup, finds all SagaState rows with status=STARTED and logs them.
 *   Production-ready recovery hooks are provided but require per-saga
 *   resume implementations (see recoverSaga).
 */

import { prismaManager } from '../../lib/prisma';

// ── All saga registrations ─────────────────────────────────────────────────────
import { registerAgentOnboardingListeners }        from './agent-onboarding.saga';
import { registerAgentManagementListeners }        from './agent-management.saga';
import { registerListingPipelineListeners }        from './listing-pipeline.saga';
import { registerListingManagementListeners }      from './listing-management.saga';
import { registerCommissionPaymentListeners }      from './commission-payment.saga';
import { registerBookingPipelineListeners }        from './booking-pipeline.saga';
import { registerCRMLeadPipelineListeners }        from './crm-lead-pipeline.saga';
import { registerCRMLeadListeners }                from './crm-lead.saga';
import { registerFinancePipelineListeners }        from './finance-pipeline.saga';
import { registerInvestmentLifecycleListeners }    from './investment-lifecycle.saga';
import { registerInvestmentAnalysisListeners }     from './investment-analysis.saga';
import { registerTransactionListeners }            from './transaction.saga';
import { registerPropertyLifecycleListeners }      from './property-lifecycle.saga';
import { registerPropertyActivationListeners }     from './property-activation.saga';
import { registerPropertyIntelligenceListeners }   from './property-intelligence.saga';
import { registerTrustVerificationListeners }      from './trust-verification.saga';
import { registerSecurityIncidentListeners }       from './security-incident.saga';
import { registerSecurityScreeningListeners }      from './security-screening.saga';
import { registerLeadConversionListeners }         from './lead-conversion.saga';
import { registerDocumentManagementListeners }     from './document-management.saga';
import { registerDocumentComplianceListeners }     from './document-compliance.saga';
import { registerNotificationPipelineListeners }   from './notification-pipeline.saga';
import { registerNotificationOrchestrationListeners } from './notification-orchestration.saga';
import { registerGovernanceAuditListeners }        from './governance-audit.saga';
import { registerGovernanceComplianceListeners }   from './governance-compliance.saga';
import { registerIdentityManagementListeners }     from './identity-management.saga';
import { registerIdentitySecurityListeners }       from './identity-security.saga';
import { registerCommerceOrderListeners }          from './commerce-order.saga';
import { registerCommercePipelineListeners }       from './commerce-pipeline.saga';
import { registerAnalyticsPipelineListeners }      from './analytics-pipeline.saga';
import { registerAnalyticsInsightListeners }       from './analytics-insight.saga';
import { registerLocalizationPipelineListeners }   from './localization-pipeline.saga';
import { registerLocalizationSyncListeners }       from './localization-sync.saga';
import { registerMaintenanceOrchestrationListeners } from './maintenance-orchestration.saga';
import { registerOperationsWorkflowListeners }     from './operations-workflow.saga';
import { registerPlatformOperationsListeners }     from './platform-operations.saga';
import { registerPortfolioLifecycleListeners }     from './portfolio-lifecycle.saga';
import { registerPartnerOnboardingListeners }      from './partner-onboarding.saga';
import { registerDeveloperApiLifecycleListeners }  from './developer-api-lifecycle.saga';
import { registerAIPipelineListeners }             from './ai-pipeline.saga';
import { registerAdsCampaignListeners }            from './ads-campaign.saga';
import { registerAPIKeyLifecycleListeners }        from './api-key-lifecycle.saga';
import { registerUserLifecycleListeners }          from './user-lifecycle.saga';
import { registerUserAcquisitionListeners }        from './user-acquisition.saga';
import { registerIntelligenceFeedbackLoopListeners } from './intelligence-feedback-loop.saga';
import { registerIntelligencePipelineListeners }      from './intelligence-pipeline.saga';
import { registerDecisionExecutionListeners }         from './decision-execution.saga';
import { registerRevenueLifecycleListeners }          from './revenue-lifecycle.saga';
import { registerHybridRentalOnboardingListeners }   from './hybrid-rental-onboarding.saga';
import { registerInsurancePolicyListeners }          from './insurance-policy.saga';
import { registerInsuranceClaimsListeners }          from './insurance-claims.saga';
import { registerRentalFinancePaymentListeners }     from './rental-finance-payment.saga';
import { registerRentalFinanceRiskListeners }        from './rental-finance-risk.saga';

// ── Listeners listener (no BaseSaga) ──────────────────────────────────────────
import { registerAiMarketingListeners } from './listeners/ai-marketing.listener';

// ── Phase 7: Feedback & Revenue Agents ───────────────────────────────────────
import { feedbackIntelligenceAgent } from '../../intelligence/feedback-intelligence-agent';
import { revenueIntelligenceAgent }  from '../../intelligence/revenue-intelligence-agent';

// ─── Recovery ─────────────────────────────────────────────────────────────────

async function recoverIncompleteSagas(): Promise<void> {
  try {
    const prisma = prismaManager.getClient('US');

    const staleSagas = await prisma.sagaState.findMany({
      where: {
        status: { in: ['STARTED', 'COMPENSATING'] },
        updatedAt: { lt: new Date(Date.now() - 5 * 60 * 1000) }, // older than 5 minutes
      },
      orderBy: { createdAt: 'asc' },
    });

    if (staleSagas.length === 0) {
      console.log('[SagaRegistry] ✅ No stale sagas found — clean startup.');
      return;
    }

    console.warn(`[SagaRegistry] ⚠️  Found ${staleSagas.length} stale saga(s). Logging for operator review:`);

    // Group by type
    const byType: Record<string, typeof staleSagas> = {};
    for (const s of staleSagas) {
      if (!byType[s.sagaType]) byType[s.sagaType] = [];
      byType[s.sagaType].push(s);
    }

    for (const [type, sagas] of Object.entries(byType)) {
      console.warn(`  [${type}] ${sagas.length} stale — steps: ${sagas.map(s => s.currentStep).join(', ')}`);
    }

    // Mark as FAILED with recovery note so they don't linger
    await prisma.sagaState.updateMany({
      where: {
        status: { in: ['STARTED', 'COMPENSATING'] },
        updatedAt: { lt: new Date(Date.now() - 5 * 60 * 1000) },
      },
      data: {
        status: 'FAILED',
        currentStep: 'RECOVERED_AT_STARTUP',
      },
    });

    console.warn(`[SagaRegistry] ⚠️  ${staleSagas.length} stale saga(s) marked as FAILED. Manual retry may be required.`);
  } catch (err) {
    // Recovery must never crash the server
    console.error('[SagaRegistry] Recovery check failed (non-fatal):', err);
  }
}

// ─── Main Init ────────────────────────────────────────────────────────────────

export async function initAllSagas(): Promise<void> {
  console.log('[SagaRegistry] 🔄 Initializing all saga listeners…');

  // ── Property & Listing ────────────────────────────────────────────────────
  registerPropertyLifecycleListeners();
  registerPropertyActivationListeners();
  registerPropertyIntelligenceListeners();   // ← NEW: Phase 5 intelligence pipeline
  registerListingPipelineListeners();
  registerListingManagementListeners();
  registerHybridRentalOnboardingListeners(); // ← NEW: Hybrid Rental & Revenue OS Saga

  // ── Insurance OS ─────────────────────────────────────────────────────────
  registerInsurancePolicyListeners();        // ← NEW: Insurance OS Policy Lifecycle Saga
  registerInsuranceClaimsListeners();        // ← NEW: Insurance OS Claims Lifecycle Saga

  // ── Rental Finance OS ────────────────────────────────────────────────────
  registerRentalFinancePaymentListeners();   // ← NEW: Rental Finance OS Plan Activation Saga
  registerRentalFinanceRiskListeners();      // ← NEW: Rental Finance OS Late Payment Risk Saga

  // ── Agent ────────────────────────────────────────────────────────────────
  registerAgentOnboardingListeners();
  registerAgentManagementListeners();

  // ── Booking ──────────────────────────────────────────────────────────────
  registerBookingPipelineListeners();

  // ── Finance & Commission ──────────────────────────────────────────────────
  registerCommissionPaymentListeners();
  registerFinancePipelineListeners();
  registerTransactionListeners();

  // ── CRM & Leads ──────────────────────────────────────────────────────────
  registerCRMLeadPipelineListeners();
  registerCRMLeadListeners();
  registerLeadConversionListeners();

  // ── Investment ────────────────────────────────────────────────────────────
  registerInvestmentLifecycleListeners();
  registerInvestmentAnalysisListeners();
  registerPortfolioLifecycleListeners();

  // ── Trust & Security ──────────────────────────────────────────────────────
  registerTrustVerificationListeners();
  registerSecurityIncidentListeners();
  registerSecurityScreeningListeners();

  // ── Documents ────────────────────────────────────────────────────────────
  registerDocumentManagementListeners();
  registerDocumentComplianceListeners();

  // ── Notifications ────────────────────────────────────────────────────────
  registerNotificationPipelineListeners();
  registerNotificationOrchestrationListeners();

  // ── Governance ───────────────────────────────────────────────────────────
  registerGovernanceAuditListeners();
  registerGovernanceComplianceListeners();

  // ── Identity ─────────────────────────────────────────────────────────────
  registerIdentityManagementListeners();
  registerIdentitySecurityListeners();

  // ── Commerce ─────────────────────────────────────────────────────────────
  registerCommerceOrderListeners();
  registerCommercePipelineListeners();

  // ── Analytics ────────────────────────────────────────────────────────────
  registerAnalyticsPipelineListeners();
  registerAnalyticsInsightListeners();

  // ── Localization ──────────────────────────────────────────────────────────
  registerLocalizationPipelineListeners();
  registerLocalizationSyncListeners();

  // ── Operations ────────────────────────────────────────────────────────────
  registerMaintenanceOrchestrationListeners();
  registerOperationsWorkflowListeners();
  registerPlatformOperationsListeners();

  // ── Partner & Developer ───────────────────────────────────────────────────
  registerPartnerOnboardingListeners();
  registerDeveloperApiLifecycleListeners();

  // ── AI & Ads ─────────────────────────────────────────────────────────────
  registerAIPipelineListeners();
  registerAdsCampaignListeners();
  registerAiMarketingListeners();

  // ── API Keys ─────────────────────────────────────────────────────────────
  registerAPIKeyLifecycleListeners();

  // ── Users ─────────────────────────────────────────────────────────────────
  registerUserLifecycleListeners();
  registerUserAcquisitionListeners();

  // ── Phase 7: Intelligence Feedback Loop ───────────────────────────────────────
  registerIntelligenceFeedbackLoopListeners();
  feedbackIntelligenceAgent.start();
  revenueIntelligenceAgent.start();

  // ── Phase 8: Enterprise Sagas ──────────────────────────────────────────────
  registerIntelligencePipelineListeners();
  registerDecisionExecutionListeners();
  registerRevenueLifecycleListeners();

  console.log('[SagaRegistry] ✅ All saga listeners registered (52 sagas) + Phase 7 agents.');

  // ── Startup Recovery ──────────────────────────────────────────────────────
  await recoverIncompleteSagas();
}
