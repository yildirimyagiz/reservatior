/**
 * REOS v5 — Full Stack End-to-End Simulation
 *
 * Pipeline:
 *   1. AgentRuntime.gatherSignals()   → AI agents (Gemini/Claude/OpenAI/mock)
 *   2. DecisionPipeline.run()         → Decision OS with AI signals + Policy constraints
 *   3. Temporal Workflow (simulated)  → Durable 8-step Workflow OS execution
 *
 * This simulation runs WITHOUT a live Temporal server by directly calling
 * activities in sequence (integration test mode).
 */

import { agentRuntime } from './src/core/ai/agent-runtime';
import { decisionPipeline } from './src/core/decision/decision-pipeline';
import { eventBus } from './src/core/events/event-bus';
import { CognitiveEvents, AIFactoryEvents } from './src/core/domain/events/event-catalog';
import type { DecisionContext } from './src/core/decision/decision-types';

// Import activities directly for simulation (no Temporal server needed)
import {
  gatherAISignals,
  uploadAssetsToStorageOS,
  runVirtualStaging,
  generateBrochure,
  renderVideoAndHLS,
  generateVoiceoverAndSubtitles,
  publishAndNotifyCRM,
} from './src/core/workflows/temporal/marketing-package.activities';

// ─── Track events ─────────────────────────────────────────────────────────────

const firedEvents: string[] = [];
const trackEvent = (ev: string) => {
  eventBus.subscribe(ev as any, () => {
    firedEvents.push(ev);
  });
};

trackEvent(CognitiveEvents.PREDICTION_COMPLETED);
trackEvent(CognitiveEvents.DECISION_GENERATED);
trackEvent(CognitiveEvents.POLICY_EVALUATED);
trackEvent(AIFactoryEvents.BROCHURE_GENERATED);
trackEvent(AIFactoryEvents.VIDEO_RENDERED);
trackEvent(AIFactoryEvents.LISTING_READY_FOR_MARKETING);

// ─── Simulation ───────────────────────────────────────────────────────────────

