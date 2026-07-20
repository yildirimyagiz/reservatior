/**
 * Saga: Platform Operations
 *
 * Flow:
 *   platform.deploy.triggered
 *       |
 *   [Pre-deploy checks, health verification]
 *       |
 *   platform.deploy.completed (or platform.deploy.failed)
 *       |
 *   [Post-deploy validation, metric collection]
 *       |
 *   platform.health.check.passed
 */

import { BaseSaga } from './saga-orchestrator';
import { eventBus } from '../events/event-bus';
import { DomainEvents, EventMessage } from '../events/domain-events';

export class PlatformOperationsSaga extends BaseSaga {
  public deployId: string;
  public environment: string;

  constructor(deployId: string, environment: string, sagaId?: string) {
    super(sagaId, { step: 'DEPLOY_TRIGGERED', deployId, environment });
    this.deployId = deployId;
    this.environment = environment;
  }

  protected async compensate(): Promise<void> {
    console.log(`[PlatformOperationsSaga] Compensating deploy ${this.deployId}. Rolling back...`);
    eventBus.publish(DomainEvents.PLATFORM_DEPLOY_FAILED, {
      deployId: this.deployId,
      reason: 'COMPENSATION',
      environment: this.environment,
    }, 'PlatformOS', this.sagaId);
  }

  public async onDeployTriggered() {
    console.log(`[PlatformOperationsSaga] Deploy ${this.deployId} triggered for ${this.environment}. Running pre-deploy checks...`);
    await this.transition({ step: 'PRE_DEPLOY_CHECKS' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.PLATFORM_HEALTH_CHECK_PASSED, {
        deployId: this.deployId,
        environment: this.environment,
      }, 'PlatformOS', this.sagaId);
    }, 800);
  }

  public async onHealthCheckPassed(msg: EventMessage) {
    console.log(`[PlatformOperationsSaga] Pre-deploy health check passed for ${this.deployId}. Deploying...`);
    await this.transition({ step: 'DEPLOYING' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.PLATFORM_DEPLOY_COMPLETED, {
        deployId: this.deployId,
        environment: this.environment,
      }, 'PlatformOS', this.sagaId);
    }, 2000);
  }

  public async onDeployCompleted(msg: EventMessage) {
    console.log(`[PlatformOperationsSaga] Deploy ${this.deployId} completed! Running post-deploy validation...`);
    await this.transition({ step: 'POST_DEPLOY_VALIDATION' });

    setTimeout(() => {
      eventBus.publish(DomainEvents.PLATFORM_HEALTH_CHECK_PASSED, {
        deployId: this.deployId,
        environment: this.environment,
        postDeploy: true,
      }, 'PlatformOS', this.sagaId);
    }, 1000);
  }

  public async onDeployFailed(msg: EventMessage) {
    console.log(`[PlatformOperationsSaga] Deploy ${this.deployId} FAILED. Compensating...`);
    await this.compensate();
  }

  public async onHealthCheckFailed(msg: EventMessage) {
    console.log(`[PlatformOperationsSaga] Post-deploy health check FAILED for ${this.deployId}. Rolling back...`);
    await this.compensate();
  }
}

// ─── Registry ─────────────────────────────────────────────────────────────────
const activeSagas = new Map<string, PlatformOperationsSaga>();

export function registerPlatformOperationsListeners() {
  eventBus.subscribe(DomainEvents.PLATFORM_DEPLOY_TRIGGERED, (msg) => {
    const { deployId, environment } = msg.payload;
    const saga = new PlatformOperationsSaga(deployId, environment, msg.correlationId);
    activeSagas.set(saga.sagaId, saga);
    saga.onDeployTriggered();
    console.log(`[PlatformOperationsSaga] Started for deploy ${deployId}`);
  });

  eventBus.subscribe(DomainEvents.PLATFORM_DEPLOY_COMPLETED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDeployCompleted(msg);
  });

  eventBus.subscribe(DomainEvents.PLATFORM_DEPLOY_FAILED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onDeployFailed(msg);
  });

  eventBus.subscribe(DomainEvents.PLATFORM_HEALTH_CHECK_PASSED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onHealthCheckPassed(msg);
  });

  eventBus.subscribe(DomainEvents.PLATFORM_HEALTH_CHECK_FAILED, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onHealthCheckFailed(msg);
  });
}
