/**
 * Agent Interface Standard - Model-Agnostic Agent Interface
 * 
 * Abstracts AI provider details from agent logic
 * Enables switching between Gemini, OpenAI, Claude, Local LLMs without code changes
 */

export interface AIProviderConfig {
  provider: 'gemini' | 'openai' | 'claude' | 'local';
  model: string;
  apiKey?: string;
  endpoint?: string;
  temperature?: number;
  maxTokens?: number;
}

export interface AIRequest {
  prompt: string;
  systemPrompt?: string;
  context?: Record<string, any>;
  temperature?: number;
  maxTokens?: number;
}

export interface AIResponse {
  content: string;
  model: string;
  provider: string;
  tokensUsed: number;
  processingTimeMs: number;
  metadata?: Record<string, any>;
}

export interface IAIProvider {
  name: string;
  config: AIProviderConfig;
  
  generateText(request: AIRequest): Promise<AIResponse>;
  generateEmbedding(text: string): Promise<number[]>;
  validateConfig(): boolean;
}

export class AgentGateway {
  private providers: Map<string, IAIProvider>;
  private defaultProvider: string;

  constructor() {
    this.providers = new Map();
    this.defaultProvider = 'gemini';
    this.initializeDefaultProviders();
  }

  /**
   * Initialize default AI providers
   */
  private initializeDefaultProviders() {
    // Gemini Provider (Default)
    this.registerProvider('gemini', {
      name: 'Gemini',
      config: {
        provider: 'gemini',
        model: 'gemini-2.5-flash',
        apiKey: process.env.GEMINI_API_KEY,
        temperature: 0.7,
        maxTokens: 1000
      },
      generateText: async (request: AIRequest) => {
        // TODO: Implement actual Gemini API call
        const { GoogleGenerativeAI } = require('@google/generative-ai');
        const genAI = new GoogleGenerativeAI(request.context?.apiKey || process.env.GEMINI_API_KEY);
        const model = genAI.getGenerativeModel({ model: 'gemini-2.5-flash' });
        
        const startTime = Date.now();
        const result = await model.generateContent(request.systemPrompt ? `${request.systemPrompt}\n\n${request.prompt}` : request.prompt);
        const processingTimeMs = Date.now() - startTime;

        return {
          content: result.response.text(),
          model: 'gemini-2.5-flash',
          provider: 'gemini',
          tokensUsed: 0, // TODO: Get actual token count
          processingTimeMs
        };
      },
      generateEmbedding: async (text: string) => {
        // TODO: Implement actual Gemini embedding API call
        return new Array(768).fill(0).map(() => Math.random());
      },
      validateConfig: () => !!process.env.GEMINI_API_KEY
    });

    // OpenAI Provider (Fallback)
    this.registerProvider('openai', {
      name: 'OpenAI',
      config: {
        provider: 'openai',
        model: 'gpt-4',
        apiKey: process.env.OPENAI_API_KEY,
        temperature: 0.7,
        maxTokens: 1000
      },
      generateText: async (request: AIRequest) => {
        // TODO: Implement actual OpenAI API call
        const startTime = Date.now();
        const processingTimeMs = Date.now() - startTime;

        return {
          content: 'OpenAI response (simulated)',
          model: 'gpt-4',
          provider: 'openai',
          tokensUsed: 0,
          processingTimeMs
        };
      },
      generateEmbedding: async (text: string) => {
        // TODO: Implement actual OpenAI embedding API call
        return new Array(1536).fill(0).map(() => Math.random());
      },
      validateConfig: () => !!process.env.OPENAI_API_KEY
    });

    // Claude Provider (Fallback)
    this.registerProvider('claude', {
      name: 'Claude',
      config: {
        provider: 'claude',
        model: 'claude-3-opus-20240229',
        apiKey: process.env.ANTHROPIC_API_KEY,
        temperature: 0.7,
        maxTokens: 1000
      },
      generateText: async (request: AIRequest) => {
        // TODO: Implement actual Claude API call
        const startTime = Date.now();
        const processingTimeMs = Date.now() - startTime;

        return {
          content: 'Claude response (simulated)',
          model: 'claude-3-opus-20240229',
          provider: 'claude',
          tokensUsed: 0,
          processingTimeMs
        };
      },
      generateEmbedding: async (text: string) => {
        // TODO: Implement actual Claude embedding API call
        return new Array(1024).fill(0).map(() => Math.random());
      },
      validateConfig: () => !!process.env.ANTHROPIC_API_KEY
    });

    // Local LLM Provider (Fallback)
    this.registerProvider('local', {
      name: 'Local LLM',
      config: {
        provider: 'local',
        model: 'local-model',
        endpoint: process.env.LOCAL_LLM_ENDPOINT || 'http://localhost:8080',
        temperature: 0.7,
        maxTokens: 1000
      },
      generateText: async (request: AIRequest) => {
        // TODO: Implement actual local LLM API call
        const startTime = Date.now();
        const processingTimeMs = Date.now() - startTime;

        return {
          content: 'Local LLM response (simulated)',
          model: 'local-model',
          provider: 'local',
          tokensUsed: 0,
          processingTimeMs
        };
      },
      generateEmbedding: async (text: string) => {
        // TODO: Implement actual local embedding API call
        return new Array(768).fill(0).map(() => Math.random());
      },
      validateConfig: () => true // Local models don't need API keys
    });

    console.log('[AgentGateway] Initialized default AI providers');
  }

