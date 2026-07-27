import { GoogleGenerativeAI } from '@google/generative-ai';

const API_KEY = process.env.NEXT_PUBLIC_GEMINI_API_KEY || '';

let genAI: GoogleGenerativeAI | null = null;

if (typeof window !== 'undefined' && API_KEY) {
  genAI = new GoogleGenerativeAI(API_KEY);
}

export interface SearchSuggestion {
  text: string;
  type: 'location' | 'property_type' | 'amenity' | 'budget';
  confidence: number;
}

export interface AIResponse {
  text: string;
  suggestions?: SearchSuggestion[];
  intent?: string;
}

export class GeminiClient {
  private static model = genAI?.getGenerativeModel({ model: 'gemini-2.5-flash' });

  /**
   * Get AI-powered search suggestions based on partial input
   */
  static async getSearchSuggestions(input: string): Promise<SearchSuggestion[]> {
    if (!input.trim() || !this.model) return [];

    try {
      const prompt = `
        You are a real estate search assistant for Reservatior.
        The user is typing: "${input}"
        
        Generate 4-6 relevant search suggestions based on their partial input.
        Suggestions should include:
        - Location completions
        - Property types
        - Amenities/features
        - Budget ranges
        
        Return ONLY valid JSON with this structure:
        {
          "suggestions": [
            { "text": "suggestion text", "type": "location|property_type|amenity|budget", "confidence": 0.9 }
          ]
        }
      `;

      const result = await this.model.generateContent(prompt);
      const responseText = result.response.text().replace(/```json/g, '').replace(/```/g, '').trim();
      const parsed = JSON.parse(responseText);
      
      return parsed.suggestions || [];
    } catch (error) {
      console.error('Gemini search suggestions error:', error);
      return [];
    }
  }

  /**
   * Process natural language search query
   */
  static async processSearchQuery(query: string): Promise<AIResponse> {
    if (!this.model) {
      return { text: 'AI service not available' };
    }

    try {
      const prompt = `
        You are a real estate search assistant for Reservatior.
        User query: "${query}"
        
        Analyze the query and provide:
        1. A helpful response acknowledging their needs
        2. Search intent (location, property type, budget, amenities)
        3. Suggested search refinements
        
        Return ONLY valid JSON:
        {
          "text": "helpful response",
          "intent": "search intent",
          "suggestions": [
            { "text": "refinement suggestion", "type": "location|property_type|amenity|budget", "confidence": 0.8 }
          ]
        }
      `;

      const result = await this.model.generateContent(prompt);
      const responseText = result.response.text().replace(/```json/g, '').replace(/```/g, '').trim();
      
      return JSON.parse(responseText);
    } catch (error) {
      console.error('Gemini search query error:', error);
      return { text: 'Sorry, I encountered an error processing your request.' };
    }
  }

  /**
   * Generate property description or insights
   */
  static async generatePropertyInsights(propertyData: any): Promise<string> {
    if (!this.model) return '';

    try {
      const prompt = `
        You are a real estate expert for Reservatior.
        Property data: ${JSON.stringify(propertyData)}
        
        Generate a compelling 2-3 sentence description highlighting key features,
        investment potential, and lifestyle benefits.
        
        Return ONLY the description text, no JSON.
      `;

      const result = await this.model.generateContent(prompt);
      return result.response.text().trim();
    } catch (error) {
      console.error('Gemini property insights error:', error);
      return '';
    }
  }
}

export default GeminiClient;
