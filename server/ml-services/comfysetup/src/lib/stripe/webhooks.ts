/**
 * Stripe Webhook Handlers
 * 
 * Process webhook events from Stripe for:
 * - Payment success/failure
 * - Subscription lifecycle
 * - Invoice events
 * 
 * NOTE: Full implementation requires Prisma schema updates:
 * - User: Add credits, subscriptionId, subscriptionPlan, subscriptionStatus fields
 * - Transaction: Add new model for payment tracking
 * - Generation: Add new model for AI generation tracking
 */

import Stripe from 'stripe';
// TODO: Uncomment when Prisma schema is updated
// import prisma from '@/lib/prisma';

export type WebhookResult = {
    success: boolean;
    message: string;
    data?: Record<string, unknown>;
};

/**
 * Handle payment_intent.succeeded
 */
export async function handlePaymentIntentSucceeded(
    paymentIntent: Stripe.PaymentIntent
): Promise<WebhookResult> {
    const { metadata } = paymentIntent;
    const userId = metadata?.userId;
    const type = metadata?.type;
    
    console.log(`[Stripe] Payment succeeded: ${paymentIntent.id}`, {
        userId,
        type,
        amount: paymentIntent.amount,
        currency: paymentIntent.currency,
    });
    
    if (!userId) {
        return { success: false, message: 'No userId in metadata' };
    }
    
    if (type === 'credits') {
        const credits = parseInt(metadata?.credits || '0', 10);
        
        // TODO: Uncomment when Prisma schema has credits field
        // await prisma.user.update({
        //     where: { id: userId },
        //     data: { credits: { increment: credits } },
        // });
        
        console.log(`[Stripe] Would add ${credits} credits to user ${userId}`);
        
        return {
            success: true,
            message: `Payment processed for ${credits} credits`,
            data: { credits, userId },
        };
    }
    
    return {
        success: true,
        message: `Payment intent ${paymentIntent.id} succeeded`,
    };
}

/**
 * Handle payment_intent.payment_failed
 */
export async function handlePaymentIntentFailed(
    paymentIntent: Stripe.PaymentIntent
): Promise<WebhookResult> {
    const { metadata } = paymentIntent;
    const userId = metadata?.userId;
    
    console.log(`[Stripe] Payment failed: ${paymentIntent.id}`, {
        userId,
        error: paymentIntent.last_payment_error?.message,
    });
    
    return {
        success: true,
        message: `Payment intent ${paymentIntent.id} failed, recorded`,
    };
}

/**
 * Handle customer.subscription.created
 */
export async function handleSubscriptionCreated(
    subscription: Stripe.Subscription
): Promise<WebhookResult> {
    const { metadata } = subscription;
    const userId = metadata?.userId;
    const plan = metadata?.plan;
    
    console.log(`[Stripe] Subscription created: ${subscription.id}`, {
        userId,
        plan,
        status: subscription.status,
    });
    
    if (!userId) {
        return { success: false, message: 'No userId in subscription metadata' };
    }
    
    // TODO: Uncomment when Prisma schema is updated
    // await prisma.user.update({
    //     where: { id: userId },
    //     data: {
    //         subscriptionId: subscription.id,
    //         subscriptionPlan: plan || 'starter',
    //         subscriptionStatus: subscription.status,
    //         subscriptionCurrentPeriodEnd: new Date(subscription.current_period_end * 1000),
    //     },
    // });
    
    return {
        success: true,
        message: `Subscription created for user ${userId}`,
        data: { plan, subscriptionId: subscription.id },
    };
}

/**
 * Handle customer.subscription.updated
 */
export async function handleSubscriptionUpdated(
    subscription: Stripe.Subscription
): Promise<WebhookResult> {
    const { metadata } = subscription;
    const userId = metadata?.userId;
    
    console.log(`[Stripe] Subscription updated: ${subscription.id}`, {
        userId,
        status: subscription.status,
    });
    
    // TODO: Implement user lookup and update when schema is ready
    
    return {
        success: true,
        message: `Subscription updated: ${subscription.id}`,
    };
}

/**
 * Handle customer.subscription.deleted
 */
export async function handleSubscriptionDeleted(
    subscription: Stripe.Subscription
): Promise<WebhookResult> {
    console.log(`[Stripe] Subscription deleted: ${subscription.id}`);
    
    // TODO: Implement user lookup and update when schema is ready
    
    return {
        success: true,
        message: `Subscription canceled: ${subscription.id}`,
    };
}

/**
 * Handle invoice.payment_succeeded
 */
export async function handleInvoicePaymentSucceeded(
    invoice: Stripe.Invoice
): Promise<WebhookResult> {
    // In newer Stripe versions, subscription is accessed differently
    const subscriptionId = (invoice as unknown as { subscription?: string }).subscription;
    
    console.log(`[Stripe] Invoice payment succeeded: ${invoice.id}`, {
        subscriptionId,
        amount: invoice.amount_paid,
    });
    
    if (!subscriptionId) {
        return { success: true, message: 'No subscription on invoice' };
    }
    
    // TODO: Implement credit renewal when schema is ready
    
    return { success: true, message: 'Invoice processed' };
}

/**
 * Handle invoice.payment_failed
 */
export async function handleInvoicePaymentFailed(
    invoice: Stripe.Invoice
): Promise<WebhookResult> {
    const subscriptionId = (invoice as unknown as { subscription?: string }).subscription;
    
    console.log(`[Stripe] Invoice payment failed: ${invoice.id}`, {
        subscriptionId,
    });
    
    // TODO: Implement subscription status update when schema is ready
    
    return {
        success: true,
        message: 'Invoice payment failure recorded',
    };
}

/**
 * Main webhook event router
 */
export async function handleWebhookEvent(
    event: Stripe.Event
): Promise<WebhookResult> {
    console.log(`[Stripe] Processing webhook: ${event.type}`);
    
    switch (event.type) {
        case 'payment_intent.succeeded':
            return handlePaymentIntentSucceeded(event.data.object as Stripe.PaymentIntent);
            
        case 'payment_intent.payment_failed':
            return handlePaymentIntentFailed(event.data.object as Stripe.PaymentIntent);
            
        case 'customer.subscription.created':
            return handleSubscriptionCreated(event.data.object as Stripe.Subscription);
            
        case 'customer.subscription.updated':
            return handleSubscriptionUpdated(event.data.object as Stripe.Subscription);
            
        case 'customer.subscription.deleted':
            return handleSubscriptionDeleted(event.data.object as Stripe.Subscription);
            
        case 'invoice.payment_succeeded':
            return handleInvoicePaymentSucceeded(event.data.object as Stripe.Invoice);
            
        case 'invoice.payment_failed':
            return handleInvoicePaymentFailed(event.data.object as Stripe.Invoice);
            
        default:
            console.log(`[Stripe] Unhandled event: ${event.type}`);
            return {
                success: true,
                message: `Unhandled event type: ${event.type}`,
            };
    }
}
