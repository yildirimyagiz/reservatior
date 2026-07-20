/**
 * Core Domain Events (Constant Map)
 * Represents exactly the bounds of the OS modules.
 */

export const DomainEvents = {
  // Agent OS
  AGENT_INVITED: 'agent.invited',
  AGENT_ACCEPTED: 'agent.accepted',
  AGENT_VERIFIED: 'agent.verified',
  AGENT_IMPORTED: 'agent.imported',
  
  // Listing OS
  LISTING_IMPORTED: 'listing.imported',
  LISTING_UPDATED: 'listing.updated',
  LISTING_PUBLISHED: 'listing.published',
  LISTING_UNPUBLISHED: 'listing.unpublished',
  LISTING_EXPIRED: 'listing.expired',
  LISTING_PRICE_CHANGED: 'listing.price_changed',
  LISTING_VIEWED: 'listing.viewed',
  LISTING_INQUIRY: 'listing.inquiry',
  LISTING_FAVORITED: 'listing.favorited',
  LISTING_SHARED: 'listing.shared',
  
  // Finance OS
  DEAL_CREATED: 'DealCreated',
  DEAL_CLOSED: 'DealClosed',
  DEAL_CANCELLED: 'DealCancelled',
  COMMISSION_CREATED: 'CommissionCreated',
  COMMISSION_PAID: 'CommissionPaid',
  COMMISSION_INSTALLMENT_OFFERED: 'CommissionAdvanceOffered',
  COMMISSION_INSTALLMENT_STARTED: 'CommissionAdvanceAccepted',
  COMMISSION_INSTALLMENT_DUE: 'commission.installment.due',
  COMMISSION_INSTALLMENT_OVERDUE: 'commission.installment.overdue',
  PAYMENT_RECEIVED: 'payment.received',
  PAYMENT_FAILED: 'payment.failed',
  PAYMENT_REFUNDED: 'payment.refunded',
  INVOICE_CREATED: 'invoice.created',
  INVOICE_PAID: 'invoice.paid',
  INVOICE_OVERDUE: 'invoice.overdue',
  REVENUE_RECOGNIZED: 'revenue.recognized',
  EXPENSE_RECORDED: 'expense.recorded',
  FINANCIAL_REPORT_GENERATED: 'financial.report.generated',
  
  // Booking OS
  BOOKING_CREATED: 'booking.created',
  BOOKING_DEPOSIT_PAID: 'booking.deposit.paid',
  BOOKING_CONFIRMED: 'booking.confirmed',
  BOOKING_CANCELLED: 'booking.cancelled',
  BOOKING_CHECKED_IN: 'booking.checked_in',
  BOOKING_CHECKED_OUT: 'booking.checked_out',
  BOOKING_MODIFIED: 'booking.modified',
  BOOKING_PAYMENT_FAILED: 'booking.payment_failed',
  BOOKING_REVIEW_REQUESTED: 'booking.review_requested',
  BOOKING_DISPUTE_OPENED: 'booking.dispute_opened',
  
  // AI OS / Marketing
  AD_GENERATED: 'ad.generated',
  AD_PUBLISHED: 'ad.published',
  AD_COMPLETED: 'ad.completed',
  AI_MODEL_TRAINED: 'ai.model.trained',
  AI_PREDICTION_MADE: 'ai.prediction.made',
  AI_INSIGHT_GENERATED: 'ai.insight.generated',

  // User OS
  USER_CREATED: 'user.created',
  USER_UPDATED: 'user.updated',
  USER_DELETED: 'user.deleted',
  USER_SUSPENDED: 'user.suspended',
  USER_REACTIVATED: 'user.reactivated',

  // Trust OS
  TRUST_SCORE_UPDATED: 'trust.score.updated',
  TRUST_VERIFICATION_REQUESTED: 'trust.verification.requested',
  TRUST_VERIFICATION_COMPLETED: 'trust.verification.completed',
  TRUST_REVIEW_SUBMITTED: 'trust.review.submitted',

  // Ads OS
  AD_CAMPAIGN_CREATED: 'ad.campaign.created',
  AD_CAMPAIGN_PAUSED: 'ad.campaign.paused',
  AD_CAMPAIGN_RESUMED: 'ad.campaign.resumed',
  AD_BUDGET_UPDATED: 'ad.budget.updated',

  // Commerce OS
  PRODUCT_CREATED: 'product.created',
  PRODUCT_UPDATED: 'product.updated',
  ORDER_CREATED: 'order.created',
  ORDER_FULFILLED: 'order.fulfilled',
  CART_UPDATED: 'cart.updated',

  // Operations OS
  TASK_CREATED: 'task.created',
  TASK_ASSIGNED: 'task.assigned',
  TASK_COMPLETED: 'task.completed',
  WORKFLOW_STARTED: 'workflow.started',
  WORKFLOW_COMPLETED: 'workflow.completed',

  // CRM OS
  LEAD_CREATED: 'lead.created',
  LEAD_QUALIFIED: 'lead.qualified',
  LEAD_CONVERTED: 'lead.converted',
  CONTACT_CREATED: 'contact.created',
  OPPORTUNITY_CREATED: 'opportunity.created',

  // Investment OS
  INVESTMENT_CREATED: 'investment.created',
  INVESTMENT_APPROVED: 'investment.approved',
  INVESTMENT_FUNDED: 'investment.funded',
  INVESTMENT_RETURNED: 'investment.returned',
  DIVIDEND_DISTRIBUTED: 'dividend.distributed',

  // Governance OS
  POLICY_CREATED: 'policy.created',
  POLICY_UPDATED: 'policy.updated',
  COMPLIANCE_CHECK: 'compliance.check',
  AUDIT_STARTED: 'audit.started',
  AUDIT_COMPLETED: 'audit.completed',

  // Partner OS
  PARTNER_ONBOARDED: 'partner.onboarded',
  PARTNER_RELATIONSHIP_CREATED: 'partner.relationship.created',
  PARTNER_AGREEMENT_SIGNED: 'partner.agreement.signed',
  PARTNER_PERFORMANCE_REVIEWED: 'partner.performance.reviewed',

  // Governance OS
  GOVERNANCE_RULE_CREATED: 'governance.rule.created',
  GOVERNANCE_RULE_EVALUATED: 'governance.rule.evaluated',
  COMPLIANCE_CHECK_PASSED: 'compliance.check.passed',
  COMPLIANCE_CHECK_FAILED: 'compliance.check.failed',
  APPROVAL_REQUESTED: 'approval.requested',
  APPROVAL_COMPLETED: 'approval.completed',
  AUDIT_LOG_CREATED: 'audit.log.created',

  // Partner OS
  PARTNER_REGISTERED: 'partner.registered',
  PARTNER_AGREEMENT_EXPIRED: 'partner.agreement.expired',
  PARTNER_REVIEW_RECEIVED: 'partner.review.received',
  PARTNER_REVENUE_RECORDED: 'partner.revenue.recorded',
  SUPPLIER_ONBOARDED: 'supplier.onboarded',

  // Developer API OS
  API_KEY_CREATED: 'api.key.created',
  API_KEY_REVOKED: 'api.key.revoked',
  API_RATE_LIMIT_EXCEEDED: 'api.rate_limit.exceeded',
  API_USAGE_LOGGED: 'api.usage.logged',

  // Security OS
  SECURITY_ALERT_TRIGGERED: 'security.alert.triggered',
  SECURITY_INCIDENT_CREATED: 'security.incident.created',
  SECURITY_SCAN_COMPLETED: 'security.scan.completed',
  ACCESS_GRANTED: 'access.granted',
  ACCESS_REVOKED: 'access.revoked',

  // Analytics OS
  ANALYTICS_METRIC_RECORDED: 'analytics.metric.recorded',
  ANALYTICS_KPI_CALCULATED: 'analytics.kpi.calculated',
  ANALYTICS_QUERY_REQUESTED: 'analytics.query.requested',
  ANALYTICS_INSIGHT_GENERATED: 'analytics.insight.generated',
  ANALYTICS_DASHBOARD_VIEWED: 'analytics.dashboard.viewed',
  ANALYTICS_QUERY_FAILED: 'analytics.query.failed',
  ANALYTICS_REPORT_GENERATED: 'analytics.report.generated',

  // Document OS
  DOCUMENT_UPLOADED: 'document.uploaded',
  DOCUMENT_CREATED: 'document.created',
  DOCUMENT_UPDATED: 'document.updated',
  DOCUMENT_APPROVED: 'document.approved',
  DOCUMENT_SIGNATURE_REQUESTED: 'document.signature_requested',
  DOCUMENT_VERSION_CREATED: 'document.version_created',
  DOCUMENT_DELETED: 'document.deleted',

  // Notification OS
  NOTIFICATION_CREATED: 'notification.created',
  NOTIFICATION_SENT: 'notification.sent',
  NOTIFICATION_DELIVERED: 'notification.delivered',
  NOTIFICATION_FAILED: 'notification.failed',
  NOTIFICATION_RULE_CREATED: 'notification.rule.created',
  NOTIFICATION_PREFERENCES_UPDATED: 'notification.preferences.updated',

  // Identity OS
  ORGANIZATION_CREATED: 'organization.created',
  TEAM_CREATED: 'team.created',
  ROLE_CREATED: 'role.created',
  ROLE_ASSIGNED: 'role.assigned',
  APIKEY_CREATED: 'apikey.created',
  SESSION_CREATED: 'session.created',
  SESSION_REVOKED: 'session.revoked',
  IDENTITY_EVENT_LOGGED: 'identity.event_logged',
  DEVICE_REGISTERED: 'device.registered',
  DEVICE_TRUSTED: 'device.trusted',

  // Localization OS
  LOCALIZATION_COUNTRY_CREATED: 'localization.country_created',
  LOCALIZATION_TRANSLATED: 'localization.translated',
  LOCALIZATION_EXCHANGE_RATE_UPDATED: 'localization.exchange_rate_updated',
  LOCALIZATION_CONTENT_UPDATED: 'localization.content_updated',
  API_REQUEST_RECEIVED: 'api.request.received',
  WEBHOOK_REGISTERED: 'webhook.registered',
  WEBHOOK_DELIVERY_FAILED: 'webhook.delivery.failed',
  INTEGRATION_CONNECTED: 'integration.connected',
  INTEGRATION_DISCONNECTED: 'integration.disconnected',

  // Analytics OS
  ANALYTICS_DATA_COLLECTED: 'analytics.data.collected',
  REPORT_GENERATED: 'report.generated',
  DASHBOARD_VIEWED: 'dashboard.viewed',
  KPI_THRESHOLD_CROSSED: 'kpi.threshold.crossed',
  PERFORMANCE_ALERT_FIRED: 'performance.alert.fired',
  HEALTH_CHECK_COMPLETED: 'health.check.completed',

  // Document OS
  DOCUMENT_ANALYZED: 'document.analyzed',
  DOCUMENT_ARCHIVED: 'document.archived',
  CONTRACT_CREATED: 'contract.created',
  CONTRACT_SIGNED: 'contract.signed',
  CONTRACT_EXPIRED: 'contract.expired',
  SIGNATURE_REQUESTED: 'signature.requested',
  SIGNATURE_COMPLETED: 'signature.completed',

  // Notification OS
  NOTIFICATION_READ: 'notification.read',
  MESSAGE_SENT: 'message.sent',
  MESSAGE_READ: 'message.read',
  TEMPLATE_RENDERED: 'template.rendered',
  CHANNEL_DELIVERED: 'channel.delivered',
} as const;

export type DomainEvent = typeof DomainEvents[keyof typeof DomainEvents];

export interface LocalizationContext {
  countryCode: string;
  language: string;
  currency: string;
  timezone: string;
}

export interface EventMessage<T = any> {
  id: string;
  type: DomainEvent;
  timestamp: Date;
  payload: T;
  source: string; // e.g. "ListingOS", "AgentOS"
  correlationId?: string; // Important for Saga tracking
  localization?: LocalizationContext; // Localization context for multi-country support
}
