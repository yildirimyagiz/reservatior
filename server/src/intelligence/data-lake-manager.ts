/**
 * Intelligence Data Lake Manager
 * Manages data routing between PostgreSQL, TimescaleDB, and BigQuery
 * based on data age and retention policy
 */

export enum DataStorageTier {
  HOT = 'HOT',           // 0-12 months: PostgreSQL
  WARM = 'WARM',         // 1-5 years: TimescaleDB
  COLD = 'COLD'          // 5+ years: BigQuery
}

export interface IntelligenceData {
  id: string;
  type: string;
  timestamp: Date;
  data: any;
  metadata?: {
    source?: string;
    countryIsoCode?: string;
    citySlug?: string;
    districtSlug?: string;
  };
}

export interface DataRetentionPolicy {
  hotRetentionMonths: number;      // Default: 12
  warmRetentionYears: number;      // Default: 5
  coldRetentionYears: number;      // Default: 10+
}

export interface DataRoutingResult {
  targetTier: DataStorageTier;
  targetSystem: string;
  reason: string;
  estimatedSize: number;
}

const DEFAULT_RETENTION_POLICY: DataRetentionPolicy = {
  hotRetentionMonths: 12,
  warmRetentionYears: 5,
  coldRetentionYears: 10
};

export class DataLakeManager {
  private retentionPolicy: DataRetentionPolicy;

  constructor(policy?: Partial<DataRetentionPolicy>) {
    this.retentionPolicy = {
      ...DEFAULT_RETENTION_POLICY,
      ...policy
    };
  }

  /**
   * Calculate data age in months
   */
  private calculateDataAge(timestamp: Date): number {
    const now = new Date();
    const monthsDiff = (now.getFullYear() - timestamp.getFullYear()) * 12 + 
                      (now.getMonth() - timestamp.getMonth());
    return Math.max(0, monthsDiff);
  }

  /**
   * Determine storage tier based on data age
   */
  determineStorageTier(timestamp: Date): DataStorageTier {
    const ageInMonths = this.calculateDataAge(timestamp);

    if (ageInMonths < this.retentionPolicy.hotRetentionMonths) {
      return DataStorageTier.HOT;
    }

    const ageInYears = ageInMonths / 12;
    if (ageInYears < this.retentionPolicy.warmRetentionYears) {
      return DataStorageTier.WARM;
    }

    return DataStorageTier.COLD;
  }

  /**
   * Route data to appropriate storage tier
   */
  routeData(data: IntelligenceData): DataRoutingResult {
    const tier = this.determineStorageTier(data.timestamp);
    
    let targetSystem: string;
    let reason: string;

    switch (tier) {
      case DataStorageTier.HOT:
        targetSystem = 'PostgreSQL';
        reason = `Data is ${this.calculateDataAge(data.timestamp)} months old (< ${this.retentionPolicy.hotRetentionMonths} months)`;
        break;
      case DataStorageTier.WARM:
        targetSystem = 'TimescaleDB';
        reason = `Data is ${this.calculateDataAge(data.timestamp) / 12} years old (< ${this.retentionPolicy.warmRetentionYears} years)`;
        break;
      case DataStorageTier.COLD:
        targetSystem = 'BigQuery';
        reason = `Data is ${this.calculateDataAge(data.timestamp) / 12} years old (>= ${this.retentionPolicy.warmRetentionYears} years)`;
        break;
    }

    const estimatedSize = this.estimateDataSize(data);

    return {
      targetTier: tier,
      targetSystem,
      reason,
      estimatedSize
    };
  }

  /**
   * Estimate data size in bytes
   */
  private estimateDataSize(data: IntelligenceData): number {
    const jsonString = JSON.stringify(data);
    return Buffer.byteLength(jsonString, 'utf8');
  }

  /**
   * Batch route multiple data items
   */
  batchRouteData(dataItems: IntelligenceData[]): DataRoutingResult[] {
    return dataItems.map(data => this.routeData(data));
  }

