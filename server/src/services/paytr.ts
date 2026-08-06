import crypto from 'crypto';

/**
 * PayTR Payment Gateway Service for Turkey transactions
 */
export const payTRService = {
  createCheckoutSession: async ({
    amount,
    currency = 'TRY',
    successUrl,
    cancelUrl,
    metadata,
    customerEmail,
  }: {
    amount: number;
    currency?: string;
    successUrl: string;
    cancelUrl: string;
    metadata: any;
    customerEmail: string;
  }) => {
    // In a real application, you would generate a token via PayTR API.
    // Example PayTR B2B API request:
    
    const merchantId = process.env.PAYTR_MERCHANT_ID || 'dummy_merchant_id';
    const merchantKey = process.env.PAYTR_MERCHANT_KEY || 'dummy_merchant_key';
    const merchantSalt = process.env.PAYTR_MERCHANT_SALT || 'dummy_merchant_salt';
    
    // Note: For Zero-Commission strategy, we use PayTR's 'Blocked' (Blokeli) B2B parameters
    // where the payout is delayed by 21 days but commission is reduced to 0%.
    const merchantOid = `res_${Date.now()}`;
    const paymentAmount = Math.round(amount * 100); // Kuruş/Cents
    const noInstallment = 1; // Blocked logic usually requires single payment or specific installment rules
    const maxInstallment = 1;
    
    // Hash generation
    const hashStr = merchantId + userIp + merchantOid + customerEmail + paymentAmount + merchantSalt;
    const token = crypto.createHmac('sha256', merchantKey).update(hashStr).digest('base64');
    
    // Return a mock response compatible with Stripe's session object for uniform processing
    return {
      id: `paytr_sess_${Date.now()}`,
      url: `https://www.paytr.com/odeme/guvenli/${token}`, // Simulated URL
      paymentGateway: 'PAYTR',
      metadata
    };
  }
};
