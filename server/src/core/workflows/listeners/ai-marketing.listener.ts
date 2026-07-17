/**
 * AI Marketing Automation Listener (AI OS)
 * 
 * Listens for `listing.published` events and automatically queues AI service tasks
 * (e.g. REELS_VIDEO_GEN or MARKETING_BROCHURE_GEN) to create marketing creatives.
 */

import { eventBus } from '../../events/event-bus';
import { DomainEvents } from '../../events/domain-events';
import { prisma } from '../../../lib/prisma';
import { AiTaskType, AiTaskStatus } from '@prisma/client';

export function registerAiMarketingListeners() {
  eventBus.subscribe(DomainEvents.LISTING_PUBLISHED, async (msg) => {
    const { agentId, count, listingIds } = msg.payload;
    const correlationId = msg.correlationId;

    console.log(`[AI-OS] 🤖 Received LISTING_PUBLISHED for Agent ${agentId} (${count} listings).`);
    console.log(`[AI-OS] Dispatching REELS_VIDEO_GEN tasks to Neural Hub...`);

    const targetListingIds: string[] = listingIds || [];

    for (const listingId of targetListingIds) {
      // Track DB record IDs for the worker callback
      let taskId: string | null = null;
      let videoRecordId: string | null = null;

      // 1. Persist task + video records (best-effort — non-fatal if DB unavailable in dev)
      try {
        const orgId = 'mock-org-123';
        const task = await prisma.aiServiceTask.create({
          data: {
            orgId,
            listingId,
            taskType: AiTaskType.REELS_VIDEO_GEN,
            status: AiTaskStatus.QUEUED,
            entityType: 'Listing',
            entityId: listingId,
            payload: { platform: 'INSTAGRAM_AND_FACEBOOK', reelsRequested: 1 },
          } as any,
        });
        taskId = task.id;

        const videoRecord = await prisma.aiVideoGeneration.create({
          data: {
            listingId,
            status: 'PENDING',
            sourcePhotos: ['https://mock-storage/photo1.jpg'],
            outputUrls: [],
          } as any,
        });
        videoRecordId = videoRecord.id;

        console.log(`[AI-OS] 📝 Persisted Task ${taskId} & VideoGen ${videoRecordId} for Listing ${listingId}`);
      } catch (dbErr: any) {
        console.warn(`[AI-OS] ⚠️ DB write skipped (${dbErr?.code ?? dbErr?.message}). Event flow continues.`);
      }

      // 2. Simulate AI Worker — always runs, updates DB if records were created
      setTimeout(async () => {
        console.log(`[AI-OS] ⚙️  Worker processing Listing ${listingId}...`);

        if (taskId && videoRecordId) {
          try {
            await prisma.aiServiceTask.update({
              where: { id: taskId },
              data: { status: AiTaskStatus.COMPLETED, result: { success: true, videosCreated: 1 } } as any,
            });
            await prisma.aiVideoGeneration.update({
              where: { id: videoRecordId },
              data: { status: 'COMPLETED', outputUrls: [`https://mock-storage/final-reels-${listingId}.mp4`] } as any,
            });
          } catch (updateErr) {
            console.warn(`[AI-OS] ⚠️ DB update skipped:`, updateErr);
          }
        }

        console.log(`[AI-OS] ✅ Ad creatives ready for Agent ${agentId} / Listing ${listingId}.`);

        // Always emit the domain event — downstream sagas depend on this
        eventBus.publish(DomainEvents.AD_GENERATED, {
          agentId,
          listingId,
          reels: 1,
          platform: 'INSTAGRAM_AND_FACEBOOK',
          creatives: [`https://mock-storage/final-reels-${listingId}.mp4`],
        }, 'AI-OS', correlationId);

      }, 2500);
    }
  });

  console.log(`[AI-OS] 🎧 AI Marketing Automation Listeners Registered.`);
}
