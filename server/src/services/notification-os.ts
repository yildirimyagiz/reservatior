/**
 * Notification OS Service
 * Central communication infrastructure
 */

import { prisma } from '../lib/prisma';
import { eventBus } from '../core/events/event-bus';
import { GeminiService } from './gemini';

export type NotificationChannel = 'email' | 'sms' | 'whatsapp' | 'push' | 'in_app' | 'telegram' | 'slack' | 'teams' | 'voice';

export interface NotificationRule {
  id: string;
  name: string;
  description: string;
  eventType: string;
  conditions: Record<string, any>;
  channels: NotificationChannel[];
  templateId?: string;
  priority: 'low' | 'medium' | 'high' | 'urgent';
  enabled: boolean;
  organizationId: string;
}

export interface NotificationTemplate {
  id: string;
  name: string;
  channel: NotificationChannel;
  subject?: string;
  body: string;
  variables: string[];
  language: string;
  organizationId: string;
}

export interface Notification {
  id: string;
  userId: string;
  type: string;
  title: string;
  body: string;
  channel: NotificationChannel;
  status: 'pending' | 'sent' | 'failed' | 'delivered';
  priority: 'low' | 'medium' | 'high' | 'urgent';
  scheduledFor?: Date;
  sentAt?: Date;
  deliveredAt?: Date;
  error?: string;
  metadata?: Record<string, any>;
  correlationId?: string;
  retryCount: number;
  countryCode?: string;
  language?: string;
  timezone?: string;
  createdAt: Date;
}

export interface UserNotificationPreferences {
  userId: string;
  channels: Partial<Record<NotificationChannel, boolean>>;
  categories: Record<string, boolean>;
  digestEnabled: boolean;
  digestFrequency: 'immediate' | 'hourly' | 'daily' | 'weekly';
  quietHours?: {
    start: string; // HH:mm
    end: string; // HH:mm
    timezone: string;
  };
}

class NotificationOSService {
  private queue: Map<string, Notification[]> = new Map();
  private processing = false;

  /**
   * Send notification
   */
  async send(data: {
    userId: string;
    type: string;
    title: string;
    body: string;
    channel: NotificationChannel;
    priority?: 'low' | 'medium' | 'high' | 'urgent';
    scheduledFor?: Date;
    metadata?: Record<string, any>;
    correlationId?: string;
    countryCode?: string;
    language?: string;
    timezone?: string;
  }) {
    const notification: Notification = {
      id: crypto.randomUUID(),
      userId: data.userId,
      type: data.type,
      title: data.title,
      body: data.body,
      channel: data.channel,
      status: 'pending',
      priority: data.priority || 'medium',
      scheduledFor: data.scheduledFor,
      metadata: data.metadata,
      correlationId: data.correlationId,
      retryCount: 0,
      countryCode: data.countryCode,
      language: data.language,
      timezone: data.timezone,
      createdAt: new Date()
    };

    // Check user preferences
    const preferences = await this.getUserPreferences(data.userId);
    if (!preferences.channels[data.channel]) {
      console.log(`[NotificationOS] User ${data.userId} has disabled ${data.channel}`);
      return null;
    }

    // Check quiet hours
    if (this.isQuietHours(preferences) && data.priority !== 'urgent') {
      // Schedule for after quiet hours
      notification.scheduledFor = this.calculateNextAvailableTime(preferences);
    }

    // Store notification
    const saved = await prisma.notification.create({
      data: notification
    });

    // Add to queue
    this.addToQueue(saved);

    // Publish event
    await eventBus.publish('notification.created', saved, 'NotificationOS');

    return saved;
  }

  /**
   * Send notification using template
   */
  async sendFromTemplate(templateId: string, userId: string, variables: Record<string, any>, channel?: NotificationChannel) {
    const template = await prisma.notificationTemplate.findUnique({
      where: { id: templateId }
    });

    if (!template) {
      throw new Error('Template not found');
    }

    // Render template
    const { subject, body } = this.renderTemplate(template, variables);

    return this.send({
      userId,
      type: template.name,
      title: subject || template.name,
      body,
      channel: channel || template.channel,
      metadata: { templateId, variables }
    });
  }

