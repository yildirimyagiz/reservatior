import Stripe from 'stripe';

const stripeSecretKey = process.env.STRIPE_SECRET_KEY || 'sk_test_51Px9zX2Lv1q6q1X1';
const stripe = new Stripe(stripeSecretKey, {
  apiVersion: '2025-01-27' as any,
});

export const stripeService = {
  createCheckoutSession: async ({
    amount,
    currency = 'try',
    successUrl,
    cancelUrl,
    metadata,
    customerEmail,
    mode = 'payment',
    priceId,
  }: {
    amount: number;
    currency?: string;
    successUrl: string;
    cancelUrl: string;
    metadata: any;
    customerEmail?: string;
    mode?: 'payment' | 'subscription';
    priceId?: string;
  }) => {
    if (mode === 'subscription' && priceId) {
      return await stripe.checkout.sessions.create({
        payment_method_types: ['card'],
        line_items: [
          {
            price: priceId,
            quantity: 1,
          },
        ],
        mode: 'subscription',
        success_url: successUrl,
        cancel_url: cancelUrl,
        metadata,
        customer_email: customerEmail,
      });
    }

    return await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: currency.toLowerCase(),
            product_data: {
              name: metadata.paymentType || 'Reservatior Payment',
              description: metadata.description || 'Payment for services on Reservatior',
            },
            unit_amount: Math.round(amount * 100),
          },
          quantity: 1,
        },
      ],
      mode: mode === 'subscription' ? 'subscription' : 'payment',
      success_url: successUrl,
      cancel_url: cancelUrl,
      metadata,
      customer_email: customerEmail,
    });
  },

  handleWebhook: async (payload: string, sig: string, webhookSecret: string) => {
    let event: Stripe.Event;

    try {
      event = stripe.webhooks.constructEvent(payload, sig, webhookSecret);
    } catch (err: any) {
      throw new Error(`Webhook Error: ${err.message}`);
    }

    return event;
  },
};
