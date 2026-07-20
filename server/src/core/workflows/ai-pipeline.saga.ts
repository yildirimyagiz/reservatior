import { BaseSaga } from './saga-orchestrator';
import { LocalizationContext, EventMessage } from '../events/domain-events';
import { eventBus } from '../events/event-bus';
import { DomainEvents } from '../events/domain-events';

export class AIPipelineSaga extends BaseSaga {
  public modelId: string;
  public modelType: string;
  public trainingDataId: string;
  public organizationId: string;

  constructor(modelId: string, modelType: string, trainingDataId: string, organizationId: string, sagaId?: string, localization?: LocalizationContext) {
    super(sagaId, { step: 'MODEL_TRAINING_STARTED', modelId, modelType, trainingDataId, organizationId }, localization);
    this.modelId = modelId;
    this.modelType = modelType;
    this.trainingDataId = trainingDataId;
    this.organizationId = organizationId;
  }

  protected async compensate(): Promise<void> {
    console.log(`[AIPipelineSaga] Compensating model ${this.modelId}. Rolling back training...`);
  }

  public async onModelTrained() {
    console.log(`[AIPipelineSaga] Model ${this.modelId} trained. Deploying...`);
    await this.transition({ step: 'DEPLOYING_MODEL' });
    setTimeout(() => {
      eventBus.publish(DomainEvents.AI_PREDICTION_MADE, { modelId: this.modelId, prediction: {}, localization: this.localization }, 'AIOS', this.sagaId);
    }, 2000);
  }

  public async onPredictionMade(msg: EventMessage) {
    console.log(`[AIPipelineSaga] Prediction made for model ${this.modelId}. AI SAGA COMPLETE.`);
    await this.complete();
  }
}

const activeSagas = new Map<string, AIPipelineSaga>();

export function registerAIPipelineListeners() {
  eventBus.subscribe(DomainEvents.AI_MODEL_TRAINED, (msg) => {
    const saga = new AIPipelineSaga(msg.payload.modelId, msg.payload.modelType, msg.payload.trainingDataId, msg.payload.organizationId, msg.correlationId, msg.localization);
    activeSagas.set(saga.sagaId, saga);
    saga.onModelTrained();
  });
  eventBus.subscribe(DomainEvents.AI_PREDICTION_MADE, (msg) => {
    const saga = activeSagas.get(msg.correlationId!);
    if (saga) saga.onPredictionMade(msg);
  });
}
