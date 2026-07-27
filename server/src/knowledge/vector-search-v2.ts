/**
 * Vector Search v2 - Country-Aware Semantic Search
 * 
 * Enables semantic search over property descriptions, features, and market data
 * Uses embeddings to find similar properties based on meaning, not just keywords
 * Integrates with Google Cloud Vertex AI Vector Search or similar
 * Country-aware: Each country has its own embedding index for data sovereignty
 */

import { agentGateway } from '../agents/agent-interface';

export interface PropertyEmbedding {
  propertyId: string;
  embedding: number[];
  text: string;
  embeddingModel: string;
  timestamp: Date;
  country_code: string;
  propertyData: any;
}

export interface SearchResult {
  propertyId: string;
  similarityScore: number;
  propertyData: any;
  matchedFeatures: string[];
  country_code: string;
}

export interface SearchQuery {
  text: string;
  country_code: string;
  filters?: {
    location?: string;
    priceRange?: { min: number; max: number };
    propertyType?: string;
    bedrooms?: number;
  };
  limit?: number;
}

export class CountryAwareVectorSearch {
  private embeddings: Map<string, Map<string, PropertyEmbedding>>; // country_code -> propertyId -> embedding
  private embeddingModel: string;
  private embeddingDimension: number;

  constructor() {
    this.embeddings = new Map();
    this.embeddingModel = process.env.EMBEDDING_MODEL || 'textembedding-gecko@003';
    this.embeddingDimension = 768; // Default for Gecko model
    
    // Initialize country-specific embedding stores
    const countries = ['TR', 'US', 'AE', 'GB'];
    countries.forEach(country => {
      this.embeddings.set(country, new Map());
    });
  }

  /**
   * Generate embedding for text using Agent Gateway
   */
  async generateEmbedding(text: string): Promise<number[]> {
    try {
      return await agentGateway.generateEmbedding(text);
    } catch (error) {
      console.error('[VectorSearch] Failed to generate embedding:', error);
      // Fallback: return random embedding
      return new Array(this.embeddingDimension).fill(0).map(() => Math.random());
    }
  }

  /**
   * Index property in country-specific embedding store
   */
  async indexProperty(countryCode: string, propertyId: string, text: string, propertyData: any): Promise<void> {
    const embedding = await this.generateEmbedding(text);
    
    const propertyEmbedding: PropertyEmbedding = {
      propertyId,
      embedding,
      text,
      embeddingModel: this.embeddingModel,
      timestamp: new Date(),
      country_code: countryCode,
      propertyData
    };

    const countryStore = this.embeddings.get(countryCode);
    if (!countryStore) {
      this.embeddings.set(countryCode, new Map());
      this.embeddings.get(countryCode)?.set(propertyId, propertyEmbedding);
    } else {
      countryStore.set(propertyId, propertyEmbedding);
    }

    console.log(`[VectorSearch] Indexed property ${propertyId} in ${countryCode} embedding store`);
  }

  /**
   * Batch index properties for a country
   */
  async batchIndexProperties(countryCode: string, properties: Array<{
    propertyId: string;
    text: string;
    propertyData: any;
  }>): Promise<void> {
    const countryStore = this.embeddings.get(countryCode);
    if (!countryStore) {
      this.embeddings.set(countryCode, new Map());
    }

    for (const property of properties) {
      await this.indexProperty(countryCode, property.propertyId, property.text, property.propertyData);
    }

    console.log(`[VectorSearch] Batch indexed ${properties.length} properties for ${countryCode}`);
  }

