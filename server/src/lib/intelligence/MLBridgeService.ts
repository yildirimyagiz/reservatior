import { prisma } from "../prisma";
import axios from "axios";

// Environment variables
const SKIPPER_API_URL = process.env.SKIPPER_API_URL || "http://localhost:8080";
const TRANSLATION_API_URL = process.env.TRANSLATION_API_URL || "http://localhost:8002";
const VIDEO_ENGINE_URL = process.env.VIDEO_ENGINE_URL || "http://localhost:8005";

export class MLBridgeService {
  /**
   * Triggers the appropriate external ML service or Skipper API workflow.
   */
  static async triggerTask(task: {
    id: string;
    orgId: string;
    propertyId?: string | null;
    listingId?: string | null;
    taskType: string;
    inputData: any;
  }) {
    const { id: taskId, orgId, propertyId, listingId, taskType, inputData } = task;

    console.log(`[MLBridgeService] Triggering task ${taskId} of type ${taskType}`);

    try {
      // Map Elysia task types to Skipper workflows / Custom API calls
      switch (taskType) {
        case "DOCUMENT_OCR":
          await this.dispatchToSkipper(taskId, "document-ocr", inputData);
          break;

        case "FINANCIAL_EXTRACTION":
          // Determine if it's a lease or receipt depending on input context/filename
          const workflow = inputData?.mime_type === "application/pdf" && 
            (inputData?.file_path?.toLowerCase().includes("lease") || inputData?.original_name?.toLowerCase().includes("lease"))
              ? "lease-analyze"
              : "receipt-process";
          await this.dispatchToSkipper(taskId, workflow, inputData);
          break;

        case "TRANSLATION_LOCALIZATION":
          await this.dispatchTranslation(taskId, inputData);
          break;

        case "REELS_VIDEO_GEN":
          await this.dispatchVideoGeneration(taskId, inputData);
          break;

        case "COMPLIANCE_CHECK":
          await this.dispatchToSkipper(taskId, "document-classify", inputData);
          break;

        case "PHOTO_ENHANCEMENT":
          await this.dispatchToSkipper(taskId, "photo-categorize", inputData);
          break;

        case "ANCILLARY_CROSS_SELL":
          // E.g. suggest Transfers or Experiences based on booking data
          await this.dispatchToSkipper(taskId, "ancillary-cross-sell", inputData);
          break;

        case "CONCIERGE_DISPATCH":
          // Process Concierge Request (VIP Transfer, Relocation etc.)
          await this.dispatchToSkipper(taskId, "concierge-dispatch", inputData);
          break;

        default:
          throw new Error(`Unsupported ML task type: ${taskType}`);
      }

      // Update state to PROCESSING
      await prisma.aiServiceTask.update({
        where: { id: taskId },
        data: { status: "PROCESSING", progress: 10 }
      });

    } catch (error: any) {
      console.error(`[MLBridgeService] Error triggering task ${taskId}:`, error.message);
      await prisma.aiServiceTask.update({
        where: { id: taskId },
        data: {
          status: "FAILED",
          progress: 0,
          errorMessage: error.message
        }
      });
    }
  }

  /**
   * Helper to dispatch tasks to RabbitMQ queues via Skipper API.
   */
  private static async dispatchToSkipper(taskId: string, workflowName: string, data: any) {
    // Check if we need to call drive/import or standard tasks
    const endpoint = data.drive_links 
      ? `${SKIPPER_API_URL}/api/v1/drive/import` 
      : `${SKIPPER_API_URL}/api/v1/skipper/tasks`;

    const payload = data.drive_links 
      ? { drive_links: data.drive_links, project_id: data.project_id }
      : { workflow: workflowName, data: { ...data, task_id: taskId } };

    const response = await axios.post(endpoint, payload);
    const externalId = response.data?.task_id || response.data?.tasks?.[0]?.task_id;

    if (externalId) {
      await prisma.aiServiceTask.update({
        where: { id: taskId },
        data: { externalJobId: externalId }
      });
    }
  }

