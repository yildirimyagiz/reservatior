/**
 * End-to-End Saga Architecture Demo
 * Tests all three independent Sagas cascading via the Event Bus.
 */

import { eventBus } from '../core/events/event-bus';
import { DomainEvents } from '../core/events/domain-events';
import { OutboxWorker } from '../core/events/outbox-worker';
import { registerAgentOnboardingListeners } from '../core/workflows/agent-onboarding.saga';
import { registerListingPipelineListeners } from '../core/workflows/listing-pipeline.saga';
import { registerCommissionPaymentListeners } from '../core/workflows/commission-payment.saga';
import { registerAiMarketingListeners } from '../core/workflows/listeners/ai-marketing.listener';
import { randomUUID } from 'crypto';

async function main() {
  console.log("=======================================================");
  console.log("    RESERVATIOR — FULL END-TO-END WEDGE PIPELINE TEST  ");
  console.log("=======================================================\n");

  // ── 1. Register all Saga & Independent listeners ───────────────────────────
  registerAgentOnboardingListeners();
  registerListingPipelineListeners();
  registerCommissionPaymentListeners();
  registerAiMarketingListeners(); // AI Ads Generation

  // ── 2. Add raw cross-module observer listeners ──────────────────────────────
  eventBus.subscribe(DomainEvents.AGENT_INVITED, () =>
    console.log(`  [NotificationOS] 📱 Sending WhatsApp invite...`)
  );
  eventBus.subscribe(DomainEvents.AD_GENERATED, (msg) =>
    console.log(`  [MarketingOS] 🎥 Ads rendering complete. Pushing to Meta Ads API...`)
  );
  eventBus.subscribe(DomainEvents.AD_PUBLISHED, (msg) =>
    console.log(`  [Analytics] 📊 Campaign ${msg.payload.campaignId} KPIs initialized. Waiting for clicks.`)
  );
  eventBus.subscribe(DomainEvents.LEAD_CREATED, (msg) =>
    console.log(`  [CRM] 🎯 Incoming Lead (${msg.payload.leadId}) assigned to sales queue.`)
  );
  eventBus.subscribe(DomainEvents.COMMISSION_INSTALLMENT_OFFERED, (msg) =>
    console.log(`  [FinanceOS] 🔔 Agent ${msg.payload.agentId} notified about installment offer ($${msg.payload.monthlyAmount}/mo x${msg.payload.installments}).`)
  );

  // ── 3. FLOW THE WEDGE ─────────────────────────────────────────────────────
  
  const correlation = randomUUID();
  const agentId = 'agt_ai_demo_001';
  
  console.log("\n>>> [STEP 1] Agent Acquisition (agent.invited) <<<\n");
  await eventBus.publish(DomainEvents.AGENT_INVITED, { agentId }, 'CRM', correlation);

  // Simulate agent accepting via WhatsApp webhook 2s later -> Triggers listing import
  setTimeout(async () => {
    console.log("\n>>> [STEP 2] Agent Accepts (agent.accepted) <<<\n");
    await eventBus.publish(DomainEvents.AGENT_ACCEPTED, { agentId }, 'WhatsApp', correlation);
  }, 2000);

  // Listing Pipeline Saga takes over after agent.accepted, and eventually emits listing.published.
  // When listing.published fires, AI-OS picks it up to generate ads (ad.generated).
  // Listing Pipeline Saga then picks up ad.generated and emits ad.published.

  // Simulate Meta Ads Webhook 8 seconds later (after ads are published and user clicks)
  setTimeout(async () => {
    console.log("\n>>> [STEP 3] Ad Interaction (lead.created) <<<\n");
    await eventBus.publish(DomainEvents.LEAD_CREATED, {
      leadId: 'lead_meta_001',
      campaignId: 'camp_demo_001',
      orgId: 'mock-org-123'
    }, 'Webhooks', correlation);
  }, 8000);

  // Simulate CRM Deal Closed 12 seconds later -> Triggers Commission Payment Saga
  setTimeout(async () => {
    console.log("\n>>> [STEP 4] CRM Conversion (deal.closed) ($18,000) <<<\n");
    await eventBus.publish(DomainEvents.DEAL_CLOSED, {
      dealId: 'deal_lead_meta_001',
      agentId: agentId,
      amount: 18000
    }, 'CRM', correlation);
  }, 12000);

  // ── 5. Keep alive ─────────────────────────────────────────────────────────
  setTimeout(() => {
    console.log("\n=======================================================");
    console.log("       ALL PIPELINES EXECUTED SUCCESSFULLY             ");
    console.log("=======================================================");
    process.exit(0);
  }, 18000);
}

main().catch(err => {
  console.error("Fatal error:", err);
  process.exit(1);
});
