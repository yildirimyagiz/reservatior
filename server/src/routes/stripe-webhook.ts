import { Elysia, t } from "elysia";
import { stripeService } from "../services/stripe";
import { prisma } from "../lib/prisma";
import { notificationService } from "../services/notification";
import { regionMiddleware } from "../middleware/region";

export const stripeWebhookRoutes = new Elysia({ prefix: "/stripe-webhook" })
  .use(regionMiddleware)
  .post("/", async ({ orgId, db, request, set }: { request: Request; set: any }) => {
    const sig = request.headers.get('stripe-signature');
    const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET || '';

    if (!sig) {
      set.status = 400;
      return { error: 'Missing stripe-signature' };
    }

    try {
      const rawBody = await request.text();
      const event = await stripeService.withDB(db as any).handleWebhook(rawBody, sig, webhookSecret);

      if (event.type === 'checkout.session.completed') {
        const session = event.data.object as any;
        const metadata = session.metadata;

        // Create the actual payment record in DB
        const payment = await prisma.payment.create({
          data: {
            tenantId: metadata.tenantId || metadata.userId,
            amount: session.amount_total / 100,
            currencyId: session.currency.toUpperCase(),
            status: 'PAID',
            paymentMethod: 'STRIPE',
            reference: session.id,
            propertyId: metadata.propertyId,
            reservationId: metadata.reservationId || metadata.bookingId,
            expenseId: metadata.expenseId,
            includedServiceId: metadata.includedServiceId,
            extraChargeId: metadata.extraChargeId,
            notes: `Stripe Checkout Session: ${session.id}`,
            paymentDate: new Date(),
            dueDate: new Date(),
            createdAt: new Date(),
            updatedAt: new Date(),
          },
        });

        // Trigger notifications
        await notificationService.withDB(db as any).create({
          title: "Payment Successful",
          content: `Payment of ${payment.amount} ${session.currency.toUpperCase()} has been successfully processed.`,
          type: "PAYMENT",
          isRead: false,
          orgId: metadata.orgId,
          userId: metadata.userId,
        } as any);

        // If it's a subscription/plan purchase, update OrgSubscription
        if (metadata.orgId && metadata.planId) {
          const existingSub = await prisma.orgSubscription.findUnique({
            where: { orgId: metadata.orgId }
          });
          if (existingSub) {
            await prisma.orgSubscription.update({
              where: { orgId: metadata.orgId },
              data: {
                status: 'ACTIVE',
                currentPeriodEnd: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
                stripeSubscriptionId: session.subscription || existingSub.stripeSubscriptionId,
                stripeCustomerId: session.customer || existingSub.stripeCustomerId,
              }
            });
          } else if (metadata.planId) {
            await prisma.orgSubscription.create({
              data: {
                orgId: metadata.orgId,
                planId: metadata.planId,
                status: 'ACTIVE',
                stripeCustomerId: session.customer,
                stripeSubscriptionId: session.subscription,
                currentPeriodEnd: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
              }
            });
          }
        }

        // If it's a reservation/booking, update its status
        const bookingId = metadata.reservationId || metadata.bookingId;
        if (bookingId) {
          await prisma.reservation.update({
            where: { id: bookingId },
            data: { status: 'CONFIRMED' }
          });
        }
      }

      return { received: true };
    } catch (err: any) {
      console.error(`Webhook Error: ${err.message}`);
      set.status = 400;
      return { error: err.message };
    }
  });
