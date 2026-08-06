// =============================================================================
// GlobalHybridRentalOnboardingSaga
// Phase 3 — Global Saga Orchestrator with compensation mechanism
// Replaces single-country flow with 23-country aware pipeline
// =============================================================================

import { multiCountryIntelligenceEngine } from './multi-country-intelligence-engine';
import { hybridRentalEngine, PropertyInputData } from './hybrid-rental-engine';
import { revenueDAGEngine } from './revenue-dag-engine';
import { partnerRevenueEngine, PartnerRole, PartnerTier } from './partner-revenue-engine';
import { hybridRentalMultiAgentSwarm } from '../ai/hybrid-rental-multi-agent';

export type SagaStepStatus = 'PENDING' | 'RUNNING' | 'COMPLETED' | 'FAILED' | 'COMPENSATED';

export interface SagaStep {
  stepName: string;
  stepLabel: string;
  osModule: string;
  status: SagaStepStatus;
  startedAt?: string;
  completedAt?: string;
  data?: Record<string, unknown>;
  error?: string;
}

export interface SagaResult {
  sagaId: string;
  correlationId: string;
  countryCode: string;
  currency: string;
  propertyId: string;
  status: 'COMPLETED' | 'COMPENSATING' | 'FAILED' | 'RUNNING';
  steps: SagaStep[];
  evaluationResult?: Record<string, unknown>;
  dagResult?: Record<string, unknown>;
  swarmResult?: Record<string, unknown>;
  compensationReason?: string;
  startedAt: string;
  completedAt?: string;
}

// =============================================================================
// SAGA CLASS
// =============================================================================
export class GlobalHybridRentalOnboardingSaga {
  private static instance: GlobalHybridRentalOnboardingSaga;

  public static getInstance(): GlobalHybridRentalOnboardingSaga {
    if (!GlobalHybridRentalOnboardingSaga.instance) {
      GlobalHybridRentalOnboardingSaga.instance = new GlobalHybridRentalOnboardingSaga();
    }
    return GlobalHybridRentalOnboardingSaga.instance;
  }

