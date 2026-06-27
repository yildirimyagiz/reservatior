import { Elysia, t } from "elysia";
import { PrismaClient } from "@prisma/client";
import { MLBridgeService } from "../lib/intelligence/MLBridgeService";

const prisma = new PrismaClient();

export const conciergeRoutes = new Elysia({ prefix: "/api/v1/concierge" })
  .post("/request", async ({ body }) => {
    const { userId, reservationId, message } = body;

    // 1. Gelen isteği veritabanına PENDING olarak kaydet
    const conciergeRequest = await prisma.conciergeRequest.create({
      data: {
        userId,
        reservationId,
        message,
        requestType: "OTHER", // Başlangıçta OTHER, yapay zeka güncelleyecek
        status: "PENDING"
      }
    });

    // 2. AiServiceTask oluştur
    const aiTask = await prisma.aiServiceTask.create({
      data: {
        orgId: "org_concierge",
        taskType: "CONCIERGE_DISPATCH",
        status: "QUEUED",
        inputData: {
          requestId: conciergeRequest.id,
          userId,
          reservationId,
          message
        }
      }
    });

    // 3. Yapay Zekaya Gönder (Asenkron)
    MLBridgeService.triggerTask({
      id: aiTask.id,
      orgId: "org_concierge",
      taskType: "CONCIERGE_DISPATCH",
      inputData: {
        requestId: conciergeRequest.id,
        userId: userId,
        reservationId: reservationId,
        message: message
      }
    }).catch(err => {
      console.error("Concierge AI trigger failed:", err);
    });

    return {
      success: true,
      message: "Concierge talebiniz alındı. Yapay zeka asistanımız işleme aldı.",
      data: conciergeRequest
    };
  }, {
    body: t.Object({
      userId: t.String(),
      reservationId: t.Optional(t.String()),
      message: t.String()
    })
  })
  .get("/requests/:userId", async ({ params }) => {
    const requests = await prisma.conciergeRequest.findMany({
      where: { userId: params.userId },
      orderBy: { createdAt: "desc" },
    });
    
    return {
      success: true,
      data: requests,
    };
  }, {
    params: t.Object({
      userId: t.String(),
    })
  });
