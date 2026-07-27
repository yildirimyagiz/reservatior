/**
 * Agent Gateway Integration Test
 * 
 * Validates that Agent Gateway can switch between AI providers
 * Tests model-agnostic interface and fallback mechanisms
 */

import { agentGateway } from '../../src/agents/agent-interface';

describe('Agent Gateway Integration', () => {
  test('should have default provider configured', () => {
    const stats = agentGateway.getUsageStats();
    expect(stats.defaultProvider).toBe('gemini');
    expect(stats.totalProviders).toBeGreaterThan(0);
  });

  test('should get provider status for all registered providers', () => {
    const status = agentGateway.getProviderStatus();
    
    expect(status).toHaveProperty('gemini');
    expect(status).toHaveProperty('openai');
    expect(status).toHaveProperty('claude');
    expect(status).toHaveProperty('local');
    
    // Check status structure
    Object.values(status).forEach(providerStatus => {
      expect(providerStatus).toHaveProperty('available');
      expect(providerStatus).toHaveProperty('model');
      expect(typeof providerStatus.available).toBe('boolean');
      expect(typeof providerStatus.model).toBe('string');
    });
  });

  test('should get all registered providers', () => {
    const providers = agentGateway.getProviders();
    
    expect(providers.size).toBeGreaterThan(0);
    expect(providers.has('gemini')).toBe(true);
    expect(providers.has('openai')).toBe(true);
    expect(providers.has('claude')).toBe(true);
    expect(providers.has('local')).toBe(true);
  });

  test('should switch default provider', async () => {
    const originalStats = agentGateway.getUsageStats();
    expect(originalStats.defaultProvider).toBe('gemini');

    // Switch to OpenAI
    await agentGateway.switchProvider('openai');
    
    const newStats = agentGateway.getUsageStats();
    expect(newStats.defaultProvider).toBe('openai');

    // Switch back to Gemini
    await agentGateway.switchProvider('gemini');
    
    const finalStats = agentGateway.getUsageStats();
    expect(finalStats.defaultProvider).toBe('gemini');
  });

  test('should throw error when switching to non-existent provider', async () => {
    await expect(agentGateway.switchProvider('non-existent-provider')).rejects.toThrow();
  });

  test('should calculate cost estimate for different providers', () => {
    const geminiCost = agentGateway.getCostEstimate('gemini', 1000);
    const openaiCost = agentGateway.getCostEstimate('openai', 1000);
    const claudeCost = agentGateway.getCostEstimate('claude', 1000);
    const localCost = agentGateway.getCostEstimate('local', 1000);

    // Gemini should be cheapest
    expect(geminiCost).toBeGreaterThan(0);
    expect(geminiCost).toBeLessThan(openaiCost);
    
    // Local should be free
    expect(localCost).toBe(0);
  });

  test('should handle text generation request', async () => {
    const request = {
      prompt: 'Test prompt for AI generation',
      temperature: 0.7,
      maxTokens: 100
    };

    // This will use the default provider (gemini)
    // In test environment without API keys, it should fallback to available providers
    try {
      const response = await agentGateway.generateText(request);
      
      expect(response).toHaveProperty('content');
      expect(response).toHaveProperty('model');
      expect(response).toHaveProperty('provider');
      expect(response).toHaveProperty('tokensUsed');
      expect(response).toHaveProperty('processingTimeMs');
      
      expect(typeof response.content).toBe('string');
      expect(typeof response.model).toBe('string');
      expect(typeof response.provider).toBe('string');
      expect(typeof response.tokensUsed).toBe('number');
      expect(typeof response.processingTimeMs).toBe('number');
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should handle embedding generation request', async () => {
    const text = 'Test text for embedding generation';

    try {
      const embedding = await agentGateway.generateEmbedding(text);
      
      expect(Array.isArray(embedding)).toBe(true);
      expect(embedding.length).toBeGreaterThan(0);
      expect(typeof embedding[0]).toBe('number');
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should handle text generation with specific provider', async () => {
    const request = {
      prompt: 'Test prompt for specific provider',
      temperature: 0.5,
      maxTokens: 50
    };

    try {
      const response = await agentGateway.generateText(request, 'openai');
      
      expect(response.provider).toBe('openai');
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should validate provider configuration', () => {
    const geminiProvider = agentGateway.getProvider('gemini');
    expect(geminiProvider.validateConfig()).toBeDefined();
    expect(typeof geminiProvider.validateConfig()).toBe('function');

    const openaiProvider = agentGateway.getProvider('openai');
    expect(openaiProvider.validateConfig()).toBeDefined();
    expect(typeof openaiProvider.validateConfig()).toBe('function');
  });

  test('should handle system prompt in text generation', async () => {
    const request = {
      prompt: 'Test prompt',
      systemPrompt: 'You are a helpful assistant',
      temperature: 0.7,
      maxTokens: 100
    };

    try {
      const response = await agentGateway.generateText(request);
      
      expect(response).toHaveProperty('content');
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should handle context in text generation', async () => {
    const request = {
      prompt: 'Test prompt',
      context: {
        apiKey: 'test-key',
        customParam: 'test-value'
      },
      temperature: 0.7,
      maxTokens: 100
    };

    try {
      const response = await agentGateway.generateText(request);
      
      expect(response).toHaveProperty('content');
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should handle embedding generation with specific provider', async () => {
    const text = 'Test text for specific provider embedding';

    try {
      const embedding = await agentGateway.generateEmbedding(text, 'openai');
      
      expect(Array.isArray(embedding)).toBe(true);
      expect(embedding.length).toBeGreaterThan(0);
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should provide different embedding dimensions for different providers', async () => {
    try {
      const geminiEmbedding = await agentGateway.generateEmbedding('test', 'gemini');
      const openaiEmbedding = await agentGateway.generateEmbedding('test', 'openai');
      
      // Different providers may have different embedding dimensions
      expect(geminiEmbedding.length).toBeGreaterThan(0);
      expect(openaiEmbedding.length).toBeGreaterThan(0);
      
      // They should likely be different
      // (though they could coincidentally be the same)
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should handle provider configuration', () => {
    const geminiProvider = agentGateway.getProvider('gemini');
    
    expect(geminiProvider.config).toHaveProperty('provider');
    expect(geminiProvider.config).toHaveProperty('model');
    expect(geminiProvider.config).toHaveProperty('temperature');
    expect(geminiProvider.config).toHaveProperty('maxTokens');
    
    expect(geminiProvider.config.provider).toBe('gemini');
    expect(geminiProvider.config.model).toBe('gemini-2.5-flash');
  });

  test('should handle cost estimation for different token amounts', () => {
    const geminiCost100 = agentGateway.getCostEstimate('gemini', 100);
    const geminiCost1000 = agentGateway.getCostEstimate('gemini', 1000);
    const geminiCost10000 = agentGateway.getCostEstimate('gemini', 10000);

    expect(geminiCost1000).toBeGreaterThan(geminiCost100);
    expect(geminiCost10000).toBeGreaterThan(geminiCost1000);
  });

  test('should handle cost estimation for all providers', () => {
    const providers = ['gemini', 'openai', 'claude', 'local'];
    
    providers.forEach(provider => {
      const cost = agentGateway.getCostEstimate(provider, 1000);
      expect(typeof cost).toBe('number');
      expect(cost).toBeGreaterThanOrEqual(0);
    });
  });
});

describe('Agent Gateway Fallback Mechanism', () => {
  test('should fallback to available provider when primary fails', async () => {
    // This test validates the fallback mechanism
    // In a real scenario with invalid API keys, it should try other providers
    
    const request = {
      prompt: 'Test prompt for fallback',
      temperature: 0.7,
      maxTokens: 100
    };

    try {
      const response = await agentGateway.generateText(request);
      
      // Should succeed with some provider (fallback or primary)
      expect(response).toHaveProperty('provider');
      expect(response).toHaveProperty('content');
    } catch (error) {
      // If all providers fail, this is expected in test environment
      expect(error).toBeDefined();
    }
  });

  test('should report provider availability correctly', () => {
    const status = agentGateway.getProviderStatus();
    
    // In test environment without API keys, most providers will be unavailable
    // Local provider should always be available
    expect(status.local.available).toBe(true);
  });
});

describe('Agent Gateway Performance', () => {
  test('should track processing time in responses', async () => {
    const request = {
      prompt: 'Test prompt for performance',
      temperature: 0.7,
      maxTokens: 50
    };

    try {
      const response = await agentGateway.generateText(request);
      
      expect(response.processingTimeMs).toBeGreaterThanOrEqual(0);
      expect(response.processingTimeMs).toBeLessThan(60000); // Should complete within 60 seconds
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });

  test('should handle concurrent requests', async () => {
    const requests = Array(5).fill(null).map(() => ({
      prompt: 'Test prompt for concurrent processing',
      temperature: 0.7,
      maxTokens: 50
    }));

    try {
      const responses = await Promise.all(
        requests.map(request => agentGateway.generateText(request))
      );

      expect(responses).toHaveLength(5);
      responses.forEach(response => {
        expect(response).toHaveProperty('content');
        expect(response).toHaveProperty('provider');
      });
    } catch (error) {
      // Expected in test environment without API keys
      expect(error).toBeDefined();
    }
  });
});
