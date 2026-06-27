import { prisma } from "../lib/prisma";
import { BaseService } from "./base";

export class TaskService extends BaseService<any, any, any> {
  constructor() {
    super(prisma.task, "task");
  }
}

export const taskService = new TaskService();
