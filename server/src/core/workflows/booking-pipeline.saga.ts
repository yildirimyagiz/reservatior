/**
 * Saga: Booking Pipeline
 * 
 * Flow:
 *   booking.created
 *       |
 *   [Payment processing]
 *       |
 *   booking.deposit.paid
 *       |
 *   booking.confirmed
 *       |
 *   [Check-in process]
 *       |
 *   booking.checked_in
 *       |
 *   [Check-out process]
 *       |
 *   booking.checked_out
 *       |
 *   booking.review_requested
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class BookingPipelineSaga extends BaseSaga {
  public bookingId: string;
  public propertyId: string;
  public guestId: string;
  public amount: number;

  constructor(bookingId: string, propertyId: string, guestId: string, amount: number, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'BOOKING_CREATED', bookingId, propertyId, guestId, amount }, localization);
    this.bookingId = bookingId;
    this.propertyId = propertyId;
    this.guestId = guestId;
    this.amount = amount;
  }

  protected async compensate(): Promise<void> {
    console.log(`[BookingPipelineSaga] Compensating booking ${this.bookingId}. Rolling back booking process...`);
  }

  public async onBookingCreated() {
    console.log(`[BookingPipelineSaga] Booking ${this.bookingId} created. Processing payment...`);
    await this.transition({ step: 'PROCESSING_PAYMENT' });

    // Simulate payment processing
    setTimeout(() => {
      eventBus.publish(DomainEvents.BOOKING_DEPOSIT_PAID, {
        bookingId: this.bookingId,
        propertyId: this.propertyId,
        guestId: this.guestId,
        amount: this.amount,
        currency: this.localization.currency
      }, 'BookingOS', this.sagaId);
    }, 1000);
  }

  public async onDepositPaid(msg: EventMessage) {
    console.log(`[BookingPipelineSaga] Deposit paid for booking ${this.bookingId}. Confirming booking...`);
    await this.transition({ step: 'CONFIRMING_BOOKING' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.BOOKING_CONFIRMED, {
        bookingId: this.bookingId,
        propertyId: this.propertyId,
        guestId: this.guestId,
        confirmationCode: `CONF-${this.bookingId.slice(0, 8).toUpperCase()}`
      }, 'BookingOS', this.sagaId);
    }, 800);
  }

  public async onBookingConfirmed(msg: EventMessage) {
    console.log(`[BookingPipelineSaga] Booking ${this.bookingId} confirmed with code ${msg.payload.confirmationCode}.`);
    await this.transition({ step: 'BOOKING_CONFIRMED' });
    // Saga parks here until check-in
  }

  public async onCheckedIn(msg: EventMessage) {
    console.log(`[BookingPipelineSaga] Guest checked in for booking ${this.bookingId}.`);
    await this.transition({ step: 'CHECKED_IN' });
    // Saga parks here until check-out
  }

  public async onCheckedOut(msg: EventMessage) {
    console.log(`[BookingPipelineSaga] Guest checked out for booking ${this.bookingId}. Requesting review...`);
    await this.transition({ step: 'REQUESTING_REVIEW' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.BOOKING_REVIEW_REQUESTED, {
        bookingId: this.bookingId,
        guestId: this.guestId,
        propertyId: this.propertyId
      }, 'BookingOS', this.sagaId);
    }, 500);
  }

  public async onReviewRequested(msg: EventMessage) {
    console.log(`[BookingPipelineSaga] Review requested for booking ${this.bookingId}. BOOKING SAGA COMPLETE.`);
    await this.complete();
  }

  public async onBookingCancelled(msg: EventMessage) {
    console.log(`[BookingPipelineSaga] Booking ${this.bookingId} cancelled. SAGA FAILED.`);
    await this.fail('Booking cancelled by user');
  }

  public async onPaymentFailed(msg: EventMessage) {
    console.log(`[BookingPipelineSaga] Payment failed for booking ${this.bookingId}. SAGA FAILED.`);
    await this.fail('Payment processing failed');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, BookingPipelineSaga>();

export function registerBookingPipelineListeners() {
  eventBus.subscribe(DomainEvents.BOOKING_CREATED, (msg) => {
    const { bookingId, propertyId, guestId, amount } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new BookingPipelineSaga(bookingId, propertyId, guestId, amount, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onBookingCreated();
    console.log(`[BookingPipelineSaga] ✅ Started for Booking ${bookingId}`);
  });

  eventBus.subscribe(DomainEvents.BOOKING_DEPOSIT_PAID, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDepositPaid(msg);
  });

  eventBus.subscribe(DomainEvents.BOOKING_CONFIRMED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onBookingConfirmed(msg);
  });

  eventBus.subscribe(DomainEvents.BOOKING_CHECKED_IN, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onCheckedIn(msg);
  });

  eventBus.subscribe(DomainEvents.BOOKING_CHECKED_OUT, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onCheckedOut(msg);
  });

  eventBus.subscribe(DomainEvents.BOOKING_REVIEW_REQUESTED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onReviewRequested(msg);
  });

  eventBus.subscribe(DomainEvents.BOOKING_CANCELLED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onBookingCancelled(msg);
  });

  eventBus.subscribe(DomainEvents.BOOKING_PAYMENT_FAILED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onPaymentFailed(msg);
  });
}
