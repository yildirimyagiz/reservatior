import "dotenv/config";
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
    transactionType?: "RENT" | "SALE" | "BOOKING";
    statusUpdateType?: "SOLD" | "RENTED" | "CANCELED" | "PRICE_CHANGE";
    newPrice?: number;
    projects?: string[]; // Array of project names mentioned, e.g. ["Vadi Teras", "Vadi Park"]
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
          "bedrooms": 4 (Numeric value of bedroom count if mentioned, e.g., 4+1 -> 4, 3+1 -> 3, 2+1 -> 2),
          "transactionType": "RENT" or "SALE",
          "statusUpdateType": "SOLD" or "RENTED" or "CANCELED" or "PRICE_CHANGE" (Only for STATUS_UPDATE intent),
          "newPrice": 24000 (Numeric value if price dropped/increased),
          "projects": ["Project Name 1", "Project Name 2"] (List of projects like "Vadi Teras", "Vadi Park", "Anthill" if mentioned)
        },
        "summary": "A short 1-sentence summary of the message"
      }
    `;

    try {
      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      return JSON.parse(text) as SocialParsedResult;
    } catch (error) {
      console.warn("⚠️ Gemini AI failed or key invalid. Executing Regex/Rule-Based Social Parser Fallback...");
      
      const textLower = messageText.toLowerCase();
      let intent: ParsedIntent = "NOISE";
      const extractedData: any = {};
      
      // Determine Intent
      if (textLower.includes("arayış") || textLower.includes("arıyorum") || textLower.includes("aranıyor") || textLower.includes("lazım") || textLower.includes("gerekli") || textLower.includes("looking for") || textLower.includes("want to rent") || textLower.includes("want to buy")) {
        intent = "DEMAND";
      } else if (textLower.includes("satılık") || textLower.includes("kiralık") || textLower.includes("kiralik") || textLower.includes("resale") || textLower.includes("rent") || textLower.includes("sale") || textLower.includes("portföy")) {
        intent = "SUPPLY";
      } else if (textLower.includes("satıldı") || textLower.includes("kiralandı") || textLower.includes("tutuldu") || textLower.includes("iptal") || textLower.includes("fiyat güncellendi")) {
        intent = "STATUS_UPDATE";
      }

      // Extract Bedrooms (e.g. 4+1 -> 4, 3+1 -> 3)
      const bedroomMatch = messageText.match(/(\d+)\s*\+\s*(\d+)/);
      if (bedroomMatch) {
        extractedData.bedrooms = parseInt(bedroomMatch[1], 10);
      } else {
        const simpleRoom = messageText.match(/(\d+)\s*oda/);
        if (simpleRoom) extractedData.bedrooms = parseInt(simpleRoom[1], 10);
      }

      // Extract Transaction Type
      if (textLower.includes("kiralık") || textLower.includes("kiralik") || textLower.includes("kira") || textLower.includes("rent") || textLower.includes("lease")) {
        extractedData.transactionType = "RENT";
      } else if (textLower.includes("satılık") || textLower.includes("satilik") || textLower.includes("sale") || textLower.includes("buy")) {
        extractedData.transactionType = "SALE";
      }

      // Extract Projects
      const knownProjects = ["Vadi Teras", "Vadi Park", "Anthill", "Büyükyalı", "Validebağ", "The Weave"];
      const matchedProjects: string[] = [];
      for (const proj of knownProjects) {
        if (new RegExp(proj, "i").test(messageText)) {
          matchedProjects.push(proj);
        }
      }
      if (matchedProjects.length > 0) {
        extractedData.projects = matchedProjects;
      }

      // Location
      if (textLower.includes("istanbul") || textLower.includes("istanbul")) {
        extractedData.location = "İstanbul";
      } else if (textLower.includes("dubai") || textLower.includes("dubai")) {
        extractedData.location = "Dubai";
      }

      const summary = intent === "DEMAND" 
        ? `${extractedData.bedrooms || ''}+1 ${extractedData.transactionType === 'RENT' ? 'Kiralık' : 'Satılık'} Arayışı (${matchedProjects.join(', ') || 'Belirtilmemiş'})`
        : `WhatsApp İlan Analizi`;

      return {
        intent,
        confidence: 0.85,
        extractedData,
        summary
      };
    }
  }
}
