/**
 * REOS v5 — Workflow OS: Temporal Activities
 *
 * Activities are the individual durable steps of the marketing package workflow.
 * Temporal guarantees: if the worker crashes mid-flight, the activity is retried
 * automatically with exponential backoff. State is persisted in Temporal's DB.
 *
 * Each activity corresponds to a step in GeneratePropertyMarketingPackageSaga.
 */

import { activityInfo, heartbeat } from '@temporalio/activity';

// Safe heartbeat: no-ops when called outside a Temporal worker context (e.g. integration tests)
const safeHeartbeat = (details?: any) => {
  try { safeHeartbeat(details); } catch { /* not in Temporal context — no-op */ }
};

export interface ActivityInput {
  tenantId: string;
  propertyId: string;
  agentId: string;
  language: string;
  pipelineType: string;
  jobId: string;
}

// ─── Activity: Gather AI Signals ─────────────────────────────────────────────

export async function gatherAISignals(input: ActivityInput) {
  const { propertyId, jobId } = input;
  console.log(`  [Temporal Activity: gatherAISignals] job=${jobId}`);
  safeHeartbeat('gathering AI signals');

  // In production: calls AgentRuntime.gatherSignals()
  await sleep(200);

  return {
    signals: [
      { agentId: 'PricingAgent',    recommendation: 'CORPORATE_MASTER_LEASE', confidence: 0.91 },
      { agentId: 'RiskAgent',       recommendation: 'CORPORATE_MASTER_LEASE', confidence: 0.88 },
      { agentId: 'ComplianceAgent', recommendation: 'LONG_TERM_RENT',         confidence: 0.75 },
    ],
    propertyId,
  };
}

// ─── Activity: Evaluate Decision ─────────────────────────────────────────────

export async function evaluateDecision(input: ActivityInput & { aiSignals: any[] }) {
  console.log(`  [Temporal Activity: evaluateDecision] job=${input.jobId}`);
  safeHeartbeat('evaluating decision');

  // In production: calls DecisionPipeline.run()
  await sleep(150);

  return {
    recommendedAction: 'CORPORATE_MASTER_LEASE',
    confidence: 0.93,
    suggestedSaga: 'CorporateLeaseSaga',
    suggestedAgents: ['KW Partner Network'],
    blockedActions: ['SHORT_TERM_RENT'],
  };
}

// ─── Activity: Upload Assets to Storage OS ───────────────────────────────────

export async function uploadAssetsToStorageOS(input: ActivityInput) {
  console.log(`  [Temporal Activity: uploadAssetsToStorageOS] job=${input.jobId}`);
  safeHeartbeat('uploading assets');

  // In production: calls storageGateway.upload() for each raw image
  await sleep(300);

  return {
    uploadedKeys: [
      `${input.tenantId}/${input.propertyId}/images/raw-001.jpg`,
      `${input.tenantId}/${input.propertyId}/images/raw-002.jpg`,
    ],
    uploadedAt: new Date().toISOString(),
  };
}

// ─── Activity: Run Virtual Staging ───────────────────────────────────────────

export async function runVirtualStaging(input: ActivityInput & { uploadedKeys: string[] }) {
  console.log(`  [Temporal Activity: runVirtualStaging] pipeline=${input.pipelineType}`);
  safeHeartbeat('staging in progress');

  // In production: calls comfysetup API → /api/v1/staging/generate
  await sleep(800);

  return {
    stagedImageKeys: [`${input.tenantId}/${input.propertyId}/images/staged-001.webp`],
    stagingCompletedAt: new Date().toISOString(),
  };
}

// ─── Activity: Generate Brochure ─────────────────────────────────────────────

export async function generateBrochure(input: ActivityInput) {
  console.log(`  [Temporal Activity: generateBrochure] lang=${input.language}`);
  safeHeartbeat('generating brochure');

  // In production: calls brochure-service → storageGateway.upload(PDF)
  await sleep(400);

  return {
    brochureMediaId: `brochure-${input.jobId}`,
    brochureKey: `${input.tenantId}/${input.propertyId}/brochures/${input.jobId}.pdf`,
  };
}

// ─── Activity: Render Video + HLS ────────────────────────────────────────────

export async function renderVideoAndHLS(input: ActivityInput) {
  console.log(`  [Temporal Activity: renderVideoAndHLS] job=${input.jobId}`);
  safeHeartbeat('rendering video');

  // In production: calls video-neural-engine → ffmpeg HLS segmenter → storageGateway
  await sleep(1000);

  return {
    videoMediaId:    `video-${input.jobId}`,
    thumbnailMediaId: `thumbnail-${input.jobId}`,
    hlsManifestKey:  `${input.tenantId}/${input.propertyId}/hls/manifest.m3u8`,
    renderedAt: new Date().toISOString(),
  };
}

// ─── Activity: Generate Voiceover + Subtitles ────────────────────────────────

export async function generateVoiceoverAndSubtitles(input: ActivityInput) {
  console.log(`  [Temporal Activity: generateVoiceoverAndSubtitles] lang=${input.language}`);
  safeHeartbeat('generating voiceover');

  // In production: calls voiceover-service.ts → ElevenLabs/GCP TTS → storageGateway
  await sleep(500);

  return {
    voiceoverMediaId: `voiceover-${input.jobId}`,
    subtitleKey: `${input.tenantId}/${input.propertyId}/subtitles/${input.language}.vtt`,
  };
}

// ─── Activity: Publish Package + Notify CRM ──────────────────────────────────

export async function publishAndNotifyCRM(
  input: ActivityInput & { brochureMediaId: string; videoMediaId: string }
) {
  console.log(`  [Temporal Activity: publishAndNotifyCRM] job=${input.jobId}`);
  safeHeartbeat('publishing and notifying');

  // In production: marks listing ACTIVE, notifies agent network, emits CRM events
  await sleep(200);

  return {
    publishedAt: new Date().toISOString(),
    notifiedAgents: ['KW Partner Network', 'Corporate Relocation Desk'],
    listingStatus: 'ACTIVE',
  };
}

// ─── Compensation Activities (called on failure) ──────────────────────────────

export async function deleteStorageAssets(input: { tenantId: string; propertyId: string; jobId: string }) {
  console.log(`  [Temporal Compensation: deleteStorageAssets] job=${input.jobId}`);
  await sleep(100);
  return { deleted: true, reason: 'saga_compensation' };
}

export async function cancelPendingRenders(input: { jobId: string }) {
  console.log(`  [Temporal Compensation: cancelPendingRenders] job=${input.jobId}`);
  await sleep(50);
  return { cancelled: true };
}

export async function refundCredits(input: { tenantId: string; jobId: string; credits: number }) {
  console.log(`  [Temporal Compensation: refundCredits] job=${input.jobId}, credits=${input.credits}`);
  await sleep(50);
  return { refunded: input.credits };
}

const sleep = (ms: number) => new Promise(r => setTimeout(r, ms));
