/**
 * Notification OS API Contract
 * Defines the API interface for Notification OS operations
 */

export interface NotificationOSAPIContract {
  // Notification Operations
  createNotification(params: CreateNotificationParams): Promise<NotificationResponse>;
  getNotification(notificationId: string): Promise<NotificationResponse>;
  updateNotification(notificationId: string, params: UpdateNotificationParams): Promise<NotificationResponse>;
  deleteNotification(notificationId: string): Promise<void>;
  sendNotification(notificationId: string): Promise<NotificationResponse>;
  cancelNotification(notificationId: string): Promise<void>;
  
  // Channel Operations
  configureChannel(channelId: string, config: ChannelConfig): Promise<ChannelResponse>;
  enableChannel(channelId: string): Promise<ChannelResponse>;
  disableChannel(channelId: string): Promise<ChannelResponse>;
  getChannelStatus(channelId: string): Promise<ChannelStatusResponse>;
  
  // Template Operations
  createTemplate(params: CreateTemplateParams): Promise<TemplateResponse>;
  getTemplate(templateId: string): Promise<TemplateResponse>;
  updateTemplate(templateId: string, params: UpdateTemplateParams): Promise<TemplateResponse>;
  deleteTemplate(templateId: string): Promise<void>;
  useTemplate(templateId: string, variables: Record<string, string>): Promise<string>;
  
  // Rule Operations
  createRule(params: CreateRuleParams): Promise<RuleResponse>;
  getRule(ruleId: string): Promise<RuleResponse>;
  updateRule(ruleId: string, params: UpdateRuleParams): Promise<RuleResponse>;
  deleteRule(ruleId: string): Promise<void>;
  enableRule(ruleId: string): Promise<RuleResponse>;
  disableRule(ruleId: string): Promise<RuleResponse>;
  
  // Preference Operations
  getPreferences(userId: string): Promise<PreferencesResponse>;
  updatePreferences(userId: string, preferences: UserPreferences): Promise<PreferencesResponse>;
  
  // Analytics Operations
  getAnalytics(params: AnalyticsParams): Promise<AnalyticsResponse>;
  exportAnalytics(params: ExportAnalyticsParams): Promise<ExportResponse>;
  
  // Bulk Operations
  sendBulk(params: BulkSendParams): Promise<BulkResponse>;
  scheduleBulk(params: BulkScheduleParams): Promise<BulkResponse>;
  
  // Integration Operations
  manageIntegration(integrationId: string, config: any): Promise<void>;
  manageWebhook(webhookId: string, config: any): Promise<void>;
}

// Request/Response Types
export interface CreateNotificationParams {
  recipientId: string;
  notificationType: string;
  channels: string[];
  templateId?: string;
  content?: {
    subject?: string;
    body: string;
    callToAction?: string;
  };
  variables?: Record<string, string>;
  priority?: 'low' | 'medium' | 'high';
  scheduledAt?: string;
  organizationId: string;
  createdBy: string;
}

export interface UpdateNotificationParams {
  content?: {
    subject?: string;
    body?: string;
    callToAction?: string;
  };
  variables?: Record<string, string>;
  priority?: 'low' | 'medium' | 'high';
  scheduledAt?: string;
}

export interface NotificationResponse {
  id: string;
  recipientId: string;
  notificationType: string;
  channels: string[];
  templateId?: string;
  content: {
    subject?: string;
    body: string;
    callToAction?: string;
  };
  status: 'draft' | 'queued' | 'sent' | 'delivered' | 'failed' | 'cancelled';
  priority: 'low' | 'medium' | 'high';
  createdAt: string;
  scheduledAt?: string;
  sentAt?: string;
  deliveredAt?: string;
  organizationId: string;
}

export interface ChannelConfig {
  apiKey?: string;
  apiSecret?: string;
  webhookUrl?: string;
  settings?: Record<string, any>;
}

export interface ChannelResponse {
  id: string;
  type: 'email' | 'sms' | 'push' | 'whatsapp';
  status: 'active' | 'inactive';
  config: ChannelConfig;
  createdAt: string;
  updatedAt: string;
}

export interface ChannelStatusResponse {
  channelId: string;
  status: 'operational' | 'degraded' | 'down';
  lastUsed: string;
  successRate: number;
}

export interface CreateTemplateParams {
  name: string;
  notificationType: string;
  content: {
    subject?: string;
    body: string;
    callToAction?: string;
  };
  variables: string[];
  organizationId: string;
  createdBy: string;
}

export interface UpdateTemplateParams {
  name?: string;
  content?: {
    subject?: string;
    body?: string;
    callToAction?: string;
  };
  variables?: string[];
}

export interface TemplateResponse {
  id: string;
  name: string;
  notificationType: string;
  content: {
    subject?: string;
    body: string;
    callToAction?: string;
  };
  variables: string[];
  organizationId: string;
  createdAt: string;
  updatedAt: string;
}

export interface CreateRuleParams {
  name: string;
  trigger: {
    event: string;
    conditions: Record<string, any>;
  };
  actions: Array<{
    type: string;
    config: Record<string, any>;
  }>;
  organizationId: string;
  createdBy: string;
}

export interface UpdateRuleParams {
  name?: string;
  trigger?: {
    event: string;
    conditions: Record<string, any>;
  };
  actions?: Array<{
    type: string;
    config: Record<string, any>;
  }>;
}

export interface RuleResponse {
  id: string;
  name: string;
  trigger: {
    event: string;
    conditions: Record<string, any>;
  };
  actions: Array<{
    type: string;
    config: Record<string, any>;
  }>;
  status: 'active' | 'inactive';
  organizationId: string;
  createdAt: string;
  updatedAt: string;
}

export interface UserPreferences {
  channels: {
    email: boolean;
    sms: boolean;
    push: boolean;
    whatsapp: boolean;
  };
  frequency: 'immediate' | 'daily' | 'weekly';
  timezone: string;
  quietHours?: {
    start: string;
    end: string;
  };
}

export interface PreferencesResponse {
  userId: string;
  preferences: UserPreferences;
  updatedAt: string;
}

export interface AnalyticsParams {
  organizationId: string;
  timeRange: { start: string; end: string };
  channels?: string[];
  notificationTypes?: string[];
}

export interface AnalyticsResponse {
  totalNotifications: number;
  sentNotifications: number;
  deliveredNotifications: number;
  failedNotifications: number;
  openRate: number;
  clickRate: number;
  responseRate: number;
  breakdown: Array<{
    channel: string;
    sent: number;
    delivered: number;
    openRate: number;
  }>;
}

export interface ExportAnalyticsParams {
  organizationId: string;
  timeRange: { start: string; end: string };
  format: 'csv' | 'excel' | 'pdf';
}

export interface ExportResponse {
  exportId: string;
  status: 'processing' | 'completed' | 'failed';
  downloadUrl?: string;
  format: string;
}

export interface BulkSendParams {
  campaignName: string;
  recipientIds: string[];
  templateId: string;
  variables?: Record<string, Record<string, string>>;
  channels: string[];
  organizationId: string;
  createdBy: string;
}

export interface BulkScheduleParams {
  campaignName: string;
  recipientIds: string[];
  templateId: string;
  variables?: Record<string, Record<string, string>>;
  channels: string[];
  scheduledAt: string;
  organizationId: string;
  createdBy: string;
}

export interface BulkResponse {
  campaignId: string;
  status: 'queued' | 'processing' | 'completed' | 'failed';
  recipientCount: number;
  sentCount: number;
  failedCount: number;
  createdAt: string;
}
