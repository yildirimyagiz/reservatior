import { stripeService } from './stripe';
import { payTRService } from './paytr';
import { OpenBankingService, PaymentMethodType, PaymentDiscountOptions } from './openbanking';

export class PaymentGatewayRouter {
  
  /**
   * Routes the payment request to the appropriate gateway (Stripe, PayTR, OpenBanking)
   * based on currency, region, and user choice.
   */
  static async routePayment({
    amount,
    currency,
    countryCode,
    metadata,
    successUrl,
    cancelUrl,
    customerEmail,
    paymentMethod = PaymentMethodType.CREDIT_CARD
  }: {
    amount: number;
    currency: string;
    countryCode: string;
    metadata: any;
    successUrl: string;
    cancelUrl: string;
    customerEmail?: string;
    paymentMethod?: PaymentMethodType;
  }) {
    
    // 1. Open Banking Transfer Route (Zero Commission, Primary Method)
    if (paymentMethod === PaymentMethodType.OPEN_BANKING_TRANSFER) {
      return await OpenBankingService.initiateSinglePayment({
        tenantId: metadata.userId || 'system',
        reservationId: metadata.reservationId || 'system',
        amount,
        currency,
        bankId: metadata.bankId || 'default-bank',
        redirectUrl: successUrl,
        reference: metadata.description || 'Payment'
      });
    }

    // 2. Credit Card Route (Fallback or explicitly requested)
    const curr = currency.toUpperCase();
    
    // Use PayTR for TRY (Turkish Lira) transactions using Blocked (Non-Commission) terms
    if (curr === 'TRY' || countryCode === 'TR') {
      return await payTRService.createCheckoutSession({
        amount,
        currency,
        successUrl,
        cancelUrl,
        metadata,
        customerEmail: customerEmail || 'customer@example.com'
      });
    } 
    
    // Use Stripe for EUR, USD, GBP (Fallback) - Passing the 3.5% fee to the buyer
    const stripeFeeMultiplier = 1.035; // 3.5% fee passed to buyer
    const amountWithFee = amount * stripeFeeMultiplier;
    
    return await stripeService.createCheckoutSession({
      amount: amountWithFee, // Buyer pays the fee
      currency,
      successUrl,
      cancelUrl,
      metadata: { ...metadata, feePassedToBuyer: true },
      customerEmail
    });
  }
}
