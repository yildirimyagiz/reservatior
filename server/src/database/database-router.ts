/**
 * Database Router Layer
 * 
 * Routes database operations to country-specific schemas based on country code
 * Agents never know about country-specific schemas, only use this router
 */

import { PrismaClient } from '@prisma/client';

export interface DatabaseConfig {
  country_code: string;
  schema_name: string;
  database_url: string;
}

export class DatabaseRouter {
  private connections: Map<string, PrismaClient>;
  private configs: Map<string, DatabaseConfig>;

  constructor() {
    this.connections = new Map();
    this.configs = new Map();
    this.initializeDefaultConfigs();
  }

  /**
   * Initialize default database configurations
   */
  private initializeDefaultConfigs() {
    // Turkey Database
    this.registerConfig({
      country_code: 'TR',
      schema_name: 'schema_tr',
      database_url: process.env.DATABASE_URL_TR || process.env.DATABASE_URL
    });

    // USA Database
    this.registerConfig({
      country_code: 'US',
      schema_name: 'schema_usa',
      database_url: process.env.DATABASE_URL_USA || process.env.DATABASE_URL
    });

    // UAE Database
    this.registerConfig({
      country_code: 'AE',
      schema_name: 'schema_ae',
      database_url: process.env.DATABASE_URL_AE || process.env.DATABASE_URL
    });

    // UK Database
    this.registerConfig({
      country_code: 'GB',
      schema_name: 'schema_uk',
      database_url: process.env.DATABASE_URL_UK || process.env.DATABASE_URL
    });

    console.log('[DatabaseRouter] Initialized default database configurations');
  }

  /**
   * Register database configuration for a country
   */
  registerConfig(config: DatabaseConfig): void {
    this.configs.set(config.country_code, config);
    console.log(`[DatabaseRouter] Registered database config for ${config.country_code}`);
  }

  /**
   * Get Prisma client for specific country
   */
  getClient(countryCode: string): PrismaClient {
    // Check if connection already exists
    if (this.connections.has(countryCode)) {
      return this.connections.get(countryCode)!;
    }

    // Get configuration
    const config = this.configs.get(countryCode);
    if (!config) {
      throw new Error(`No database configuration found for country: ${countryCode}`);
    }

    // Create new Prisma client with schema override
    const prisma = new PrismaClient({
      datasources: {
        db: {
          url: config.database_url
        }
      }
    });

    // Cache the connection
    this.connections.set(countryCode, prisma);
    console.log(`[DatabaseRouter] Created Prisma client for ${countryCode}`);

    return prisma;
  }

  /**
   * Execute query on specific country database
   */
  async executeQuery<T>(
    countryCode: string,
    query: (prisma: PrismaClient) => Promise<T>
  ): Promise<T> {
    const prisma = this.getClient(countryCode);
    return await query(prisma);
  }

  /**
   * Get property by ID from country database
   */
  async getProperty(countryCode: string, propertyId: string) {
    return this.executeQuery(countryCode, async (prisma) => {
      // Dynamic model access based on country
      const Model = (prisma as any).propertyProspect || (prisma as any).PropertyProspect;
      
      if (!Model) {
        throw new Error(`PropertyProspect model not found for country: ${countryCode}`);
      }

      return await Model.findUnique({
        where: { id: propertyId }
      });
    });
  }

  /**
   * Create property in country database
   */
  async createProperty(countryCode: string, propertyData: any) {
    return this.executeQuery(countryCode, async (prisma) => {
      const Model = (prisma as any).propertyProspect || (prisma as any).PropertyProspect;
      
      if (!Model) {
        throw new Error(`PropertyProspect model not found for country: ${countryCode}`);
      }

      return await Model.create({
        data: propertyData
      });
    });
  }

  /**
   * Update property in country database
   */
  async updateProperty(countryCode: string, propertyId: string, updateData: any) {
    return this.executeQuery(countryCode, async (prisma) => {
      const Model = (prisma as any).propertyProspect || (prisma as any).PropertyProspect;
      
      if (!Model) {
        throw new Error(`PropertyProspect model not found for country: ${countryCode}`);
      }

      return await Model.update({
        where: { id: propertyId },
        data: updateData
      });
    });
  }

  /**
   * Get properties by filter from country database
   */
  async getProperties(countryCode: string, filter: any = {}) {
    return this.executeQuery(countryCode, async (prisma) => {
      const Model = (prisma as any).propertyProspect || (prisma as any).PropertyProspect;
      
      if (!Model) {
        throw new Error(`PropertyProspect model not found for country: ${countryCode}`);
      }

      return await Model.findMany({
        where: filter
      });
    });
  }

  /**
   * Create valuation in country database
   */
  async createValuation(countryCode: string, valuationData: any) {
    return this.executeQuery(countryCode, async (prisma) => {
      const Model = (prisma as any).valuationAI || (prisma as any).ValuationAI;
      
      if (!Model) {
        throw new Error(`ValuationAI model not found for country: ${countryCode}`);
      }

      return await Model.create({
        data: valuationData
      });
    });

  }

  /**
   * Update property with AI analysis results
   */
  async updatePropertyWithAI(countryCode: string, propertyId: string, aiData: any) {
    return this.executeQuery(countryCode, async (prisma) => {
      const Model = (prisma as any).propertyProspect || (prisma as any).PropertyProspect;
      
      if (!Model) {
        throw new Error(`PropertyProspect model not found for country: ${countryCode}`);
      }

      return await Model.update({
        where: { id: propertyId },
        data: {
          aiAnalyzed: true,
          aiAnalysisDate: new Date(),
          aiConfidenceScore: aiData.confidenceScore,
          aiAnalysisMetadata: aiData.metadata,
          acquisitionScore: aiData.acquisitionScore,
          valuationScore: aiData.valuationScore,
          overallPriority: aiData.overallPriority
        }
      });
    });
  }

  /**
   * Get database configuration
   */
  getConfig(countryCode: string): DatabaseConfig | undefined {
    return this.configs.get(countryCode);
  }

  /**
   * Get all configured countries
   */
  getConfiguredCountries(): string[] {
    return Array.from(this.configs.keys());
  }

  /**
   * Close all database connections
   */
  async closeAllConnections(): Promise<void> {
    for (const [countryCode, prisma] of this.connections.entries()) {
      await prisma.$disconnect();
      console.log(`[DatabaseRouter] Closed connection for ${countryCode}`);
    }
    this.connections.clear();
  }

  /**
   * Test connection to country database
   */
  async testConnection(countryCode: string): Promise<boolean> {
    try {
      const prisma = this.getClient(countryCode);
      await prisma.$queryRaw`SELECT 1`;
      console.log(`[DatabaseRouter] Connection test successful for ${countryCode}`);
      return true;
    } catch (error) {
      console.error(`[DatabaseRouter] Connection test failed for ${countryCode}:`, error);
      return false;
    }
  }

  /**
   * Get connection status for all countries
   */
  async getConnectionStatus(): Promise<Record<string, boolean>> {
    const status: Record<string, boolean> = {};
    
    for (const countryCode of this.getConfiguredCountries()) {
      status[countryCode] = await this.testConnection(countryCode);
    }
    
    return status;
  }
}

export const databaseRouter = new DatabaseRouter();
