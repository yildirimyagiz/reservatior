import fs from 'fs';
import path from 'path';
import { parse } from 'csv-parse/sync';
import { decisionGraph } from "../core/decision/decision-graph";
import { executionPlanner } from "../core/decision/execution-planner";
import { contractMutator } from "../core/decision/contract-mutator";

// Paths
const BASE_DIR = path.resolve(__dirname, '../../data/airbnb/netherlands/north_holland/amsterdam');
const LISTINGS_CSV = path.join(BASE_DIR, 'listings.csv');
const REVIEWS_CSV = path.join(BASE_DIR, 'reviews.csv');
const CALENDAR_CSV = path.join(BASE_DIR, 'calendar.csv');

async function sleep(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function runBacktest() {
  console.log("===============================================================");
  console.log("🚀 STARTING: Real-World Airbnb Backtesting Engine");
  console.log(`📁 Source: Amsterdam, Netherlands`);
  console.log("===============================================================\n");

  // 1. Ingest Listings
  console.log("[Seeder] Reading listings.csv...");
  const listingsContent = fs.readFileSync(LISTINGS_CSV, 'utf-8');
  const listings: any[] = parse(listingsContent, { columns: true, skip_empty_lines: true }).slice(0, 5); // Limit to 5 for demo
  
  console.log(`[Seeder] Loaded ${listings.length} target listings for backtesting.`);
  listings.forEach((l: any) => console.log(`   - ID: ${l.id} | Name: ${l.name} | Price: $${l.price}`));

  console.log("\n[Replayer] Reversing historical data into events...\n");

  for (const listing of listings) {
    console.log(`--- ANALYZING LISTING: ${listing.id} ---`);

    // Simulate Historical Views (Top of Funnel) based on total reviews
    const simulatedViews = Math.max(1, Math.floor((parseInt(listing.number_of_reviews) || 0) / 10));
    console.log(`[Simulator] Injecting ${simulatedViews} historical LISTING_VIEWED events...`);
    
    for (let i = 0; i < Math.min(simulatedViews, 5); i++) {
      await decisionGraph.processEventSync({
        id: `evt_view_${listing.id}_${i}`,
        eventName: "LISTING_VIEWED" as any,
        entityId: listing.id,
        entityType: "LISTING",
        source: "AIRBNB_HISTORICAL",
        payload: { viewCount: 1 },
        timestamp: new Date()
      });
    }

    // Read a chunk of calendar data to simulate a supply drop (Demand Spike)
    // For the demo, we will artificially trigger the drop to show the AI reaction
    console.log(`[Simulator] Fast-forwarding to high-season (Artificial Supply Drop)...`);
    
    await decisionGraph.processEventSync({
      id: `evt_supply_${listing.id}`,
      eventName: "MARKET_SUPPLY_DROPPED" as any,
      entityId: listing.id,
      entityType: "LISTING",
      source: "AIRBNB_CALENDAR",
      payload: { competitorAvailabilityDelta: -45 },
      timestamp: new Date()
    });

    await sleep(500); // Give OpportunityNode time to process

    const queue = executionPlanner.getQueue();
    const pendingTasks = queue.filter(t => t.status === "PENDING" && t.metadata?.entityId === listing.id);

    if (pendingTasks.length > 0) {
      const task = pendingTasks[0];
      console.log(`[Opportunity Node] High Demand Triggered for Listing ${listing.id}!`);
      console.log(`[Opportunity Node] Reasoning: ${task.metadata?.reason}`);
      
      console.log(`[Execution Planner] Triggering Contract Mutator...`);
      await contractMutator.executeMutation(task.id);
    } else {
      console.log(`[Decision Graph] No critical mutation required for ${listing.id}.`);
    }
    console.log("\n");
  }

  console.log("===============================================================");
  console.log("✅ BACKTEST COMPLETE");
  console.log("===============================================================");
}

runBacktest().catch(err => {
  console.error("Backtest failed:", err);
});
