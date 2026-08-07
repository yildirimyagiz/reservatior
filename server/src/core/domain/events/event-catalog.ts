// REOS v4 Master Event Catalog

export const IntentEvents = {
  SEARCH_SUBMITTED: 'intent.search.submitted',
  INTENT_CLASSIFIED: 'intent.classified',
} as const;

export const TrustEvents = {
  KYC_SUBMITTED: 'trust.kyc.submitted',
  KYC_APPROVED: 'trust.kyc.approved',
  FRAUD_ALERT_RAISED: 'trust.fraud.alert.raised',
} as const;

export const FinanceEvents = {
  PAYMENT_TOKENIZED: 'finance.payment.tokenized',
  PAYMENT_PROCESSED: 'finance.payment.processed',
  PAYMENT_FAILED: 'finance.payment.failed',
  TAX_CALCULATED: 'finance.tax.calculated',
} as const;

export const RevenueEvents = {
  COMMISSION_CREATED: 'revenue.commission.created',
  COMMISSION_CALCULATED: 'revenue.commission.calculated',
  COMMISSION_INSTALLMENT_OFFERED: 'revenue.commission.installment.offered',
  COMMISSION_INSTALLMENT_STARTED: 'revenue.commission.installment.started',
  COMMISSION_PAID: 'revenue.commission.paid',
  COMMISSION_VOIDED: 'revenue.commission.voided',
  REVENUE_FORECAST_UPDATED: 'revenue.forecast.updated',
  DEAL_CLOSED: 'revenue.deal.closed',
} as const;

export const BookingEvents = {
  BOOKING_CREATED: 'booking.created',
  BOOKING_DEPOSIT_PAID: 'booking.deposit.paid',
  BOOKING_CONFIRMED: 'booking.confirmed',
} as const;

export const ContractEvents = {
  LEASE_DRAFTED: 'contract.lease.drafted',
  LEASE_SIGNED: 'contract.lease.signed',
} as const;

// REOS v5 Second-Generation Events (Cognitive & Decision Layer)
export const CognitiveEvents = {
  POLICY_EVALUATED: 'policy.evaluated',
  DECISION_GENERATED: 'decision.generated',
  RECOMMENDATION_ACCEPTED: 'knowledge.recommendation.accepted',
  RECOMMENDATION_REJECTED: 'knowledge.recommendation.rejected',
  KNOWLEDGE_UPDATED: 'knowledge.graph.updated',
  RISK_DETECTED: 'intelligence.risk.detected',
  CONFIDENCE_CHANGED: 'intelligence.confidence.changed',
  PREDICTION_COMPLETED: 'intelligence.prediction.completed',
  LEARNING_COMPLETED: 'intelligence.learning.completed',
} as const;

// AI Factory OS Events: Property Listing → AI Production Pipeline
// Audit finding: Brochure/video production emits no domain events → fixed here.
export const AIFactoryEvents = {
  // Job lifecycle
  AI_ASSET_GENERATION_REQUESTED: 'ai-factory.asset.generation.requested',
  AI_JOB_QUEUED:                 'ai-factory.job.queued',
  AI_JOB_STARTED:                'ai-factory.job.started',
  AI_JOB_FAILED:                 'ai-factory.job.failed',
  AI_JOB_CANCELLED:              'ai-factory.job.cancelled',

  // Production steps
  STAGING_STARTED:               'ai-factory.staging.started',
  STAGING_COMPLETED:             'ai-factory.staging.completed',
  BROCHURE_GENERATED:            'ai-factory.brochure.generated',
  VIDEO_RENDER_STARTED:          'ai-factory.video.render.started',
  VIDEO_RENDERED:                'ai-factory.video.rendered',
  VOICEOVER_GENERATED:           'ai-factory.voiceover.generated',
  SUBTITLE_GENERATED:            'ai-factory.subtitle.generated',
  THUMBNAIL_EXTRACTED:           'ai-factory.thumbnail.extracted',
  HLS_TRANSCODING_STARTED:       'ai-factory.hls.transcoding.started',
  HLS_TRANSCODING_COMPLETED:     'ai-factory.hls.transcoding.completed',

  // Package lifecycle
  ASSET_PACKAGE_PUBLISHED:       'ai-factory.asset.package.published',
  LISTING_READY_FOR_MARKETING:   'ai-factory.listing.ready.for.marketing',

  // Quality & compliance
  VISUAL_QUALITY_CHECKED:        'ai-factory.visual.quality.checked',
  COMPLIANCE_REVIEWED:           'ai-factory.compliance.reviewed',

  // Compensation events
  ASSETS_DELETED:                'ai-factory.assets.deleted',
  RENDER_CANCELLED:              'ai-factory.render.cancelled',
  CREDITS_REFUNDED:              'ai-factory.credits.refunded',
} as const;

// Storage OS Events: Object lifecycle & security
// Audit finding: No multi-tenant isolation, presigned URLs missing → addressed here.
export const StorageOSEvents = {
  OBJECT_UPLOADED:               'storage.object.uploaded',
  OBJECT_DELETED:                'storage.object.deleted',
  PRESIGNED_URL_ISSUED:          'storage.presigned.url.issued',
  OBJECT_ENCRYPTED:              'storage.object.encrypted',
  LIFECYCLE_POLICY_APPLIED:      'storage.lifecycle.policy.applied',
  CDN_INVALIDATION_REQUESTED:    'storage.cdn.invalidation.requested',
  VIRUS_SCAN_PASSED:             'storage.virus.scan.passed',
  VIRUS_SCAN_FAILED:             'storage.virus.scan.failed',
} as const;

// CRM & Revenue Attribution Events
// Audit finding: AI content is disconnected from the sales pipeline → fixed here.
export const CRMAttributionEvents = {
  VIDEO_WATCHED:                 'crm.video.watched',
  LEAD_SCORE_INCREASED:          'crm.lead.score.increased',
  INVESTOR_INTEREST_DETECTED:    'crm.investor.interest.detected',
  DEAL_CREATED_FROM_CONTENT:     'crm.deal.created.from.content',
  PARTNER_NOTIFIED:              'crm.partner.notified',
  REVENUE_ATTRIBUTED:            'crm.revenue.attributed',
} as const;

// Property Pipeline Events
export const PropertyPipelineEvents = {
  PROPERTY_CREATED:              'property.created',
  PROPERTY_CLAIM_REQUESTED:      'property.claim.requested',
  PROPERTY_VERIFIED:             'property.verified',
  PROPERTY_PUBLISHED:            'property.published',
  PROPERTY_UNLISTED:             'property.unlisted',
  OFF_MARKET_MATCHED:            'property.off-market.matched',
} as const;

export const EventCatalog = {
  ...IntentEvents,
  ...TrustEvents,
  ...FinanceEvents,
  ...RevenueEvents,
  ...BookingEvents,
  ...ContractEvents,
  ...CognitiveEvents,
  ...AIFactoryEvents,
  ...StorageOSEvents,
  ...CRMAttributionEvents,
  ...PropertyPipelineEvents,
} as const;

export type EventType = typeof EventCatalog[keyof typeof EventCatalog];
