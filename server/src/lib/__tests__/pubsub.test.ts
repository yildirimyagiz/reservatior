import { describe, it, expect, afterEach } from 'bun:test';
import { pubsub } from '../pubsub';

describe('PubSubManager', () => {
  afterEach(() => {
    pubsub.disconnect();
  });

  it('getClient returns null when GCP_PROJECT_ID not set', () => {
    delete process.env.GCP_PROJECT_ID;
    expect(pubsub.getClient()).toBeNull();
  });

  it('getTopic returns null when not configured', () => {
    delete process.env.GCP_PROJECT_ID;
    expect(pubsub.getTopic('test-topic')).toBeNull();
  });

  it('publish returns null when not configured', async () => {
    delete process.env.GCP_PROJECT_ID;
    const result = await pubsub.publish('test-topic', { event: 'test' });
    expect(result).toBeNull();
  });

  it('subscribe does not throw when not configured', async () => {
    delete process.env.GCP_PROJECT_ID;
    await expect(
      pubsub.subscribe('test-topic', 'test-sub', async () => {}),
    ).resolves.toBeUndefined();
  });

  it('disconnect does not throw when not connected', async () => {
    await expect(pubsub.disconnect()).resolves.toBeUndefined();
  });
});