  /**
   * Get storage tier statistics
   */
  getStorageStatistics(dataItems: IntelligenceData[]): {
    total: number;
    hot: number;
    warm: number;
    cold: number;
    totalEstimatedSize: number;
    tierBreakdown: Record<DataStorageTier, {
      count: number;
      estimatedSize: number;
      percentage: number;
    }>;
  } {
    const results = this.batchRouteData(dataItems);
    
    let totalEstimatedSize = 0;
    const tierCounts = {
      [DataStorageTier.HOT]: 0,
      [DataStorageTier.WARM]: 0,
      [DataStorageTier.COLD]: 0
    };
    const tierSizes = {
      [DataStorageTier.HOT]: 0,
      [DataStorageTier.WARM]: 0,
      [DataStorageTier.COLD]: 0
    };

    results.forEach(result => {
      tierCounts[result.targetTier]++;
      tierSizes[result.targetTier] += result.estimatedSize;
      totalEstimatedSize += result.estimatedSize;
    });

    const tierBreakdown: Record<DataStorageTier, any> = {
      [DataStorageTier.HOT]: {
        count: tierCounts[DataStorageTier.HOT],
        estimatedSize: tierSizes[DataStorageTier.HOT],
        percentage: dataItems.length > 0 ? (tierCounts[DataStorageTier.HOT] / dataItems.length) * 100 : 0
      },
      [DataStorageTier.WARM]: {
        count: tierCounts[DataStorageTier.WARM],
        estimatedSize: tierSizes[DataStorageTier.WARM],
        percentage: dataItems.length > 0 ? (tierCounts[DataStorageTier.WARM] / dataItems.length) * 100 : 0
      },
      [DataStorageTier.COLD]: {
        count: tierCounts[DataStorageTier.COLD],
        estimatedSize: tierSizes[DataStorageTier.COLD],
        percentage: dataItems.length > 0 ? (tierCounts[DataStorageTier.COLD] / dataItems.length) * 100 : 0
      }
    };

    return {
      total: dataItems.length,
      hot: tierCounts[DataStorageTier.HOT],
      warm: tierCounts[DataStorageTier.WARM],
      cold: tierCounts[DataStorageTier.COLD],
      totalEstimatedSize,
      tierBreakdown
    };
  }

  /**
   * Update retention policy
   */
  updateRetentionPolicy(policy: Partial<DataRetentionPolicy>): void {
    this.retentionPolicy = {
      ...this.retentionPolicy,
      ...policy
    };
  }

  /**
   * Get current retention policy
   */
  getRetentionPolicy(): DataRetentionPolicy {
    return { ...this.retentionPolicy };
  }

  /**
   * Check if data needs migration
   */
  checkMigrationNeeds(data: IntelligenceData): {
    needsMigration: boolean;
    currentTier: DataStorageTier;
    targetTier: DataStorageTier;
    reason?: string;
  } {
    const currentTier = this.determineStorageTier(data.timestamp);
    
    // For this implementation, we assume data is currently in the correct tier
    // In production, this would check the actual storage location
    const targetTier = currentTier;
    
    return {
      needsMigration: false,
      currentTier,
      targetTier
    };
  }

  /**
   * Get data migration candidates
   */
  getMigrationCandidates(dataItems: IntelligenceData[]): {
    hotToWarm: IntelligenceData[];
    warmToCold: IntelligenceData[];
    total: number;
  } {
    const hotToWarm: IntelligenceData[] = [];
    const warmToCold: IntelligenceData[] = [];

    dataItems.forEach(data => {
      const ageInMonths = this.calculateDataAge(data.timestamp);
      
      // Hot to Warm: data approaching hot retention limit
      if (ageInMonths >= this.retentionPolicy.hotRetentionMonths - 1 && 
          ageInMonths < this.retentionPolicy.hotRetentionMonths) {
        hotToWarm.push(data);
      }
      
      // Warm to Cold: data approaching warm retention limit
      const ageInYears = ageInMonths / 12;
      if (ageInYears >= this.retentionPolicy.warmRetentionYears - 0.5 && 
          ageInYears < this.retentionPolicy.warmRetentionYears) {
        warmToCold.push(data);
      }
    });

    return {
      hotToWarm,
      warmToCold,
      total: hotToWarm.length + warmToCold.length
    };
  }
}

// Singleton instance
export const dataLakeManager = new DataLakeManager();

/**
 * Example usage
 */
export function exampleDataLakeUsage() {
  const manager = new DataLakeManager();

  // Recent data (should go to PostgreSQL)
  const recentData: IntelligenceData = {
    id: '1',
    type: 'market_snapshot',
    timestamp: new Date(), // Now
    data: { price: 1000000, demand: 0.85 }
  };

  // Historical data (should go to TimescaleDB)
  const historicalData: IntelligenceData = {
    id: '2',
    type: 'market_trend',
    timestamp: new Date('2023-01-01'), // ~18 months ago
    data: { price: 800000, demand: 0.70 }
  };

  // Research data (should go to BigQuery)
  const researchData: IntelligenceData = {
    id: '3',
    type: 'historical_pattern',
    timestamp: new Date('2018-01-01'), // ~6 years ago
    data: { pattern: 'seasonal', correlation: 0.92 }
  };

  const results = manager.batchRouteData([recentData, historicalData, researchData]);
  const stats = manager.getStorageStatistics([recentData, historicalData, researchData]);

  return { results, stats };
}
