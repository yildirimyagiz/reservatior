import { apiClient } from "./client";

export enum AgentRole {
  LEASING_AGENT = "LEASING_AGENT",
  PROPERTY_MANAGER = "PROPERTY_MANAGER",
  FINANCIAL_ANALYST = "FINANCIAL_ANALYST",
  COMPLIANCE_AGENT = "COMPLIANCE_AGENT",
  MARKETING_AGENT = "MARKETING_AGENT",
  CUSTOMER_SERVICE_AGENT = "CUSTOMER_SERVICE_AGENT",
}

export enum AgentStatus {
  IDLE = "IDLE",
  BUSY = "BUSY",
  OFFLINE = "OFFLINE",
  MAINTENANCE = "MAINTENANCE",
}

export enum TaskPriority {
  LOW = "LOW",
  MEDIUM = "MEDIUM",
  HIGH = "HIGH",
  URGENT = "URGENT",
}

export enum TaskStatus {
  PENDING = "PENDING",
  IN_PROGRESS = "IN_PROGRESS",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELLED = "CANCELLED",
}

export interface AIAgent {
  id: string;
  role: AgentRole;
  name: string;
  status: AgentStatus;
  capabilities: string[];
  performance: {
    tasksCompleted: number;
    successRate: number;
    avgResponseTime: number;
  };
  metadata?: Record<string, unknown>;
  lastActive: string;
}

export interface AgentTask {
  id: string;
  agentId: string;
  type: string;
  priority: TaskPriority;
  status: TaskStatus;
  input: Record<string, unknown>;
  output?: Record<string, unknown>;
  error?: string;
  startedAt?: string;
  completedAt?: string;
  estimatedDuration?: number;
  actualDuration?: number;
}

export const aiAgentOSApi = {
  // Create agent
  createAgent: async (data: Omit<AIAgent, 'id' | 'lastActive'>): Promise<AIAgent> => {
    const response = await apiClient.post<AIAgent>(`/api/v1/ai-agent-os/agent`, data);
    return response;
  },

  // Get agent
  getAgent: async (agentId: string): Promise<AIAgent> => {
    const response = await apiClient.get<AIAgent>(`/api/v1/ai-agent-os/agent/${agentId}`);
    return response;
  },

  // Get available agents for role
  getAvailableAgents: async (role: AgentRole): Promise<AIAgent[]> => {
    const response = await apiClient.get<AIAgent[]>(`/api/v1/ai-agent-os/agents/available/${role}`);
    return response;
  },

  // Assign task to agent
  assignTask: async (data: Omit<AgentTask, 'id' | 'status' | 'startedAt' | 'completedAt' | 'actualDuration'>): Promise<AgentTask> => {
    const response = await apiClient.post<AgentTask>(`/api/v1/ai-agent-os/task`, data);
    return response;
  },

  // Get agent performance
  getAgentPerformance: async (agentId: string): Promise<any> => {
    const response = await apiClient.get(`/api/v1/ai-agent-os/agent/${agentId}/performance`);
    return response;
  },

  // Scale agents
  scaleAgents: async (role: AgentRole, targetCount: number): Promise<{ scaled: boolean }> => {
    const response = await apiClient.post<{ scaled: boolean }>(`/api/v1/ai-agent-os/agents/scale`, {
      role,
      targetCount,
    });
    return response;
  },

  // Get agent dashboard
  getDashboard: async (): Promise<any> => {
    const response = await apiClient.get(`/api/v1/ai-agent-os/dashboard`);
    return response;
  },
};
