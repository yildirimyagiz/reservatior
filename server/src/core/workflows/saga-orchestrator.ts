import { v4 as uuidv4 } from 'uuid';
import { prismaManager } from '../../lib/prisma';

export enum SagaStatus {
  STARTED = 'STARTED',
  COMPENSATING = 'COMPENSATING',
  COMPLETED = 'COMPLETED',
  FAILED = 'FAILED'
}

/**
 * Base class for a Saga/Workflow.
 * In a production environment, you would save the 'state' to Prisma 
 * on every step transition to survive server restarts.
 */
export abstract class BaseSaga {
  public sagaId: string;
  public status: SagaStatus;
  protected state: any;

  constructor(sagaId?: string, initialState: any = {}) {
    this.sagaId = sagaId || uuidv4();
    this.status = SagaStatus.STARTED;
    this.state = initialState;
    this.persistState();
  }

  /**
   * Called to advance the workflow state.
   */
  protected async transition(newStateData: any): Promise<void> {
    this.state = { ...this.state, ...newStateData };
    await this.persistState();
  }

  protected async complete(): Promise<void> {
    this.status = SagaStatus.COMPLETED;
    await this.persistState();
    console.log(`[Saga ${this.constructor.name}] Completed: ${this.sagaId}`);
  }

  protected async fail(reason: string): Promise<void> {
    this.status = SagaStatus.FAILED;
    this.state.failureReason = reason;
    await this.persistState();
    console.error(`[Saga ${this.constructor.name}] Failed: ${this.sagaId} - ${reason}`);
    await this.compensate();
  }

  /**
   * Implement compensating transactions here (e.g. rollback DB, cancel stripe charge)
   */
  protected abstract compensate(): Promise<void>;

  /**
   * Real persistence to Prisma Event Sourcing Table
   */
  private async persistState(): Promise<void> {
    try {
      const prisma = prismaManager.getClient('US');
      await prisma.sagaState.upsert({
        where: { correlationId: this.sagaId },
        create: {
          correlationId: this.sagaId,
          sagaType: this.constructor.name,
          currentStep: this.state.step || 'INIT',
          status: this.status,
          context: this.state
        },
        update: {
          currentStep: this.state.step || 'UPDATE',
          status: this.status,
          context: this.state
        }
      });
      // console.log(`[SagaState] DB Persisted state for ${this.sagaId}`);
    } catch (err) {
      console.error(`[SagaState] Failed to persist Saga ${this.sagaId}`, err);
    }
  }
}