  /**
   * Semantic search within country
   */
  async semanticSearch(query: SearchQuery): Promise<SearchResult[]> {
    const { text, country_code, filters, limit = 10 } = query;
    
    const countryStore = this.embeddings.get(country_code);
    if (!countryStore || countryStore.size === 0) {
      console.warn(`[VectorSearch] No embeddings found for country: ${country_code}`);
      return [];
    }

    // Generate query embedding
    const queryEmbedding = await this.generateEmbedding(text);

    // Calculate similarity scores
    const results: SearchResult[] = [];
    
    for (const [propertyId, propertyEmbedding] of countryStore.entries()) {
      const similarity = this.calculateCosineSimilarity(queryEmbedding, propertyEmbedding.embedding);
      
      // Apply filters if provided
      let matchesFilters = true;
      if (filters) {
        if (filters.location && propertyEmbedding.propertyData.location !== filters.location) {
          matchesFilters = false;
        }
        if (filters.priceRange) {
          const price = propertyEmbedding.propertyData.price || 0;
          if (price < filters.priceRange.min || price > filters.priceRange.max) {
            matchesFilters = false;
          }
        }
        if (filters.propertyType && propertyEmbedding.propertyData.propertyType !== filters.propertyType) {
          matchesFilters = false;
        }
        if (filters.bedrooms && propertyEmbedding.propertyData.bedrooms !== filters.bedrooms) {
          matchesFilters = false;
        }
      }

      if (matchesFilters) {
        results.push({
          propertyId,
          similarityScore: similarity,
          propertyData: propertyEmbedding.propertyData,
          matchedFeatures: this.extractMatchedFeatures(text, propertyEmbedding.text),
          country_code
        });
      }
    }

    // Sort by similarity score and limit results
    results.sort((a, b) => b.similarityScore - a.similarityScore);
    
    console.log(`[VectorSearch] Semantic search returned ${Math.min(limit, results.length)} results for ${country_code}`);
    
    return results.slice(0, limit);
  }

  /**
   * Find similar properties within country
   */
  async findSimilarProperties(countryCode: string, propertyId: string, limit: number = 10): Promise<SearchResult[]> {
    const countryStore = this.embeddings.get(countryCode);
    if (!countryStore) {
      console.warn(`[VectorSearch] No embeddings found for country: ${countryCode}`);
      return [];
    }

    const targetEmbedding = countryStore.get(propertyId);
    if (!targetEmbedding) {
      console.warn(`[VectorSearch] Property not found in embedding store: ${propertyId}`);
      return [];
    }

    const results: SearchResult[] = [];
    
    for (const [pid, propertyEmbedding] of countryStore.entries()) {
      if (pid === propertyId) continue; // Skip the target property itself
      
      const similarity = this.calculateCosineSimilarity(targetEmbedding.embedding, propertyEmbedding.embedding);
      
      results.push({
        propertyId: pid,
        similarityScore: similarity,
        propertyData: propertyEmbedding.propertyData,
        matchedFeatures: this.extractMatchedFeatures(targetEmbedding.text, propertyEmbedding.text),
        country_code: countryCode
      });
    }

    // Sort by similarity score and limit results
    results.sort((a, b) => b.similarityScore - a.similarityScore);
    
    console.log(`[VectorSearch] Found ${Math.min(limit, results.length)} similar properties for ${propertyId} (${countryCode})`);
    
    return results.slice(0, limit);
  }

  /**
   * Calculate cosine similarity between two embeddings
   */
  private calculateCosineSimilarity(embedding1: number[], embedding2: number[]): number {
    if (embedding1.length !== embedding2.length) {
      console.warn('[VectorSearch] Embedding dimensions do not match');
      return 0;
    }

    let dotProduct = 0;
    let norm1 = 0;
    let norm2 = 0;

    for (let i = 0; i < embedding1.length; i++) {
      dotProduct += embedding1[i] * embedding2[i];
      norm1 += embedding1[i] * embedding1[i];
      norm2 += embedding2[i] * embedding2[i];
    }

    if (norm1 === 0 || norm2 === 0) {
      return 0;
    }

    return dotProduct / (Math.sqrt(norm1) * Math.sqrt(norm2));
  }

  /**
   * Extract matched features between query and property text
   */
  private extractMatchedFeatures(queryText: string, propertyText: string): string[] {
    const queryWords = queryText.toLowerCase().split(/\s+/);
    const propertyWords = propertyText.toLowerCase().split(/\s+/);
    
    const matchedFeatures = queryWords.filter(word => 
      propertyWords.some(pWord => pWord.includes(word) || word.includes(pWord))
    );
    
    return [...new Set(matchedFeatures)]; // Remove duplicates
  }

  /**
   * Update property embedding
   */
  async updateProperty(countryCode: string, propertyId: string, text: string, propertyData: any): Promise<void> {
    const countryStore = this.embeddings.get(countryCode);
    if (!countryStore) {
      console.warn(`[VectorSearch] No embedding store for country: ${countryCode}`);
      return;
    }

    await this.indexProperty(countryCode, propertyId, text, propertyData);
    console.log(`[VectorSearch] Updated embedding for property ${propertyId} (${countryCode})`);
  }

