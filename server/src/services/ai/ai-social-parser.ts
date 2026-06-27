import { GoogleGenerativeAI } from "@google/generative-ai";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export type ParsedIntent = "DEMAND" | "SUPPLY" | "STATUS_UPDATE" | "NOISE";

export interface SocialParsedResult {
  intent: ParsedIntent;
  confidence: number;
  extractedData: {
    location?: string;
    budget?: number;
    currency?: string;
    propertyType?: string; // e.g. "Apartment", "Villa"
    bedrooms?: number;
    transactionType?: "RENT" | "SALE";
    statusUpdateType?: "SOLD" | "RENTED" | "CANCELED" | "PRICE_CHANGE";
    newPrice?: number;
  };
  summary: string;
}

export class AISocialParser {
  /**
   * Parses a raw social media message (WhatsApp, Telegram) to extract intent and entity data.
   */
  static async parseMessage(messageText: string): Promise<SocialParsedResult> {
    const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

    const prompt = `
      You are an expert Real Estate AI assistant specialized in parsing social media group messages.
      Your job is to read the incoming message, determine the user's intent, and extract relevant entities.

      INTENT CATEGORIES:
      1. "DEMAND": Someone is looking for a property to rent or buy.
      2. "SUPPLY": Someone is offering a property for rent or sale.
      3. "STATUS_UPDATE": Someone is updating the status of a previous supply (e.g. "Satıldı", "Kiralandı", "Fiyat 10.000 TL oldu").
      4. "NOISE": General chatter, spam, or irrelevant messages.

      Message to parse:
      "${messageText}"

      Respond ONLY with a valid JSON object matching this structure:
      {
        "intent": "DEMAND" | "SUPPLY" | "STATUS_UPDATE" | "NOISE",
        "confidence": 0.0 to 1.0,
        "extractedData": {
          "location": "City or neighborhood name if mentioned",
          "budget": 25000 (Numeric value if mentioned),
          "currency": "TRY", "USD", "EUR" etc.
          "propertyType": "Apartment", "Villa", "Commercial" etc.
          "bedrooms": 3 (Numeric value if mentioned, like 3+1 = 3),
          "transactionType": "RENT" or "SALE",
          "statusUpdateType": "SOLD" or "RENTED" or "CANCELED" or "PRICE_CHANGE" (Only for STATUS_UPDATE intent),
          "newPrice": 24000 (Numeric value if price dropped/increased)
        },
        "summary": "A short 1-sentence summary of the message"
      }
    `;

    try {
      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      return JSON.parse(text) as SocialParsedResult;
    } catch (error) {
      console.error("Error parsing social message with Gemini:", error);
      return {
        intent: "NOISE",
        confidence: 0,
        extractedData: {},
        summary: "Failed to parse message"
      };
    }
  }
}
