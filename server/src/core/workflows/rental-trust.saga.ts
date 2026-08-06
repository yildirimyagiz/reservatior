/**
 * Saga: Rental Trust Pipeline
 * 
 * Flow:
 *   rental.application.submitted
 *       |
 *   [Tenant Trust Verification]
 *       |
 *   tenant.trust.verified
 *       |
 *   [Landlord Trust Verification]
 *       |
 *   landlord.trust.verified
 *       |
 *   [Property Trust Verification]
 *       |
 *   property.trust.verified
 *       |
 *   [Transaction Trust Assessment]
 *       |
 *   transaction.trust.assessed
 *       |
 *   rental.trust.approved
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';
import { tenantTrustScoreService } from '../../services/trust/tenant-trust-score.service';
import { landlordTrustScoreService } from '../../services/trust/landlord-trust-score.service';
import { propertyTrustScoreService } from '../../services/trust/property-trust-score.service';
import { transactionTrustScoreService } from '../../services/trust/transaction-trust-score.service';
import { trustGraphService } from '../../services/trust/trust-graph.service';

export class RentalTrustSaga extends BaseSaga {
  public rentalId: string;
  public tenantId: string;
  public landlordId: string;
  public propertyId: string;

  constructor(
    rentalId: string,
    tenantId: string,
    landlordId: string,
    propertyId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(
      sagaId,
      { step: 'APPLICATION_SUBMITTED', rentalId, tenantId, landlordId, propertyId },
      localization
    );
    this.rentalId = rentalId;
    this.tenantId = tenantId;
    this.landlordId = landlordId;
    this.propertyId = propertyId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[RentalTrustSaga] Compensating rental trust ${this.rentalId}. Rolling back...`);
    await super.compensate();
  }

  public async onApplicationSubmitted() {
    console.log(`[RentalTrustSaga] Application ${this.rentalId} submitted. Verifying tenant trust...`);
    await this.transition({ step: 'VERIFYING_TENANT_TRUST' });
  }

  public async onTenantTrustVerified() {
    console.log(`[RentalTrustSaga] Tenant ${this.tenantId} trust verified. Verifying landlord trust...`);
    await this.transition({ step: 'VERIFYING_LANDLORD_TRUST' });
  }

  public async onLandlordTrustVerified() {
    console.log(`[RentalTrustSaga] Landlord ${this.landlordId} trust verified. Verifying property trust...`);
    await this.transition({ step: 'VERIFYING_PROPERTY_TRUST' });
  }

  public async onPropertyTrustVerified() {
    console.log(`[RentalTrustSaga] Property ${this.propertyId} trust verified. Assessing transaction trust...`);
    await this.transition({ step: 'ASSESSING_TRANSACTION_TRUST' });
  }

  public async onTransactionTrustAssessed() {
    console.log(`[RentalTrustSaga] Transaction trust assessed. Creating trust graph edges...`);
    await this.transition({ step: 'CREATING_TRUST_GRAPH' });
  }

  public async onTrustGraphCreated() {
    console.log(`[RentalTrustSaga] Trust graph created. Rental trust approved.`);
    await this.transition({ step: 'TRUST_APPROVED' });
  }


  private async verifyTenantTrust() {
    try {
      const tenantProfile = await tenantTrustScoreService.calculateTrustScore(this.tenantId);
      
      if (tenantProfile.overallScore < 50) {
        throw new Error(`Tenant trust score too low: ${tenantProfile.overallScore}`);
      }

      await trustGraphService.createNode('TENANT', this.tenantId, { trustScore: tenantProfile.overallScore });

      await this.onTenantTrustVerified();
    } catch (error) {
      console.error(`[RentalTrustSaga] Tenant trust verification failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async verifyLandlordTrust() {
    try {
      const landlordProfile = await landlordTrustScoreService.calculateTrustScore(this.landlordId);
      
      if (landlordProfile.overallScore < 50) {
        throw new Error(`Landlord trust score too low: ${landlordProfile.overallScore}`);
      }

      await trustGraphService.createNode('LANDLORD', this.landlordId, { trustScore: landlordProfile.overallScore });

      await this.onLandlordTrustVerified();
    } catch (error) {
      console.error(`[RentalTrustSaga] Landlord trust verification failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async verifyPropertyTrust() {
    try {
      const propertyProfile = await propertyTrustScoreService.calculateTrustScore(this.propertyId);
      
      if (propertyProfile.overallScore < 50) {
        throw new Error(`Property trust score too low: ${propertyProfile.overallScore}`);
      }

      await trustGraphService.createNode('PROPERTY', this.propertyId, { trustScore: propertyProfile.overallScore });

      await this.onPropertyTrustVerified();
    } catch (error) {
      console.error(`[RentalTrustSaga] Property trust verification failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async assessTransactionTrust() {
    try {
      const transactionProfile = await transactionTrustScoreService.calculateTrustScore(this.rentalId, 'RENTAL');
      
      if (transactionProfile.overallScore < 50) {
        throw new Error(`Transaction trust score too low: ${transactionProfile.overallScore}`);
      }

      await trustGraphService.createNode('TRANSACTION', this.rentalId, { trustScore: transactionProfile.overallScore });

      await this.onTransactionTrustAssessed();
    } catch (error) {
      console.error(`[RentalTrustSaga] Transaction trust assessment failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async createTrustGraph() {
    try {
      await trustGraphService.createEdge('TENANT', this.tenantId, 'PROPERTY', this.propertyId, 'TENANT_RENTED_PROPERTY', {}, 0.8);
      await trustGraphService.createEdge('LANDLORD', this.landlordId, 'PROPERTY', this.propertyId, 'LANDLORD_OWNS_PROPERTY', {}, 0.9);
      await trustGraphService.createEdge('TENANT', this.tenantId, 'LANDLORD', this.landlordId, 'TENANT_PAID_LANDLORD', {}, 0.7);
      
      await this.onTrustGraphCreated();
    } catch (error) {
      console.error(`[RentalTrustSaga] Trust graph creation failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async publishTrustApproved() {
    console.log(`[RentalTrustSaga] Rental trust approved for ${this.rentalId}`);
  }
}
