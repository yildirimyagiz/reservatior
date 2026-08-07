/**
 * REOS v5: Decision OS Simulation
 *
 * Scenario: Istanbul Luxury Villa
 * - Short-term rental restricted (Law 7464)
 * - High corporate demand in neighborhood
 * - Investor interest: HIGH
 * - AI agents recommend corporate lease
 *
 * Expected Decision: CORPORATE_MASTER_LEASE (>85% confidence)
 * Expected Saga:     CorporateLeaseSaga
 * Then: User overrides → HOLD (family usage)
 * Expected: DecisionOverridden + KnowledgeUpdated events fire
 */

import { decisionPipeline } from './src/core/decision/decision-pipeline';
import { eventBus } from './src/core/events/event-bus';
import { CognitiveEvents } from './src/core/domain/events/event-catalog';
import type { DecisionContext, DecisionOverride } from './src/core/decision/decision-types';

// Track events
const fired: Record<string, any> = {};

const track = (event: string) => {
  eventBus.subscribe(event as any, (msg) => {
    fired[event] = msg.payload;
    console.log(`  📡 Event: ${event}`);
    if (msg.payload) {
      const keys = ['action', 'blockedActions', 'suggestedSaga', 'overrideAction', 'learnedPreference'];
      for (const k of keys) {
        if (msg.payload[k] !== undefined) console.log(`     ${k}: ${JSON.stringify(msg.payload[k])}`);
      }
    }
  });
};

track(CognitiveEvents.DECISION_GENERATED);
track(CognitiveEvents.POLICY_EVALUATED);
track(CognitiveEvents.RECOMMENDATION_REJECTED);
track(CognitiveEvents.KNOWLEDGE_UPDATED);

