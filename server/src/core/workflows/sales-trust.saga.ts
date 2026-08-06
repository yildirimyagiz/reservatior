/**
 * Saga: Sales Trust Pipeline
 * 
 * Flow:
 *   sales.offer.submitted
 *       |
 *   [Buyer Trust Verification]
 *       |
 *   buyer.trust.verified
 *       |
 *   [Seller Trust Verification]
 *       |
 *   seller.trust.verified
 *       |
 *   [Property Trust Verification]
 *       |
 *   property.trust.verified
 *       |
 *   [Transaction Trust Assessment]
 *       |
 *   transaction.trust.assessed
 *       |
 *   sales.trust.approved
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext } from '../events/domain-events';
import { tenantTrustScoreService } from '../../services/trust/tenant-trust-score.service';
import { landlordTrustScoreService } from '../../services/trust/landlord-trust-score.service';
import { propertyTrustScoreService } from '../../services/trust/property-trust-score.service';
import { transactionTrustScoreService } from '../../services/trust/transaction-trust-score.service';
import { trustGraphService } from '../../services/trust/trust-graph.service';

export class SalesTrustSaga extends BaseSaga {
  public salesId: string;
  public buyerId: string;
  public sellerId: string;
  public propertyId: string;

  constructor(
    salesId: string,
    buyerId: string,
    sellerId: string,
    propertyId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(
      sagaId,
      { step: 'OFFER_SUBMITTED', salesId, buyerId, sellerId, propertyId },
      localization
    );
    this.salesId = salesId;
    this.buyerId = buyerId;
    this.sellerId = sellerId;
    this.propertyId = propertyId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[SalesTrustSaga] Compensating sales trust ${this.salesId}. Rolling back...`);
    await super.compensate();
  }

  public async onOfferSubmitted() {
    console.log(`[SalesTrustSaga] Offer ${this.salesId} submitted. Verifying buyer trust...`);
    await this.transition({ step: 'VERIFYING_BUYER_TRUST' });
  }

  public async onBuyerTrustVerified() {
    console.log(`[SalesTrustSaga] Buyer ${this.buyerId} trust verified. Verifying seller trust...`);
    await this.transition({ step: 'VERIFYING_SELLER_TRUST' });
  }

  public async onSellerTrustVerified() {
    console.log(`[SalesTrustSaga] Seller ${this.sellerId} trust verified. Verifying property trust...`);
    await this.transition({ step: 'VERIFYING_PROPERTY_TRUST' });
  }

  public async onPropertyTrustVerified() {
    console.log(`[SalesTrustSaga] Property ${this.propertyId} trust verified. Assessing transaction trust...`);
    await this.transition({ step: 'ASSESSING_TRANSACTION_TRUST' });
  }

  public async onTransactionTrustAssessed() {
    console.log(`[SalesTrustSaga] Transaction trust assessed. Creating trust graph edges...`);
    await this.transition({ step: 'CREATING_TRUST_GRAPH' });
  }

  public async onTrustGraphCreated() {
    console.log(`[SalesTrustSaga] Trust graph created. Sales trust approved.`);
    await this.transition({ step: 'TRUST_APPROVED' });
  }

  private async verifyBuyerTrust() {
    try {
      const buyerProfile = await tenantTrustScoreService.calculateTrustScore(this.buyerId);
      
      if (buyerProfile.overallScore < 50) {
        throw new Error(`Buyer trust score too low: ${buyerProfile.overallScore}`);
      }

      await trustGraphService.createNode('TENANT', this.buyerId, { trustScore: buyerProfile.overallScore });

      await this.onBuyerTrustVerified();
    } catch (error) {
      console.error(`[SalesTrustSaga] Buyer trust verification failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async verifySellerTrust() {
    try {
      const sellerProfile = await landlordTrustScoreService.calculateTrustScore(this.sellerId);
      
      if (sellerProfile.overallScore < 50) {
        throw new Error(`Seller trust score too low: ${sellerProfile.overallScore}`);
      }

      await trustGraphService.createNode('LANDLORD', this.sellerId, { trustScore: sellerProfile.overallScore });

      await this.onSellerTrustVerified();
    } catch (error) {
      console.error(`[SalesTrustSaga] Seller trust verification failed:`, error);
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
      console.error(`[SalesTrustSaga] Property trust verification failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async assessTransactionTrust() {
    try {
      const transactionProfile = await transactionTrustScoreService.calculateTrustScore(this.salesId, 'SALES');
      
      if (transactionProfile.overallScore < 50) {
        throw new Error(`Transaction trust score too low: ${transactionProfile.overallScore}`);
      }

      await trustGraphService.createNode('TRANSACTION', this.salesId, { trustScore: transactionProfile.overallScore });

      await this.onTransactionTrustAssessed();
    } catch (error) {
      console.error(`[SalesTrustSaga] Transaction trust assessment failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async createTrustGraph() {
    try {
      await trustGraphService.createEdge('TENANT', this.buyerId, 'PROPERTY', this.propertyId, 'BUYER_INTERESTED_PROPERTY', {}, 0.7);
      await trustGraphService.createEdge('LANDLORD', this.sellerId, 'PROPERTY', this.propertyId, 'SELLER_OWNS_PROPERTY', {}, 0.9);
      await trustGraphService.createEdge('TENANT', this.buyerId, 'LANDLORD', this.sellerId, 'BUYER_NEGOTIATING_SELLER', {}, 0.6);
      
      await this.onTrustGraphCreated();
    } catch (error) {
      console.error(`[SalesTrustSaga] Trust graph creation failed:`, error);
      await this.compensate();
      throw error;
    }
  }

  private async publishTrustApproved() {
    console.log(`[SalesTrustSaga] Sales trust approved for ${this.salesId}`);
  }
}
