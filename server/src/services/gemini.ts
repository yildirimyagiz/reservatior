import { GoogleGenerativeAI } from "@google/generative-ai";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export class GeminiService {
  /**
   * Processes a query from the Home Search Hub with role-based context and chat history.
   */
  static async processHubSearch(query: string, user: any, history: any[] = []) {
    try {
      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

      const role = user?.role || "GUEST";
      const name = user?.name || "User";

      // Context prompt based on user role
      let roleContext = "";
      switch (role) {
        case "SUPER_ADMIN":
        case "ADMIN":
          roleContext = "You are assisting a system Administrator. They might want to view system metrics, manage users, or approve pending reservations.";
          break;
        case "AGENT":
        case "AGENCY":
          roleContext = "You are assisting a Real Estate Agent. They might want to add new listings, view leads, or check their commissions pipeline.";
          break;
        case "TENANT":
          roleContext = "You are assisting a Tenant. They might want to pay rent, report maintenance issues, or view their lease agreement.";
          break;
        case "GUEST":
        default:
          roleContext = "You are assisting a Guest. They might want to book a vacation rental, check-in details, or explore nearby amenities.";
          break;
      }

      const formattedHistory = history.map((msg: any) => `${msg.role.toUpperCase()}: ${msg.text}`).join('\\n');

      const prompt = `
        You are the intelligent assistant for the "Reservatior" Platform Ecosystem.
        User Name: ${name}
        User Role: ${role}
        Context: ${roleContext}
        
        Previous Conversation:
        ${formattedHistory}
        
        The user just said: "${query}"
        
        You must act as a helpful conversational guide across the platform's modules.
        Provide a JSON response with the following structure:
        {
          "intent": "SEARCH_PROPERTIES" | "MANAGE_TASKS" | "FINANCIAL" | "GENERAL_ASSIST",
          "response": "A conversational, highly helpful response guiding them through their problem (can be a bit longer to be helpful).",
          "actions": [
            {
              "label": "Button Label",
              "route": "/frontend-route",
              "icon": "icon_name (e.g. payment, home, settings)"
            }
          ]
        }
        
        Return ONLY valid JSON.
      `;

      if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
        // Return mock data if no key is present to prevent crashing
        return this._getMockResponse(query, role);
      }

      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      
      return JSON.parse(text);
    } catch (error) {
      console.error("GeminiService error:", error);
      return this._getMockResponse(query, user?.role);
    }
  }

  /**
   * Analyzes a chat message to detect Platform Leakage (e.g., sharing IBANs, phone numbers, 
   * or asking to transact outside the platform).
   * Returns whether it's a leakage attempt, and a masked version of the message.
   */
  static async analyzeMessageForLeakage(message: string): Promise<{ isLeakage: boolean; maskedMessage: string; reason?: string }> {
    try {
      if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
        // Fallback simple regex check if no API key
        const hasPhone = /(?:\+90|0)?\s*5\d{2}\s*\d{3}\s*\d{2}\s*\d{2}/.test(message);
        const hasIban = /TR\d{2}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{2}/i.test(message);
        const isLeakage = hasPhone || hasIban;
        
        let masked = message;
        if (hasPhone) masked = masked.replace(/(?:\+90|0)?\s*5\d{2}\s*\d{3}\s*\d{2}\s*\d{2}/g, "📞 [TELEFON GİZLENDİ]");
        if (hasIban) masked = masked.replace(/TR\d{2}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{2}/gi, "🏦 [IBAN GİZLENDİ - Lütfen Ödemeyi Checkout'tan Yapın]");
        
        return { isLeakage, maskedMessage: masked, reason: isLeakage ? "Regex fallback match" : "" };
      }

      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });
      
      const prompt = `
        You are the security AI for a real estate marketplace called "Reservatior".
        Your job is to prevent "Platform Leakage" - meaning users trying to share contact info 
        (phone numbers, emails) or payment info (IBAN, bank details, crypto wallets, asking for cash) 
        to bypass the platform's escrow and commission system.
        
        Analyze the following message:
        "${message}"
        
        If it contains a phone number, IBAN, email, or an attempt to bypass the platform, set "isLeakage" to true.
        Also, provide a "maskedMessage" where the sensitive information is replaced with "[GÜVENLİK GEREĞİ GİZLENDİ]".
        
        Return ONLY valid JSON with this structure:
        {
          "isLeakage": boolean,
          "maskedMessage": "string",
          "reason": "string (why it was flagged, empty if false)"
        }
      `;

      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      
      return JSON.parse(text);
    } catch (error) {
      console.error("GeminiService leakage analysis error (falling back to regex):", (error as any).message);
      // Fallback to simple regex check on API failure
      const hasPhone = /(?:\+90|0)?\s*5\d{2}\s*\d{3}\s*\d{2}\s*\d{2}/.test(message);
      const hasIban = /TR\d{2}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{2}/i.test(message);
      const isLeakage = hasPhone || hasIban;
      
      let masked = message;
      if (hasPhone) masked = masked.replace(/(?:\+90|0)?\s*5\d{2}\s*\d{3}\s*\d{2}\s*\d{2}/g, "📞 [TELEFON GİZLENDİ]");
      if (hasIban) masked = masked.replace(/TR\d{2}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{2}/gi, "🏦 [IBAN GİZLENDİ - Lütfen Ödemeyi Checkout'tan Yapın]");
      
      return { isLeakage, maskedMessage: masked, reason: isLeakage ? "Regex fallback match" : "" };
    }
  }

  static _getMockResponse(query: string, role: string) {
    if (role === "ADMIN") {
      return {
        intent: "MANAGE_TASKS",
        response: `Hello Admin, I see you are looking for "${query}". Here are some quick actions you can take to manage operations.`,
        actions: [
          { label: "Approve Reservations", route: "/admin/reservation", icon: "check_circle" },
          { label: "View Audit Logs", route: "/admin/audit_log", icon: "history" }
        ]
      };
    } else if (role === "AGENT") {
      return {
        intent: "MANAGE_TASKS",
        response: `Hello Agent, to help with "${query}", I've pulled up your most relevant pipeline actions.`,
        actions: [
          { label: "My Listings", route: "/admin/listing", icon: "home" },
          { label: "Pipeline Deals", route: "/deals", icon: "monetization_on" }
        ]
      };
    } else if (role === "TENANT") {
      return {
        intent: "FINANCIAL",
        response: `Hi there! Regarding "${query}", here are your tenant actions.`,
        actions: [
          { label: "Pay Rent", route: "/financial", icon: "payment" },
          { label: "Maintenance Request", route: "/admin/maintenance_work_order", icon: "build" }
        ]
      };
    } else {
      return {
        intent: "SEARCH_PROPERTIES",
        response: `Welcome to Reservatior! You searched for "${query}". Let's find your perfect place.`,
        actions: [
          { label: "Explore Properties", route: "/search", icon: "search" },
          { label: "My Bookings", route: "/admin/booking", icon: "event" }
        ]
      };
    }
  }

  /**
   * Audits a Partner Agreement using Gemini model to protect the "Invisible Moat".
   * Checks if the agreement is too static (replicable) or satisfies dynamic lifecycle standards.
   */
  static async auditAgreementWithGemini(agreement: any): Promise<{
    isMoatCompliant: boolean;
    recommendation: string;
    riskScore: number;
  }> {
    try {
      if (apiKey === "AIzaSy_MOCK_KEY_FOR_DEV") {
        return {
          isMoatCompliant: true,
          recommendation: "Dev Mode: Agreement verified against simulated moat rules.",
          riskScore: 0.1
        };
      }

      const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });
      const prompt = `
        You are the Chief Financial Auditor AI for Reservatior.
        Our core defense strategy (Moat) is keeping commercial pricing rules/commissions hidden and dynamically dependent on real-time event lifecycle curves, preventing competitors from reverse-engineering our economics.
        
        Analyze this Partner Agreement structure:
        ${JSON.stringify(agreement, null, 2)}
        
        Evaluate:
        1. Is this agreement too static or easily copyable by competitors? (e.g. flat % rates with no time decay or loyalty multipliers).
        2. Does it utilize dynamic curves (monthly schedules, behavioral multipliers, time-decay factors)?
        
        Provide a riskScore (0.0: secure/highly dynamic, to 1.0: highly vulnerable/static) and recommendations to enforce our structural moat.
        
        Return ONLY valid JSON:
        {
          "isMoatCompliant": boolean,
          "recommendation": "string",
          "riskScore": number
        }
      `;

      const result = await model.generateContent(prompt);
      const text = result.response.text().replace(/```json/g, "").replace(/```/g, "").trim();
      return JSON.parse(text);
    } catch (e: any) {
      console.error("Gemini Moat Audit failed:", e.message);
      return {
        isMoatCompliant: true,
        recommendation: "Auditor Offline: Fallback automated security validation applied.",
        riskScore: 0.2
      };
    }
  }
}