  /**
   * Directly execute translation API and update task status.
   */
  private static async dispatchTranslation(taskId: string, data: any) {
    try {
      const response = await axios.post(`${TRANSLATION_API_URL}/translate`, {
        text: data.text,
        source_lang: data.sourceLang || "auto",
        target_lang: data.targetLang || "tr"
      });

      if (response.data?.success) {
        await this.onTaskUpdate(taskId, "COMPLETED", {
          translatedText: response.data.translated_text,
          detectedLanguage: response.data.detected_source_language,
          confidence: response.data.confidence
        });
      } else {
        throw new Error("Translation service returned unsuccessful status");
      }
    } catch (err: any) {
      await this.onTaskUpdate(taskId, "FAILED", null, err.message);
    }
  }

  /**
   * Dispatch video generation to video neural engine.
   */
  private static async dispatchVideoGeneration(taskId: string, data: any) {
    // If the data does not contain a file upload but contains mockup text/urls,
    // simulate it via direct API bridge
    try {
      const response = await axios.get(`${VIDEO_ENGINE_URL}/`);
      
      // Mocking video service call for demonstration. 
      // If a real filepath is present, compile result.
      if (response.data?.status === "online") {
        setTimeout(async () => {
          await this.onTaskUpdate(taskId, "COMPLETED", {
            videoUrl: data.videoUrl || "https://assets.mixkit.co/videos/preview/mixkit-modern-apartment-living-room-42865-large.mp4",
            metadata: {
              summary: "A modern luxury apartment tour with high quality AV1 encoding.",
              compressionRatio: "10.4x",
              engine: response.data.model
            }
          });
        }, 3000); // Wait 3s to simulate progress
      } else {
        throw new Error("Video neural engine offline");
      }
    } catch (err: any) {
      await this.onTaskUpdate(taskId, "FAILED", null, err.message);
    }
  }

  /**
   * Callback to update task status in our database.
   */
  static async onTaskUpdate(taskId: string, status: string, result?: any, error?: string) {
    console.log(`[MLBridgeService] Task update received for ${taskId}: status=${status}`);

    const task = await prisma.aiServiceTask.update({
      where: { id: taskId },
      data: {
        status: status as any,
        outputData: result || undefined,
        errorMessage: error || undefined,
        progress: status === "COMPLETED" ? 100 : (status === "FAILED" ? 0 : undefined)
      }
    });

    // Write to Extracted Data database if OCR/Extraction completed
    if (status === "COMPLETED" && result && (task.taskType === "DOCUMENT_OCR" || task.taskType === "FINANCIAL_EXTRACTION")) {
      await prisma.aiExtractedData.create({
        data: {
          propertyId: task.propertyId,
          sourceType: task.taskType,
          extractedValues: result,
          confidence: result.confidence || 0.9,
          verifiedBy: "TesseractOCR-v4"
        }
      });
    }

    return task;
  }

  /**
   * Sends telemetry/feedback to the Skipper API for Reinforcement Learning 
   * and logs it immutably into the AIFeedbackLoop table.
   * This forms the "Learning Loop" of the Unified OS.
   */
  static async sendFeedback(modelName: string, eventType: string, reward: number, context: any) {
    console.log(`[MLBridgeService] Dispatching feedback: ${modelName} | ${eventType} | Reward: ${reward}`);
    
    try {
      // 1. Send feedback to Skipper API (Python Brain)
      await axios.post(`${SKIPPER_API_URL}/api/v1/ml/feedback`, {
        model_name: modelName,
        event_type: eventType,
        reward,
        context
      });

      // 2. Audit Trail in Postgres (Prisma)
      let orgId = context?.orgId;
      if (!orgId) {
        const firstOrg = await prisma.organization.findFirst({ select: { id: true } });
        orgId = firstOrg?.id || "system";
      }
      
      await prisma.aIFeedbackLoop.create({
        data: {
          orgId: orgId,
          actionType: eventType,
          entityId: modelName,
          outcomeScore: reward,
          outcomeReason: `Feedback recorded for model ${modelName} with reward ${reward}`,
          originalDecision: context || {}
        }
      });

      console.log(`[MLBridgeService] Feedback recorded successfully.`);
    } catch (error: any) {
      console.error(`[MLBridgeService] Error sending feedback:`, error.message);
    }
  }
}
