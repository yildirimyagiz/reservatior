/**
 * Payment API Routes
 * 
 * POST /api/v1/payments/credits - Purchase credits
 * POST /api/v1/payments/subscribe - Start subscription
 * POST /api/v1/payments/portal - Access billing portal
 */

import { NextRequest, NextResponse } from 'next/server';
import { auth } from '@/lib/auth';
import {
    createCreditsPaymentIntent,
    createSubscriptionCheckout,
    createBillingPortalSession,
    getOrCreateCustomer,
    PRICING,
} from '@/lib/stripe';

/**
 * POST /api/v1/payments - Create payment intent for credits
 */
export async function POST(request: NextRequest) {
    try {
        const session = await auth();
        
        if (!session?.user?.id) {
            return NextResponse.json(
                { error: 'Unauthorized' },
                { status: 401 }
            );
        }
        
        const body = await request.json();
        const { action, credits, plan } = body;
        
        const baseUrl = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000';
        
        switch (action) {
            case 'purchase_credits': {
                if (!credits || credits < 10) {
                    return NextResponse.json(
                        { error: 'Minimum 10 credits required' },
                        { status: 400 }
                    );
                }
                
                const result = await createCreditsPaymentIntent({
                    credits,
                    userId: session.user.id,
                    email: session.user.email || undefined,
                });
                
                return NextResponse.json({
                    clientSecret: result.clientSecret,
                    paymentIntentId: result.paymentIntentId,
                    amount: credits * 10, // cents
                    credits,
                });
            }
            
            case 'subscribe': {
                if (!plan || !PRICING.plans[plan as keyof typeof PRICING.plans]) {
                    return NextResponse.json(
                        { error: 'Invalid plan' },
                        { status: 400 }
                    );
                }
                
                const checkoutSession = await createSubscriptionCheckout({
                    plan: plan as keyof typeof PRICING.plans,
                    userId: session.user.id,
                    email: session.user.email || '',
                    successUrl: `${baseUrl}/dashboard/billing?success=true`,
                    cancelUrl: `${baseUrl}/pricing?canceled=true`,
                });
                
                return NextResponse.json({
                    sessionId: checkoutSession.id,
                    url: checkoutSession.url,
                });
            }
            
            case 'billing_portal': {
                // Get customer ID
                const customer = await getOrCreateCustomer({
                    email: session.user.email || '',
                    userId: session.user.id,
                    name: session.user.name || undefined,
                });
                
                const portalSession = await createBillingPortalSession({
                    customerId: customer.id,
                    returnUrl: `${baseUrl}/dashboard/billing`,
                });
                
                return NextResponse.json({
                    url: portalSession.url,
                });
            }
            
            default:
                return NextResponse.json(
                    { error: 'Invalid action' },
                    { status: 400 }
                );
        }
        
    } catch (error) {
        console.error('Payment error:', error);
        return NextResponse.json(
            { error: error instanceof Error ? error.message : 'Payment failed' },
            { status: 500 }
        );
    }
}

/**
 * GET /api/v1/payments - Get pricing info
 */
export async function GET() {
    return NextResponse.json({
        pricing: PRICING,
        plans: Object.entries(PRICING.plans).map(([key, plan]) => ({
            id: key,
            ...plan,
        })),
    });
}
