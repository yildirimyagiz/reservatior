/**
 * Feature Store - Vertex AI Feature Store Integration
 * 
 * Provides O(1) access to pre-computed features for AI agents
 * Eliminates redundant calculations and improves response times
 * 
 * Features stored:
 * - Property features (yield, vacancy, crime, walkability, school, investor demand, trust, risk)
 * - Market features (regional trends, price movements, demand patterns)
 * - Temporal features (seasonal patterns, time-based trends)
 */

export interface PropertyFeatures {
  propertyId: string;
  
  // Yield features
  capRate: number;
  cashOnCashReturn: number;
  grossYield: number;
  netYield: number;
  
  // Vacancy features
  areaVacancyRate: number;
  propertyVacancyRate: number;
  
  // Location quality features
  crimeScore: number;           // Lower is better (inverted for scoring)
  walkabilityScore: number;
  schoolQualityScore: number;
  
  // Market demand features
  investorDemandScore: number;
  searchVolume: number;
  daysOnMarketAverage: number;
  
  // Trust and risk features
  trustScore: number;
  riskScore: number;
  liquidityScore: number;
  
  // Metadata
  lastUpdated: Date;
  dataQuality: number;          // 0-100 score of data quality
}

export interface MarketFeatures {
  areaId: string;
  areaName: string;
  
  // Price trends
  averagePrice: number;
  priceChangePercent: number;
  priceTrend: 'RISING' | 'STABLE' | 'FALLING';
  
  // Market dynamics
  demandLevel: number;          // 0-100
  competitionLevel: number;     // 0-100
  marketLiquidity: number;      // 0-100
  
  // Economic indicators
  interestRateImpact: number;
  employmentGrowth: number;
  populationGrowth: number;
  
  // Metadata
  lastUpdated: Date;
  forecastHorizon: number;     // months
}

export interface FeatureReadResult {
  propertyId: string;
  features: PropertyFeatures;
  readTimeMs: number;
  cacheHit: boolean;
}

export class FeatureStore {
  private cache: Map<string, PropertyFeatures>;
  private marketCache: Map<string, MarketFeatures>;
  private cacheExpiry: number = 3600000; // 1 hour in milliseconds
  private projectId: string;
  private featureStoreId: string;

  constructor() {
    this.cache = new Map();
    this.marketCache = new Map();
    this.projectId = process.env.GCP_PROJECT_ID || 'reservatior-prod';
    this.featureStoreId = process.env.FEATURE_STORE_ID || 'reservatior-feature-store';
  }

  /**
   * Read property features with O(1) cache access
   */
  async readPropertyFeatures(propertyId: string): Promise<FeatureReadResult> {
    const startTime = Date.now();

    // Check cache first
    const cached = this.cache.get(propertyId);
    if (cached && this.isCacheValid(cached.lastUpdated)) {
      return {
        propertyId,
        features: cached,
        readTimeMs: Date.now() - startTime,
        cacheHit: true
      };
    }

    // Cache miss - fetch from feature store
    const features = await this.fetchFromFeatureStore(propertyId);
    
    // Update cache
    this.cache.set(propertyId, features);

    return {
      propertyId,
      features,
      readTimeMs: Date.now() - startTime,
      cacheHit: false
    };
  }

  /**
   * Batch read multiple property features
   */
  async batchReadPropertyFeatures(propertyIds: string[]): Promise<FeatureReadResult[]> {
    const results = await Promise.all(
      propertyIds.map(id => this.readPropertyFeatures(id))
    );
    
    return results;
  }

  /**
   * Write property features to feature store
   */
  async writePropertyFeatures(features: PropertyFeatures): Promise<void> {
    // Update cache
    this.cache.set(features.propertyId, features);

    // TODO: Implement actual Vertex AI Feature Store write
    // const { FeatureStoreServiceClient } = require('@google-cloud/aiplatform').v1;
    // const client = new FeatureStoreServiceClient();
    // await client.writeFeatureValues({ ... });

    console.log(`[FeatureStore] Written features for property: ${features.propertyId}`);
  }

  /**
   * Read market features for an area
   */
  async readMarketFeatures(areaId: string): Promise<MarketFeatures | null> {
    const cached = this.marketCache.get(areaId);
    if (cached && this.isCacheValid(cached.lastUpdated)) {
      return cached;
    }

    // Fetch from feature store
    const features = await this.fetchMarketFeaturesFromStore(areaId);
    
    if (features) {
      this.marketCache.set(areaId, features);
    }

    return features;
  }

  /**
   * Fetch features from Vertex AI Feature Store
   */
  private async fetchFromFeatureStore(propertyId: string): Promise<PropertyFeatures> {
    // TODO: Implement actual Vertex AI Feature Store read
    // For now, return mock data
    
    return {
      propertyId,
      capRate: 0.08,
      cashOnCashReturn: 0.12,
      grossYield: 0.15,
      netYield: 0.10,
      areaVacancyRate: 0.05,
      propertyVacancyRate: 0.03,
      crimeScore: 0.7,           // 70/100 (lower is better)
      walkabilityScore: 0.85,
      schoolQualityScore: 0.8,
      investorDemandScore: 0.75,
      searchVolume: 1000,
      daysOnMarketAverage: 45,
      trustScore: 0.85,
      riskScore: 0.3,
      liquidityScore: 0.8,
      lastUpdated: new Date(),
      dataQuality: 90
    };
  }

  /**
   * Fetch market features from store
   */
  private async fetchMarketFeaturesFromStore(areaId: string): Promise<MarketFeatures | null> {
    // TODO: Implement actual Vertex AI Feature Store read
    // For now, return mock data
    
    return {
      areaId,
      areaName: 'Unknown Area',
      averagePrice: 500000,
      priceChangePercent: 5.2,
      priceTrend: 'RISING',
      demandLevel: 75,
      competitionLevel: 60,
      marketLiquidity: 80,
      interestRateImpact: 0.3,
      employmentGrowth: 2.5,
      populationGrowth: 1.8,
      lastUpdated: new Date(),
      forecastHorizon: 12
    };
  }

  /**
   * Check if cache entry is still valid
   */
  private isCacheValid(lastUpdated: Date): boolean {
    const now = new Date();
    const age = now.getTime() - lastUpdated.getTime();
    return age < this.cacheExpiry;
  }

  /**
   * Clear cache
   */
  clearCache(): void {
    this.cache.clear();
    this.marketCache.clear();
    console.log('[FeatureStore] Cache cleared');
  }

  /**
   * Get cache statistics
   */
  getCacheStats() {
    return {
      propertyCacheSize: this.cache.size,
      marketCacheSize: this.marketCache.size,
      cacheExpiryMs: this.cacheExpiry,
      projectId: this.projectId,
      featureStoreId: this.featureStoreId
    };
  }

  /**
   * Pre-warm cache with commonly accessed features
   */
  async preWarmCache(propertyIds: string[]): Promise<void> {
    console.log(`[FeatureStore] Pre-warming cache for ${propertyIds.length} properties`);
    
    await this.batchReadPropertyFeatures(propertyIds);
    
    console.log('[FeatureStore] Cache pre-warming completed');
  }

  /**
   * Update cache expiry time
   */
  setCacheExpiry(milliseconds: number): void {
    this.cacheExpiry = milliseconds;
    console.log(`[FeatureStore] Cache expiry set to ${milliseconds}ms`);
  }
}

export const featureStore = new FeatureStore();
