import { apiClient } from "./client";

export interface Task {
  id: string;
  orgId: string;
  title: string;
  description?: string;
  status: string;
  priority: string;
  taskType: string;
  assignedToId?: string;
  assignedById?: string;
  propertyId?: string;
  contactId?: string;
  dealId?: string;
  dueDate?: string;
  completedAt?: string;
  tags?: string[];
  attachments?: string[];
  checklist?: Array<{
    id: string;
    text: string;
    completed: boolean;
  }>;
  subtasks?: string[];
  estimatedHours?: number;
  actualHours?: number;
  recurring?: {
    enabled: boolean;
    frequency: string;
    interval: number;
    endDate?: string;
  };
  createdAt: string;
  updatedAt: string;
}

export interface TaskCreate {
  orgId: string;
  title: string;
  description?: string;
  status: string;
  priority: string;
  taskType: string;
  assignedToId?: string;
  assignedById?: string;
  propertyId?: string;
  contactId?: string;
  dealId?: string;
  dueDate?: string;
  tags?: string[];
  checklist?: Array<{
    id: string;
    text: string;
    completed: boolean;
  }>;
  estimatedHours?: number;
  recurring?: {
    enabled: boolean;
    frequency: string;
    interval: number;
    endDate?: string;
  };
}

export interface TaskUpdate {
  title?: string;
  description?: string;
  status?: string;
  priority?: string;
  taskType?: string;
  assignedToId?: string;
  propertyId?: string;
  contactId?: string;
  dealId?: string;
  dueDate?: string;
  completedAt?: string;
  tags?: string[];
  attachments?: string[];
  checklist?: Array<{
    id: string;
    text: string;
    completed: boolean;
  }>;
  subtasks?: string[];
  estimatedHours?: number;
  actualHours?: number;
  recurring?: {
    enabled: boolean;
    frequency: string;
    interval: number;
    endDate?: string;
  };
}

export const tasksApi = {
  getAll: async (params?: {
    page?: number;
    limit?: number;
    search?: string;
    orgId?: string;
    status?: string;
    priority?: string;
    assignedToId?: string;
    taskType?: string;
    dueDate?: string;
  }): Promise<{ data: Task[] }> => {
    return await apiClient.get<{ data: Task[] }>("/api/task", { params });
  },

  getById: async (id: string) => {
    return await apiClient.get(`/api/task/${id}`);
  },

  create: async (data: TaskCreate) => {
    return await apiClient.post("/api/task", data);
  },

  update: async (id: string, data: TaskUpdate) => {
    return await apiClient.patch(`/api/task/${id}`, data);
  },

  delete: async (id: string) => {
    return await apiClient.delete(`/api/task/${id}`);
  },

  // Get tasks for organization
  getOrgTasks: async (orgId: string) => {
    return await apiClient.get("/api/task", {
      params: { orgId },
    });
  },

  // Get my tasks
  getMyTasks: async (userId: string) => {
    return await apiClient.get("/api/task", {
      params: { assignedToId: userId },
    });
  },

  // Search tasks
  searchTasks: async (query: string, filters?: any) => {
    return await apiClient.get("/api/task/search", {
      params: { q: query, ...filters },
    });
  },

  // Get task analytics
  getTaskAnalytics: async (orgId: string) => {
    return await apiClient.get("/api/task/analytics", {
      params: { orgId },
    });
  },

  // Complete task
  completeTask: async (id: string) => {
    return await apiClient.post(`/api/task/${id}/complete`);
  },

  // Reopen task
  reopenTask: async (id: string) => {
    return await apiClient.post(`/api/task/${id}/reopen`);
  },

  // Update task status
  updateStatus: async (id: string, status: string) => {
    return await apiClient.patch(`/api/task/${id}`, { status });
  },

  // Add comment
  addComment: async (id: string, comment: string) => {
    return await apiClient.post(`/api/task/${id}/comments`, {
      comment,
    });
  },

  // Get task comments
  getComments: async (id: string) => {
    return await apiClient.get(`/api/task/${id}/comments`);
  },

  // Upload attachments
  uploadAttachments: async (id: string, files: File[]) => {
    const formData = new FormData();
    files.forEach((file) => formData.append("attachments", file));

    return await apiClient.post(
      `/api/task/${id}/attachments`,
      formData
    );
  },

  // Update checklist
  updateChecklist: async (
    id: string,
    checklist: Array<{
      id: string;
      text: string;
      completed: boolean;
    }>
  ) => {
    return await apiClient.patch(`/api/task/${id}/checklist`, {
      checklist,
    });
  },

  // Log time
  logTime: async (id: string, hours: number, description?: string) => {
    return await apiClient.post(`/api/task/${id}/time`, {
      hours,
      description,
    });
  },

  // Get time logs
  getTimeLogs: async (id: string) => {
    return await apiClient.get(`/api/task/${id}/time-logs`);
  },
};
