import { describe, it, expect, afterEach } from 'bun:test';
import { neo4jManager } from '../neo4j';

describe('Neo4jManager', () => {
  afterEach(() => {
    neo4jManager.close();
  });

  it('getDriver returns null when env vars not set', () => {
    delete process.env.NEO4J_URI;
    delete process.env.NEO4J_USERNAME;
    delete process.env.NEO4J_PASSWORD;
    expect(neo4jManager.getDriver()).toBeNull();
  });

  it('getSession returns null when not configured', () => {
    delete process.env.NEO4J_URI;
    delete process.env.NEO4J_USERNAME;
    delete process.env.NEO4J_PASSWORD;
    expect(neo4jManager.getSession()).toBeNull();
  });

  it('run returns empty array when not configured', async () => {
    delete process.env.NEO4J_URI;
    delete process.env.NEO4J_USERNAME;
    delete process.env.NEO4J_PASSWORD;
    const result = await neo4jManager.run('MATCH (n) RETURN n');
    expect(result).toEqual([]);
  });

  it('run with params returns empty array when not configured', async () => {
    delete process.env.NEO4J_URI;
    const result = await neo4jManager.run('MATCH (n {id: $id}) RETURN n', { id: 'test' }, 'testdb');
    expect(result).toEqual([]);
  });

  it('close does not throw when not connected', async () => {
    await expect(neo4jManager.close()).resolves.toBeUndefined();
  });
});
