/**
 * REOS v5 — GeneratePropertyMarketingPackageSaga
 *
 * Workflow OS: Full 8-step Saga orchestrating the AI Factory OS production pipeline.
 *
 * Trigger:  PropertyPipelineEvents.PROPERTY_CREATED (or manual kick-off)
 * Steps:
 *   1. Create AI Job & reserve credits
 *   2. Upload raw assets to Storage OS
 *   3. Run Virtual Staging (ComfyUI / A1111)
 *   4. Generate Brochure (PDF)
 *   5. Render Video walkthrough
 *   6. Generate Voiceover + Subtitles
 *   7. Publish asset package (mark listing ready)
 *   8. Notify CRM / Partner Network / Owner
 *
 * Compensation (if any step fails):
 *   - Delete generated assets from Storage OS
 *   - Cancel queued renders
 *   - Refund credits
 *   - Revert listing status to DRAFT
 *   - Emit ASSETS_DELETED and CREDITS_REFUNDED events
 */

import { BaseSaga } from './saga-orchestrator';
import { eventBus } from '../events/event-bus';
import {
  AIFactoryEvents,
  StorageOSEvents,
  CRMAttributionEvents,
  PropertyPipelineEvents,
} from '../domain/events/event-catalog';
import { storageGateway } from '../storage/storage-gateway';

// --- Types ---

export interface MarketingPackageContext {
  tenantId: string;
  propertyId: string;
  agentId: string;
  listingTitle: string;
  rawImageUrls: string[];   // Source images from upload form
  language: 'TR' | 'EN' | 'DE' | 'AR' | 'RU' | 'ES';
  pipelineType: 'STANDARD' | 'LUXURY' | 'INVEST';
  credits?: number;         // Credits reserved for this run
}

export interface MarketingPackageResult {
  jobId: string;
  stagedImageKeys: string[];
  brochureMediaId?: string;
  videoMediaId?: string;
  voiceoverMediaId?: string;
  thumbnailMediaId?: string;
  hlsManifestKey?: string;
  packagePublishedAt?: string;
  status: 'COMPLETED' | 'FAILED' | 'COMPENSATED';
}

// --- Saga ---

export class GeneratePropertyMarketingPackageSaga extends BaseSaga {
  private readonly ctx: MarketingPackageContext;
  private readonly result: Partial<MarketingPackageResult>;

  constructor(sagaId: string, ctx: MarketingPackageContext) {
    super(sagaId);
    this.ctx = ctx;
    this.result = { jobId: sagaId, stagedImageKeys: [] };
  }

  async execute(): Promise<MarketingPackageResult> {
    console.log(`\n[MarketingPackageSaga] 🚀 Starting for property ${this.ctx.propertyId}`);

    try {
      await this.step1_createJobAndReserveCredits();
      await this.step2_uploadRawAssets();
      await this.step3_runVirtualStaging();
      await this.step4_generateBrochure();
      await this.step5_renderVideo();
      await this.step6_generateVoiceoverAndSubtitles();
      await this.step7_publishAssetPackage();
      await this.step8_notifyCRMAndPartners();

      this.result.status = 'COMPLETED';
      console.log(`[MarketingPackageSaga] ✅ Completed for ${this.ctx.propertyId}`);
      return this.result as MarketingPackageResult;

    } catch (error) {
      console.error(`[MarketingPackageSaga] ❌ Failed at step: ${this.state?.step || 'unknown'}`, error);
      await this.compensate();
      this.result.status = 'COMPENSATED';
      return this.result as MarketingPackageResult;
    }
  }

  // ─── Step 1: Create AI Job & Reserve Credits ────────────────────────────────