  /**
   * Register AI provider
   */
  registerProvider(providerId: string, provider: IAIProvider): void {
    this.providers.set(providerId, provider);
    console.log(`[AgentGateway] Registered provider: ${provider.name}`);
  }

  /**
   * Get AI provider
   */
  getProvider(providerId?: string): IAIProvider {
    const id = providerId || this.defaultProvider;
    const provider = this.providers.get(id);
    
    if (!provider) {
      throw new Error(`AI provider not found: ${id}`);
    }
    
    return provider;
  }

  /**
   * Set default provider
   */
  setDefaultProvider(providerId: string): void {
    if (!this.providers.has(providerId)) {
      throw new Error(`Provider not found: ${providerId}`);
    }
    
    this.defaultProvider = providerId;
    console.log(`[AgentGateway] Default provider set to: ${providerId}`);
  }

  /**
   * Generate text using default provider
   */
  async generateText(request: AIRequest, providerId?: string): Promise<AIResponse> {
    const provider = this.getProvider(providerId);
    
    if (!provider.validateConfig()) {
      console.warn(`[AgentGateway] Provider ${provider.name} configuration invalid, trying fallback`);
      // Try fallback providers
      for (const [id, fallbackProvider] of this.providers.entries()) {
        if (id !== providerId && fallbackProvider.validateConfig()) {
          console.log(`[AgentGateway] Using fallback provider: ${fallbackProvider.name}`);
          return await fallbackProvider.generateText(request);
        }
      }
      throw new Error('No valid AI provider configuration found');
    }
    
    return await provider.generateText(request);
  }

  /**
   * Generate embedding using default provider
   */
  async generateEmbedding(text: string, providerId?: string): Promise<number[]> {
    const provider = this.getProvider(providerId);
    
    if (!provider.validateConfig()) {
      console.warn(`[AgentGateway] Provider ${provider.name} configuration invalid, trying fallback`);
      // Try fallback providers
      for (const [id, fallbackProvider] of this.providers.entries()) {
        if (id !== providerId && fallbackProvider.validateConfig()) {
          console.log(`[AgentGateway] Using fallback provider for embedding: ${fallbackProvider.name}`);
          return await fallbackProvider.generateEmbedding(text);
        }
      }
      throw new Error('No valid AI provider configuration found for embedding');
    }
    
    return await provider.generateEmbedding(text);
  }

  /**
   * Get all registered providers
   */
  getProviders(): Map<string, IAIProvider> {
    return new Map(this.providers);
  }

  /**
   * Get provider status
   */
  getProviderStatus(): Record<string, { available: boolean; model: string }> {
    const status: Record<string, { available: boolean; model: string }> = {};
    
    for (const [id, provider] of this.providers.entries()) {
      status[id] = {
        available: provider.validateConfig(),
        model: provider.config.model
      };
    }
    
    return status;
  }

  /**
   * Switch provider dynamically
   */
  async switchProvider(newProviderId: string): Promise<void> {
    const provider = this.providers.get(newProviderId);
    
    if (!provider) {
      throw new Error(`Provider not found: ${newProviderId}`);
    }
    
    if (!provider.validateConfig()) {
      throw new Error(`Provider ${newProviderId} configuration invalid`);
    }
    
    this.setDefaultProvider(newProviderId);
    console.log(`[AgentGateway] Switched to provider: ${provider.name}`);
  }

  /**
   * Get cost estimate for request
   */
  getCostEstimate(providerId: string, estimatedTokens: number): number {
    const provider = this.getProvider(providerId);
    
    // Cost per 1K tokens (USD)
    const costs: Record<string, number> = {
      'gemini': 0.0001,
      'openai': 0.03,
      'claude': 0.015,
      'local': 0
    };
    
    const costPer1K = costs[provider.config.provider] || 0;
    return (estimatedTokens / 1000) * costPer1K;
  }

  /**
   * Get usage statistics
   */
  getUsageStats() {
    return {
      defaultProvider: this.defaultProvider,
      totalProviders: this.providers.size,
      providerStatus: this.getProviderStatus()
    };
  }
}

export const agentGateway = new AgentGateway();
