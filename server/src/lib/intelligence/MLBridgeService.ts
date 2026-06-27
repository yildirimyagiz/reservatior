// Bypass for local generation issues
type AiTaskType = any;
type AiTaskStatus = any;
const AiTaskStatus = { QUEUED: "QUEUED", PROCESSING: "PROCESSING", COMPLETED: "COMPLETED", FAILED: "FAILED" } as any;
const AiTaskType = { REELS_VIDEO_GEN: "REELS_VIDEO_GEN" } as any;
import axios from "axios";
import { prismaManager } from "../prisma";

const prisma = prismaManager.getDefault();

// The Skipper API or individual ML service URLs
const ML_API_BASE_URL = process.env.ML_API_BASE_URL || "http://localhost:8080/api/v1/ml";

export class MLBridgeService {
  /**
   * Register and trigger a new ML task (Video, Brochure, etc.)
   */
  static async triggerTask(orgId: string, propertyId: string, type: AiTaskType, input: any) {
    // 1. Create a task record in our database
    const task = await (prisma as any).aiServiceTask.create({
      data: {
        orgId,
        propertyId,
        taskType: type,
        status: AiTaskStatus.QUEUED,
        inputData: input,
      }
    });

    // 2. Dispatch to the external ML worker (e.g., ComfyUI or Document Processor)
    try {
      const response = await axios.post(`${ML_API_BASE_URL}/tasks/dispatch`, {
        taskId: task.id,
        type: type,
        data: input
      });

      // Update with the remote task ID if available
      if (response.data?.externalId) {
        return (prisma as any).aiServiceTask.update({
          where: { id: task.id },
          data: { 
            externalJobId: response.data.externalId,
            status: AiTaskStatus.PROCESSING
          }
        });
      }
    } catch (error: any) {
      console.error(`Failed to dispatch ML task: ${error.message}`);
      return prisma.aiServiceTask.update({
        where: { id: task.id },
        data: { 
          status: AiTaskStatus.FAILED,
          errorMessage: error.message
        }
      });
    }

    return task;
  }

  /**
   * Callback received from ML services when a task is completed/failed
   */
  static async onTaskUpdate(taskId: string, status: AiTaskStatus, output?: any, error?: string) {
    const task = await (prisma as any).aiServiceTask.update({
      where: { id: taskId },
      data: {
        status,
        outputData: output,
        errorMessage: error,
        progress: status === AiTaskStatus.COMPLETED ? 100 : undefined
      }
    });

    // Special logic for AI Visual Enhancement (Update Property Video if it was a Video Gen task)
    if (status === AiTaskStatus.COMPLETED && task.taskType === AiTaskType.REELS_VIDEO_GEN) {
      await this.finalizeVideoGeneration(task.propertyId, output.videoUrl);
    }

    return task;
  }

  private static async finalizeVideoGeneration(propertyId: string, videoUrl: string) {
    return (prisma as any).aiVideoGeneration.create({
      data: {
        propertyId,
        videoUrl,
        status: "COMPLETED",
      }
    });
  }
}