  /**
   * Create notification rule
   */
  async createRule(rule: Omit<NotificationRule, 'id'>) {
    const created = await prisma.notificationRule.create({
      data: rule as any
    });

    // Subscribe to event
    eventBus.subscribe(rule.eventType, async (message) => {
      if (this.evaluateConditions(rule.conditions, message.payload)) {
        await this.executeRule(created, message.payload);
      }
    });

    return created;
  }

  /**
   * Execute notification rule
   */
  private async executeRule(rule: NotificationRule, payload: any) {
    if (!rule.enabled) return;

    // Determine target users
    const userIds = await this.getTargetUsers(rule, payload);

    // Send notifications
    for (const channel of rule.channels) {
      for (const userId of userIds) {
        if (rule.templateId) {
          await this.sendFromTemplate(rule.templateId, userId, payload, channel);
        } else {
          await this.send({
            userId,
            type: rule.eventType,
            title: rule.name,
            body: rule.description,
            channel,
            priority: rule.priority,
            metadata: { ruleId: rule.id, payload }
          });
        }
      }
    }
  }

  /**
   * Generate AI-powered notification message
   */
  async generateAIMessage(eventType: string, payload: any, channel: NotificationChannel): Promise<{ title: string; body: string }> {
    try {
      const prompt = `
        Generate a ${channel} notification for this event:
        Event Type: ${eventType}
        Payload: ${JSON.stringify(payload)}
        
        Generate:
        1. A concise title (max 50 chars)
        2. A clear, actionable body message (max 200 chars)
        
        The message should be:
        - Professional and friendly
        - Action-oriented when appropriate
        - Clear about what happened and what to do next
        
        Return as JSON: { title: string, body: string }
      `;

      const response = await GeminiService.processHubSearch(prompt, { role: 'ADMIN' });
      return JSON.parse(response);
    } catch (error) {
      console.error('AI message generation failed:', error);
      return {
        title: eventType,
        body: JSON.stringify(payload)
      };
    }
  }

  /**
   * Send digest notification
   */
  async sendDigest(userId: string, frequency: 'hourly' | 'daily' | 'weekly') {
    const preferences = await this.getUserPreferences(userId);
    if (!preferences.digestEnabled || preferences.digestFrequency !== frequency) {
      return;
    }

    const timeRange = this.getTimeRange(frequency);
    
    const notifications = await prisma.notification.findMany({
      where: {
        userId,
        createdAt: { gte: timeRange.start, lte: timeRange.end },
        status: 'delivered'
      },
      orderBy: { createdAt: 'desc' }
    });

    if (notifications.length === 0) {
      return;
    }

    // Group by type
    const grouped = notifications.reduce((acc: Record<string, Notification[]>, n: Notification) => {
      if (!acc[n.type]) acc[n.type] = [];
      acc[n.type].push(n);
      return acc;
    }, {} as Record<string, Notification[]>);

    // Generate digest message
    const digest = await this.generateDigestMessage(grouped, frequency);

    await this.send({
      userId,
      type: 'digest',
      title: `Your ${frequency} digest`,
      body: digest,
      channel: 'email',
      priority: 'low'
    });
  }

  /**
   * Update user notification preferences
   */
  async updatePreferences(userId: string, preferences: Partial<UserNotificationPreferences>) {
    return prisma.userNotificationPreference.upsert({
      where: { userId },
      create: {
        userId,
        ...preferences,
        channels: preferences.channels || {},
        categories: preferences.categories || {},
        digestEnabled: preferences.digestEnabled ?? true,
        digestFrequency: preferences.digestFrequency || 'daily'
      },
      update: preferences
    });
  }

  /**
   * Get user notification preferences
   */
  async getUserPreferences(userId: string): Promise<UserNotificationPreferences> {
    const prefs = await prisma.userNotificationPreference.findUnique({
      where: { userId }
    });

    return prefs || {
      userId,
      channels: {
        email: true,
        sms: false,
        whatsapp: true,
        push: true,
        in_app: true,
        telegram: false,
        slack: false,
        teams: false,
        voice: false
      },
      categories: {},
      digestEnabled: true,
      digestFrequency: 'daily'
    };
  }

