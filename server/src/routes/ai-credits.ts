import { Elysia, t } from "elysia";
import * as AICreditService from "../services/ai/ai-credit-service";
import { authMiddleware } from "../middleware/auth";

export const aiCreditRoutes = new Elysia({ prefix: "/ai-credits" })

  // Bakiye sorgulama (Auth gerekli)
  .use(authMiddleware)
  .get("/balance", async ({ userId, set }) => {
    try {
      const balance = await AICreditService.getBalance(userId);
      return balance;
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  })

  // Kredi yükleme (Pay-as-you-go)
  .post("/topup", async ({ userId, body, set }) => {
    try {
      const { amount } = body as { amount: number };
      if (!amount || amount < 1) {
        set.status = 400;
        return { error: "Minimum 1 kredi yüklemelisiniz." };
      }
      const result = await AICreditService.topUp(userId, amount);
      return { success: true, ...result };
    } catch (error: any) {
      set.status = 500;
      return { error: error.message };
    }
  }, {
    body: t.Object({
      amount: t.Number()
    })
  });