async function runDecisionSimulation() {
  console.log('\n╔══════════════════════════════════════════════════════════════╗');
  console.log('║   REOS v5: Decision OS — Istanbul Luxury Villa Scenario      ║');
  console.log('╚══════════════════════════════════════════════════════════════╝\n');

  const ctx: DecisionContext = {
    requestId: 'dec-istanbul-001',
    tenantId: 'tenant-reservatior',
    actorId: 'owner-ahmed-123',
    propertyId: 'prop-istanbul-beykoz-villa-001',
    propertyType: 'LUXURY',
    currentUsage: 'VACANT',
    countryCode: 'TR',
    currency: 'USD',
    objective: 'MAXIMIZE_REVENUE',

    knowledge: {
      neighborhoodDemandScore: 88,
      marketTrend: 'RISING',
      corporateDemandPresent: true,
      touristDemandPresent: true,
      investorInterestLevel: 'HIGH',
      avgRentalYield: 0.14,  // 14%
    },

    aiSignals: [
      {
        agentId: 'PricingAgent',
        signal: 'Property is priced 12% below market — ideal for corporate lease to lock in yield.',
        recommendation: 'CORPORATE_MASTER_LEASE',
        confidence: 0.91,
      },
      {
        agentId: 'RiskAgent',
        signal: 'Low vacancy risk in corporate segment. Stable 2-year contracts expected.',
        recommendation: 'CORPORATE_MASTER_LEASE',
        confidence: 0.88,
      },
      {
        agentId: 'MarketingAgent',
        signal: 'Short-term rental demand high, but legal risk under Law 7464.',
        recommendation: 'LONG_TERM_RENT',
        confidence: 0.72,
      },
    ],

    policyConstraints: [
      {
        ruleId: 'tr-law-7464',
        ruleName: 'Turkey Short-Term Rental Restriction (Law 7464)',
        allows: false,
        restrictedActions: ['SHORT_TERM_RENT'],
        reason: 'Short-term rentals in residential zones require municipal license under Law 7464.',
      },
    ],
  };

  console.log('📋 Context:');
  console.log(`  Property:   ${ctx.propertyId}`);
  console.log(`  Type:       ${ctx.propertyType}`);
  console.log(`  Country:    ${ctx.countryCode}`);
  console.log(`  Objective:  ${ctx.objective}`);
  console.log(`  AI Agents:  ${ctx.aiSignals.length} signals`);
  console.log(`  Policies:   ${ctx.policyConstraints.length} constraints\n`);

  // === Run Decision Pipeline ===
  const decision = await decisionPipeline.run(ctx);

  console.log('\n╔══════════════════════════════════════════════╗');
  console.log('║   DECISION RESULT                            ║');
  console.log('╠══════════════════════════════════════════════╣');
  console.log(`║  Action:     ${decision.recommendedAction.padEnd(30)} ║`);
  console.log(`║  Confidence: ${String((decision.confidence * 100).toFixed(0) + '%').padEnd(30)} ║`);
  console.log(`║  Saga:       ${String(decision.suggestedSaga ?? 'None').padEnd(30)} ║`);
  console.log(`║  Agents:     ${String((decision.suggestedAgents ?? []).join(', ')).slice(0, 30).padEnd(30)} ║`);
  console.log(`║  Overridable: ${String(decision.overridable).padEnd(29)} ║`);
  console.log('╚══════════════════════════════════════════════╝');

  console.log('\n📋 Reasoning:');
  decision.reasoning.forEach(r => {
    console.log(`  [${r.source}] ${r.signal} (weight: ${(r.weight * 100).toFixed(0)}%)`);
  });

  if (decision.blockedActions.length > 0) {
    console.log('\n🚫 Blocked Actions:');
    decision.blockedActions.forEach(b => {
      console.log(`  ${b.action}: ${b.reason}`);
    });
  }

  // === User Override Scenario ===
  console.log('\n─────────────────────────────────────────────────');
  console.log('🖐️  Owner Override: "I want to keep it for family use"');
  console.log('─────────────────────────────────────────────────\n');

  const override: DecisionOverride = {
    requestId: ctx.requestId,
    originalDecision: decision.recommendedAction,
    overrideAction: 'HOLD',
    reason: 'Family usage — property reserved for personal use during summer.',
    actorId: ctx.actorId!,
    overriddenAt: new Date().toISOString(),
  };

  decisionPipeline.applyOverride(override);

  // Wait for async events
  await new Promise(r => setTimeout(r, 100));

  // === Validation ===
  console.log('\n═══════════════════════════════════════════════');
  console.log('VALIDATION');
  console.log('═══════════════════════════════════════════════');

  const checks = [
    { label: 'Decision action is CORPORATE_MASTER_LEASE', pass: decision.recommendedAction === 'CORPORATE_MASTER_LEASE' },
    { label: 'Confidence > 85%', pass: decision.confidence > 0.85 },
    { label: 'Suggested saga is CorporateLeaseSaga', pass: decision.suggestedSaga === 'CorporateLeaseSaga' },
    { label: 'SHORT_TERM_RENT blocked by policy', pass: decision.blockedActions.some(b => b.action === 'SHORT_TERM_RENT') },
    { label: 'DECISION_GENERATED event fired', pass: !!fired[CognitiveEvents.DECISION_GENERATED] },
    { label: 'RECOMMENDATION_REJECTED event fired (override)', pass: !!fired[CognitiveEvents.RECOMMENDATION_REJECTED] },
    { label: 'KNOWLEDGE_UPDATED event fired (learning loop)', pass: !!fired[CognitiveEvents.KNOWLEDGE_UPDATED] },
  ];

  let allPassed = true;
  for (const check of checks) {
    const icon = check.pass ? '✅' : '❌';
    console.log(`  ${icon} ${check.label}`);
    if (!check.pass) allPassed = false;
  }

  console.log(`\n${ allPassed ? '✅ ALL TESTS PASSED' : '❌ SOME TESTS FAILED' }\n`);
  process.exit(allPassed ? 0 : 1);
}

runDecisionSimulation().catch(err => {
  console.error('Simulation error:', err);
  process.exit(1);
});