  // ---------------------------------------------------------------------------
  // Main saga execution
  // ---------------------------------------------------------------------------
  public async execute(
    propertyInput: PropertyInputData & { grossRevenueLocal?: number },
    correlationId?: string
  ): Promise<SagaResult> {
    const sagaId = `GLOBAL-SAGA-${Math.floor(100000 + Math.random() * 900000)}`;
    const corrId = correlationId || `CORR-${Math.floor(100000 + Math.random() * 900000)}`;
    const startedAt = new Date().toISOString();
    const countryCode = (propertyInput.countryCode || 'TR').toUpperCase();
    const policy = multiCountryIntelligenceEngine.getCountryPolicy(countryCode);
    const currency = policy?.currency || 'TRY';
    const propertyId = propertyInput.propertyId || `PROP-${Math.floor(100000 + Math.random() * 900000)}`;

    // Build step definitions
    const steps: SagaStep[] = [
      { stepName: 'PropertyDetected',        stepLabel: 'Property Detected & Registered',         osModule: 'ListingOS',      status: 'PENDING' },
      { stepName: 'CountryComplianceChecked', stepLabel: 'Country Compliance Checked',              osModule: 'GovernanceOS',   status: 'PENDING' },
      { stepName: 'MarketOpportunityScored',  stepLabel: 'Market Opportunity Scored',               osModule: 'IntelligenceOS', status: 'PENDING' },
      { stepName: 'RentalModelSelected',      stepLabel: 'Rental Model Selected by AI Engine',      osModule: 'HybridRentalOS', status: 'PENDING' },
      { stepName: 'PartnerMatched',           stepLabel: 'Partner Matched & Commission Configured',  osModule: 'PartnerOS',      status: 'PENDING' },
      { stepName: 'OwnerProposalCreated',     stepLabel: 'Owner Proposal Package Generated',         osModule: 'AI-OS',          status: 'PENDING' },
      { stepName: 'ContractGenerated',        stepLabel: 'Contract Generated',                       osModule: 'LegalOS',        status: 'PENDING' },
      { stepName: 'OperationActivated',       stepLabel: 'Operations & Channels Activated',          osModule: 'OperationsOS',   status: 'PENDING' },
      { stepName: 'RevenueDAGStarted',        stepLabel: 'Revenue DAG Pipeline Started',             osModule: 'FinanceOS',      status: 'PENDING' },
      { stepName: 'GlobalLedgerCommitted',    stepLabel: 'Global Finance Ledger Committed',          osModule: 'FinanceOS',      status: 'PENDING' },
    ];

    const result: SagaResult = {
      sagaId,
      correlationId: corrId,
      countryCode,
      currency,
      propertyId,
      status: 'RUNNING',
      steps,
      startedAt,
    };

    try {
      // ── STEP 1: PropertyDetected ────────────────────────────────────────
      this.setStep(steps, 'PropertyDetected', 'RUNNING');
      await this.delay(10);
      this.setStep(steps, 'PropertyDetected', 'COMPLETED', {
        propertyId,
        countryCode,
        currency,
        registeredAt: new Date().toISOString(),
      });

      // ── STEP 2: CountryComplianceChecked ───────────────────────────────
      this.setStep(steps, 'CountryComplianceChecked', 'RUNNING');
      const complianceResult = multiCountryIntelligenceEngine.assessCompliance(
        countryCode,
        propertyInput.hasTourismResidenceLicense,
        propertyInput.hasKabisRegistration
      );
      await this.delay(10);

      if (!complianceResult.isCompliant && complianceResult.legalRiskScore > 80) {
        this.setStep(steps, 'CountryComplianceChecked', 'FAILED', undefined,
          `High legal risk (${complianceResult.legalRiskScore}/100): ${complianceResult.blockers.join(', ')}`);
        return this.compensate(result, `Compliance check failed: ${complianceResult.blockers[0]}`);
      }

      this.setStep(steps, 'CountryComplianceChecked', 'COMPLETED', {
        complianceScore: complianceResult.complianceScore,
        legalRiskScore: complianceResult.legalRiskScore,
        isCompliant: complianceResult.isCompliant,
        blockers: complianceResult.blockers,
        recommendations: complianceResult.recommendations,
      });

      // ── STEP 3: MarketOpportunityScored ────────────────────────────────
      this.setStep(steps, 'MarketOpportunityScored', 'RUNNING');
      const marketOpp = multiCountryIntelligenceEngine.getMarketOpportunity(countryCode);
      await this.delay(10);
      this.setStep(steps, 'MarketOpportunityScored', 'COMPLETED', {
        opportunity: marketOpp.opportunity,
        primaryModel: marketOpp.primaryModel,
        estimatedRevenueLiftPct: marketOpp.estimatedRevenueLiftPct,
        reasoning: marketOpp.reasoning,
      });

      // ── STEP 4: RentalModelSelected ────────────────────────────────────
      this.setStep(steps, 'RentalModelSelected', 'RUNNING');
      const evalResult = hybridRentalEngine.evaluateProperty({
        ...propertyInput,
        propertyId,
        countryCode,
      });
      await this.delay(10);

      if (evalResult.recommendedModel === 'REJECT') {
        this.setStep(steps, 'RentalModelSelected', 'FAILED', undefined,
          `Property rejected: ${evalResult.modelExplanation}`);
        return this.compensate(result, `Property score too low for ${countryCode} operations`);
      }

      this.setStep(steps, 'RentalModelSelected', 'COMPLETED', {
        recommendedModel: evalResult.recommendedModel,
        recommendedModelLabel: evalResult.recommendedModelLabel,
        totalScore: evalResult.scoreBreakdown.totalScore,
        countryComplianceScore: evalResult.countryComplianceScore,
        estimatedRevenueLift: evalResult.estimatedRevenueLift,
      });
      result.evaluationResult = evalResult as unknown as Record<string, unknown>;

      // ── STEP 5: PartnerMatched ──────────────────────────────────────────
      this.setStep(steps, 'PartnerMatched', 'RUNNING');
      const countryCommission = partnerRevenueEngine.calculateCountryCommission(
        propertyInput.primaryPartnerId || 'PARTNER-001',
        countryCode,
        propertyInput.grossRevenueLocal || evalResult.estimatedShortStayMonthlyRevenueTRY,
        (propertyInput.primaryPartnerRole as PartnerRole) || 'REAL_ESTATE_AGENT',
        'GOLD' as PartnerTier
      );
      await this.delay(10);
      this.setStep(steps, 'PartnerMatched', 'COMPLETED', {
        partnerId: countryCommission.partnerId,
        countryCode: countryCommission.countryCode,
        baseCommissionRate: countryCommission.baseCommissionRate,
        currency: countryCommission.currency,
      });

      // ── STEP 6: OwnerProposalCreated ───────────────────────────────────
      this.setStep(steps, 'OwnerProposalCreated', 'RUNNING');
      const swarmResult = hybridRentalMultiAgentSwarm.runSwarmAnalysis(
        { ...propertyInput, propertyId, countryCode },
        evalResult
      );
      await this.delay(10);
      this.setStep(steps, 'OwnerProposalCreated', 'COMPLETED', {
        swarmId: swarmResult.swarmId,
        consensusScore: swarmResult.consensusScore,
        agentCount: swarmResult.agents.length,
        finalStrategy: swarmResult.finalStrategy,
      });
      result.swarmResult = swarmResult as unknown as Record<string, unknown>;

      // ── STEP 7: ContractGenerated ──────────────────────────────────────
      this.setStep(steps, 'ContractGenerated', 'RUNNING');
      await this.delay(10);
      const contractType = evalResult.recommendedModel === 'MASTER_LEASE' || evalResult.recommendedModel === 'CORPORATE_MASTER_LEASE'
        ? 'MASTER_LEASE_AGREEMENT'
        : evalResult.recommendedModel === 'CORPORATE_HOUSING'
        ? 'CORPORATE_HOUSING_AGREEMENT'
        : 'REVENUE_SHARE_AGREEMENT';
      this.setStep(steps, 'ContractGenerated', 'COMPLETED', {
        contractType,
        contractId: `CONTRACT-${Math.floor(100000 + Math.random() * 900000)}`,
        governingLaw: policy?.contractRules || 'CIVIL_LAW',
        currency,
        generatedAt: new Date().toISOString(),
      });

      // ── STEP 8: OperationActivated ─────────────────────────────────────
      this.setStep(steps, 'OperationActivated', 'RUNNING');
      await this.delay(10);
      this.setStep(steps, 'OperationActivated', 'COMPLETED', {
        channels: ['AIRBNB', 'BOOKING_COM', 'DIRECT_WEB', 'CORPORATE_PORTAL'],
        activatedAt: new Date().toISOString(),
        countrySpecificPlatforms: countryCode === 'TR' ? ['SAHIBINDEN', 'EMLAKJET'] : ['LOCAL_OTA'],
      });

      // ── STEP 9: RevenueDAGStarted ──────────────────────────────────────
      this.setStep(steps, 'RevenueDAGStarted', 'RUNNING');
      const grossRevenueLocal = propertyInput.grossRevenueLocal || evalResult.estimatedShortStayMonthlyRevenueTRY;
      const dagResult = revenueDAGEngine.processGlobalRevenueDAG({
        propertyId,
        countryCode,
        grossRevenueLocal,
        ownerSharePct: 55,
        partnerCommissionRatePct: countryCommission.baseCommissionRate,
      });
      await this.delay(10);
      this.setStep(steps, 'RevenueDAGStarted', 'COMPLETED', {
        transactionId: dagResult.transactionId,
        grossRevenueLocal: dagResult.grossRevenueLocal,
        currency: dagResult.currency,
        totalTaxDeductedPct: dagResult.totalTaxDeductedPct,
        nodeCount: dagResult.dagNodes.length,
      });
      result.dagResult = dagResult as unknown as Record<string, unknown>;

      // ── STEP 10: GlobalLedgerCommitted ─────────────────────────────────
      this.setStep(steps, 'GlobalLedgerCommitted', 'RUNNING');
      await this.delay(10);
      this.setStep(steps, 'GlobalLedgerCommitted', 'COMPLETED', {
        ledgerCommitHash: dagResult.ledgerCommitHash,
        committedAt: new Date().toISOString(),
        prismaModels: ['Commission', 'Payout', 'EscrowSplitConfig', 'RevenueEvent'],
      });

      result.status = 'COMPLETED';
      result.completedAt = new Date().toISOString();
      return result;

    } catch (err: unknown) {
      const errMsg = err instanceof Error ? err.message : String(err);
      return this.compensate(result, `Unexpected error: ${errMsg}`);
    }
  }

  // ---------------------------------------------------------------------------
  // Compensation mechanism
  // ---------------------------------------------------------------------------
  private compensate(result: SagaResult, reason: string): SagaResult {
    result.status = 'COMPENSATING';
    result.compensationReason = reason;
    result.completedAt = new Date().toISOString();

    // Roll back completed steps in reverse
    for (let i = result.steps.length - 1; i >= 0; i--) {
      if (result.steps[i].status === 'COMPLETED') {
        result.steps[i].status = 'COMPENSATED';
      }
    }

    result.status = 'FAILED';
    return result;
  }

  private setStep(
    steps: SagaStep[],
    stepName: string,
    status: SagaStepStatus,
    data?: Record<string, unknown>,
    error?: string
  ) {
    const step = steps.find(s => s.stepName === stepName);
    if (step) {
      step.status = status;
      if (status === 'RUNNING') step.startedAt = new Date().toISOString();
      if (status === 'COMPLETED' || status === 'FAILED') step.completedAt = new Date().toISOString();
      if (data) step.data = data;
      if (error) step.error = error;
    }
  }

  private delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

export const globalHybridRentalSaga = GlobalHybridRentalOnboardingSaga.getInstance();
