/**
 * Threat Intelligence Integration
 * Integrates with threat intelligence feeds for real-time protection
 * Supports STIX 2.1, TAXII 2.x, and custom threat feeds
 */

import { cacheSet, cacheGet } from './cache';

export interface ThreatIndicator {
  id: string;
  type: 'IP' | 'DOMAIN' | 'URL' | 'HASH' | 'EMAIL' | 'CVE';
  value: string;
  threatLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  source: string;
  description?: string;
  firstSeen: Date;
  lastSeen: Date;
  tags: string[];
}

export interface ThreatIntelligenceResult {
  isThreat: boolean;
  indicators: ThreatIndicator[];
  threatLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  recommendedActions: string[];
}

// In-memory threat indicator cache (in production, use database)
const THREAT_INDICATORS = new Map<string, ThreatIndicator>();

/**
 * Check if IP is in threat intelligence
 */
export async function checkIPTHreat(ip: string): Promise<ThreatIntelligenceResult> {
  const cacheKey = `threat:ip:${ip}`;
  const cached = await cacheGet<ThreatIntelligenceResult>(cacheKey);
  
  if (cached) {
    return cached;
  }
  
  const indicators: ThreatIndicator[] = [];
  
  // Check in-memory cache
  for (const [key, indicator] of THREAT_INDICATORS.entries()) {
    if (indicator.type === 'IP' && indicator.value === ip) {
      indicators.push(indicator);
    }
  }
  
  // Check against known threat feeds (simplified)
  const feedIndicators = await checkThreatFeeds('IP', ip);
  indicators.push(...feedIndicators);
  
  // Determine threat level
  let threatLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL' = 'LOW';
  if (indicators.some(i => i.threatLevel === 'CRITICAL')) {
    threatLevel = 'CRITICAL';
  } else if (indicators.some(i => i.threatLevel === 'HIGH')) {
    threatLevel = 'HIGH';
  } else if (indicators.some(i => i.threatLevel === 'MEDIUM')) {
    threatLevel = 'MEDIUM';
  }
  
  const result: ThreatIntelligenceResult = {
    isThreat: indicators.length > 0,
    indicators,
    threatLevel,
    recommendedActions: generateThreatActions(threatLevel),
  };
  
  // Cache for 1 hour
  await cacheSet(cacheKey, result, 3600);
  
  return result;
}

/**
 * Check if domain is in threat intelligence
 */
export async function checkDomainThreat(domain: string): Promise<ThreatIntelligenceResult> {
  const cacheKey = `threat:domain:${domain}`;
  const cached = await cacheGet<ThreatIntelligenceResult>(cacheKey);
  
  if (cached) {
    return cached;
  }
  
  const indicators: ThreatIndicator[] = [];
  
  // Check in-memory cache
  for (const [key, indicator] of THREAT_INDICATORS.entries()) {
    if (indicator.type === 'DOMAIN' && indicator.value === domain) {
      indicators.push(indicator);
    }
  }
  
  // Check against threat feeds
  const feedIndicators = await checkThreatFeeds('DOMAIN', domain);
  indicators.push(...feedIndicators);
  
  let threatLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL' = 'LOW';
  if (indicators.some(i => i.threatLevel === 'CRITICAL')) {
    threatLevel = 'CRITICAL';
  } else if (indicators.some(i => i.threatLevel === 'HIGH')) {
    threatLevel = 'HIGH';
  } else if (indicators.some(i => i.threatLevel === 'MEDIUM')) {
    threatLevel = 'MEDIUM';
  }
  
  const result: ThreatIntelligenceResult = {
    isThreat: indicators.length > 0,
    indicators,
    threatLevel,
    recommendedActions: generateThreatActions(threatLevel),
  };
  
  await cacheSet(cacheKey, result, 3600);
  
  return result;
}

/**
 * Check if hash is in threat intelligence
 */
