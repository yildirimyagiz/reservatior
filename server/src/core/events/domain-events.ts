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
  
  // Finance OS
  DEAL_CREATED: 'DealCreated',
  DEAL_CLOSED: 'DealClosed',
  DEAL_CANCELLED: 'DealCancelled',
  COMMISSION_CREATED: 'CommissionCreated',
  COMMISSION_PAID: 'CommissionPaid',
  COMMISSION_INSTALLMENT_OFFERED: 'CommissionAdvanceOffered',
  COMMISSION_INSTALLMENT_STARTED: 'CommissionAdvanceAccepted',
  
  // Booking OS
  BOOKING_CREATED: 'booking.created',
  BOOKING_DEPOSIT_PAID: 'booking.deposit.paid',
  
  // AI OS / Marketing
  AD_GENERATED: 'ad.generated',
  AD_PUBLISHED: 'ad.published',
  AD_COMPLETED: 'ad.completed',

  // CRM OS
  LEAD_CREATED: 'lead.created',
} as const;

export type DomainEvent = typeof DomainEvents[keyof typeof DomainEvents];

export interface EventMessage<T = any> {
  id: string;
  type: DomainEvent;
  timestamp: Date;
  payload: T;
  source: string; // e.g. "ListingOS", "AgentOS"
  correlationId?: string; // Important for Saga tracking
}
