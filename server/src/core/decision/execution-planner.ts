import { DecisionNodeResult } from "./nodes/base-node";

export interface ExecutionTask {
  id: string;
  action: string;
  priority: number;
  expectedGain: number;
  cost: number;
  roi: number;
  confidence: number;
  metadata?: any;
  status: "PENDING" | "EXECUTING" | "COMPLETED" | "FAILED";
}

export class ExecutionPlanner {
  private taskQueue: ExecutionTask[] = [];

  /**
   * Receives decisions from the OpportunityNode or others, 
   * prioritizes them, and queues them for asynchronous execution.
   */
  public planExecution(result: DecisionNodeResult) {
    if (!result.metadata?.proposedActions) {
      return;
    }

    const actions: any[] = result.metadata.proposedActions;

    for (const actionData of actions) {
      const task: ExecutionTask = {
        id: Math.random().toString(36).substring(7),
        action: actionData.action,
        priority: actionData.priority || 50,
        expectedGain: actionData.expectedGain || 0,
        cost: actionData.cost || 0,
        roi: actionData.roi || 0,
        confidence: actionData.confidence || 1.0,
        metadata: actionData,
        status: "PENDING",
      };

      this.taskQueue.push(task);
      console.log(`[ExecutionPlanner] Queued Action: ${task.action} (Priority: ${task.priority}, ROI: ${task.roi})`);
    }

    this.sortQueue();
  }

  private sortQueue() {
    // Sort primarily by Priority, then by ROI for ties
    this.taskQueue.sort((a, b) => {
      if (b.priority !== a.priority) {
        return b.priority - a.priority;
      }
      return b.roi - a.roi;
    });
  }

  public getQueue() {
    return this.taskQueue;
  }

  public markExecuted(taskId: string) {
    const task = this.taskQueue.find(t => t.id === taskId);
    if (task) {
      task.status = "COMPLETED";
    }
  }
}

// Singleton instance
export const executionPlanner = new ExecutionPlanner();
