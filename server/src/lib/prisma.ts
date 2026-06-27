/**
 * PrismaManager — Multi-Region Database Connection Manager
 * 
 * Manages PrismaClient instances per country/region.
 * Each region connects to its own PostgreSQL database.
 * Connections are lazily initialized and cached for performance.
 */
import { PrismaClient } from "@prisma/client";
import { countryGuardExtension } from "./country-guard";

// ─── Region → DATABASE_URL_XX Mapping ──────────────────────
const REGION_DB_MAP: Record<string, string> = {
  US:  "DATABASE_URL_US",
  USA: "DATABASE_URL_US",
  TR:  "DATABASE_URL_TR",
  UK:  "DATABASE_URL_UK",
  DE:  "DATABASE_URL_DE",
  FR:  "DATABASE_URL_FR",
  ES:  "DATABASE_URL_ES",
  IT:  "DATABASE_URL_IT",
  NL:  "DATABASE_URL_NL",
  CA:  "DATABASE_URL_CA",
  MX:  "DATABASE_URL_MX",
  BR:  "DATABASE_URL_BR",
  AR:  "DATABASE_URL_AR",
  AU:  "DATABASE_URL_AU",
  NZ:  "DATABASE_URL_NZ",
  JP:  "DATABASE_URL_JP",
  KR:  "DATABASE_URL_KR",
  CN:  "DATABASE_URL_CN",
  IN:  "DATABASE_URL_IN",
  SG:  "DATABASE_URL_SG",
  MY:  "DATABASE_URL_MY",
  TH:  "DATABASE_URL_TH",
  AE:  "DATABASE_URL_AE",
  SA:  "DATABASE_URL_SA",
};

// Default region when no X-Region header is sent
const DEFAULT_REGION = "US";

class PrismaManager {
  private clients = new Map<string, PrismaClient>();
  private defaultClient: PrismaClient;

  constructor() {
    // The default client uses DATABASE_URL (main/base database)
    this.defaultClient = new PrismaClient({
      log: process.env.NODE_ENV === "development" ? ["error", "warn"] : ["error"],
    }).$extends(countryGuardExtension(DEFAULT_REGION)) as unknown as PrismaClient;
  }

  /**
   * Resolve a region code to its normalized uppercase form
   */
  private normalizeRegion(region: string): string {
    return region.trim().toUpperCase();
  }

  /**
   * Get a PrismaClient for a specific region.
   * Lazily creates and caches connections.
   */
  getClient(region?: string | null): PrismaClient {
    // If no region specified, return default
    if (!region) return this.defaultClient;

    const normalized = this.normalizeRegion(region);

    // Check cache
    const cached = this.clients.get(normalized);
    if (cached) return cached;

    // Find the env var for this region
    const envKey = REGION_DB_MAP[normalized];
    if (!envKey) {
      console.warn(`⚠️ PrismaManager: Unknown region "${normalized}", falling back to default database`);
      return this.defaultClient;
    }

    const dbUrl = process.env[envKey];
    if (!dbUrl) {
      console.warn(`⚠️ PrismaManager: ${envKey} not set in .env, falling back to default database`);
      return this.defaultClient;
    }

    // Create new client for this region with override
    console.log(`🌍 PrismaManager: Initializing database connection for region [${normalized}]`);
    const baseClient = new PrismaClient({
      datasources: {
        db: {
          url: dbUrl,
        },
      },
      log: process.env.NODE_ENV === "development" ? ["error", "warn"] : ["error"],
    });
    
    const client = baseClient.$extends(countryGuardExtension(normalized)) as unknown as PrismaClient;

    this.clients.set(normalized, client);
    return client;
  }

  /**
   * Get the default (base) PrismaClient
   */
  getDefault(): PrismaClient {
    return this.defaultClient;
  }

  /**
   * Disconnect all clients gracefully (for shutdown)
   */
  async disconnectAll(): Promise<void> {
    const promises: Promise<void>[] = [this.defaultClient.$disconnect()];
    for (const [region, client] of this.clients) {
      console.log(`🔌 PrismaManager: Disconnecting region [${region}]`);
      promises.push(client.$disconnect());
    }
    await Promise.all(promises);
  }

  /**
   * List all active region connections
   */
  getActiveRegions(): string[] {
    return Array.from(this.clients.keys());
  }

  /**
   * Get supported regions list
   */
  getSupportedRegions(): string[] {
    return Object.keys(REGION_DB_MAP).filter(
      (key, i, arr) => arr.indexOf(key) === i // deduplicate aliases
    );
  }
}

// Singleton instance
const globalForPrismaManager = globalThis as unknown as { prismaManager: PrismaManager };

export const prismaManager =
  globalForPrismaManager.prismaManager ?? new PrismaManager();

if (process.env.NODE_ENV !== "production") {
  globalForPrismaManager.prismaManager = prismaManager;
}

// Also export the default client for backward compatibility
export const prisma = prismaManager.getDefault();

export default prismaManager;
