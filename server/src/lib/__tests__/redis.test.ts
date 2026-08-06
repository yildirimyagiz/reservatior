import { describe, it, expect, beforeEach, afterEach } from 'bun:test';
import { redis } from '../redis';

describe('RedisManager', () => {
  beforeEach(() => {
    // Ensure no REDIS_URL for testing graceful fallback
    delete process.env.REDIS_URL;
  });

  afterEach(() => {
    redis.disconnect();
  });

  it('getClient returns null when REDIS_URL not set', () => {
    expect(redis.getClient()).toBeNull();
  });

  it('get returns null when not connected', async () => {
    const result = await redis.get('test-key');
    expect(result).toBeNull();
  });

  it('set does not throw when not connected', async () => {
    await expect(redis.set('test-key', { foo: 'bar' })).resolves.toBeUndefined();
  });

  it('del does not throw when not connected', async () => {
    await expect(redis.del('test-key')).resolves.toBeUndefined();
  });

  it('incr returns 0 when not connected', async () => {
    const result = await redis.incr('counter');
    expect(result).toBe(0);
  });

  it('delPattern does not throw when not connected', async () => {
    await expect(redis.delPattern('test:*')).resolves.toBeUndefined();
  });
});
