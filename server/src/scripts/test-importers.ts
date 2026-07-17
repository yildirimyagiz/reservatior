import { agentImportOrchestrator } from '../services/agent-importers/agent-import-orchestrator';
import { NWMLSAgentProvider } from '../services/agent-importers/nwmls-agent-provider';
import { CRMLSAgentProvider } from '../services/agent-importers/crmls-agent-provider';
import { RightmoveAgentProvider } from '../services/agent-importers/rightmove-agent-provider';

async function main() {
  console.log("=======================================================");
  console.log("    RESERVATIOR — MLS/AGENT IMPORTER ORCHESTRATION     ");
  console.log("=======================================================\n");

  const nwmls = new NWMLSAgentProvider();
  const crmls = new CRMLSAgentProvider();
  const rightmove = new RightmoveAgentProvider();

  // Test NWMLS (Washington, US Database)
  console.log(">>> [TEST 1] NWMLS (Washington State) <<<");
  await agentImportOrchestrator.runImport(nwmls, 'US');

  // Test CRMLS (California, US Database)
  console.log("\n>>> [TEST 2] CRMLS (California) <<<");
  await agentImportOrchestrator.runImport(crmls, 'US');

  // Test Rightmove (UK, UK Database)
  // Our PrismaManager automatically switches the connection based on the region parameter
  console.log("\n>>> [TEST 3] Rightmove (UK) <<<");
  await agentImportOrchestrator.runImport(rightmove, 'UK');

  console.log("\n=======================================================");
  console.log("             ALL IMPORTERS EXECUTED                    ");
  console.log("=======================================================");
  
  process.exit(0);
}

main().catch(err => {
  console.error("Fatal error:", err);
  process.exit(1);
});