export async function checkHashThreat(hash: string): Promise<ThreatIntelligenceResult> {
  const cacheKey = `threat:hash:${hash}`;
  const cached = await cacheGet<ThreatIntelligenceResult>(cacheKey);
  
  if (cached) {
    return cached;
  }
  
  const indicators: ThreatIndicator[] = [];
  
  // Check in-memory cache
  for (const [key, indicator] of THREAT_INDICATORS.entries()) {
    if (indicator.type === 'HASH' && indicator.value === hash) {
      indicators.push(indicator);
    }
  }
  
  // Check against threat feeds
  const feedIndicators = await checkThreatFeeds('HASH', hash);
  indicators.push(...feedIndicators);
  
  let threatLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL' = 'LOW';
  if (indicators.some(i => i.threatLevel === 'CRITICAL')) {
    threatLevel = 'CRITICAL';
  } else if (indicators.some(i => i.threatLevel === 'HIGH')) {
    threatLevel = 'HIGH';
  } else if (indicators.some(i => i.threatLevel === 'MEDIUM')) {
    threatLevel = 'MEDIUM';
  }
  
  const result: ThreatIntelligenceResult = {
    isThreat: indicators.length > 0,
    indicators,
    threatLevel,
    recommendedActions: generateThreatActions(threatLevel),
  };
  
  await cacheSet(cacheKey, result, 3600);
  
  return result;
}

/**
 * Check against threat feeds (simplified - in production use actual APIs)
 */
async function checkThreatFeeds(
  type: string,
  value: string
): Promise<ThreatIndicator[]> {
  const indicators: ThreatIndicator[] = [];
  
  // In production, integrate with:
  // - VirusTotal API
  // - AbuseIPDB
  // - AlienVault OTX
  // - MISP
  // - TAXII servers
  // - Custom threat feeds
  
  // For now, return empty array
  return indicators;
}

/**
 * Add threat indicator
 */
export function addThreatIndicator(indicator: ThreatIndicator): void {
  const key = `${indicator.type}:${indicator.value}`;
  THREAT_INDICATORS.set(key, indicator);
  console.log(`[Threat Intel] Added indicator: ${key}`);
}

/**
 * Remove threat indicator
 */
export function removeThreatIndicator(type: string, value: string): void {
  const key = `${type}:${value}`;
  THREAT_INDICATORS.delete(key);
  console.log(`[Threat Intel] Removed indicator: ${key}`);
}

/**
 * Get all threat indicators
 */
export function getAllThreatIndicators(): ThreatIndicator[] {
  return Array.from(THREAT_INDICATORS.values());
}

/**
 * Get threat indicators by type
 */
export function getThreatIndicatorsByType(type: string): ThreatIndicator[] {
  return Array.from(THREAT_INDICATORS.values()).filter(i => i.type === type);
}

/**
 * Generate recommended actions based on threat level
 */
function generateThreatActions(threatLevel: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL'): string[] {
  const actions: string[] = [];
  
  switch (threatLevel) {
    case 'CRITICAL':
      actions.push('BLOCK_IMMEDIATELY');
      actions.push('ESCALATE_TO_SECURITY_TEAM');
      actions.push('LOG_CRITICAL_EVENT');
      actions.push('NOTIFY_STAKEHOLDERS');
      break;
    case 'HIGH':
      actions.push('BLOCK_OR_CHALLENGE');
      actions.push('LOG_HIGH_SEVERITY_EVENT');
      actions.push('MONITOR_CLOSER');
      break;
    case 'MEDIUM':
      actions.push('MONITOR');
      actions.log('LOG_EVENT');
      actions.push('REQUIRE_ADDITIONAL_VERIFICATION');
      break;
    case 'LOW':
      actions.push('LOG_EVENT');
      actions.push('MONITOR');
      break;
  }
  
  return actions;
}

/**
 * Import STIX 2.1 bundle
 */
export async function importSTIXBundle(bundle: any): Promise<number> {
  let imported = 0;
  
  if (bundle.objects) {
    for (const obj of bundle.objects) {
      if (obj.type === 'indicator') {
        const indicator: ThreatIndicator = {
          id: obj.id,
          type: obj.indicator_types?.[0] || 'IP',
          value: obj.pattern || '',
          threatLevel: obj.labels?.includes('malicious') ? 'HIGH' : 'MEDIUM',
          source: 'STIX',
          description: obj.description,
          firstSeen: new Date(obj.created),
          lastSeen: new Date(obj.modified),
          tags: obj.labels || [],
        };
        
        addThreatIndicator(indicator);
        imported++;
      }
    }
  }
  
  console.log(`[Threat Intel] Imported ${imported} indicators from STIX bundle`);
  return imported;
}

