
import { getStripe } from '@/lib/stripe';
import prisma from '@/lib/prisma';

// Use centralized lazy stripe instance
// const stripe = new Stripe(...); // Removed global init

/**
 * STRIPE SOFT PAYWALL LOGIC
 * Creates a SetupIntent to verify card validity without charging
 */
export async function createCardVerificationSession(userId: string) {
  const user = await prisma.user.findUnique({ where: { id: userId } });

  if (!user?.stripeCustomerId) {
    const customer = await getStripe()!.customers.create({ email: user?.email || undefined });
    await prisma.user.update({
      where: { id: userId },
      data: { stripeCustomerId: customer.id }
    });
  }

  // Create Setup Intent
  const setupIntent = await getStripe()!.setupIntents.create({
    customer: user?.stripeCustomerId || '',
    payment_method_types: ['card'],
    usage: 'off_session', // We might charge later
  });

  return setupIntent.client_secret;
}

/**
 * Check if user has a valid payment method attached
 */
export async function hasValidPaymentMethod(userId: string): Promise<boolean> {
  const user = await prisma.user.findUnique({ where: { id: userId } });
  if (!user?.stripeCustomerId) return false;

  const methods = await getStripe()!.paymentMethods.list({
    customer: user.stripeCustomerId,
    type: 'card'
  });

  return methods.data.length > 0;
}
