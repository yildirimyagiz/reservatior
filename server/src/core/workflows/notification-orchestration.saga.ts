/**
 * Notification Orchestration Saga
 *
 * Flow: notification sent → track delivery
 *       message sent → log communication
 *       notification read → update engagement metrics
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerNotificationOrchestrationListeners() {
  eventBus.subscribe(DomainEvents.NOTIFICATION_SENT, async (msg: EventMessage) => {
    const { notificationId, orgId, channel, recipientId } = msg.payload;
    console.log(`[NotificationOrchestrationSaga] 📤 Notification sent: ${notificationId} via ${channel} to ${recipientId}`);

    eventBus.publish(DomainEvents.CHANNEL_DELIVERED, {
      notificationId,
      channel,
      recipientId,
      orgId,
      deliveredAt: new Date(),
    }, "NotificationOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.MESSAGE_SENT, async (msg: EventMessage) => {
    const { messageId, orgId, senderId, recipientId } = msg.payload;
    console.log(`[NotificationOrchestrationSaga] 💬 Message sent: ${messageId} from ${senderId} to ${recipientId}`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "MESSAGE_SENT",
      messageId,
      senderId,
      recipientId,
      orgId,
      timestamp: new Date(),
    }, "NotificationOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.NOTIFICATION_READ, async (msg: EventMessage) => {
    const { notificationId, orgId, recipientId } = msg.payload;
    console.log(`[NotificationOrchestrationSaga] 👁️  Notification read: ${notificationId} by ${recipientId}`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "NOTIFICATION_READ",
      notificationId,
      recipientId,
      orgId,
      readAt: new Date(),
    }, "NotificationOS", msg.correlationId);
  });
}
