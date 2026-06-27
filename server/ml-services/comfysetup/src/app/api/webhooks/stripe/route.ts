/**
 * Stripe Webhook Endpoint
 * 
 * POST /api/webhooks/stripe
 * 
 * Handles all Stripe webhook events.
 * Must be configured in Stripe Dashboard → Webhooks.
 */

import { NextRequest, NextResponse } from 'next/server';
import { verifyWebhookSignature, handleWebhookEvent } from '@/lib/stripe';

// App Router handles raw body automatically with request.text()

export async function POST(request: NextRequest) {
    try {
        // Get raw body for signature verification
        const body = await request.text();
        const signature = request.headers.get('stripe-signature');
        
        if (!signature) {
            return NextResponse.json(
                { error: 'Missing stripe-signature header' },
                { status: 400 }
            );
        }
        
        // Verify webhook signature
        let event;
        try {
            event = verifyWebhookSignature(body, signature);
        } catch (err) {
            console.error('Webhook signature verification failed:', err);
            return NextResponse.json(
                { error: 'Webhook signature verification failed' },
                { status: 400 }
            );
        }
        
        // Handle the event
        console.log(`Processing webhook: ${event.type}`);
        const result = await handleWebhookEvent(event);
        
        if (!result.success) {
            console.error(`Webhook processing failed: ${result.message}`);
            // Still return 200 to acknowledge receipt
            // Stripe will retry if we return error
        }
        
        console.log(`Webhook processed: ${result.message}`);
        
        return NextResponse.json({
            received: true,
            event: event.type,
            result: result.message,
        });
        
    } catch (error) {
        console.error('Webhook error:', error);
        return NextResponse.json(
            { error: 'Webhook handler failed' },
            { status: 500 }
        );
    }
}
