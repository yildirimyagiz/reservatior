import { BaseSaga } from './saga-orchestrator';
import { EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { hybridRentalEngine } from '../../services/intelligence/hybrid-rental-engine';

export interface HybridSagaData {
  step: string;
  propertyId: string;
  neighbourhood: string;
  ownerId?: string;
  partnerId?: string;
  score?: number;
  recommendedModel?: string;
  isLegalApproved?: boolean;
  contractId?: string;
  annualNetValueTRY?: number;
}

export class HybridRentalOnboardingSaga extends BaseSaga {
  public propertyId: string;
  public neighbourhood: string;
  public sagaData: HybridSagaData;

  constructor(propertyId: string, neighbourhood: string, sagaId?: string) {
    super(sagaId, { step: 'PROPERTY_HYBRID_EVALUATION_STARTED', propertyId, neighbourhood });
    this.propertyId = propertyId;
    this.neighbourhood = neighbourhood;
    this.sagaData = {
      step: 'PROPERTY_HYBRID_EVALUATION_STARTED',
      propertyId,
      neighbourhood
    };
  }

  // ── Compensation Rollback Logic ─────────────────────────────────────────
  protected async compensate(): Promise<void> {
    console.log(`[HybridRentalOnboardingSaga ${this.sagaId}] ⚠️ COMPENSATION TRIGGERED for Property ${this.propertyId}`);
    console.log(`[HybridRentalOnboardingSaga] Step 1: ContractCancelled for ${this.sagaData.contractId || 'PENDING'}`);
    console.log(`[HybridRentalOnboardingSaga] Step 2: PartnerAttributionReleased for Partner ${this.sagaData.partnerId || 'N/A'}`);
    console.log(`[HybridRentalOnboardingSaga] Step 3: CommissionReservationRemoved from FinanceOS Ledger`);
    
    eventBus.publish('hybrid.contract.cancelled', { propertyId: this.propertyId, reason: 'LEGAL_OR_OWNER_REJECTION' }, 'HybridRentalOS', this.sagaId);
    eventBus.publish('hybrid.partner.attribution.released', { propertyId: this.propertyId }, 'PartnerOS', this.sagaId);
    eventBus.publish('hybrid.commission.reservation.removed', { propertyId: this.propertyId }, 'FinanceOS', this.sagaId);
  }

  // ── Workflow Steps ──────────────────────────────────────────────────────
  public async startEvaluation(inputPayload: any) {
    console.log(`[HybridRentalOnboardingSaga ${this.sagaId}] Step 1: PropertyHybridEvaluationStarted for ${this.propertyId}`);
    await this.transition({ step: 'PROPERTY_HYBRID_EVALUATION_STARTED' });

    // Step 2: Run Evaluation Engine
    const evalResult = hybridRentalEngine.evaluateProperty({
      propertyId: this.propertyId,
      neighbourhood: this.neighbourhood,
      roomType: 'Entire home/apt',
      accommodates: inputPayload.accommodates || 4,
      bedrooms: inputPayload.bedrooms || 2,
      bathrooms: inputPayload.bathrooms || 1,
      sizeSqm: inputPayload.sizeSqm || 85,
      buildingAge: inputPayload.buildingAge || 5,
      isFurnished: true,
      hasElevator: true,
      hasParking: true,
      hasPoolOrGym: false,
      proximityToMetroMins: 5,
      proximityToAirportMins: 35,
      hasBuildingConsent100Pct: inputPayload.hasBuildingConsent100Pct ?? true,
      hasTourismResidenceLicense: inputPayload.hasTourismResidenceLicense ?? true,
      hasKabisRegistration: true
    });

    this.sagaData.score = evalResult.scoreBreakdown.totalScore;
    this.sagaData.recommendedModel = evalResult.recommendedModel;
    this.sagaData.isLegalApproved = evalResult.legalCompliance.isFullyCompliant;
    this.sagaData.annualNetValueTRY = evalResult.ownerOffer.hybridEstimatedAnnualRevenueTRY;

    // Step 2 Event: PropertyScoreGenerated
    eventBus.publish('hybrid.property.score.generated', {
      propertyId: this.propertyId,
      score: evalResult.scoreBreakdown.totalScore,
      breakdown: evalResult.scoreBreakdown
    }, 'HybridRentalOS', this.sagaId);

    // Step 3 Event: RentalModelRecommended
    eventBus.publish('hybrid.rental.model.recommended', {
      propertyId: this.propertyId,
      model: evalResult.recommendedModel,
      label: evalResult.recommendedModelLabel
    }, 'HybridRentalOS', this.sagaId);

    // Step 4: Legal Compliance Check
    if (!evalResult.legalCompliance.isFullyCompliant) {
      console.log(`[HybridRentalOnboardingSaga ${this.sagaId}] ❌ Legal Compliance Failed. Triggering Compensation!`);
      await this.triggerCompensation('7464 Sayılı Kanun Kat Malikleri Rıza Eksikliği');
      return;
    }

    eventBus.publish('hybrid.legal.compliance.approved', {
      propertyId: this.propertyId,
      status: evalResult.legalCompliance.law7464Status
    }, 'GovernanceOS', this.sagaId);

    // Step 5: Partner Attributed
    this.sagaData.partnerId = evalResult.partnerAttribution.primaryPartnerId;
    eventBus.publish('hybrid.partner.attributed', {
      propertyId: this.propertyId,
      partnerId: evalResult.partnerAttribution.primaryPartnerId,
      tier: evalResult.partnerAttribution.primaryPartnerTier
    }, 'PartnerOS', this.sagaId);

    // Step 6: Revenue Projection Created
    eventBus.publish('hybrid.revenue.projection.created', {
      propertyId: this.propertyId,
      grossAnnualRevenue: evalResult.reservatiorEconomics.expectedGrossAnnualRevenueTRY,
      netAnnualMargin: evalResult.reservatiorEconomics.netMarginAnnualTRY
    }, 'FinanceOS', this.sagaId);

    // Step 7: Owner Proposal Generated
    eventBus.publish('hybrid.owner.proposal.generated', {
      propertyId: this.propertyId,
      pitchHeadline: evalResult.aiProposalGenerator.ownerPitch.headline,
      estimatedAnnualRevenue: evalResult.ownerOffer.hybridEstimatedAnnualRevenueTRY
    }, 'AI-OS', this.sagaId);

    // Step 8: Simulate Owner Offer Accepted
    await this.onOwnerAccepted();
  }

  public async onOwnerAccepted() {
    console.log(`[HybridRentalOnboardingSaga ${this.sagaId}] Step 8: OwnerAcceptedOffer for ${this.propertyId}`);
    await this.transition({ step: 'OWNER_ACCEPTED_OFFER' });

    // Step 9: Contract Created
    this.sagaData.contractId = `CNT-HYBRID-${Math.floor(100000 + Math.random() * 900000)}`;
    eventBus.publish('hybrid.contract.created', {
      propertyId: this.propertyId,
      contractId: this.sagaData.contractId,
      annualRentGuaranteeTRY: this.sagaData.annualNetValueTRY
    }, 'ListingOS', this.sagaId);

    // Step 10: Operation Activated
    eventBus.publish('hybrid.property.operation.activated', {
      propertyId: this.propertyId,
      status: 'ACTIVE_HYBRID_RENTAL'
    }, 'OperationsOS', this.sagaId);

    // Step 11 & 12: Commission Split & Revenue Accrued
    eventBus.publish('hybrid.commission.split.created', {
      propertyId: this.propertyId,
      splitStatus: 'COMMISSION_COMMITTED'
    }, 'FinanceOS', this.sagaId);

    eventBus.publish('hybrid.partner.revenue.accrued', {
      propertyId: this.propertyId,
      partnerId: this.sagaData.partnerId
    }, 'PartnerOS', this.sagaId);

    console.log(`[HybridRentalOnboardingSaga ${this.sagaId}] ✅ SAGA WORKFLOW FULLY ACTIVATED AND COMPLETED!`);
    await this.complete();
  }
}

const activeSagas = new Map<string, HybridRentalOnboardingSaga>();

export function registerHybridRentalOnboardingListeners() {
  eventBus.subscribe('hybrid.evaluation.requested', (msg) => {
    const propertyId = msg.payload?.propertyId || `PROP-${Math.floor(10000 + Math.random() * 90000)}`;
    const neighbourhood = msg.payload?.neighbourhood || 'Beyoğlu';
    
    const saga = new HybridRentalOnboardingSaga(propertyId, neighbourhood, msg.correlationId);
    activeSagas.set(saga.sagaId, saga);
    saga.startEvaluation(msg.payload || {});
  });

  eventBus.subscribe('hybrid.compensation.requested', (msg) => {
    const saga = activeSagas.get(msg.correlationId || '');
    if (saga) {
      saga.triggerCompensation(msg.payload?.reason || 'User Manual Trigger');
    }
  });
}
