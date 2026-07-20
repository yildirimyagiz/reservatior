/**
 * Identity Security Saga
 *
 * Flow: session revoked → check for suspicious activity, log security event
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerIdentitySecurityListeners() {
  eventBus.subscribe(DomainEvents.SESSION_REVOKED, async (msg: EventMessage) => {
    const { sessionId, userId, orgId, reason } = msg.payload;
    console.log(`[IdentitySecuritySaga] 🔒 Session revoked: ${sessionId} (user: ${userId}, reason: ${reason})`);

    eventBus.publish(DomainEvents.ACCESS_LOG_RECORDED, {
      action: "SESSION_REVOKED",
      sessionId,
      userId,
      reason,
      orgId,
      timestamp: new Date(),
    }, "IdentityOS", msg.correlationId);

    if (reason === "SUSPICIOUS_ACTIVITY" || reason === "FRAUD_DETECTED") {
      console.log(`[IdentitySecuritySaga] ⚠️  Suspicious session revocation for user ${userId} — raising fraud alert`);

      eventBus.publish(DomainEvents.FRAUD_ALERT_RAISED, {
        userId,
        sessionId,
        orgId,
        reason,
        severity: "HIGH",
        raisedAt: new Date(),
      }, "IdentityOS", msg.correlationId);
    }
  });

  eventBus.subscribe(DomainEvents.USER_SSO_CONNECTED, async (msg: EventMessage) => {
    const { userId, orgId, provider } = msg.payload;
    console.log(`[IdentitySecuritySaga] 🔑 SSO login: user ${userId} via ${provider}`);

    eventBus.publish(DomainEvents.ACCESS_LOG_RECORDED, {
      action: "SSO_LOGIN",
      userId,
      provider,
      orgId,
      timestamp: new Date(),
    }, "IdentityOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.PERMISSION_CHANGED, async (msg: EventMessage) => {
    const { userId, orgId, permission, granted } = msg.payload;
    console.log(`[IdentitySecuritySaga] 🛡️  Permission ${granted ? "granted" : "revoked"}: ${permission} for user ${userId}`);

    eventBus.publish(DomainEvents.ACCESS_LOG_RECORDED, {
      action: "PERMISSION_CHANGED",
      userId,
      permission,
      granted,
      orgId,
      timestamp: new Date(),
    }, "IdentityOS", msg.correlationId);
  });
}