  /**
   * Get notification delivery analytics
   */
  async getDeliveryAnalytics(timeRange: { start: Date; end: Date }, orgId?: string) {
    const where: any = {
      createdAt: { gte: timeRange.start, lte: timeRange.end }
    };

    if (orgId) {
      where.user = { organizationId: orgId };
    }

    const notifications = await prisma.notification.findMany({ where });

    const byChannel = notifications.reduce((acc: Record<NotificationChannel, { sent: number; delivered: number; failed: number }>, n: Notification) => {
      if (!acc[n.channel]) acc[n.channel] = { sent: 0, delivered: 0, failed: 0 };
      acc[n.channel].sent++;
      if (n.status === 'delivered') acc[n.channel].delivered++;
      if (n.status === 'failed') acc[n.channel].failed++;
      return acc;
    }, {} as Record<NotificationChannel, { sent: number; delivered: number; failed: number }>);

    const byStatus = notifications.reduce((acc: Record<string, number>, n: Notification) => {
      acc[n.status] = (acc[n.status] || 0) + 1;
      return acc;
    }, {} as Record<string, number>);

    return {
      total: notifications.length,
      byChannel,
      byStatus,
      deliveryRate: notifications.length > 0 
        ? (byStatus.delivered || 0) / notifications.length 
        : 0
    };
  }

  /**
   * Process notification queue
   */
  private async processQueue() {
    if (this.processing) return;
    this.processing = true;

    try {
      const pending = await prisma.notification.findMany({
        where: {
          status: 'pending',
          OR: [
            { scheduledFor: null },
            { scheduledFor: { lte: new Date() } }
          ]
        },
        orderBy: [
          { priority: 'desc' },
          { createdAt: 'asc' }
        ],
        take: 100
      });

      for (const notification of pending) {
        await this.deliverNotification(notification);
      }
    } finally {
      this.processing = false;
    }
  }

  /**
   * Deliver notification
   */
  private async deliverNotification(notification: Notification) {
    try {
      // Channel-specific delivery logic
      switch (notification.channel) {
        case 'email':
          await this.sendEmail(notification);
          break;
        case 'sms':
          await this.sendSMS(notification);
          break;
        case 'whatsapp':
          await this.sendWhatsApp(notification);
          break;
        case 'push':
          await this.sendPush(notification);
          break;
        case 'in_app':
          await this.sendInApp(notification);
          break;
        default:
          console.log(`[NotificationOS] Channel ${notification.channel} not implemented`);
      }

      await prisma.notification.update({
        where: { id: notification.id },
        data: {
          status: 'sent',
          sentAt: new Date()
        }
      });

      await eventBus.publish('notification.sent', notification, 'NotificationOS');
    } catch (error) {
      console.error(`[NotificationOS] Failed to deliver notification ${notification.id}:`, error);
      
      await prisma.notification.update({
        where: { id: notification.id },
        data: {
          status: 'failed',
          error: String(error),
          retryCount: notification.retryCount + 1
        }
      });

      // Retry logic
      if (notification.retryCount < 3) {
        setTimeout(() => this.deliverNotification(notification), 1000 * Math.pow(2, notification.retryCount));
      }
    }
  }

  /**
   * Send email notification
   */
  private async sendEmail(notification: Notification) {
    // Integrate with email service (SendGrid, AWS SES, etc.)
    console.log(`[NotificationOS] Sending email to user ${notification.userId}: ${notification.title}`);
  }

  /**
   * Send SMS notification
   */
  private async sendSMS(notification: Notification) {
    // Integrate with SMS service (Twilio, etc.)
    console.log(`[NotificationOS] Sending SMS to user ${notification.userId}: ${notification.title}`);
  }

  /**
   * Send WhatsApp notification
   */
  private async sendWhatsApp(notification: Notification) {
    // Integrate with WhatsApp service
    console.log(`[NotificationOS] Sending WhatsApp to user ${notification.userId}: ${notification.title}`);
  }

