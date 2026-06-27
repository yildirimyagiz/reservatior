const quoteStore = new Map<string, any>();

export const wiseService = {
  /**
   * Quote a transfer: USD -> TRY
   */
  async getQuote(amount: number, sourceCurrency = 'USD', targetCurrency = 'TRY') {
    const quoteId = `quote_${Math.random().toString(36).substring(7)}`;
    const quote = {
      id: quoteId,
      sourceAmount: amount,
      targetAmount: amount * 32.15, // Example mid-market rate
      fee: amount * 0.005, // 0.5% fee vs Stripe's 1.5-2.5%+
      rate: 32.15,
      deliveryEstimate: 'Same day',
      expiresAt: new Date(Date.now() + 30 * 60 * 1000).toISOString()
    };
    
    quoteStore.set(quoteId, quote);
    return quote;
  },

  /**
   * Execute Payout to Agent
   */
  async createPayoutToAgent(agentBankDetails: { iban: string, fullName: string }, amount: number, quoteId?: string) {
    // Process: Quote -> Recipient -> Transfer
    const quote = quoteId ? quoteStore.get(quoteId) : await this.getQuote(amount);
    
    console.log(`🚀 Executing Wise Payout via Founder Agents Program 🚀`);
    console.log(`→ Recipient: ${agentBankDetails.fullName}`);
    console.log(`→ IBAN: ${agentBankDetails.iban}`);
    console.log(`→ Amount: ${amount} USD (${quote.targetAmount} TRY)`);
    
    return {
      id: `wise_trx_${Date.now()}`,
      quoteId: quote.id,
      status: 'PROCESSING',
      recipient: agentBankDetails.fullName,
      payoutAmount: quote.targetAmount,
      currency: 'TRY',
      eta: new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString(),
      trackingUrl: `https://wise.com/track/TRX_${Date.now()}`
    };
  }
};
