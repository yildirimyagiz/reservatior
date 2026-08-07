/**
 * REOS v5 — Workflow OS: Temporal Workflow Definition
 *
 * This is the durable, persistent counterpart of GeneratePropertyMarketingPackageSaga.
 * Unlike the in-memory BaseSaga, this workflow survives server restarts, retries
 * failed activities automatically, and supports long-running transactions (weeks/months).
 *
 * Key differences from BaseSaga:
 *   - State is persisted in Temporal's event history (PostgreSQL-backed)
 *   - Activities are retried with configurable backoff
 *   - Signals allow external systems to interact mid-workflow
 *   - Queries allow inspection of workflow state at any time
 *   - Compensation is handled via structured try/catch + compensate()
 *
 * IMPORTANT: Workflow code must be deterministic. No I/O, no Date.now(), no random.
 * All I/O happens in Activities.
 */

import {
  proxyActivities,
  defineSignal,
  defineQuery,
  setHandler,
  condition,
  log,
} from '@temporalio/workflow';

import type {
  gatherAISignals,
  evaluateDecision,
  uploadAssetsToStorageOS,
  runVirtualStaging,
  generateBrochure,
  renderVideoAndHLS,
  generateVoiceoverAndSubtitles,
  publishAndNotifyCRM,
  deleteStorageAssets,
  cancelPendingRenders,
  refundCredits,
} from './marketing-package.activities';

// --- Activity proxies (Temporal DI) ---

const {
  gatherAISignals: gatherSignals,
  evaluateDecision: evalDecision,
  uploadAssetsToStorageOS: uploadAssets,
  runVirtualStaging: runStaging,
  generateBrochure: genBrochure,
  renderVideoAndHLS: renderVideo,
  generateVoiceoverAndSubtitles: genVoiceover,
  publishAndNotifyCRM: publishPackage,
  deleteStorageAssets: deleteAssets,
  cancelPendingRenders: cancelRenders,
  refundCredits: doRefund,
} = proxyActivities<
  typeof import('./marketing-package.activities')
>({
  startToCloseTimeout: '10 minutes',
  retry: {
    initialInterval: '5s',
    backoffCoefficient: 2,
    maximumInterval: '2 minutes',
    maximumAttempts: 5,
    nonRetryableErrorTypes: ['ComplianceBlockedError'],
  },
});

// --- Signals (external → workflow) ---

/** Signal: human approval / override received from owner portal */
export const humanApprovalSignal = defineSignal<[{ approved: boolean; reason?: string }]>('humanApproval');

/** Signal: cancel the job (e.g. owner changed their mind) */
export const cancelJobSignal = defineSignal<[{ reason: string }]>('cancelJob');

// --- Queries (external → read workflow state) ---

export const currentStepQuery  = defineQuery<string>('currentStep');
export const workflowStateQuery = defineQuery<object>('workflowState');

// --- Workflow Input / Output ---

export interface MarketingPackageWorkflowInput {
  jobId: string;
  tenantId: string;
  propertyId: string;
  agentId: string;
  language: string;
  pipelineType: string;
  requiresHumanApproval?: boolean;
  credits: number;
}

export interface MarketingPackageWorkflowResult {
  jobId: string;
  status: 'COMPLETED' | 'CANCELLED' | 'COMPENSATED';
  recommendedAction?: string;
  brochureMediaId?: string;
  videoMediaId?: string;
  voiceoverMediaId?: string;
  hlsManifestKey?: string;
  publishedAt?: string;
}

// ─── Main Workflow ────────────────────────────────────────────────────────────

