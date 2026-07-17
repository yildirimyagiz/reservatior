import { IAgentProvider, NormalizedAgentLead, FetchAgentsOptions } from './types';

export class RightmoveAgentProvider implements IAgentProvider {
  readonly providerName = 'Rightmove UK';

  async fetchAgents(options?: FetchAgentsOptions): Promise<NormalizedAgentLead[]> {
    console.log(`[${this.providerName}] Connecting to Rightmove API endpoint (London)...`);
    
    // Simulate network delay
    await new Promise(resolve => setTimeout(resolve, 600));

    // Simulate fetching UK agents
    const agents: NormalizedAgentLead[] = [
      {
        name: 'Oliver Twist Properties',
        phoneNumber: '+44 20 7946 0958',
        address: 'Mayfair, London, UK',
        status: 'PENDING',
      },
      {
        name: 'Elizabeth Bennet',
        phoneNumber: '+44 161 496 0382',
        address: 'Manchester, UK',
        status: 'PENDING',
      }
    ];

    console.log(`[${this.providerName}] Extracted ${agents.length} agents from the UK.`);
    return agents;
  }
}
