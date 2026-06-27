import { NextResponse } from "next/server";
import { auth } from "@/lib/auth";
import { getStripe } from "@/lib/stripe";
import prisma from "@/lib/prisma";

export const dynamic = 'force-dynamic';

// Global init removed
// const stripe = new Stripe(...);

export async function POST() {
  const session = await auth();
  if (!session?.user?.id) {
    return new NextResponse("Unauthorized", { status: 401 });
  }

  const user = await prisma.user.findUnique({
    where: { id: session.user.id },
  });

  if (!user) return new NextResponse("User not found", { status: 404 });

  let customerId = user.stripeCustomerId;

  if (!customerId) {
    const customer = await getStripe()!.customers.create({
      email: user.email!,
      name: (user as unknown as { name?: string }).name ?? undefined,
      metadata: { userId: user.id },
    });
    customerId = customer.id;
    await prisma.user.update({
      where: { id: user.id },
      data: { stripeCustomerId: customerId },
    });
  }

  // Create Setup Intent for soft paywall (card verification only)
  const setupIntent = await getStripe()!.setupIntents.create({
    customer: customerId,
    usage: 'off_session', // We might charge them later if they upgrade
  });

  return NextResponse.json({ clientSecret: setupIntent.client_secret });
}