  /**
   * Remove property from embedding store
   */
  async removeProperty(countryCode: string, propertyId: string): Promise<void> {
    const countryStore = this.embeddings.get(countryCode);
    if (!countryStore) {
      console.warn(`[VectorSearch] No embedding store for country: ${countryCode}`);
      return;
    }

    countryStore.delete(propertyId);
    console.log(`[VectorSearch] Removed embedding for property ${propertyId} (${countryCode})`);
  }

  /**
   * Hybrid search: semantic + keyword filters
   */
  async hybridSearch(query: SearchQuery, keywordFilters: string[]): Promise<SearchResult[]> {
    const semanticResults = await this.semanticSearch(query);
    
    // Apply keyword filters
    const filteredResults = semanticResults.filter(result => {
      const propertyText = JSON.stringify(result.propertyData).toLowerCase();
      return keywordFilters.every(keyword => 
        propertyText.includes(keyword.toLowerCase())
      );
    });

    console.log(`[VectorSearch] Hybrid search returned ${filteredResults.length} results for ${query.country_code}`);
    
    return filteredResults;
  }

  /**
   * Cluster properties by similarity within country
   */
  async clusterProperties(countryCode: string, threshold: number = 0.8): Promise<Map<string, string[]>> {
    const countryStore = this.embeddings.get(countryCode);
    if (!countryStore || countryStore.size === 0) {
      console.warn(`[VectorSearch] No embeddings found for country: ${countryCode}`);
      return new Map();
    }

    const clusters = new Map<string, string[]>();
    const visited = new Set<string>();

    for (const [propertyId, propertyEmbedding] of countryStore.entries()) {
      if (visited.has(propertyId)) continue;

      const cluster = [propertyId];
      visited.add(propertyId);

      // Find similar properties
      for (const [pid, otherEmbedding] of countryStore.entries()) {
        if (visited.has(pid)) continue;

        const similarity = this.calculateCosineSimilarity(
          propertyEmbedding.embedding,
          otherEmbedding.embedding
        );

        if (similarity >= threshold) {
          cluster.push(pid);
          visited.add(pid);
        }
      }

      clusters.set(propertyId, cluster);
    }

    console.log(`[VectorSearch] Created ${clusters.size} clusters for ${countryCode}`);
    
    return clusters;
  }

  /**
   * Get embedding model info
   */
  getModelInfo() {
    return {
      model: this.embeddingModel,
      dimension: this.embeddingDimension,
      countries: Array.from(this.embeddings.keys()),
      totalProperties: Array.from(this.embeddings.values()).reduce((sum, store) => sum + store.size, 0)
    };
  }

  /**
   * Get index statistics for a country
   */
  getIndexStats(countryCode: string) {
    const countryStore = this.embeddings.get(countryCode);
    
    return {
      country_code: countryCode,
      propertyCount: countryStore?.size || 0,
      model: this.embeddingModel,
      dimension: this.embeddingDimension
    };
  }

  /**
   * Switch embedding model
   */
  async switchModel(newModel: string): Promise<void> {
    console.log(`[VectorSearch] Switching embedding model from ${this.embeddingModel} to ${newModel}`);
    
    this.embeddingModel = newModel;
    
    // Re-index all properties with new model
    for (const [countryCode, countryStore] of this.embeddings.entries()) {
      const properties = Array.from(countryStore.values());
      this.embeddings.set(countryCode, new Map()); // Clear existing embeddings
      
      for (const property of properties) {
        await this.indexProperty(
          countryCode,
          property.propertyId,
          property.text,
          property.propertyData
        );
      }
    }

    console.log(`[VectorSearch] Re-indexed all properties with new model: ${newModel}`);
  }

  /**
   * Cross-country semantic search (for multi-country investors)
   */
  async crossCountrySearch(query: string, countries: string[], limit: number = 10): Promise<SearchResult[]> {
    const results: SearchResult[] = [];
    
    for (const countryCode of countries) {
      const countryResults = await this.semanticSearch({
        text: query,
        country_code: countryCode,
        limit
      });
      results.push(...countryResults);
    }

    // Sort by similarity score across all countries
    results.sort((a, b) => b.similarityScore - a.similarityScore);
    
    console.log(`[VectorSearch] Cross-country search returned ${Math.min(limit, results.length)} results`);
    
    return results.slice(0, limit);
  }
}

export const countryAwareVectorSearch = new CountryAwareVectorSearch();
