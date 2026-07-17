import { prismaManager } from '../../lib/prisma';
import { IAgentProvider } from './types';
import { eventBus } from '../../core/events/event-bus';

export class AgentImportOrchestrator {
  /**
   * Run the import process for a given provider and region.
   * 
   * @param provider The MLS provider instance
   * @param region The database region (e.g. "US", "UK")
   */
  async runImport(provider: IAgentProvider, region: string) {
    console.log(`\n[AgentImportOrchestrator] Starting import via ${provider.providerName} for region ${region}...`);
    
    // 1. Fetch normalized agents from the provider
    const agents = await provider.fetchAgents();
    
    if (agents.length === 0) {
      console.log(`[AgentImportOrchestrator] No agents found by ${provider.providerName}. Aborting.`);
      return;
    }

    console.log(`[AgentImportOrchestrator] ${provider.providerName} returned ${agents.length} agents. Saving to DB...`);

    // 2. Connect to the correct database via PrismaManager
    const prisma = prismaManager.getClient(region);

    let created = 0;
    
    // 3. Save to database (deduplicate by name)
    // NOTE: In production, deduping by name + phone or email is safer
    for (const agent of agents) {
      try {
        const existing = await prisma.agent.findFirst({
          where: { name: agent.name }
        });
        
        if (!existing) {
          // Transactional Outbox Pattern
          // Ensure Agent creation and EventLog creation are strictly consistent
          const [newAgent, _] = await prisma.$transaction([
            prisma.agent.create({ data: agent }),
            prisma.eventLog.create({
              data: {
                eventType: 'agent.imported',
                aggregateType: 'AgentOS',
                aggregateId: agent.name, // Temporary correlation, should be ID if known
                payload: { name: agent.name, source: provider.providerName },
                status: 'PENDING'
              }
            })
          ]);
          created++;

          // Note: We no longer call eventBus.publish here directly.
          // The OutboxWorker will pick this up and publish it guaranteeing delivery.
        }
      } catch (err: any) {
        console.error(`[AgentImportOrchestrator] Failed to save agent ${agent.name}:`, err.message);
      }
    }

    console.log(`[AgentImportOrchestrator] Import complete! Created ${created} new agent profiles.`);
  }
}

export const agentImportOrchestrator = new AgentImportOrchestrator();
