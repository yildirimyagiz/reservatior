/**
 * Neo4j Manager — Singleton driver with graceful fallback
 *
 * If NEO4J_URI/USERNAME/PASSWORD are not set, all queries return empty arrays.
 * Each country gets its own Neo4j database for data sovereignty.
 */
import neo4j, { Driver, Session, Record } from 'neo4j-driver';

class Neo4jManager {
  private static driver: Driver | null = null;

  static getDriver(): Driver | null {
    const uri = process.env.NEO4J_URI;
    const user = process.env.NEO4J_USERNAME;
    const pass = process.env.NEO4J_PASSWORD;

    if (!uri || !user || !pass) {
      return null;
    }

    if (!this.driver) {
      this.driver = neo4j.driver(uri, neo4j.auth.basic(user, pass), {
        maxConnectionPoolSize: 50,
        connectionAcquisitionTimeout: 30_000,
      });
      console.log('[Neo4j] Driver initialized');
    }

    return this.driver;
  }

  static getSession(database?: string): Session | null {
    const driver = this.getDriver();
    if (!driver) return null;
    return driver.session({ database: database || 'neo4j' });
  }

  static async run(
    cypher: string,
    params?: Record<string, any>,
    database?: string,
  ): Promise<Record<string, any>[]> {
    const session = this.getSession(database);
    if (!session) return [];

    try {
      const result = await session.run(cypher, params ?? {});
      return result.records.map((r) => r.toObject());
    } catch (err: any) {
      console.error('[Neo4j] Query error:', err?.message ?? err);
      return [];
    } finally {
      await session.close().catch(() => {});
    }
  }

  static async close(): Promise<void> {
    if (this.driver) {
      await this.driver.close().catch(() => {});
      this.driver = null;
    }
  }
}

export const neo4jManager = Neo4jManager;
