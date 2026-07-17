import { agentImportOrchestrator } from '../services/agent-importers/agent-import-orchestrator';
import { NWMLSAgentProvider } from '../services/agent-importers/nwmls-agent-provider';

async function main() {
  const args = process.argv.slice(2);
  
  if (args.length < 2) {
    console.log("Usage: bun run src/scripts/run-agent-import.ts <PROVIDER> <REGION> [LIMIT]");
    console.log("Example: bun run src/scripts/run-agent-import.ts NWMLS US 3");
    process.exit(1);
  }

  const providerName = args[0].toUpperCase();
  const region = args[1].toUpperCase();
  const limit = args[2] ? parseInt(args[2], 10) : undefined;

  let provider;

  switch (providerName) {
    case 'NWMLS':
      provider = new NWMLSAgentProvider();
      // In the future, we can dynamically override the options via args if needed.
      break;
    // Add new cases here for CREA, Zillow, etc.
    // case 'CREA':
    //   provider = new CreaAgentProvider();
    //   break;
    default:
      console.error(`Provider ${providerName} is not supported.`);
      process.exit(1);
  }

  // A generic wrapper could intercept options, for now we pass a patched instance or rely on the class internal default
  // To allow dynamic limits, we could wrap the provider or pass options to fetchAgents, 
  // but since our orchestrator doesn't pass options, let's inject it into the provider if needed,
  // or change orchestrator to accept options. Let's do a quick hack for now.
  const originalFetch = provider.fetchAgents.bind(provider);
  provider.fetchAgents = (options) => originalFetch({ limit, ...options });

  await agentImportOrchestrator.runImport(provider, region);
  process.exit(0);
}

main().catch(err => {
  console.error("Fatal error:", err);
  process.exit(1);
});
