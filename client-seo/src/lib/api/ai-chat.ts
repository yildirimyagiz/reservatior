import { apiClient } from "./client";

export interface AIChatMessage {
  id: string;
  sessionId: string;
  role: 'USER' | 'ASSISTANT' | 'SYSTEM';
  content: string;
  isAI: boolean;
  createdAt: string;
  metadata?: Record<string, any>;
}

export interface AIChatSession {
  sessionId: string;
  status: 'ACTIVE' | 'HANDED_OFF' | 'CLOSED';
  createdAt: string;
  endedAt?: string;
  messages?: AIChatMessage[];
  metadata?: Record<string, any>;
}

export const aiChatApi = {
  // Create new AI chat session
  createSession: async (data: {
    propertyId?: string;
    userId?: string;
    agentId?: string;
    model?: string;
    systemPrompt?: string;
    temperature?: number;
    maxTokens?: number;
    metadata?: Record<string, any>;
  }): Promise<AIChatSession> => {
    const response = await apiClient.post<AIChatSession>(`/organizations/current/ai-chat/sessions`, data);
    return response;
  },

  // Get AI chat session by ID
  getSessionById: async (sessionId: string): Promise<AIChatSession> => {
    const response = await apiClient.get<AIChatSession>(`/organizations/current/ai-chat/sessions/${sessionId}`);
    return response;
  },

  // Get all AI chat sessions
  getAllSessions: async (filters?: {
    userId?: string;
    agentId?: string;
    propertyId?: string;
    status?: AIChatSession['status'];
    startDate?: string;
    endDate?: string;
    limit?: number;
  }): Promise<AIChatSession[]> => {
    const response = await apiClient.get<AIChatSession[]>(`/organizations/current/ai-chat/sessions`, {
      params: { ...filters }
    });
    return response;
  },

  // Get messages from session
  getMessages: async (sessionId: string, filters?: {
    limit?: number;
    before?: string;
    after?: string;
    role?: AIChatMessage['role'];
  }): Promise<AIChatMessage[]> => {
    const response = await apiClient.get<AIChatMessage[]>(`/organizations/current/ai-chat/sessions/${sessionId}/messages`, {
      params: { ...filters }
    });
    return response;
  },

  // Send message to session
  sendMessage: async (sessionId: string, data: {
    content: string;
    role?: AIChatMessage['role'];
    metadata?: Record<string, any>;
  }): Promise<AIChatMessage> => {
    const response = await apiClient.post<AIChatMessage>(`/organizations/current/ai-chat/sessions/${sessionId}/messages`, data);
    return response;
  },

  // Update session status
  updateSessionStatus: async (sessionId: string, status: AIChatSession['status']): Promise<AIChatSession> => {
    const response = await apiClient.patch<AIChatSession>(`/organizations/current/ai-chat/sessions/${sessionId}/status`, { status });
    return response;
  },

  // End AI chat session
  endSession: async (sessionId: string, data?: {
    reason?: string;
    summary?: string;
    rating?: number;
    feedback?: string;
  }): Promise<AIChatSession> => {
    const response = await apiClient.patch<AIChatSession>(`/organizations/current/ai-chat/sessions/${sessionId}/end`, data);
    return response;
  },

  // Get session statistics
  getSessionStatistics: async (sessionId: string): Promise<{
    totalMessages: number;
    userMessages: number;
    aiMessages: number;
    averageResponseTime: number;
    sessionDuration: number;
    satisfactionScore?: number;
    tokensUsed: number;
    cost: number;
  }> => {
    const response = await apiClient.get<{
    totalMessages: number;
    userMessages: number;
    aiMessages: number;
    averageResponseTime: number;
    sessionDuration: number;
    satisfactionScore?: number;
    tokensUsed: number;
    cost: number;
  }>(`/organizations/current/ai-chat/sessions/${sessionId}/statistics`);
    return response;
  },

  // Generate session transcript
  generateTranscript: async (sessionId: string, options: {
    format: "PDF" | "TXT" | "JSON";
    includeMetadata?: boolean;
    includeTimestamps?: boolean;
  }): Promise<Blob> => {
    const response = await apiClient.post<Blob>(`/organizations/current/ai-chat/sessions/${sessionId}/transcript`, options, {
      responseType: 'blob'
    });
    return response;
  },

  // Get AI models
  getModels: async (): Promise<Array<{
    id: string;
    name: string;
    description: string;
    capabilities: string[];
    pricing: {
      inputTokenCost: number;
      outputTokenCost: number;
      maxTokens: number;
    };
    isActive: boolean;
  }>> => {
    const response = await apiClient.get<Array<{
    id: string;
    name: string;
    description: string;
    capabilities: string[];
    pricing: {
      inputTokenCost: number;
      outputTokenCost: number;
      maxTokens: number;
    };
    isActive: boolean;
  }>>(`/organizations/current/ai-chat/models`);
    return response;
  },

  // Get chat analytics
  getAnalytics: async (filters?: {
    startDate?: string;
    endDate?: string;
    userId?: string;
    agentId?: string;
    propertyId?: string;
  }): Promise<{
    totalSessions: number;
    totalMessages: number;
    totalUsers: number;
    averageSessionDuration: number;
    satisfactionScore: number;
    costAnalysis: {
      totalCost: number;
      averageCostPerSession: number;
      mostUsedModel: string;
    };
    usageByPeriod: Array<{
      period: string;
      sessions: number;
      messages: number;
      cost: number;
    }>;
    topUsers: Array<{
      userId: string;
      userName: string;
      sessions: number;
      messages: number;
      satisfaction: number;
    }>;
  }> => {
    const response = await apiClient.get<{
    totalSessions: number;
    totalMessages: number;
    totalUsers: number;
    averageSessionDuration: number;
    satisfactionScore: number;
    costAnalysis: {
      totalCost: number;
      averageCostPerSession: number;
      mostUsedModel: string;
    };
    usageByPeriod: Array<{
      period: string;
      sessions: number;
      messages: number;
      cost: number;
    }>;
    topUsers: Array<{
      userId: string;
      userName: string;
      sessions: number;
      messages: number;
      satisfaction: number;
    }>;
  }>(`/organizations/current/ai-chat/analytics`, {
      params: { ...filters }
    });
    return response;
  },

  // Rate AI response
  rateResponse: async (sessionId: string, messageId: string, data: {
    rating: number;
    feedback?: string;
    helpful?: boolean;
    accurate?: boolean;
  }): Promise<void> => {
    await apiClient.post(`/organizations/current/ai-chat/sessions/${sessionId}/messages/${messageId}/rate`, data);
  },

  // Delete session
  deleteSession: async (sessionId: string): Promise<void> => {
    await apiClient.delete(`/organizations/current/ai-chat/sessions/${sessionId}`);
  },

  // Archive session
  archiveSession: async (sessionId: string): Promise<AIChatSession> => {
    const response = await apiClient.patch<AIChatSession>(`/organizations/current/ai-chat/sessions/${sessionId}/archive`);
    return response;
  },
};