  /**
   * Send push notification
   */
  private async sendPush(notification: Notification) {
    // Integrate with push service (FCM, APNs, etc.)
    console.log(`[NotificationOS] Sending push to user ${notification.userId}: ${notification.title}`);
  }

  /**
   * Send in-app notification
   */
  private async sendInApp(notification: Notification) {
    // Store in database for in-app display
    console.log(`[NotificationOS] Sending in-app to user ${notification.userId}: ${notification.title}`);
  }

  /**
   * Add to queue
   */
  private addToQueue(notification: Notification) {
    const priority = notification.priority;
    if (!this.queue.has(priority)) {
      this.queue.set(priority, []);
    }
    this.queue.get(priority)!.push(notification);
    
    // Trigger processing
    setTimeout(() => this.processQueue(), 0);
  }

  /**
   * Evaluate rule conditions
   */
  private evaluateConditions(conditions: Record<string, any>, payload: any): boolean {
    // Simple condition evaluation
    // In production, use a proper expression evaluator
    return Object.entries(conditions).every(([key, value]) => {
      const payloadValue = this.getNestedValue(payload, key);
      return payloadValue === value;
    });
  }

  /**
   * Get target users for rule
   */
  private async getTargetUsers(rule: NotificationRule, payload: any): Promise<string[]> {
    // In production, this would evaluate user targeting logic
    // For now, return from payload if available
    if (payload.userId) return [payload.userId];
    if (payload.userIds) return payload.userIds;
    return [];
  }

  /**
   * Render template
   */
  private renderTemplate(template: NotificationTemplate, variables: Record<string, any>): { subject?: string; body: string } {
    let body = template.body;
    let subject = template.subject;

    Object.entries(variables).forEach(([key, value]) => {
      const placeholder = `{{${key}}}`;
      body = body.replace(new RegExp(placeholder, 'g'), String(value));
      if (subject) {
        subject = subject.replace(new RegExp(placeholder, 'g'), String(value));
      }
    });

    return { subject, body };
  }

  /**
   * Check if current time is in quiet hours
   */
  private isQuietHours(preferences: UserNotificationPreferences): boolean {
    if (!preferences.quietHours) return false;

    const now = new Date();
    const currentTime = now.toLocaleTimeString('en-US', { 
      hour: '2-digit', 
      minute: '2-digit', 
      hour12: false,
      timeZone: preferences.quietHours.timezone
    });

    return currentTime >= preferences.quietHours.start && currentTime <= preferences.quietHours.end;
  }

  /**
   * Calculate next available time outside quiet hours
   */
  private calculateNextAvailableTime(preferences: UserNotificationPreferences): Date {
    if (!preferences.quietHours) return new Date();

    const now = new Date();
    const [endHour, endMinute] = preferences.quietHours.end.split(':').map(Number);
    
    const nextAvailable = new Date(now);
    nextAvailable.setHours(endHour, endMinute, 0, 0);
    
    if (nextAvailable <= now) {
      nextAvailable.setDate(nextAvailable.getDate() + 1);
    }

    return nextAvailable;
  }

  /**
   * Get time range for digest
   */
  private getTimeRange(frequency: 'hourly' | 'daily' | 'weekly'): { start: Date; end: Date } {
    const end = new Date();
    const start = new Date();

    switch (frequency) {
      case 'hourly':
        start.setHours(start.getHours() - 1);
        break;
      case 'daily':
        start.setDate(start.getDate() - 1);
        break;
      case 'weekly':
        start.setDate(start.getDate() - 7);
        break;
    }

    return { start, end };
  }

  /**
   * Generate digest message
   */
  private async generateDigestMessage(grouped: Record<string, Notification[]>, frequency: string): Promise<string> {
    const summary = Object.entries(grouped)
      .map(([type, notifications]) => `${type}: ${notifications.length}`)
      .join('\n');

    return `Here's your ${frequency} digest:\n\n${summary}`;
  }

  /**
   * Get nested value from object
   */
  private getNestedValue(obj: any, path: string): any {
    return path.split('.').reduce((current, key) => current?.[key], obj);
  }
}

export const notificationOSService = new NotificationOSService();
