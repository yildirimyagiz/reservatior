import { getLocalizationHeaders } from './localization-helper';

export const notificationOSApi = {
  getDashboardStats: async (orgId: string) => {
    const res = await fetch(`/api/v1/notification-os/dashboard?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch notification OS dashboard stats');
    return res.json();
  },

  send: async (data: {
    userId: string;
    type: string;
    title: string;
    body: string;
    channel: 'email' | 'sms' | 'whatsapp' | 'push' | 'in_app' | 'telegram' | 'slack' | 'teams' | 'voice';
    priority?: 'low' | 'medium' | 'high' | 'urgent';
    scheduledFor?: string;
    metadata?: Record<string, any>;
    correlationId?: string;
  }) => {
    const res = await fetch('/api/v1/notification-os/send', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(data),
    });
    if (!res.ok) throw new Error('Failed to send notification');
    return res.json();
  },

  sendFromTemplate: async (templateId: string, userId: string, variables: Record<string, any>, channel?: string) => {
    const params = new URLSearchParams({ templateId, userId });
    if (channel) params.append('channel', channel);
    const res = await fetch(`/api/v1/notification-os/send-from-template?${params}`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ variables }),
    });
    if (!res.ok) throw new Error('Failed to send notification from template');
    return res.json();
  },

  createRule: async (rule: {
    name: string;
    description: string;
    eventType: string;
    conditions: Record<string, any>;
    channels: string[];
    templateId?: string;
    priority: 'low' | 'medium' | 'high' | 'urgent';
    enabled: boolean;
    organizationId: string;
  }) => {
    const res = await fetch('/api/v1/notification-os/rules', {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(rule),
    });
    if (!res.ok) throw new Error('Failed to create notification rule');
    return res.json();
  },

  generateAIMessage: async (eventType: string, payload: any, channel: string) => {
    const res = await fetch(`/api/v1/notification-os/ai-message?eventType=${eventType}&channel=${channel}`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify({ payload }),
    });
    if (!res.ok) throw new Error('Failed to generate AI message');
    return res.json();
  },

  sendDigest: async (userId: string, frequency: 'hourly' | 'daily' | 'weekly') => {
    const res = await fetch(`/api/v1/notification-os/digest?userId=${userId}&frequency=${frequency}`, {
      method: 'POST',
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to send digest');
    return res.json();
  },

  updatePreferences: async (userId: string, preferences: {
    channels?: Partial<Record<string, boolean>>;
    categories?: Record<string, boolean>;
    digestEnabled?: boolean;
    digestFrequency?: 'immediate' | 'hourly' | 'daily' | 'weekly';
    quietHours?: { start: string; end: string; timezone: string };
  }) => {
    const res = await fetch(`/api/v1/notification-os/preferences/${userId}`, {
      method: 'PUT',
      headers: { 
        'Content-Type': 'application/json',
        ...getLocalizationHeaders(),
      },
      body: JSON.stringify(preferences),
    });
    if (!res.ok) throw new Error('Failed to update preferences');
    return res.json();
  },

  getPreferences: async (userId: string) => {
    const res = await fetch(`/api/v1/notification-os/preferences/${userId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch preferences');
    return res.json();
  },

  getDeliveryAnalytics: async (timeRange: { start: string; end: string }, orgId?: string) => {
    const params = new URLSearchParams({ start: timeRange.start, end: timeRange.end });
    if (orgId) params.append('orgId', orgId);
    const res = await fetch(`/api/v1/notification-os/analytics?${params}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch delivery analytics');
    return res.json();
  },

  getNotificationTrends: async (orgId: string) => {
    const res = await fetch(`/api/v1/notification-os/notification-trends?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch notification trends');
    return res.json();
  },

  getChannelDistribution: async (orgId: string) => {
    const res = await fetch(`/api/v1/notification-os/channel-distribution?orgId=${orgId}`, {
      headers: getLocalizationHeaders(),
    });
    if (!res.ok) throw new Error('Failed to fetch channel distribution');
    return res.json();
  },
};
