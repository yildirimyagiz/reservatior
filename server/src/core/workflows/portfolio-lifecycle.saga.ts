/**
 * Saga: Portfolio Lifecycle
 *
 * Flow:
 *   portfolio.created
 *       |
 *   [Portfolio analysis, risk assessment]
 *       |
 *   portfolio.holding.added
 *       |
 *   portfolio.valuation.updated
 *       |
 *   [Rebalancing if needed]
 *       |
 *   portfolio.report.generated
 */

import { BaseSaga } from './saga-orchestrator';
import { eventBus } from '../events/event-bus';
import { DomainEvents, EventMessage } from '../events/domain-events';

export class PortfolioLifecycleSaga extends BaseSaga {
  public portfolioId: string;
  public orgId: string;

  constructor(portfolioId: string, orgId: string, sagaId?: string) {
    super(sagaId, { step: 'PORTFOLIO_CREATED', portfolioId, orgId });
    this.portfolioId = portfolioId;
    this.orgId = orgId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[PortfolioLifecycleSaga] Compensating portfolio ${this.portfolioId}. Rolling back...`);
  }

  public async onPortfolioCreated() {
    console.log(`[PortfolioLifecycleSaga] Portfolio ${this.portfolioId} created. Running initial analysis...`);
    await this.transition({ step: 'ANALYZING' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.PORTFOLIO_VALUATION_UPDATED, {
        portfolioId: this.portfolioId,
        orgId: this.orgId,
      }, 'PortfolioOS', this.sagaId);
    }, 1200);
  }

  public async onHoldingAdded(msg: EventMessage) {
    console.log(`[PortfolioLifecycleSaga] Holding added to portfolio ${this.portfolioId}. Triggering valuation...`);
    await this.transition({ step: 'VALUATING' });

    eventBus.publish(DomainEvents.VALUATION_REQUESTED, {
      portfolioId: this.portfolioId,
      propertyId: msg.payload.propertyId,
      orgId: this.orgId,
    }, 'PortfolioOS', this.sagaId);
  }

  public async onValuationCompleted(msg: EventMessage) {
    console.log(`[PortfolioLifecycleSaga] Valuation completed for portfolio ${this.portfolioId}.`);
    await this.transition({ step: 'VALUATION_COMPLETE' });

    eventBus.publish(DomainEvents.PORTFOLIO_REBALANCED, {
      portfolioId: this.portfolioId,
      orgId: this.orgId,
    }, 'PortfolioOS', this.sagaId);
  }

  public async onRebalanced(msg: EventMessage) {
    console.log(`[PortfolioLifecycleSaga] Portfolio ${this.portfolioId} rebalanced. Generating report...`);
    await this.transition({ step: 'GENERATING_REPORT' });

    eventBus.publish(DomainEvents.PORTFOLIO_REPORT_GENERATED, {
      portfolioId: this.portfolioId,
      orgId: this.orgId,
    }, 'PortfolioOS', this.sagaId);
  }

  public async onReportGenerated(msg: EventMessage) {
    console.log(`[PortfolioLifecycleSaga] Portfolio ${this.portfolioId} report generated. Pipeline COMPLETE.`);
    await this.complete();
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, PortfolioLifecycleSaga>();

export function registerPortfolioLifecycleListeners() {
  eventBus.subscribe(DomainEvents.PORTFOLIO_CREATED, (msg) => {
    const { portfolioId, orgId } = msg.payload;
    const saga = new PortfolioLifecycleSaga(portfolioId, orgId, msg.correlationId);
    activeSagas.set(saga.sagaId, saga);
    saga.onPortfolioCreated();
    console.log(`[PortfolioLifecycleSaga] Started for portfolio ${portfolioId}`);
  });

  eventBus.subscribe(DomainEvents.PORTFOLIO_HOLDING_ADDED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onHoldingAdded(msg);
  });

  eventBus.subscribe(DomainEvents.VALUATION_COMPLETED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onValuationCompleted(msg);
  });

  eventBus.subscribe(DomainEvents.PORTFOLIO_REBALANCED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onRebalanced(msg);
  });

  eventBus.subscribe(DomainEvents.PORTFOLIO_REPORT_GENERATED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onReportGenerated(msg);
  });
}
