export interface NormalizedAgentLead {
  name: string;
  phoneNumber?: string;
  address?: string;
  website?: string;
  logoUrl?: string;
  status: 'PENDING';
}

export interface FetchAgentsOptions {
  limit?: number;
  [key: string]: any;
}

export interface IAgentProvider {
  /**
   * Identifies the provider (e.g. "NWMLS", "Zillow")
   */
  readonly providerName: string;

  /**
   * Fetches agent records and returns them in a normalized format.
   * Implementation depends on the provider (e.g. pagination, auth).
   */
  fetchAgents(options?: FetchAgentsOptions): Promise<NormalizedAgentLead[]>;
}
