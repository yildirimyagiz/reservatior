export interface LocalizationContext {
  countryCode: string;
  language: string;
  currency: string;
  timezone: string;
}

export interface EventMessage<T = any> {
  id: string;
  type: string;
  timestamp: Date;
  payload: T;
  source: string;
  correlationId?: string;
  localization?: LocalizationContext;
  idempotencyKey?: string;
  version?: string;
  aggregateId?: string;
}

export interface ReliableEventMessage<T = any> extends EventMessage<T> {
  idempotencyKey: string;
  version: string;
  aggregateId: string;
  retryCount?: number;
  metadata?: {
    source?: string;
    correlationId?: string;
    causationId?: string;
    userId?: string;
    orgId?: string;
  };
}

export enum EventProcessingStatus {
  PENDING = 'PENDING',
  PROCESSING = 'PROCESSING',
  COMPLETED = 'COMPLETED',
  FAILED = 'FAILED',
  SKIPPED = 'SKIPPED'
}

export function generateIdempotencyKey(
  eventType: string,
  aggregateId: string,
  timestamp: Date
): string {
  return `${eventType}_${aggregateId}_${timestamp.getTime()}`;
}

export function createReliableEvent<T>(
  eventType: string,
  aggregateId: string,
  payload: T,
  metadata?: {
    source?: string;
    correlationId?: string;
    causationId?: string;
    userId?: string;
    orgId?: string;
  }
): ReliableEventMessage<T> {
  const timestamp = new Date();
  return {
    id: `evt_${timestamp.getTime()}_${Math.random().toString(36).substr(2, 9)}`,
    type: eventType,
    timestamp,
    payload,
    source: metadata?.source || 'unknown',
    correlationId: metadata?.correlationId,
    localization: undefined,
    idempotencyKey: generateIdempotencyKey(eventType, aggregateId, timestamp),
    version: 'v1',
    aggregateId,
    metadata
  };
}
