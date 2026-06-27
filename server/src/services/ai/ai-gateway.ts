import { GoogleGenerativeAI } from '@google/generative-ai';

// Initialize Gemini (Will be the main intelligence core)
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');

export interface ParsedIntent {
  intent: 'SEARCH_PROPERTIES' | 'CREATE_LISTING' | 'SCHEDULE_MEETING' | 'INITIATE_ESCROW' | 'GENERAL_CONVERSATION';
  parameters: any;
  replyText?: string;
  detectedLanguage?: string;
  catalogType?: 'project' | 'second_hand';
  localMediaPaths?: string[];
}

export class AIGateway {
  
  /**
   * Parses natural language into actionable intents using Gemini
   */
  static async parseMessage(text: string, userLanguage: string = 'tr'): Promise<ParsedIntent> {
    try {
      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

      const prompt = `
        You are the TrustLink / Reservatior AI Concierge (an Omnichannel Real Estate Assistant).
        Analyze the following user message. Determine the primary intent, extract any relevant parameters, and reply in the detected user language.
        
        Possible Intents:
        1. SEARCH_PROPERTIES: User wants to buy/rent/search for properties. Parameters: city, propertyType, maxPrice, minBeds, currency.
        2. CREATE_LISTING: User is sharing details about a property they want to sell/rent out. Parameters: city, propertyType, price, currency, beds, description.
        3. SCHEDULE_MEETING: User wants to schedule a viewing or meeting. Parameters: propertyId, requestedDate.
        4. INITIATE_ESCROW: User wants to pay or use TrustLink Escrow. Parameters: propertyId.
        5. CONTACT_SELLER: User wants to send a message or inquiry to the property owner. Parameters: propertyId, messageContent.
        6. GENERAL_CONVERSATION: Anything else. Parameters: none.

        User Message: "${text}"
        Default Language Context: ${userLanguage}
        
        Respond ONLY with a valid JSON object matching this schema:
        {
          "intent": "INTENT_NAME",
          "parameters": { ... extracted parameters ... },
          "replyText": "A friendly confirmation or conversational response in the user's language.",
          "detectedLanguage": "en|tr|ar|etc",
          "catalogType": "project" // Or "second_hand". If it looks like a brand new development, use project, otherwise second_hand.
        }
      `;

      const result = await model.generateContent(prompt);
      const responseText = result.response.text();
      
      // Clean markdown block if Gemini returns it
      const jsonStr = responseText.replace(/```json/g, '').replace(/```/g, '').trim();
      
      return JSON.parse(jsonStr) as ParsedIntent;
      
    } catch (error) {
      console.error('Error parsing message with Gemini:', error);
      return { intent: 'GENERAL_CONVERSATION', parameters: {}, replyText: "Bir hata oluştu. Size nasıl yardımcı olabilirim?" };
    }
  }

  public static async analyzeChatContext(chatHistory: string): Promise<{ paymentAgreed: boolean, securityFlag: boolean, securityReason?: string, piiDetected: boolean } | null> {
    try {
      const model = genAI.getGenerativeModel({ model: 'gemini-2.5-flash' });
      
      const prompt = `
        Sen bir gayrimenkul işlem güvenlik ve analiz yapay zekasısın.
        Aşağıdaki mesajlaşma geçmişini oku ve şu 3 durumu analiz et:
        1. paymentAgreed: Taraflar fiyat veya kapora konusunda anlaştı mı ve ödemeye geçmek üzereler mi? (Evet ise true)
        2. securityFlag: Tehdit, dolandırıcılık şüphesi, platform dışına ödeme alma veya IBAN isteme durumu var mı? (Evet ise true)
        3. piiDetected: Kredi kartı bilgisi, T.C. Kimlik numarası vb. hassas veri paylaşıldı mı? (Evet ise true)

        Konuşma:
        ${chatHistory}

        Yanıtı SADECE JSON formatında ver:
        {
            "paymentAgreed": boolean,
            "securityFlag": boolean,
            "securityReason": "string (Eğer securityFlag true ise nedeni)",
            "piiDetected": boolean
        }
      `;

      const result = await model.generateContent(prompt);
      const jsonStr = result.response.text().replace(/```json/g, '').replace(/```/g, '').trim();
      return JSON.parse(jsonStr);

    } catch (error) {
      console.error('Error analyzing chat with Gemini:', error);
      return null;
    }
  }
}
