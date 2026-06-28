import { agentMatchingService, LeadMatchingParams, AgentPerformanceData } from "./src/services/agent-matching";

async function testAgentMatching() {
  console.log("🚀 STARTING AGENT MATCHING ENGINE VALIDATION");

  // 1. Scoring Primitive Validation
  console.log("\n📐 1. Testing Composite Scoring...");
  const mockAgentA: AgentPerformanceData = {
    agentId: "agent-a",
    name: "John Doe (Best)",
    responseSpeedMinutes: 5, // Fast response
    successRate: 0.95,       // High success
    availability: true,
    recentActivityScore: 0.9
  };

  const mockAgentB: AgentPerformanceData = {
    agentId: "agent-b",
    name: "Jane Smith (Balanced)",
    responseSpeedMinutes: 20,
    successRate: 0.8,
    availability: true,
    recentActivityScore: 0.7
  };

  const mockAgentC: AgentPerformanceData = {
    agentId: "agent-c",
    name: "Bob Johnson (Rising)",
    responseSpeedMinutes: 45, // Slower response
    successRate: 0.6,
    availability: true,
    recentActivityScore: 0.5
  };

  const scoreA = agentMatchingService.calculateCompositeScore(mockAgentA);
  const scoreB = agentMatchingService.calculateCompositeScore(mockAgentB);
  const scoreC = agentMatchingService.calculateCompositeScore(mockAgentC);

  console.log("Score A (Best):", scoreA);
  console.log("Score B (Balanced):", scoreB);
  console.log("Score C (Rising):", scoreC);

  if (scoreA <= scoreB || scoreB <= scoreC) {
    throw new Error("❌ Performance score ordering mismatch");
  }
  console.log("✅ Composite scoring verified!");

  // 2. Matching Engine Allocation & Pools Validation
  console.log("\n🤝 2. Testing A candidate Matching Resolution...");
  const leadParams: LeadMatchingParams = {
    region: "Kadıköy",
    propertyType: "apartment",
    activityLevel: "ACTIVE"
  };

  const availableAgents = [mockAgentA, mockAgentB, mockAgentC];

  // Run matching
  const results = await agentMatchingService.matchLeadToAgents(leadParams, availableAgents);
  
  console.log("Best Match Selection:", results.bestMatch.name, "Score:", results.bestMatch.score);
  console.log("Balanced Match Selection:", results.balancedPerformer.name, "Score:", results.balancedPerformer.score);
  console.log("Rising Match Selection:", results.risingAgent.name, "Score:", results.risingAgent.score);

  if (results.bestMatch.agentId !== "agent-a") {
    throw new Error("❌ Match resolution failed: John Doe should be the Best Match");
  }
  console.log("✅ Match engine candidate routing verified!");

  // 3. Visibility Budget Incrementation Test
  console.log("\n💳 3. Testing Visibility Budget Deduction...");
  // Simulate selection of Agent A
  const budgetResult = await agentMatchingService.selectAgentAndConsumeBudget("agent-a");
  console.log("Selected Agent A. Visibility budget used count:", budgetResult.used);

  if (budgetResult.used <= 0) {
    throw new Error("❌ Visibility budget counter failed to increment");
  }
  console.log("✅ Visibility budget logic verified!");

  console.log("\n🎉 ALL AGENT MATCHING ENGINE TEST CASES PASSED SUCCESSFULLY!");
  process.exit(0);
}

testAgentMatching().catch(err => {
  console.error("❌ Test failed with error:", err);
  process.exit(1);
});
