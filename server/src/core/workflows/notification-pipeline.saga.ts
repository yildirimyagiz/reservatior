/**
 * Saga: Notification Pipeline
 * 
 * Flow:
 *   notification.created
 *       |
 *   [Channel selection & content preparation]
 *       |
 *   notification.sent
 *       |
 *   [Delivery tracking]
 *       |
 *   notification.delivered
 *       |
 *   [Notification complete]
 */

import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class NotificationPipelineSaga extends BaseSaga {
  public notificationId: string;
  public notificationType: string;
  public recipientId: string;
  public channels: string[];
  public organizationId: string;

  constructor(
    notificationId: string,
    notificationType: string,
    recipientId: string,
    channels: string[],
    organizationId: string,
    sagaId?: string,
    localization?: LocalizationContext
  ) {
    super(sagaId, { step: 'NOTIFICATION_CREATED', notificationId, notificationType, recipientId, channels, organizationId }, localization);
    this.notificationId = notificationId;
    this.notificationType = notificationType;
    this.recipientId = recipientId;
    this.channels = channels;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[NotificationPipelineSaga] Compensating notification ${this.notificationId}. Cancelling pending deliveries...`);
  }

  public async onCreated() {
    console.log(`[NotificationPipelineSaga] Notification ${this.notificationId} created. Preparing content...`);
    await this.transition({ step: 'PREPARING_CONTENT' });

    // Simulate content preparation based on localizationpreferences
    setTimeout(() => {
      eventBus.publish(DomainEvents.NOTIFICATION_SENT, {
        notificationId: this.notificationId,
        notificationType: this.notificationType,
        recipientId: this.recipientId,
        channels: this.channels,
        sentAt: new Date().toISOString(),
        localization: this.localization
      }, 'NotificationOS', this.sagaId);
    }, 1000);
  }

  public async onSent(msg: EventMessage) {
    console.log(`[NotificationPipelineSaga] Notification ${this.notificationId} sent. Tracking delivery...`);
    await this.transition({ step: 'TRACKING_DELIVERY' });

    // Simulate delivery tracking
    setTimeout(() => {
      eventBus.publish(DomainEvents.NOTIFICATION_DELIVERED, {
        notificationId: this.notificationId,
        recipientId: this.recipientId,
        channels: this.channels,
        deliveredAt: new Date().toISOString(),
        deliveryStatus: 'delivered',
        localization: this.localization
      }, 'NotificationOS', this.sagaId);
    }, 2000);
  }

  public async onDelivered(msg: EventMessage) {
    console.log(`[NotificationPipelineSaga] Notification ${this.notificationId} delivered. NOTIFICATION SAGA COMPLETE.`);
    await this.complete();
  }

  public async onFailed(msg: EventMessage) {
    console.log(`[NotificationPipelineSaga] Notification ${this.notificationId} failed. SAGA FAILED.`);
    await this.fail('Notification delivery failed');
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, NotificationPipelineSaga>();

export function registerNotificationPipelineListeners() {
  eventBus.subscribe(DomainEvents.NOTIFICATION_CREATED, (msg) => {
    const { notificationId, notificationType, recipientId, channels, organizationId } = msg.payload;
    const localization = msg.localization || {
      countryCode: 'US',
      language: 'en',
      currency: 'USD',
      timezone: 'America/New_York'
    };
    const saga = new NotificationPipelineSaga(notificationId, notificationType, recipientId, channels, organizationId, msg.correlationId, localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onCreated();
    console.log(`[NotificationPipelineSaga] ✅ Started for Notification ${notificationId}`);
  });

  eventBus.subscribe(DomainEvents.NOTIFICATION_SENT, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onSent(msg);
  });

  eventBus.subscribe(DomainEvents.NOTIFICATION_DELIVERED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDelivered(msg);
  });

  eventBus.subscribe(DomainEvents.NOTIFICATION_FAILED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onFailed(msg);
  });
}
