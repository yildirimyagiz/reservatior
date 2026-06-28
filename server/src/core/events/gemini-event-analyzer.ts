import { GoogleGenAI } from "@google/genai";

const ai = new GoogleGenAI({ apiKey: process.env.GEMINI_API_KEY || "" }); // uses GEMINI_API_KEY from process.env

export class GeminiEventAnalyzer {
  /**
   * Analyze failed tasks to determine root cause and suggest corrective actions
   */
  static async analyzeFailure(taskType: string, errorMessage: string, inputData: any): Promise<{
    rootCause: string;
    suggestedAction: string;
    severity: "LOW" | "MEDIUM" | "HIGH" | "CRITICAL";
  }> {
    try {
      const response = await ai.models.generateContent({
        model: "gemini-2.5-flash",
        contents: `
          You are the AI Operations Controller for a real estate operating system.
          An event of type AI_TASK_FAILED occurred.
          
          Task Type: ${taskType}
          Error Message: ${errorMessage}
          Input Parameters: ${JSON.stringify(inputData)}
          
          Analyze this failure and return a JSON object with:
          1. "rootCause": Brief explanation of why this happened.
          2. "suggestedAction": How the system or agent can resolve this.
          3. "severity": One of "LOW", "MEDIUM", "HIGH", "CRITICAL".
          
          Return ONLY valid JSON. No markdown wrappers.
        `
      });

      const text = response.text?.trim() || "{}";
      const cleanJson = text.replace(/```json/g, "").replace(/```/g, "").trim();
      return JSON.parse(cleanJson);
    } catch (error) {
      console.error("Gemini Failure Analysis failed:", error);
      return {
        rootCause: "Unknown system failure during processing.",
        suggestedAction: "Retry the task or check system logs.",
        severity: "HIGH"
      };
    }
  }

  /**
   * Intelligently classify and enrich incoming raw lead or listing events
   */
  static async triageEvent(eventPayload: any): Promise<{
    intent: string;
    priorityScore: number;
    recommendedTopic: string;
  }> {
    try {
      const response = await ai.models.generateContent({
        model: "gemini-2.5-flash",
        contents: `
          Analyze this incoming event payload for a real estate OS:
          Payload: ${JSON.stringify(eventPayload)}
          
          Determine:
          1. "intent": What does the user/system intend to do (e.g. lease_inquiry, scheduling, support, listing_optimization).
          2. "priorityScore": 0 (low) to 100 (high urgency, like payments or water leaks).
          3. "recommendedTopic": The Kafka topic to route to (e.g. "leads-topic", "billing-topic", "maintenance-topic").
          
          Return ONLY valid JSON.
        `
      });

      const text = response.text?.trim() || "{}";
      const cleanJson = text.replace(/```json/g, "").replace(/```/g, "").trim();
      return JSON.parse(cleanJson);
    } catch {
      return {
        intent: "unknown",
        priorityScore: 50,
        recommendedTopic: "general-events"
      };
    }
  }
}
