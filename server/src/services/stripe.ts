import Stripe from 'stripe';

// Secret removed from source (audit §6.H.30): a literal test key was committed
// here. The Stripe client is now created lazily and only from the environment,
// so the app never constructs a client with a fake key.
const stripeSecretKey = process.env.STRIPE_SECRET_KEY;

function getStripe(): Stripe {
  if (!stripeSecretKey) {
    throw new Error("STRIPE_SECRET_KEY is not configured. Stripe is unavailable.");
  }
  return new Stripe(stripeSecretKey, {
    apiVersion: '2025-01-27' as any,
  });
}

export const stripeService = {
  createCheckoutSession: async ({
    amount,
    currency = 'try',
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
    customerEmail?: string;
  }) => {
    return await getStripe().checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: currency.toLowerCase(),
            product_data: {
              name: metadata.paymentType || 'Reservatior Payment',
              description: metadata.description || 'Payment for services on Reservatior',
            },
            unit_amount: Math.round(amount * 100), // Stripe expects cents
          },
          quantity: 1,
        },
      ],
      mode: 'payment',
      success_url: successUrl,
      cancel_url: cancelUrl,
      metadata,
      customer_email: customerEmail,
    });
  },

  handleWebhook: async (payload: string, sig: string, webhookSecret: string) => {
    let event: Stripe.Event;

    try {
      event = getStripe().webhooks.constructEvent(payload, sig, webhookSecret);
    } catch (err: any) {
      throw new Error(`Webhook Error: ${err.message}`);
    }

    return event;
  },
};
