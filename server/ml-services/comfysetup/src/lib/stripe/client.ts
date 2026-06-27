/**
 * Stripe Payment Integration
 * 
 * Server-side Stripe client for:
 * - Creating payment intents
 * - Managing subscriptions
 * - Handling usage-based billing
 * - Processing webhooks
 */

import Stripe from 'stripe';

// Lazy initialization to prevent build failures
let stripeInstance: Stripe | undefined;

function getStripe() {
    if (!stripeInstance) {
        // Use placeholder if missing, to allow build to pass. Calls will fail at runtime if key is missing.
        const key = process.env.STRIPE_SECRET_KEY || 'sk_test_placeholder';
        stripeInstance = new Stripe(key, {
            // eslint-disable-next-line @typescript-eslint/no-explicit-any
            apiVersion: '2025-12-15.clover' as any,
        });
    }
    return stripeInstance;
}

// Pricing configuration
export const PRICING = {
    // Pay-per-image pricing
    perImage: {
        staging: 0.10,      // $0.10 per staged image
        enhancement: 0.05,  // $0.05 per enhanced image
        walkthrough: 0.50,  // $0.50 per walkthrough video
    },
    
    // Subscription plans
    plans: {
        starter: {
            priceId: process.env.STRIPE_STARTER_PRICE_ID || '',
            price: 29,
            credits: 50,
            name: 'Starter',
        },
        professional: {
            priceId: process.env.STRIPE_PROFESSIONAL_PRICE_ID || '',
            price: 79,
            credits: 200,
            name: 'Professional',
        },
        agency: {
            priceId: process.env.STRIPE_AGENCY_PRICE_ID || '',
            price: 199,
            credits: 1000,
            name: 'Agency',
        },
    },
} as const;

export type PlanType = keyof typeof PRICING.plans;

/**
 * Create a payment intent for one-time purchases
 */
export async function createPaymentIntent(params: {
    amount: number; // Amount in cents
    currency?: string;
    customerId?: string;
    metadata?: Record<string, string>;
}): Promise<Stripe.PaymentIntent> {
    const { amount, currency = 'usd', customerId, metadata = {} } = params;
    
    return getStripe().paymentIntents.create({
        amount,
        currency,
        customer: customerId,
        metadata: {
            ...metadata,
            source: 'atlasvs',
        },
        automatic_payment_methods: {
            enabled: true,
        },
    });
}

/**
 * Create a payment intent for image generation credits
 */
export async function createCreditsPaymentIntent(params: {
    credits: number;
    userId: string;
    email?: string;
}): Promise<{ clientSecret: string; paymentIntentId: string }> {
    const { credits, userId, email } = params;
    
    // Calculate amount: $0.10 per credit (in cents)
    const amount = credits * 10;
    
    // Get or create customer
    let customerId: string | undefined;
    if (email) {
        const existingCustomers = await getStripe().customers.list({ email, limit: 1 });
        if (existingCustomers.data.length > 0) {
            customerId = existingCustomers.data[0].id;
        } else {
            const customer = await getStripe().customers.create({
                email,
                metadata: { userId },
            });
            customerId = customer.id;
        }
    }
    
    const paymentIntent = await createPaymentIntent({
        amount,
        customerId,
        metadata: {
            type: 'credits',
            credits: credits.toString(),
            userId,
        },
    });
    
    return {
        clientSecret: paymentIntent.client_secret!,
        paymentIntentId: paymentIntent.id,
    };
}

/**
 * Create a checkout session for subscription
 */
export async function createSubscriptionCheckout(params: {
    plan: PlanType;
    userId: string;
    email: string;
    successUrl: string;
    cancelUrl: string;
}): Promise<Stripe.Checkout.Session> {
    const { plan, userId, email, successUrl, cancelUrl } = params;
    const planConfig = PRICING.plans[plan];
    
    if (!planConfig.priceId) {
        throw new Error(`Price ID not configured for plan: ${plan}`);
    }
    
    return getStripe().checkout.sessions.create({
        mode: 'subscription',
        customer_email: email,
        line_items: [
            {
                price: planConfig.priceId,
                quantity: 1,
            },
        ],
        success_url: `${successUrl}?session_id={CHECKOUT_SESSION_ID}`,
        cancel_url: cancelUrl,
        subscription_data: {
            metadata: {
                userId,
                plan,
            },
        },
        metadata: {
            userId,
            plan,
        },
    });
}

/**
 * Cancel a subscription
 */
export async function cancelSubscription(
    subscriptionId: string
): Promise<Stripe.Subscription> {
    return getStripe().subscriptions.cancel(subscriptionId);
}

/**
 * Get subscription details
 */
export async function getSubscription(
    subscriptionId: string
): Promise<Stripe.Subscription> {
    return getStripe().subscriptions.retrieve(subscriptionId);
}

/**
 * Get customer's active subscriptions
 */
export async function getCustomerSubscriptions(
    customerId: string
): Promise<Stripe.Subscription[]> {
    const subscriptions = await getStripe().subscriptions.list({
        customer: customerId,
        status: 'active',
    });
    return subscriptions.data;
}

// TODO: Implement usage recording with new Stripe Billing Meter API
// The createUsageRecord method has been deprecated in newer Stripe versions
// See: https://stripe.com/docs/api/billing/meter-event

/**
 * Get or create a customer
 */
export async function getOrCreateCustomer(params: {
    email: string;
    userId: string;
    name?: string;
}): Promise<Stripe.Customer> {
    const { email, userId, name } = params;
    
    // Check if customer exists
    const existingCustomers = await getStripe().customers.list({ email, limit: 1 });
    
    if (existingCustomers.data.length > 0) {
        return existingCustomers.data[0];
    }
    
    // Create new customer
    return getStripe().customers.create({
        email,
        name,
        metadata: {
            userId,
            source: 'atlasvs',
        },
    });
}

/**
 * Create a billing portal session for subscription management
 */
export async function createBillingPortalSession(params: {
    customerId: string;
    returnUrl: string;
}): Promise<Stripe.BillingPortal.Session> {
    const { customerId, returnUrl } = params;
    
    return getStripe().billingPortal.sessions.create({
        customer: customerId,
        return_url: returnUrl,
    });
}

/**
 * Verify a webhook signature
 */
export function verifyWebhookSignature(
    payload: string | Buffer,
    signature: string
): Stripe.Event {
    const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
    
    if (!webhookSecret) {
        throw new Error('STRIPE_WEBHOOK_SECRET not configured');
    }
    
    return getStripe().webhooks.constructEvent(payload, signature, webhookSecret);
}

/**
 * Get invoice details
 */
export async function getInvoice(invoiceId: string): Promise<Stripe.Invoice> {
    return getStripe().invoices.retrieve(invoiceId);
}

/**
 * List customer invoices
 */
export async function listInvoices(
    customerId: string,
    limit = 10
): Promise<Stripe.Invoice[]> {
    const invoices = await getStripe().invoices.list({
        customer: customerId,
        limit,
    });
    return invoices.data;
}

// Export Stripe getter instance check function if needed
export { getStripe };
