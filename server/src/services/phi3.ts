import axios from "axios";

export class Phi3Service {
  private static OLLAMA_URL = process.env.OLLAMA_URL || "http://localhost:11434/api/generate";
  private static MODEL = "phi3";

  static async generateResponse(prompt: string): Promise<string> {
    try {
      console.log(`[Phi-3] Generating response for: ${prompt.substring(0, 50)}...`);
      
      const response = await axios.post(this.OLLAMA_URL, {
        model: this.MODEL,
        prompt: `System: You are an AI Real Estate Concierge for Reservatior. Be professional, helpful, and concise.
                  User: ${prompt}
                  Assistant:`,
        stream: false,
        options: {
          temperature: 0.7,
          num_predict: 150
        }
      }, { timeout: 15000 });

      return response.data.response.trim();
    } catch (e) {
      console.error("[Phi-3] Error calling local LLM:", (e as any).message);
      return "I'm having trouble thinking clearly right now. Let me connect you with a human agent.";
    }
  }

  static async translate(text: string, targetLang: string = "tr"): Promise<string> {
    try {
      console.log(`[Phi-3] Translating to ${targetLang}: ${text.substring(0, 50)}...`);
      const prompt = `Translate the following real estate text to ${targetLang}. 
                     Keep the terminology professional and the tone appropriate for luxury property listings:
                     
                     Text: "${text}"
                     Translation:`;
      
      const res = await this.generateResponse(prompt);
      return res.replace(/^"|"$/g, '').trim(); // Clean up quotes if any
    } catch (e) {
      console.error("[Phi-3] Translation Error:", (e as any).message);
      return text;
    }
  }

  static async checkAvailability(): Promise<boolean> {
    try {
      const res = await axios.get(this.OLLAMA_URL.replace('/api/generate', '/api/tags'));
      return res.status === 200;
    } catch {
      return false;
    }
  }
}
