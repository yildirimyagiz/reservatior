import { decisionGraph } from "../core/decision/decision-graph";
import { executionPlanner } from "../core/decision/execution-planner";
import { contractMutator } from "../core/decision/contract-mutator";

async function sleep(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function runSimulation() {
  console.log("===============================================================");
  console.log("🚀 STARTING: Reservatior Economic Nervous System Simulation");
  console.log("===============================================================\n");

  const listingId = "lst_hotelbeds_90124";
  console.log(`[Simulation] Initializing tracking for Listing: ${listingId} (Booking Enabled: TRUE)`);
  console.log(`[Simulation] Current Baseline Commission: 10% (MID_MARKET)\n`);

  // Phase 1: Normal Traffic (Mid Market)
  console.log("--- PHASE 1: STANDARD TRAFFIC (MID MARKET) ---");
  console.log("[Hotelbeds API] Ingesting standard visibility metrics...");
  
  for (let i = 0; i < 3; i++) {
    await decisionGraph.processEventSync({
      id: `evt_view_${i}`,
      eventName: "LISTING_VIEWED" as any,
      entityId: listingId,
      entityType: "LISTING",
      source: "HOTELBEDS_API",
      payload: { viewCount: 2 },
      timestamp: new Date()
    });
  }

  await sleep(1000); // Give background graph updates a moment
  let queue = executionPlanner.getQueue();
  let latestTask = queue[0];
  console.log(`\n[Decision] Latest Opportunity Target Commission: ${(latestTask?.metadata as any)?.targetCommission || 10}%`);
  console.log(`[Decision] No critical mutation required yet.\n`);

  // Phase 2: Sudden Supply Drop (Demand Spike)
  console.log("--- PHASE 2: B2B INVENTORY SHOCK (HIGH DEMAND) ---");
  console.log("[Hotelbeds API] SIGNAL RECEIVED: Competitor availability dropped by 60% in the area.");
  
  await decisionGraph.processEventSync({
    id: `evt_supply_shock`,
    eventName: "MARKET_SUPPLY_DROPPED" as any,
    entityId: listingId,
    entityType: "LISTING",
    source: "HOTELBEDS_API",
    payload: { competitorAvailabilityDelta: -60 },
    timestamp: new Date()
  });

  await sleep(1000); // Give OpportunityNode time to run

  queue = executionPlanner.getQueue();
  latestTask = queue[0]; // Highest priority task
  const opportunity = latestTask.metadata as any;

  console.log(`\n[Opportunity Node] High Demand Triggered!`);
  console.log(`[Opportunity Node] Reasoning: ${opportunity.reason}`);
  console.log(`[Opportunity Node] Expected Systemic Gain: +$${opportunity.expectedGain}\n`);

  // Phase 3: Automated Execution
  console.log("--- PHASE 3: AUTONOMOUS ACTUATOR (CONTRACT MUTATION) ---");
  console.log(`[Execution Planner] Handing over Task ID: ${latestTask.id} to Contract Mutator...`);
  
  await contractMutator.executeMutation(latestTask.id);

  console.log("\n===============================================================");
  console.log("✅ SIMULATION COMPLETE: Closed-loop optimization successful.");
  console.log("===============================================================");
}

runSimulation().catch(console.error);
