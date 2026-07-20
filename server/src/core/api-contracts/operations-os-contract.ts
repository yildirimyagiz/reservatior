export interface OperationsOSAPIContract {
  createTask(params: any): Promise<any>;
  getTask(taskId: string): Promise<any>;
  updateTask(taskId: string, params: any): Promise<any>;
  deleteTask(taskId: string): Promise<any>;
  assignTask(taskId: string, assigneeId: string): Promise<any>;
  completeTask(taskId: string): Promise<any>;
  createWorkflow(params: any): Promise<any>;
  getWorkflow(workflowId: string): Promise<any>;
  updateWorkflow(workflowId: string, params: any): Promise<any>;
  deleteWorkflow(workflowId: string): Promise<any>;
}
