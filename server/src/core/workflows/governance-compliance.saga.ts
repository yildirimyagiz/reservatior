/**
 * Governance Compliance Saga
 *
 * Flow: compliance check passed → log success
 *       compliance check failed → notify owner, log failure
 */
import { eventBus } from "../events/event-bus";
import { DomainEvents, EventMessage } from "../events/domain-events";

export function registerGovernanceComplianceListeners() {
  eventBus.subscribe(DomainEvents.COMPLIANCE_CHECK_PASSED, async (msg: EventMessage) => {
    const { recordId, orgId, checkType } = msg.payload;
    console.log(`[GovernanceComplianceSaga] ✅ Compliance check passed for ${recordId} (type: ${checkType})`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "COMPLIANCE_PASSED",
      recordId,
      checkType,
      orgId,
      timestamp: new Date(),
    }, "GovernanceOS", msg.correlationId);
  });

  eventBus.subscribe(DomainEvents.COMPLIANCE_CHECK_FAILED, async (msg: EventMessage) => {
    const { recordId, orgId, checkType, reason } = msg.payload;
    console.log(`[GovernanceComplianceSaga] ❌ Compliance check failed for ${recordId} (type: ${checkType}): ${reason}`);

    eventBus.publish(DomainEvents.AUDIT_LOG_CREATED, {
      action: "COMPLIANCE_FAILED",
      recordId,
      checkType,
      reason,
      orgId,
      timestamp: new Date(),
    }, "GovernanceOS", msg.correlationId);

    eventBus.publish(DomainEvents.APPROVAL_REQUESTED, {
      recordId,
      orgId,
      reason: `Compliance check failed: ${reason}. Manual review required.`,
      requestedAt: new Date(),
    }, "GovernanceOS", msg.correlationId);
  });
}
