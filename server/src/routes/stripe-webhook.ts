import { Elysia, t } from "elysia";
import { stripeService } from "../services/stripe";
import { prisma } from "../lib/prisma";
import { notificationService } from "../services/notification";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

export const stripeWebhookRoutes = new Elysia({ prefix: "/stripe-webhook" })
  .post("/", async ({ request, set }: { request: Request; set: any }) => {
    const sig = request.headers.get('stripe-signature');
    const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET || '';

    if (!sig) {
      set.status = 400;
      return { error: 'Missing stripe-signature' };
    }

    try {
      const rawBody = await request.text();
      const event = await stripeService.handleWebhook(rawBody, sig, webhookSecret);

      if (event.type === 'checkout.session.completed') {
        const session = event.data.object as any;
        const metadata = session.metadata;

        // Create the actual payment record in DB
        const payment = await prisma.payment.create({
          data: {
            tenantId: metadata.tenantId || metadata.userId, // Using userId as fallback if tenantId is missing
            amount: session.amount_total / 100,
            currencyId: session.currency.toUpperCase(), // Assuming currency code is the ID or can be mapped
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
        await notificationService.create({
          title: "Payment Successful",
          content: `Payment of ${payment.amount} ${session.currency.toUpperCase()} has been successfully processed.`,
          type: "PAYMENT",
          isRead: false,
          orgId: metadata.orgId,
          userId: metadata.userId,
        } as any);

        // If it's a reservation/booking, update its status
        const bookingId = metadata.reservationId || metadata.bookingId;
        if (bookingId) {
          await prisma.reservation.update({
            where: { id: bookingId },
            data: { status: 'CONFIRMED' }
          });
        }
      } else if (event.type === 'payment_intent.payment_failed') {
        const intent = event.data.object as any;
        const metadata = intent.metadata;

        // ML Feedback Loop: Payment Failed -> Tenant Risk Penalty
        MLBridgeService.sendFeedback("tenant-screening", "PAYMENT_FAILED", -5.0, {
          userId: metadata?.userId,
          amount: intent.amount / 100,
          error: intent.last_payment_error?.message
        }).catch(console.error);

        if (metadata?.userId) {
          await notificationService.create({
            title: "Payment Failed",
            content: `Your payment of ${intent.amount / 100} ${intent.currency.toUpperCase()} failed. Reason: ${intent.last_payment_error?.message}`,
            type: "ALERT",
            isRead: false,
            orgId: metadata.orgId,
            userId: metadata.userId,
          } as any);
        }
      } else if (event.type === 'charge.refunded') {
        const charge = event.data.object as any;
        const metadata = charge.metadata;

        // Update payment status if needed or notify user
        if (metadata?.userId) {
          await notificationService.create({
            title: "Payment Refunded",
            content: `Your payment of ${charge.amount_refunded / 100} ${charge.currency.toUpperCase()} has been refunded.`,
            type: "SYSTEM",
            isRead: false,
            orgId: metadata.orgId,
            userId: metadata.userId,
          } as any);
        }
      }

      return { received: true };
    } catch (err: any) {
      console.error(`Webhook Error: ${err.message}`);
      set.status = 400;
      return { error: err.message };
    }
  });
