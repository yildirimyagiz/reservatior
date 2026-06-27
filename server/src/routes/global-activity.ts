import { Elysia } from "elysia";
import { globalActivityService } from "../services/global-activity";

export const globalActivityRoutes = new Elysia({ prefix: "/user" })
  /**
   * GET /api/v1/user/global-activity
   * Fetches the user's unified activity feed across all region databases.
   */
  .get("/global-activity", async ({ headers }) => {
    // In a real scenario, the email would come from the decoded JWT token.
    // For this implementation, we extract from authorization or query.
    // Assuming authMiddleware sets user context, but as a standalone route we extract it.
    
    // Quick mock implementation: fetch token, decode, get email.
    // Replace with standard authMiddleware user extraction.
    const token = headers.authorization?.split(" ")[1];
    if (!token) throw new Error("Unauthorized");

    try {
      const payloadBase64 = token.split(".")[1];
      const decoded = JSON.parse(Buffer.from(payloadBase64, "base64").toString());
      const email = decoded.email;

      if (!email) throw new Error("Invalid token payload");

      const activity = await globalActivityService.getUserGlobalActivity(email);

      return {
        count: activity.length,
        data: activity,
      };
    } catch (e) {
      throw new Error("Failed to process global activity");
    }
  });