async function runFullStackSimulation() {
  console.log('\n╔═══════════════════════════════════════════════════════════════╗');
  console.log('║  REOS v5: Full Stack Simulation                               ║');
  console.log('║  AI OS (Gemini/Claude/OpenAI) → Decision OS → Temporal WF    ║');
  console.log('╚═══════════════════════════════════════════════════════════════╝\n');

  const PROPERTY = {
    jobId:        'sim-fullstack-001',
    tenantId:     'tenant-reservatior',
    propertyId:   'prop-dubai-downtown-001',
    agentId:      'agent-007',
    language:     'EN' as const,
    pipelineType: 'LUXURY',
    countryCode:  'AE',
    credits:      20,
  };

  const base = {
    tenantId:     PROPERTY.tenantId,
    propertyId:   PROPERTY.propertyId,
    agentId:      PROPERTY.agentId,
    language:     PROPERTY.language,
    pipelineType: PROPERTY.pipelineType,
    jobId:        PROPERTY.jobId,
  };

  // ─── Phase 1: AI OS — Agent Runtime ───────────────────────────────────────

  console.log('━━━ Phase 1: AI OS — Agent Runtime ━━━\n');

  const agentInput = {
    propertyId:   PROPERTY.propertyId,
    propertyType: 'LUXURY',
    countryCode:  PROPERTY.countryCode,
    listingTitle: 'Luxury Penthouse — Dubai Downtown',
    marketData: {
      avgRentalYield:           0.09,   // 9% — typical Dubai yield
      neighborhoodDemandScore:  95,
      marketTrend:              'RISING',
      corporateDemandPresent:   true,
      touristDemandPresent:     true,
      investorInterestLevel:    'HIGH',
    },
  };

  const aiSignals = await agentRuntime.gatherSignals(agentInput);

  console.log(`\n  ✓ ${aiSignals.length} agents responded:`);
  aiSignals.forEach(s => {
    console.log(`    • ${s.agentId}: ${s.recommendation} @ ${(s.confidence * 100).toFixed(0)}%`);
  });

  // ─── Phase 2: Decision OS ─────────────────────────────────────────────────

  console.log('\n━━━ Phase 2: Decision OS — Pipeline ━━━\n');

  const decisionCtx: DecisionContext = {
    requestId:    PROPERTY.jobId,
    tenantId:     PROPERTY.tenantId,
    actorId:      PROPERTY.agentId,
    propertyId:   PROPERTY.propertyId,
    propertyType: 'LUXURY',
    countryCode:  PROPERTY.countryCode,
    currency:     'USD',
    objective:    'MAXIMIZE_REVENUE',
    knowledge: {
      neighborhoodDemandScore: 95,
      marketTrend:             'RISING',
      corporateDemandPresent:  true,
      touristDemandPresent:    true,
      investorInterestLevel:   'HIGH',
      avgRentalYield:          0.09,
    },
    aiSignals,         // ← real signals from Phase 1
    policyConstraints: [], // AE has no short-stay ban
  };

  const decision = await decisionPipeline.run(decisionCtx);

  console.log(`\n  ✓ Decision: ${decision.recommendedAction} (${(decision.confidence * 100).toFixed(0)}%)`);
  console.log(`  ✓ Saga:     ${decision.suggestedSaga}`);
  console.log(`  ✓ Agents:   ${(decision.suggestedAgents ?? []).join(', ')}`);

  // ─── Phase 3: Temporal Workflow (activity simulation) ─────────────────────

  console.log('\n━━━ Phase 3: Workflow OS — Temporal Activities ━━━\n');

  // Simulate step by step (no live Temporal server needed for integration test)
  const { signals } = await gatherAISignals(base);
  console.log(`  ✓ Step 1: ${signals.length} AI signals gathered`);

  const { uploadedKeys } = await uploadAssetsToStorageOS(base);
  console.log(`  ✓ Step 2: ${uploadedKeys.length} assets uploaded to Storage OS`);

  const { stagedImageKeys } = await runVirtualStaging({ ...base, uploadedKeys });
  console.log(`  ✓ Step 3: Staging completed — ${stagedImageKeys.length} images`);

  const { brochureMediaId } = await generateBrochure(base);
  console.log(`  ✓ Step 4: Brochure generated — mediaId: ${brochureMediaId}`);

  const { videoMediaId, hlsManifestKey } = await renderVideoAndHLS(base);
  console.log(`  ✓ Step 5: Video + HLS rendered — mediaId: ${videoMediaId}`);

  const { voiceoverMediaId } = await generateVoiceoverAndSubtitles(base);
  console.log(`  ✓ Step 6: Voiceover generated — mediaId: ${voiceoverMediaId}`);

  const { publishedAt, notifiedAgents } = await publishAndNotifyCRM({ ...base, brochureMediaId, videoMediaId });
  console.log(`  ✓ Step 7: Published at ${publishedAt}`);
  console.log(`  ✓ Step 8: Notified: ${notifiedAgents.join(', ')}`);

  // ─── Results ──────────────────────────────────────────────────────────────

  await new Promise(r => setTimeout(r, 100)); // flush event bus

  console.log('\n━━━ Validation ━━━\n');

  const checks = [
    { label: `${aiSignals.length} AI agents responded`,                          pass: aiSignals.length >= 3 },
    { label: 'Decision generated with confidence > 50%',                          pass: decision.confidence > 0.5 },
    { label: 'Suggested saga is set',                                             pass: !!decision.suggestedSaga },
    { label: 'Brochure mediaId returned',                                         pass: !!brochureMediaId },
    { label: 'Video + HLS manifest key returned',                                 pass: !!videoMediaId && !!hlsManifestKey },
    { label: 'Voiceover mediaId returned',                                        pass: !!voiceoverMediaId },
    { label: 'Package published',                                                 pass: !!publishedAt },
    { label: 'DECISION_GENERATED event fired',                                    pass: firedEvents.includes(CognitiveEvents.DECISION_GENERATED) },
    { label: `PREDICTION_COMPLETED fired ${aiSignals.length}x`,                  pass: firedEvents.filter(e => e === CognitiveEvents.PREDICTION_COMPLETED).length >= aiSignals.length },
  ];

  let allPassed = true;
  for (const c of checks) {
    const icon = c.pass ? '✅' : '❌';
    console.log(`  ${icon} ${c.label}`);
    if (!c.pass) allPassed = false;
  }

  console.log(`\n${ allPassed ? '✅ ALL TESTS PASSED' : '❌ SOME TESTS FAILED' }`);
  console.log(`\nEvents fired: ${firedEvents.length} total`);
  console.log('\n');

  process.exit(allPassed ? 0 : 1);
}

runFullStackSimulation().catch(err => {
  console.error('Full-stack simulation error:', err);
  process.exit(1);
});