  private async step1_createJobAndReserveCredits() {
    await this.transition({ step: 'CREATE_JOB' });

    // Compensation: refund credits if later steps fail
    this.registerCompensation('refund_credits', async () => {
      eventBus.publish(
        AIFactoryEvents.CREDITS_REFUNDED,
        { jobId: this.sagaId, tenantId: this.ctx.tenantId, credits: this.ctx.credits },
        'MarketingPackageSaga', this.sagaId,
      );
    });

    eventBus.publish(
      AIFactoryEvents.AI_JOB_QUEUED,
      {
        jobId: this.sagaId,
        tenantId: this.ctx.tenantId,
        propertyId: this.ctx.propertyId,
        pipelineType: this.ctx.pipelineType,
      },
      'MarketingPackageSaga', this.sagaId,
    );

    // Simulate credit reservation (would call Finance OS in production)
    await this.simulateWork(200);

    eventBus.publish(
      AIFactoryEvents.AI_JOB_STARTED,
      { jobId: this.sagaId, startedAt: new Date().toISOString() },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Step 2: Upload Raw Assets to Storage OS ────────────────────────────────

  private async step2_uploadRawAssets() {
    await this.transition({ step: 'UPLOAD_ASSETS' });

    // Compensation: delete all objects under this property prefix
    this.registerCompensation('delete_raw_assets', async () => {
      const keys = await storageGateway.list(this.ctx.tenantId, this.ctx.propertyId);
      for (const key of keys) {
        await storageGateway.delete(key, 'cleanup');
      }
      eventBus.publish(
        AIFactoryEvents.ASSETS_DELETED,
        { jobId: this.sagaId, propertyId: this.ctx.propertyId },
        'MarketingPackageSaga', this.sagaId,
      );
    });

    // Simulate uploading raw images (in production: stream from request / S3 copy)
    console.log(`  [Step 2] Uploading ${this.ctx.rawImageUrls.length} raw images to Storage OS...`);
    await this.simulateWork(300);

    eventBus.publish(
      StorageOSEvents.OBJECT_UPLOADED,
      { propertyId: this.ctx.propertyId, count: this.ctx.rawImageUrls.length },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Step 3: Virtual Staging (ComfyUI / A1111) ──────────────────────────────

  private async step3_runVirtualStaging() {
    await this.transition({ step: 'STAGING' });

    // Compensation: cancel queued renders
    this.registerCompensation('cancel_staging_render', async () => {
      eventBus.publish(
        AIFactoryEvents.RENDER_CANCELLED,
        { jobId: this.sagaId, stage: 'staging' },
        'MarketingPackageSaga', this.sagaId,
      );
    });

    eventBus.publish(
      AIFactoryEvents.STAGING_STARTED,
      { jobId: this.sagaId, propertyId: this.ctx.propertyId },
      'MarketingPackageSaga', this.sagaId,
    );

    // Simulate staging inference call (would POST to /api/v1/staging/generate)
    console.log(`  [Step 3] Running virtual staging pipeline (${this.ctx.pipelineType})...`);
    await this.simulateWork(800);

    // Store staged image media IDs
    (this.result.stagedImageKeys as string[]).push(`staged-image-${this.ctx.propertyId}-001`);

    eventBus.publish(
      AIFactoryEvents.STAGING_COMPLETED,
      { jobId: this.sagaId, stagedCount: 1 },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Step 4: Generate Brochure (PDF) ────────────────────────────────────────

  private async step4_generateBrochure() {
    await this.transition({ step: 'BROCHURE' });

    console.log(`  [Step 4] Generating branded brochure (lang: ${this.ctx.language})...`);
    await this.simulateWork(400);

    // In production: call brochure-service.ts → upload PDF to Storage OS → get mediaId
    this.result.brochureMediaId = `brochure-${this.sagaId}`;

    eventBus.publish(
      AIFactoryEvents.BROCHURE_GENERATED,
      { jobId: this.sagaId, mediaId: this.result.brochureMediaId, language: this.ctx.language },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Step 5: Render Video Walkthrough ───────────────────────────────────────

  private async step5_renderVideo() {
    await this.transition({ step: 'VIDEO_RENDER' });

    this.registerCompensation('cancel_video_render', async () => {
      eventBus.publish(
        AIFactoryEvents.RENDER_CANCELLED,
        { jobId: this.sagaId, stage: 'video' },
        'MarketingPackageSaga', this.sagaId,
      );
    });

    eventBus.publish(
      AIFactoryEvents.VIDEO_RENDER_STARTED,
      { jobId: this.sagaId },
      'MarketingPackageSaga', this.sagaId,
    );

    console.log(`  [Step 5] Rendering video walkthrough + HLS transcode...`);
    await this.simulateWork(1000);

    this.result.videoMediaId = `video-${this.sagaId}`;
    this.result.thumbnailMediaId = `thumbnail-${this.sagaId}`;
    this.result.hlsManifestKey = `${this.ctx.tenantId}/${this.ctx.propertyId}/hls/manifest.m3u8`;

    eventBus.publish(AIFactoryEvents.VIDEO_RENDERED,
      { jobId: this.sagaId, mediaId: this.result.videoMediaId },
      'MarketingPackageSaga', this.sagaId,
    );
    eventBus.publish(AIFactoryEvents.HLS_TRANSCODING_COMPLETED,
      { jobId: this.sagaId, manifestKey: this.result.hlsManifestKey },
      'MarketingPackageSaga', this.sagaId,
    );
    eventBus.publish(AIFactoryEvents.THUMBNAIL_EXTRACTED,
      { jobId: this.sagaId, mediaId: this.result.thumbnailMediaId },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Step 6: Voiceover + Subtitles ──────────────────────────────────────────

  private async step6_generateVoiceoverAndSubtitles() {
    await this.transition({ step: 'VOICEOVER' });

    console.log(`  [Step 6] Generating voiceover + subtitles (lang: ${this.ctx.language})...`);
    await this.simulateWork(500);

    this.result.voiceoverMediaId = `voiceover-${this.sagaId}`;

    eventBus.publish(AIFactoryEvents.VOICEOVER_GENERATED,
      { jobId: this.sagaId, mediaId: this.result.voiceoverMediaId },
      'MarketingPackageSaga', this.sagaId,
    );
    eventBus.publish(AIFactoryEvents.SUBTITLE_GENERATED,
      { jobId: this.sagaId, language: this.ctx.language },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Step 7: Publish Asset Package ──────────────────────────────────────────

  private async step7_publishAssetPackage() {
    await this.transition({ step: 'PUBLISH' });

    console.log(`  [Step 7] Publishing asset package & updating listing status...`);
    await this.simulateWork(200);

    this.result.packagePublishedAt = new Date().toISOString();

    eventBus.publish(AIFactoryEvents.ASSET_PACKAGE_PUBLISHED,
      { jobId: this.sagaId, propertyId: this.ctx.propertyId, publishedAt: this.result.packagePublishedAt },
      'MarketingPackageSaga', this.sagaId,
    );
    eventBus.publish(AIFactoryEvents.LISTING_READY_FOR_MARKETING,
      { propertyId: this.ctx.propertyId, agentId: this.ctx.agentId },
      'MarketingPackageSaga', this.sagaId,
    );
    eventBus.publish(PropertyPipelineEvents.PROPERTY_PUBLISHED,
      { propertyId: this.ctx.propertyId, tenantId: this.ctx.tenantId },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Step 8: Notify CRM & Partner Network ───────────────────────────────────

  private async step8_notifyCRMAndPartners() {
    await this.transition({ step: 'NOTIFY' });

    console.log(`  [Step 8] Notifying CRM, Partner Network, and Owner...`);
    await this.simulateWork(150);

    eventBus.publish(CRMAttributionEvents.PARTNER_NOTIFIED,
      { propertyId: this.ctx.propertyId, agentId: this.ctx.agentId },
      'MarketingPackageSaga', this.sagaId,
    );
    eventBus.publish(CRMAttributionEvents.REVENUE_ATTRIBUTED,
      { propertyId: this.ctx.propertyId, jobId: this.sagaId },
      'MarketingPackageSaga', this.sagaId,
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  private simulateWork(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

// --- Bootstrap: listen for PropertyCreated events ---

import { getTemporalClient } from './temporal/client';

export function registerMarketingPackageSagaListeners() {
  eventBus.subscribe(PropertyPipelineEvents.PROPERTY_CREATED, async (msg) => {
    const { tenantId, propertyId, agentId, title, rawImageUrls, language, pipelineType } = msg.payload;
    const sagaId = `marketing-${propertyId}-${Date.now()}`;

    console.log(`[MarketingPackageSaga] 🚀 Triggering Temporal Workflow for ${propertyId}`);

    try {
      const client = await getTemporalClient();
      
      const handle = await client.workflow.start('generatePropertyMarketingPackageWorkflow', {
        taskQueue: process.env.TEMPORAL_TASK_QUEUE ?? 'reos-marketing-package',
        workflowId: sagaId,
        args: [{
          jobId: sagaId,
          tenantId: tenantId ?? 'default',
          propertyId,
          agentId,
          language: language ?? 'EN',
          pipelineType: pipelineType ?? 'STANDARD',
          credits: 10,
        }],
      });

      console.log(`[MarketingPackageSaga] Started Temporal Workflow with ID: ${handle.workflowId}`);
    } catch (err) {
      console.error(`[MarketingPackageSaga] ❌ Failed to start Temporal Workflow:`, err);
    }
  });
}
