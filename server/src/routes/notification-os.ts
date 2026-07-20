/**
 * Notification OS API Routes
 */

import { Elysia, t } from 'elysia';
import { notificationOSService } from '../services/notification-os';

export const notificationOSRoutes = new Elysia({ prefix: '/notifications' })
  /**
   * POST /api/notifications/send
   * Send notification
   */
  .post('/send', async ({ body, set }) => {
    try {
      const notification = await notificationOSService.send(body);
      return notification;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to send notification' };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      type: t.String(),
      title: t.String(),
      body: t.String(),
      channel: t.Union([
        t.Literal('email'),
        t.Literal('sms'),
        t.Literal('whatsapp'),
        t.Literal('push'),
        t.Literal('in_app'),
        t.Literal('telegram'),
        t.Literal('slack'),
        t.Literal('teams'),
        t.Literal('voice')
      ]),
      priority: t.Optional(t.Union([
        t.Literal('low'),
        t.Literal('medium'),
        t.Literal('high'),
        t.Literal('urgent')
      ])),
      scheduledFor: t.Optional(t.String()),
      metadata: t.Optional(t.Record(t.String, t.Any())),
      correlationId: t.Optional(t.String())
    })
  })

  /**
   * POST /api/notifications/from-template
   * Send notification from template
   */
  .post('/from-template', async ({ body, set }) => {
    try {
      const notification = await notificationOSService.sendFromTemplate(
        body.templateId,
        body.userId,
        body.variables,
        body.channel
      );
      return notification;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to send notification from template' };
    }
  }, {
    body: t.Object({
      templateId: t.String(),
      userId: t.String(),
      variables: t.Record(t.String, t.Any()),
      channel: t.Optional(t.Union([
        t.Literal('email'),
        t.Literal('sms'),
        t.Literal('whatsapp'),
        t.Literal('push'),
        t.Literal('in_app'),
        t.Literal('telegram'),
        t.Literal('slack'),
        t.Literal('teams'),
        t.Literal('voice')
      ]))
    })
  })

  /**
   * POST /api/notifications/rules
   * Create notification rule
   */
  .post('/rules', async ({ body, set }) => {
    try {
      const rule = await notificationOSService.createRule(body);
      return rule;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to create notification rule' };
    }
  }, {
    body: t.Object({
      name: t.String(),
      description: t.String(),
      eventType: t.String(),
      conditions: t.Record(t.String, t.Any()),
      channels: t.Array(t.Union([
        t.Literal('email'),
        t.Literal('sms'),
        t.Literal('whatsapp'),
        t.Literal('push'),
        t.Literal('in_app'),
        t.Literal('telegram'),
        t.Literal('slack'),
        t.Literal('teams'),
        t.Literal('voice')
      ])),
      templateId: t.Optional(t.String()),
      priority: t.Union([
        t.Literal('low'),
        t.Literal('medium'),
        t.Literal('high'),
        t.Literal('urgent')
      ]),
      enabled: t.Boolean(),
      organizationId: t.String()
    })
  })

  /**
   * PUT /api/notifications/preferences
   * Update user notification preferences
   */
  .put('/preferences', async ({ body, set }) => {
    try {
      const preferences = await notificationOSService.updatePreferences(
        body.userId,
        body.preferences
      );
      return preferences;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to update preferences' };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      preferences: t.Record(t.String, t.Any())
    })
  })

  /**
   * GET /api/notifications/preferences/:userId
   * Get user notification preferences
   */
  .get('/preferences/:userId', async ({ params, set }) => {
    try {
      const preferences = await notificationOSService.getUserPreferences(params.userId);
      return preferences;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get preferences' };
    }
  })

  /**
   * GET /api/notifications/analytics
   * Get notification delivery analytics
   */
  .get('/analytics', async ({ query, set }) => {
    try {
      const timeRange = query.start && query.end ? {
        start: new Date(query.start),
        end: new Date(query.end)
      } : {
        start: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000),
        end: new Date()
      };

      const analytics = await notificationOSService.getDeliveryAnalytics(
        timeRange,
        query.orgId
      );
      return analytics;
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to get analytics' };
    }
  })

  /**
   * POST /api/notifications/digest
   * Send digest notification
   */
  .post('/digest', async ({ body, set }) => {
    try {
      await notificationOSService.sendDigest(
        body.userId,
        body.frequency
      );
      return { success: true };
    } catch (error) {
      set.status = 500;
      return { error: 'Failed to send digest' };
    }
  }, {
    body: t.Object({
      userId: t.String(),
      frequency: t.Union([
        t.Literal('hourly'),
        t.Literal('daily'),
        t.Literal('weekly')
      ])
    })
  });
