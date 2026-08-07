/**
 * AI Factory OS + Storage OS End-to-End Simulation
 * Simulates a full PropertyCreated → LISTING_READY_FOR_MARKETING pipeline.
 */

import { registerMarketingPackageSagaListeners, GeneratePropertyMarketingPackageSaga } from './src/core/workflows/generate-property-marketing-package.saga';
import { eventBus } from './src/core/events/event-bus';
import { PropertyPipelineEvents } from './src/core/domain/events/event-catalog';

// Subscribe to key output events to verify they fire
const receivedEvents: string[] = [];
const track = (event: string) => {
  eventBus.subscribe(event as any, (msg) => {
    receivedEvents.push(event);
    console.log(`  ✓ Event received: ${event}`);
  });
};

track('ai-factory.listing.ready.for.marketing');
track('ai-factory.brochure.generated');
track('ai-factory.video.rendered');
track('ai-factory.hls.transcoding.completed');
track('ai-factory.voiceover.generated');
track('crm.partner.notified');
track('property.published');

// Register the saga listener
registerMarketingPackageSagaListeners();

async function runSimulation() {
  console.log('\n=== REOS v5: AI Factory OS — Marketing Package Saga Simulation ===\n');

  // Trigger via direct call (bypasses event bus for test clarity)
  const saga = new GeneratePropertyMarketingPackageSaga('test-saga-001', {
    tenantId: 'tenant-reservatior',
    propertyId: 'prop-istanbul-beykoz-001',
    agentId: 'agent-007',
    listingTitle: 'Luxury Villa – Beykoz, Istanbul',
    rawImageUrls: ['https://example.com/img1.jpg', 'https://example.com/img2.jpg'],
    language: 'EN',
    pipelineType: 'LUXURY',
    credits: 20,
  });

  const result = await saga.execute();

  console.log('\n--- Saga Result ---');
  console.log(JSON.stringify(result, null, 2));

  console.log('\n--- Events Fired ---');
  console.log(`Total events: ${receivedEvents.length}`);
  receivedEvents.forEach(e => console.log(` • ${e}`));

  const pass = result.status === 'COMPLETED' &&
               result.brochureMediaId !== undefined &&
               result.videoMediaId !== undefined &&
               result.voiceoverMediaId !== undefined;

  console.log(`\n✅ Simulation ${pass ? 'PASSED' : '❌ FAILED'}\n`);
  process.exit(pass ? 0 : 1);
}

runSimulation().catch(err => {
  console.error('Simulation error:', err);
  process.exit(1);
});