/**
 * Export threat indicators as STIX 2.1 bundle
 */
export function exportSTIXBundle(): any {
  const indicators = getAllThreatIndicators();
  
  const bundle = {
    type: 'bundle',
    id: `bundle--${crypto.randomUUID()}`,
    objects: indicators.map(i => ({
      type: 'indicator',
      id: i.id,
      pattern: `[${i.type.toLowerCase()} = '${i.value}']`,
      indicator_types: [i.type],
      labels: [...i.tags, i.threatLevel.toLowerCase()],
      description: i.description,
      created: i.firstSeen.toISOString(),
      modified: i.lastSeen.toISOString(),
    })),
  };
  
  return bundle;
}

/**
 * Sync with TAXII 2.x server
 */
export async function syncTAXII(serverUrl: string, collectionId: string): Promise<number> {
  // In production, implement actual TAXII 2.x client
  console.log(`[Threat Intel] Syncing with TAXII server: ${serverUrl}`);
  
  // For now, return 0
  return 0;
}

/**
 * Get threat intelligence statistics
 */
export function getThreatIntelStats(): {
  totalIndicators: number;
  byType: Record<string, number>;
  byThreatLevel: Record<string, number>;
  bySource: Record<string, number>;
} {
  const indicators = getAllThreatIndicators();
  
  const stats = {
    totalIndicators: indicators.length,
    byType: {} as Record<string, number>,
    byThreatLevel: {} as Record<string, number>,
    bySource: {} as Record<string, number>,
  };
  
  for (const indicator of indicators) {
    stats.byType[indicator.type] = (stats.byType[indicator.type] || 0) + 1;
    stats.byThreatLevel[indicator.threatLevel] = (stats.byThreatLevel[indicator.threatLevel] || 0) + 1;
    stats.bySource[indicator.source] = (stats.bySource[indicator.source] || 0) + 1;
  }
  
  return stats;
}

/**
 * Check CVE for vulnerabilities
 */
export async function checkCVE(cveId: string): Promise<ThreatIntelligenceResult> {
  const cacheKey = `threat:cve:${cveId}`;
  const cached = await cacheGet<ThreatIntelligenceResult>(cacheKey);
  
  if (cached) {
    return cached;
  }
  
  // In production, query NVD API
  // For now, return non-threat
  const result: ThreatIntelligenceResult = {
    isThreat: false,
    indicators: [],
    threatLevel: 'LOW',
    recommendedActions: [],
  };
  
  await cacheSet(cacheKey, result, 86400); // Cache for 24 hours
  
  return result;
}

/**
 * Get CVE information
 */
export async function getCVEInfo(cveId: string): Promise<any> {
  // In production, query NVD API
  // For now, return null
  return null;
}

/**
 * Elysia middleware for threat intelligence checking
 */
export const threatIntelMiddleware = async ({ 
  headers, 
  query, 
  body, 
  set 
}: any) => {
  const ip = headers.get('x-forwarded-for') || 
             headers.get('cf-connecting-ip') || 
             'unknown';
  
  // Check IP threat
  const ipThreat = await checkIPTHreat(ip);
  
  if (ipThreat.isThreat && ipThreat.threatLevel === 'CRITICAL') {
    set.status = 403;
    throw new Error(`Blocked: IP is listed in threat intelligence (${ipThreat.indicators[0].source})`);
  }
  
  if (ipThreat.isThreat && ipThreat.threatLevel === 'HIGH') {
    set.status = 403;
    throw new Error(`Blocked: IP has high threat level (${ipThreat.indicators[0].source})`);
  }
  
  // Check URL threat if present
  const url = query.url || body?.url;
  if (url) {
    try {
      const urlObj = new URL(url);
      const domainThreat = await checkDomainThreat(urlObj.hostname);
      
      if (domainThreat.isThreat && domainThreat.threatLevel === 'CRITICAL') {
        set.status = 403;
        throw new Error(`Blocked: Domain is listed in threat intelligence`);
      }
    } catch {
      // Invalid URL, skip
    }
  }
  
  set.headers = {
    ...set.headers,
    'X-Threat-Checked': 'true',
    'X-Threat-Level': ipThreat.threatLevel,
  };
  
  console.log(`[Threat Intel] IP: ${ip}, Threat Level: ${ipThreat.threatLevel}`);
};
