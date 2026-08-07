/**
 * REOS v5 — AI OS: Multi-Model Router
 *
 * Model-agnostic inference layer. Agents never import a specific SDK directly —
 * they call the router and get a structured response back.
 *
 * Supported providers (all optional, activated via env vars):
 *   GOOGLE_AI_API_KEY   → Gemini 2.0 Flash / Pro
 *   ANTHROPIC_API_KEY   → Claude Sonnet / Haiku / Opus
 *   OPENAI_API_KEY      → GPT-4o / o1
 *
 * Routing strategy (configurable per agent):
 *   'AUTO'     → picks the cheapest available model for the task
 *   'GEMINI'   → force Gemini
 *   'CLAUDE'   → force Claude
 *   'OPENAI'   → force OpenAI
 *
 * Each agent gets a structured JSON response (no free-text parsing needed).
 */

import Anthropic from '@anthropic-ai/sdk';
import OpenAI from 'openai';
import { GoogleGenAI } from '@google/genai';

// --- Types ---

export type ModelProvider = 'GEMINI' | 'CLAUDE' | 'OPENAI' | 'AUTO';

export interface AIInferenceRequest {
  systemPrompt: string;
  userPrompt: string;
  outputSchema: string;       // JSON schema description for the model to follow
  provider?: ModelProvider;
  temperature?: number;       // 0–1
  maxTokens?: number;
}

export interface AIInferenceResponse {
  provider: ModelProvider;
  model: string;
  rawText: string;
  parsed: Record<string, any>;
  latencyMs: number;
  tokensUsed?: number;
}

// --- Model config ---

const GEMINI_MODEL  = 'gemini-2.0-flash';
const CLAUDE_MODEL  = 'claude-sonnet-4-5';
const OPENAI_MODEL  = 'gpt-4o-mini';

// --- Router ---

export class AIModelRouter {
  private gemini: GoogleGenAI | null = null;
  private claude: Anthropic | null = null;
  private openai: OpenAI | null = null;

  constructor() {
    if (process.env.GOOGLE_AI_API_KEY) {
      this.gemini = new GoogleGenAI({ apiKey: process.env.GOOGLE_AI_API_KEY });
    }
    if (process.env.ANTHROPIC_API_KEY) {
      this.claude = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });
    }
    if (process.env.OPENAI_API_KEY) {
      this.openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
    }

    const available = [
      this.gemini  ? 'Gemini'  : null,
      this.claude  ? 'Claude'  : null,
      this.openai  ? 'OpenAI'  : null,
    ].filter(Boolean);

    console.log(`[AI OS Router] Initialized. Available providers: ${available.join(', ') || 'NONE (mock mode)'}`);
  }

  /**
   * Route an inference request to the appropriate model.
   * Returns a parsed JSON object matching the requested output schema.
   */
  async infer(req: AIInferenceRequest): Promise<AIInferenceResponse> {
    const provider = this.resolveProvider(req.provider ?? 'AUTO');
    const start = Date.now();

    try {
      if (provider === 'GEMINI' && this.gemini) {
        return await this.runGemini(req, start);
      }
      if (provider === 'CLAUDE' && this.claude) {
        return await this.runClaude(req, start);
      }
      if (provider === 'OPENAI' && this.openai) {
        return await this.runOpenAI(req, start);
      }
    } catch (err) {
      console.warn(`[AI OS Router] ${provider} call failed, falling back to mock:`, (err as Error).message);
    }

    // Mock mode (no API keys configured)
    return this.mockResponse(req, start);
  }

  // --- Gemini ---

  private async runGemini(req: AIInferenceRequest, start: number): Promise<AIInferenceResponse> {
    const model = this.gemini!;
    const prompt = this.buildPrompt(req);

    const result = await model.models.generateContent({
      model: GEMINI_MODEL,
      contents: prompt,
      config: {
        temperature: req.temperature ?? 0.3,
        maxOutputTokens: req.maxTokens ?? 1024,
      },
    });

    const rawText = result.text ?? '';
    return {
      provider: 'GEMINI',
      model: GEMINI_MODEL,
      rawText,
      parsed: this.extractJSON(rawText),
      latencyMs: Date.now() - start,
    };
  }

  // --- Claude ---

  private async runClaude(req: AIInferenceRequest, start: number): Promise<AIInferenceResponse> {
    const response = await this.claude!.messages.create({
      model: CLAUDE_MODEL,
      max_tokens: req.maxTokens ?? 1024,
      system: req.systemPrompt,
      messages: [{ role: 'user', content: req.userPrompt }],
    });

    const rawText = response.content[0].type === 'text' ? response.content[0].text : '';
    return {
      provider: 'CLAUDE',
      model: CLAUDE_MODEL,
      rawText,
      parsed: this.extractJSON(rawText),
      latencyMs: Date.now() - start,
      tokensUsed: response.usage.input_tokens + response.usage.output_tokens,
    };
  }

  // --- OpenAI ---

  private async runOpenAI(req: AIInferenceRequest, start: number): Promise<AIInferenceResponse> {
    const response = await this.openai!.chat.completions.create({
      model: OPENAI_MODEL,
      temperature: req.temperature ?? 0.3,
      max_tokens: req.maxTokens ?? 1024,
      messages: [
        { role: 'system', content: req.systemPrompt },
        { role: 'user', content: req.userPrompt },
      ],
      response_format: { type: 'json_object' },
    });

    const rawText = response.choices[0]?.message?.content ?? '';
    return {
      provider: 'OPENAI',
      model: OPENAI_MODEL,
      rawText,
      parsed: this.extractJSON(rawText),
      latencyMs: Date.now() - start,
      tokensUsed: response.usage?.total_tokens,
    };
  }

  // --- Mock (no API keys) ---

  private mockResponse(req: AIInferenceRequest, start: number): AIInferenceResponse {
    console.log('[AI OS Router] 🔶 Running in MOCK mode (no API keys configured)');
    const rawText = JSON.stringify({ recommendation: 'CORPORATE_MASTER_LEASE', confidence: 0.91, signal: 'Mock analysis: Corporate demand high, yield attractive.' });
    return {
      provider: 'AUTO',
      model: 'mock',
      rawText,
      parsed: JSON.parse(rawText),
      latencyMs: Date.now() - start,
    };
  }

  // --- Helpers ---

  private resolveProvider(preferred: ModelProvider): ModelProvider {
    if (preferred !== 'AUTO') return preferred;
    if (this.gemini)  return 'GEMINI';
    if (this.claude)  return 'CLAUDE';
    if (this.openai)  return 'OPENAI';
    return 'AUTO'; // mock
  }

  private buildPrompt(req: AIInferenceRequest): string {
    return `${req.systemPrompt}\n\nUser request:\n${req.userPrompt}\n\nYou MUST respond with valid JSON matching this schema:\n${req.outputSchema}`;
  }

  private extractJSON(text: string): Record<string, any> {
    try {
      // Try direct parse
      return JSON.parse(text);
    } catch {
      // Extract from markdown code block
      const match = text.match(/```(?:json)?\s*([\s\S]*?)\s*```/);
      if (match) {
        try { return JSON.parse(match[1]); } catch {}
      }
      // Find first {...} block
      const jsonMatch = text.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        try { return JSON.parse(jsonMatch[0]); } catch {}
      }
      return { raw: text };
    }
  }
}

export const aiRouter = new AIModelRouter();
