import { IAgentProvider, NormalizedAgentLead, FetchAgentsOptions } from './types';

export class CRMLSAgentProvider implements IAgentProvider {
  readonly providerName = 'CRMLS';

  async fetchAgents(options?: FetchAgentsOptions): Promise<NormalizedAgentLead[]> {
    console.log(`[${this.providerName}] Connecting to CRMLS API endpoint (California)...`);
    
    // Simulate network delay
    await new Promise(resolve => setTimeout(resolve, 800));

    // Simulate fetching California agents
    const agents: NormalizedAgentLead[] = [
      {
        name: 'Michael Chen',
        phoneNumber: '(310) 555-0198',
        address: 'Beverly Hills, CA',
        status: 'PENDING',
      },
      {
        name: 'Sarah Connor',
        phoneNumber: '(213) 555-9012',
        address: 'Los Angeles, CA',
        status: 'PENDING',
      },
      {
        name: 'David Reynolds',
        phoneNumber: '(858) 555-3456',
        address: 'San Diego, CA',
        status: 'PENDING',
      }
    ];

    console.log(`[${this.providerName}] Extracted ${agents.length} agents from California.`);
    return agents;
  }
}