export async function generatePropertyMarketingPackageWorkflow(
  input: MarketingPackageWorkflowInput,
): Promise<MarketingPackageWorkflowResult> {

  const { jobId, tenantId, propertyId, agentId, language, pipelineType, credits } = input;
  const base = { tenantId, propertyId, agentId, language, pipelineType, jobId };

  // Mutable state (safe — Temporal replays deterministically)
  let currentStep = 'INIT';
  let cancelled = false;
  let humanApproved = false;
  let humanApprovalReason: string | undefined;

  // Track what we've done for compensation
  const compensations: Array<() => Promise<void>> = [];

  // --- Register signal handlers ---

  setHandler(cancelJobSignal, ({ reason }) => {
    log.info(`[Temporal] Cancel signal received: ${reason}`);
    cancelled = true;
  });

  setHandler(humanApprovalSignal, ({ approved, reason }) => {
    log.info(`[Temporal] Human approval signal: approved=${approved}`);
    humanApproved = approved;
    humanApprovalReason = reason;
  });

  // --- Register queries ---

  setHandler(currentStepQuery, () => currentStep);
  setHandler(workflowStateQuery, () => ({ currentStep, cancelled, humanApproved, jobId, propertyId }));

  // ─── Step 1: AI Signal Gathering ───────────────────────────────────────────

  currentStep = 'GATHERING_AI_SIGNALS';
  if (cancelled) return compensate(compensations, jobId, 'CANCELLED');

  const { signals } = await gatherSignals(base);
  log.info(`[Temporal] AI signals gathered: ${signals.length} agents`);

  // ─── Step 2: Decision Evaluation ───────────────────────────────────────────

  currentStep = 'EVALUATING_DECISION';
  const decision = await evalDecision({ ...base, aiSignals: signals });
  log.info(`[Temporal] Decision: ${decision.recommendedAction} @ ${(decision.confidence * 100).toFixed(0)}%`);

  // Human approval gate (optional — for high-value / luxury properties)
  if (input.requiresHumanApproval) {
    currentStep = 'AWAITING_HUMAN_APPROVAL';
    log.info('[Temporal] Waiting for human approval signal (max 7 days)...');

    const approved = await condition(
      () => humanApproved || cancelled,
      '7 days', // SLA timer
    );

    if (!approved || cancelled) {
      return compensate(compensations, jobId, 'CANCELLED');
    }
  }

  // ─── Step 3: Upload Raw Assets ─────────────────────────────────────────────

  currentStep = 'UPLOADING_ASSETS';
  const { uploadedKeys } = await uploadAssets(base);
  compensations.push(async () => { await deleteAssets({ tenantId, propertyId, jobId }); });
  log.info(`[Temporal] Uploaded ${uploadedKeys.length} assets`);

  // ─── Step 4: Virtual Staging ───────────────────────────────────────────────

  currentStep = 'STAGING';
  if (cancelled) return compensate(compensations, jobId, 'CANCELLED');
  const { stagedImageKeys } = await runStaging({ ...base, uploadedKeys });
  compensations.push(async () => { await cancelRenders({ jobId }); });

  // ─── Step 5: Generate Brochure ─────────────────────────────────────────────

  currentStep = 'BROCHURE';
  const { brochureMediaId } = await genBrochure(base);

  // ─── Step 6: Render Video + HLS ────────────────────────────────────────────

  currentStep = 'VIDEO_RENDER';
  if (cancelled) return compensate(compensations, jobId, 'CANCELLED');
  const { videoMediaId, thumbnailMediaId, hlsManifestKey } = await renderVideo(base);

  // ─── Step 7: Voiceover + Subtitles ─────────────────────────────────────────

  currentStep = 'VOICEOVER';
  const { voiceoverMediaId } = await genVoiceover(base);

  // ─── Step 8: Publish + Notify CRM ──────────────────────────────────────────

  currentStep = 'PUBLISHING';
  const { publishedAt } = await publishPackage({ ...base, brochureMediaId, videoMediaId });

  currentStep = 'COMPLETED';
  log.info(`[Temporal] Workflow COMPLETED for ${propertyId}`);

  return {
    jobId,
    status: 'COMPLETED',
    recommendedAction: decision.recommendedAction,
    brochureMediaId,
    videoMediaId,
    voiceoverMediaId,
    hlsManifestKey,
    publishedAt,
  };
}

// ─── Compensation helper ──────────────────────────────────────────────────────

async function compensate(
  compensations: Array<() => Promise<void>>,
  jobId: string,
  status: 'CANCELLED' | 'COMPENSATED',
): Promise<MarketingPackageWorkflowResult> {
  log.warn(`[Temporal] Running ${compensations.length} compensations for job=${jobId}`);
  for (const fn of compensations.reverse()) {
    try { await fn(); } catch (e) { log.error(`Compensation failed: ${e}`); }
  }
  return { jobId, status };
}
