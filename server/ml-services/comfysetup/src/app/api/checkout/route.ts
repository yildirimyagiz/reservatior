import { NextResponse } from 'next/server';
import { auth } from '@/lib/auth';
import Stripe from 'stripe';

export const dynamic = 'force-dynamic';

export async function POST(req: Request) {
  try {
      const stripe = new Stripe(process.env.STRIPE_SK_LIVE || process.env.STRIPE_PK_TEST!, { 
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        apiVersion: '2025-01-27.acacia' as any 
      });

      const session = await auth();
      if (!session?.user) return new NextResponse('Unauthorized', { status: 401 });

      const { plan } = await req.json();
      
      // Ideally these are in .env
      // For now, we return 400 if not configured
      const prices: Record<string, string | undefined> = {
        standard: process.env.STRIPE_PRICE_STANDARD,
        advanced: process.env.STRIPE_PRICE_ADVANCED,
        premium: process.env.STRIPE_PRICE_PREMIUM,
        enterprise: process.env.STRIPE_PRICE_ENTERPRISE
      };

      const priceId = prices[plan as string]?.toString();

      if (!priceId) {
        return NextResponse.json({ error: 'Price ID not configured for this plan' }, { status: 400 });
      }

      const checkoutSession = await stripe.checkout.sessions.create({
        mode: 'subscription',
        customer_email: session.user.email || undefined,
        line_items: [{ price: priceId, quantity: 1 }],
        success_url: `${process.env.NEXT_PUBLIC_APP_URL}/en/dashboard?checkout=success`,
        cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/en/pricing`,
        metadata: { 
            userId: session.user.id || '',
            plan: String(plan)
        }
      });

      return NextResponse.json({ url: checkoutSession.url });
  } catch (error) {
      console.error('Checkout error:', error);
      return new NextResponse('Internal Server Error', { status: 500 });
  }
}
