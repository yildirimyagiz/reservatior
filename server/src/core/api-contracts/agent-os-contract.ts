/**
 * Agent OS API Contract
 * Defines the API interface for Agent OS operations
 */

export interface AgentOSAPIContract {
  // Agent CRUD Operations
  createAgent(params: CreateAgentParams): Promise<AgentResponse>;
  getAgent(agentId: string): Promise<AgentResponse>;
  updateAgent(agentId: string, params: UpdateAgentParams): Promise<AgentResponse>;
  deleteAgent(agentId: string): Promise<void>;
  
  // Agent Operations
  inviteAgent(params: InviteAgentParams): Promise<InvitationResponse>;
  verifyAgent(agentId: string, verificationData: any): Promise<AgentResponse>;
  suspendAgent(agentId: string, reason: string): Promise<AgentResponse>;
  reactivateAgent(agentId: string): Promise<AgentResponse>;
  
  // Profile Operations
  updateProfile(agentId: string, profile: ProfileUpdate): Promise<AgentResponse>;
  getProfile(agentId: string): Promise<AgentResponse>;
  
  // Performance Operations
  getPerformance(agentId: string, params: TimeRangeParams): Promise<PerformanceResponse>;
  updatePerformance(agentId: string, metrics: PerformanceMetrics): Promise<void>;
  getLeaderboard(params: LeaderboardParams): Promise<LeaderboardResponse>;
  
  // Commission Operations
  getCommissions(agentId: string, params: TimeRangeParams): Promise<CommissionResponse[]>;
  calculateCommission(params: CommissionCalculationParams): Promise<CommissionCalculationResponse>;
  
  // Network Operations
  getNetwork(agentId: string): Promise<NetworkResponse>;
  addConnection(agentId: string, targetAgentId: string): Promise<void>;
  removeConnection(agentId: string, targetAgentId: string): Promise<void>;
  
  // Training Operations
  assignTraining(agentId: string, trainingId: string): Promise<void>;
  getTrainings(agentId: string): Promise<TrainingResponse[]>;
  updateTrainingProgress(agentId: string, trainingId: string, progress: number): Promise<void>;
  
  // Communication Operations
  sendCommunication(params: CommunicationParams): Promise<CommunicationResponse>;
  getCommunications(agentId: string, params: TimeRangeParams): Promise<CommunicationResponse[]>;
  
  // Analytics Operations
  getAgentAnalytics(agentId: string, params: AnalyticsParams): Promise<AgentAnalyticsResponse>;
  exportAgentData(agentId: string, params: ExportParams): Promise<ExportResponse>;
  
  // Trust Scoring
  getTrustScore(agentId: string): Promise<TrustScoreResponse>;
  updateTrustScore(agentId: string, adjustment: number, reason: string): Promise<TrustScoreResponse>;
}

// Request/Response Types
export interface CreateAgentParams {
  email: string;
  name: string;
  phone: string;
  organizationId: string;
  teamId?: string;
}

export interface UpdateAgentParams {
  name?: string;
  email?: string;
  phone?: string;
  teamId?: string;
  status?: string;
}

export interface AgentResponse {
  id: string;
  email: string;
  name: string;
  phone: string;
  organizationId: string;
  teamId?: string;
  status: 'invited' | 'active' | 'suspended' | 'deleted';
  trustScore: number;
  performanceScore: number;
  createdAt: string;
  updatedAt: string;
}

export interface InviteAgentParams {
  email: string;
  name: string;
  phone: string;
  organizationId: string;
  invitationChannel: 'email' | 'whatsapp' | 'sms';
}

export interface InvitationResponse {
  invitationId: string;
  agentId: string;
  status: 'pending' | 'accepted' | 'expired' | 'cancelled';
  expiresAt: string;
  sentAt: string;
}

export interface ProfileUpdate {
  name?: string;
  bio?: string;
  avatar?: string;
  specialties?: string[];
  languages?: string[];
}

export interface TimeRangeParams {
  startDate: string;
  endDate: string;
}

export interface PerformanceResponse {
  agentId: string;
  overallScore: number;
  metrics: {
    sales: number;
    clientSatisfaction: number;
    responseTime: number;
    listingQuality: number;
  };
  trend: 'improving' | 'stable' | 'declining';
  period: string;
}

export interface PerformanceMetrics {
  sales?: number;
  clientSatisfaction?: number;
  responseTime?: number;
  listingQuality?: number;
}

export interface LeaderboardParams {
  organizationId: string;
  metric: 'sales' | 'commission' | 'client_satisfaction';
  timeRange: TimeRangeParams;
  limit?: number;
}

export interface LeaderboardResponse {
  rankings: Array<{
    agentId: string;
    name: string;
    value: number;
    rank: number;
  }>;
}

export interface CommissionResponse {
  id: string;
  agentId: string;
  amount: number;
  currency: string;
  status: 'pending' | 'approved' | 'paid';
  dealId: string;
  createdAt: string;
  paidAt?: string;
}

export interface CommissionCalculationParams {
  agentId: string;
  dealId: string;
  salePrice: number;
  currency: string;
  commissionRate: number;
}

export interface CommissionCalculationResponse {
  commissionAmount: number;
  currency: string;
  breakdown: Array<{
    type: string;
    amount: number;
  }>;
}

export interface NetworkResponse {
  agentId: string;
  connections: Array<{
    agentId: string;
    name: string;
    relationship: string;
    strength: number;
  }>;
  networkStrength: number;
  influenceScore: number;
}

export interface TrainingResponse {
  id: string;
  title: string;
  description: string;
  status: 'assigned' | 'in_progress' | 'completed';
  progress: number;
  score?: number;
  assignedAt: string;
  completedAt?: string;
}

export interface CommunicationParams {
  agentId: string;
  recipientId: string;
  channel: 'email' | 'whatsapp' | 'sms' | 'in_app';
  message: string;
  subject?: string;
  priority?: 'low' | 'medium' | 'high';
}

export interface CommunicationResponse {
  id: string;
  agentId: string;
  recipientId: string;
  channel: string;
  status: 'sent' | 'delivered' | 'read' | 'failed';
  sentAt: string;
  deliveredAt?: string;
  readAt?: string;
}

export interface AnalyticsParams {
  agentId: string;
  timeRange: TimeRangeParams;
  metrics?: string[];
  groupBy?: 'day' | 'week' | 'month';
}

export interface AgentAnalyticsResponse {
  performance: PerformanceResponse;
  commissions: {
    total: number;
    average: number;
    trend: number;
  };
  leads: {
    total: number;
    converted: number;
    conversionRate: number;
  };
  communication: {
    sent: number;
    responseRate: number;
    averageResponseTime: number;
  };
}

export interface ExportParams {
  format: 'csv' | 'excel' | 'pdf';
  timeRange: TimeRangeParams;
  includeMetrics?: string[];
}

export interface ExportResponse {
  exportId: string;
  status: 'processing' | 'completed' | 'failed';
  downloadUrl?: string;
  format: string;
  recordCount?: number;
}

export interface TrustScoreResponse {
  agentId: string;
  trustScore: number;
  confidence: number;
  breakdown: {
    reliability: number;
    integrity: number;
    competence: number;
    communication: number;
  };
  lastUpdated: string;
}
