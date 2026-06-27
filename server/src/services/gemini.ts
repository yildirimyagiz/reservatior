import { GoogleGenerativeAI } from "@google/generative-ai";

const apiKey = process.env.GEMINI_API_KEY || "AIzaSy_MOCK_KEY_FOR_DEV";
const genAI = new GoogleGenerativeAI(apiKey);

export class GeminiService {
  /**
   * Processes a query from the Home Search Hub with role-based context and chat history.
   */
  static async processHubSearch(query: string, user: any, history: any[] = []) {
    try {
      const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

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
}
