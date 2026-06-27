/**
 * IP INTELLIGENCE LOGIC (Simplified Mock)
 * In production: Use MaxMind GeoIP2 or IPQualityScore API
 */

export interface IpScore {
  score: number;
  tags: string[];
}

export async function scoreIpAddress(ip: string): Promise<IpScore> {
  const tags: string[] = [];
  let score = 0;

  // Mock Logic for Datacenter Ranges
  if (ip.startsWith('35.') || ip.startsWith('34.') || ip.startsWith('104.')) {
    score += 50;
    tags.push('DATACENTER_IP'); // Likely Cloud Cloud
  }

  // Mock Logic for Tor Exit Nodes (usually public lists)
  // if (TOR_EXIT_NODES.has(ip)) ...

  // Localhost
  if (ip === '127.0.0.1' || ip === '::1') {
    score = 0;
    tags.push('LOCALHOST');
  }

  return { score, tags };
}
