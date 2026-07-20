import { prisma } from "../lib/prisma";
import { SystemEventType, EventSeverity } from "@prisma/client";

type ActionType = "CREATE_TASK" | "SEND_NOTIFICATION" | "SEND_EMAIL" | "SEND_SMS" | "CALL_WEBHOOK" | "UPDATE_ENTITY" | "CREATE_LEAD" | "NOTIFY_AGENT" | "CHAIN_RULE" | "CUSTOM" | "RELEASE_ESCROW" | "TRACK_ANALYTICS_METRIC" | "GENERATE_DOCUMENT" | "REQUEST_SIGNATURE" | "SEND_NOTIFICATION_OS" | "UPDATE_USER_PERMISSIONS" | "CREATE_API_KEY" | "TRANSLATE_CONTENT" | "UPDATE_COUNTRY_CONFIG";

interface ActionConfig {
  type: ActionType;
  config: Record<string, unknown>;
}

interface ConditionGroup {
  operator: "AND" | "OR";
  conditions: Condition[];
}

interface Condition {
  field: string;
  operator: "EQ" | "NEQ" | "GT" | "GTE" | "LT" | "LTE" | "IN" | "NOT_IN" | "CONTAINS" | "EXISTS" | "NOT_EXISTS";
  value: unknown;
}

function getNestedValue(obj: Record<string, unknown>, path: string): unknown {
  return path.split(".").reduce((acc: unknown, part: string) => {
    if (acc && typeof acc === "object") return (acc as Record<string, unknown>)[part];
    return undefined;
  }, obj);
}

function evaluateCondition(condition: Condition, payload: Record<string, unknown>): boolean {
  const actual = getNestedValue(payload, condition.field);
  const expected = condition.value;

  switch (condition.operator) {
    case "EQ": return actual === expected;
    case "NEQ": return actual !== expected;
    case "GT": return typeof actual === "number" && typeof expected === "number" && actual > expected;
    case "GTE": return typeof actual === "number" && typeof expected === "number" && actual >= expected;
    case "LT": return typeof actual === "number" && typeof expected === "number" && actual < expected;
    case "LTE": return typeof actual === "number" && typeof expected === "number" && actual <= expected;
    case "IN": return Array.isArray(expected) && expected.includes(actual);
    case "NOT_IN": return Array.isArray(expected) && !expected.includes(actual);
    case "CONTAINS": return typeof actual === "string" && typeof expected === "string" && actual.includes(expected);
    case "EXISTS": return actual !== undefined && actual !== null;
    case "NOT_EXISTS": return actual === undefined || actual === null;
    default: return true;
  }
}

function evaluateConditionGroup(group: ConditionGroup, payload: Record<string, unknown>): boolean {
  if (group.operator === "AND") return group.conditions.every(c => evaluateConditionGroup(c as unknown as ConditionGroup, payload) || evaluateCondition(c as Condition, payload));
  return group.conditions.some(c => evaluateConditionGroup(c as unknown as ConditionGroup, payload) || evaluateCondition(c as Condition, payload));
}

function evaluateConditions(conditions: unknown, payload: Record<string, unknown>): boolean {
  if (!conditions) return true;
  if (typeof conditions === "object" && "conditions" in (conditions as ConditionGroup)) {
    return evaluateConditionGroup(conditions as ConditionGroup, payload);
  }
  return true;
}

export class TriggerEngine {
  async emit(params: {
    orgId: string;
    eventType: SystemEventType;
    severity?: EventSeverity;
    entityType?: string;
    entityId?: string;
    entityLabel?: string;
    payload?: Record<string, unknown>;
    metadata?: Record<string, unknown>;
    source?: string;
    countryCode?: string;
    language?: string;
    currency?: string;
    timezone?: string;
  }): Promise<{ event: unknown; executions: unknown[] }> {
    const event = await prisma.systemEvent.create({
      data: {
        orgId: params.orgId,
        eventType: params.eventType,
        severity: params.severity || "INFO",
        entityType: params.entityType || null,
        entityId: params.entityId || null,
        entityLabel: params.entityLabel || null,
        payload: {
          ...(params.payload || {}),
          countryCode: params.countryCode,
          language: params.language,
          currency: params.currency,
          timezone: params.timezone,
        },
        metadata: params.metadata || undefined,
        source: params.source || null,
      },
    });

    const matchedRules = await this.findMatchingRules(params.orgId, params.eventType, params.countryCode);

    const executions: unknown[] = [];
    for (const rule of matchedRules) {
      try {
        const exec = await this.executeRule(rule, event, params.payload || {}, {
          countryCode: params.countryCode,
          language: params.language,
          currency: params.currency,
          timezone: params.timezone,
        });
        executions.push(exec);
      } catch (err) {
        console.error(`[TriggerEngine] Rule ${rule.id} failed:`, err);
      }
    }

    return { event, executions };
  }

  private async findMatchingRules(orgId: string, eventType: SystemEventType, countryCode?: string) {
    const rules = await prisma.automationRule.findMany({
      where: {
        orgId,
        isActive: true,
        eventTypes: { has: eventType },
      },
      include: {
        notificationTemplate: true,
        chainRule: true,
      },
    });
    
    // Filter by country code if specified
    if (countryCode) {
      return rules.filter(rule => {
        const ruleCountryCode = (rule.conditions as any)?.countryCode;
        return !ruleCountryCode || ruleCountryCode === countryCode;
      });
    }
    
    return rules;
  }

  private async executeRule(
    rule: unknown,
    event: unknown,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ): Promise<unknown> {
    const r = rule as {
      id: string;
      orgId: string;
      conditions: unknown;
      actions: unknown;
      cooldownMinutes: number | null;
      maxExecutions: number | null;
      executionCount: number;
      lastExecutedAt: Date | null;
      chainRuleId: string | null;
      notificationTemplateId: string | null;
      chainRule: unknown | null;
      notificationTemplate: unknown | null;
      ruleName: string;
    };
    const ev = event as { id: string; eventType: string };

    if (r.maxExecutions !== null && r.executionCount >= r.maxExecutions) {
      return { skipped: true, reason: "max_executions_reached" };
    }

    if (r.cooldownMinutes !== null && r.lastExecutedAt) {
      const elapsed = (Date.now() - r.lastExecutedAt.getTime()) / 60000;
      if (elapsed < r.cooldownMinutes) {
        return { skipped: true, reason: "cooldown_active" };
      }
    }

    if (!evaluateConditions(r.conditions, payload)) {
      return { skipped: true, reason: "conditions_not_met" };
    }

    const start = Date.now();

    const actions = (r.actions as ActionConfig[]) || [];
    const results: unknown[] = [];

    for (const action of actions) {
      try {
        const result = await this.executeAction(action, r, ev, payload, context);
        results.push(result);
      } catch (err) {
        results.push({ action: action.type, error: err instanceof Error ? err.message : String(err) });
      }
    }

    const execution = await prisma.automationExecution.create({
      data: {
        orgId: r.orgId,
        ruleId: r.id,
        eventId: ev.id,
        triggerEvent: { type: ev.eventType, payload },
        executionData: { actions: r.actions },
        resultData: { results },
        status: results.some(rr => (rr as { error?: string }).error) ? "PARTIAL" : "COMPLETED",
        processingTimeMs: Date.now() - start,
      },
    });

    await prisma.automationRule.update({
      where: { id: r.id },
      data: {
        lastExecutedAt: new Date(),
        executionCount: { increment: 1 },
      },
    });

    if (r.chainRuleId && r.chainRule) {
      const cr = r.chainRule as { id: string; orgId: string; isActive: boolean };
      if (cr.isActive) {
        await this.executeRule(r.chainRule, event, payload);
      }
    }

    return { executionId: execution.id, results };
  }

  private async executeAction(
    action: ActionConfig,
    rule: { id: string; orgId: string; ruleName: string; notificationTemplateId: string | null },
    event: { id: string; eventType: string },
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ): Promise<unknown> {
    switch (action.type) {
      case "CREATE_TASK":
        return this.actionCreateTask(rule, action.config, payload, context);

      case "SEND_NOTIFICATION":
        return this.actionSendNotification(rule, action.config, payload, context);

      case "SEND_EMAIL":
        return this.actionSendEmail(rule, action.config, payload, context);

      case "CALL_WEBHOOK":
        return this.actionCallWebhook(rule, action.config, payload);

      case "NOTIFY_AGENT":
        return this.actionNotifyAgent(rule, action.config, payload, context);

      case "UPDATE_ENTITY":
        return this.actionUpdateEntity(rule, action.config, payload);

      case "CREATE_LEAD":
        return this.actionCreateLead(rule, action.config, payload, context);

      case "RELEASE_ESCROW":
        return this.actionReleaseEscrow(rule, action.config, payload);

      case "TRACK_ANALYTICS_METRIC":
        return this.actionTrackAnalyticsMetric(rule, action.config, payload, context);

      case "GENERATE_DOCUMENT":
        return this.actionGenerateDocument(rule, action.config, payload, context);

      case "REQUEST_SIGNATURE":
        return this.actionRequestSignature(rule, action.config, payload);

      case "SEND_NOTIFICATION_OS":
        return this.actionSendNotificationOS(rule, action.config, payload, context);

      case "UPDATE_USER_PERMISSIONS":
        return this.actionUpdateUserPermissions(rule, action.config, payload);

      case "CREATE_API_KEY":
        return this.actionCreateAPIKey(rule, action.config, payload);

      case "TRANSLATE_CONTENT":
        return this.actionTranslateContent(rule, action.config, payload, context);

      case "UPDATE_COUNTRY_CONFIG":
        return this.actionUpdateCountryConfig(rule, action.config, payload);

      case "CUSTOM":
        return { type: "CUSTOM", config: action.config };

      default:
        return { type: "UNKNOWN", config: action.config };
    }
  }

  private async actionCreateTask(
    rule: { orgId: string; ruleName: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; timezone?: string }
  ) {
    const task = await prisma.task.create({
      data: {
        orgId: rule.orgId,
        type: (config.type as string) || "OTHER",
        title: this.interpolate((config.title as string) || `Task: ${rule.ruleName}`, payload),
        description: this.interpolate((config.description as string) || null, payload),
        priority: (config.priority as string) || "MEDIUM",
        assignedToUserId: (config.assignToUserId as string) || null,
        propertyId: (payload.propertyId as string) || null,
        countryCode: context?.countryCode,
        language: context?.language,
        currency: context?.currency,
      },
    });
    return { type: "CREATE_TASK", taskId: task.id };
  }

  private async actionSendNotification(
    rule: { orgId: string; notificationTemplateId: string | null },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ) {
    const templateId = config.templateId as string || rule.notificationTemplateId;
    if (!templateId) return { type: "SEND_NOTIFICATION", skipped: true, reason: "no_template" };

    const template = await prisma.notificationTemplate.findUnique({ where: { id: templateId } });
    if (!template) return { type: "SEND_NOTIFICATION", skipped: true, reason: "template_not_found" };

    const body = this.interpolate(template.body, payload);
    const subject = template.subject ? this.interpolate(template.subject, payload) : undefined;

    const notification = await prisma.notification.create({
      data: {
        orgId: rule.orgId,
        type: "AUTOMATION",
        title: subject || body.slice(0, 100),
        message: body,
        channel: template.channel,
        metadata: { templateId, ruleTriggered: true },
      },
    });
    return { type: "SEND_NOTIFICATION", notificationId: notification.id, channel: template.channel };
  }

  private async actionSendEmail(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ) {
    const to = this.interpolate((config.to as string) || "", payload);
    const subject = this.interpolate((config.subject as string) || "Automation Notification", payload);
    const body = this.interpolate((config.body as string) || "", payload);

    const notification = await prisma.notification.create({
      data: {
        orgId: rule.orgId,
        type: "AUTOMATION",
        title: subject,
        message: body,
        channel: "EMAIL",
        metadata: { to, config, triggeredBy: "trigger_engine" },
      },
    });
    return { type: "SEND_EMAIL", notificationId: notification.id, to };
  }

  private async actionCallWebhook(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
  ) {
    const url = config.url as string;
    if (!url) return { type: "CALL_WEBHOOK", skipped: true, reason: "no_url" };

    const body = {
      event: "trigger_engine",
      ruleId: rule.orgId,
      timestamp: new Date().toISOString(),
      payload,
      config,
    };

    try {
      const response = await fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      return { type: "CALL_WEBHOOK", statusCode: response.status };
    } catch (err) {
      return { type: "CALL_WEBHOOK", error: err instanceof Error ? err.message : String(err) };
    }
  }

  private async actionNotifyAgent(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ) {
    const agentId = (config.agentId as string) || (payload.agentId as string) || (payload.assignedToUserId as string);
    if (!agentId) return { type: "NOTIFY_AGENT", skipped: true, reason: "no_agent" };

    const message = this.interpolate((config.message as string) || "You have a new notification from automation rule", payload);

    const notification = await prisma.notification.create({
      data: {
        orgId: rule.orgId,
        userId: agentId,
        type: "AUTOMATION",
        title: "Agent Notification",
        message,
        channel: "IN_APP",
        metadata: { config, triggeredBy: "trigger_engine" },
      },
    });
    return { type: "NOTIFY_AGENT", notificationId: notification.id, agentId };
  }

  private async actionUpdateEntity(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
  ) {
    const entityType = config.entityType as string;
    const entityId = config.entityId as string || (payload.entityId as string) || (payload.id as string);
    const updates = config.updates as Record<string, unknown>;

    if (!entityType || !entityId || !updates) {
      return { type: "UPDATE_ENTITY", skipped: true, reason: "missing_params" };
    }

    const modelMap: Record<string, unknown> = {
      property: prisma.property,
      listing: prisma.listing,
      task: prisma.task,
      lead: prisma.lead,
      booking: prisma.booking,
      contract: prisma.contract,
    };

    const model = modelMap[entityType];
    if (!model) return { type: "UPDATE_ENTITY", skipped: true, reason: `unknown_entity: ${entityType}` };

    await (model as { update: (args: { where: { id: string }; data: Record<string, unknown> }) => Promise<unknown> }).update({
      where: { id: entityId },
      data: updates,
    });

    return { type: "UPDATE_ENTITY", entityType, entityId, updates };
  }

  private async actionCreateLead(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ) {
    const lead = await prisma.lead.create({
      data: {
        orgId: rule.orgId,
        name: this.interpolate((config.name as string) || (payload.name as string) || "Auto Lead", payload),
        email: this.interpolate((config.email as string) || (payload.email as string) || null, payload),
        phone: this.interpolate((config.phone as string) || (payload.phone as string) || null, payload),
        source: (config.source as string) || "AUTOMATION",
        status: "NEW",
        metadata: { triggeredBy: rule.orgId, ruleId: rule.orgId, payload },
        countryCode: context?.countryCode,
        language: context?.language,
        currency: context?.currency,
      },
    });
    return { type: "CREATE_LEAD", leadId: lead.id };
  }

  private async actionReleaseEscrow(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
  ) {
    const escrowId = (config.escrowId as string) || (payload.escrowId as string);
    const triggerEvent = (config.triggerEvent as string) || (payload.triggerEvent as string);
    
    if (!escrowId || !triggerEvent) {
      return { type: "RELEASE_ESCROW", skipped: true, reason: "missing_escrow_or_event" };
    }

    const { AdvancedEscrowRouter } = await import("./financial/advanced-escrow-router");
    
    try {
      const result = await AdvancedEscrowRouter.routeFundsOnTrigger(escrowId, triggerEvent as any);
      return { type: "RELEASE_ESCROW", status: result?.status || "SUCCESS" };
    } catch (e: any) {
      return { type: "RELEASE_ESCROW", error: e.message };
    }
  }

  private interpolate(template: string | null, payload: Record<string, unknown>): string {
    if (!template) return "";
    return template.replace(/\{\{(\w+(?:\.\w+)*)\}\}/g, (_, path) => {
      const value = getNestedValue(payload, path);
      return value !== undefined ? String(value) : `{{${path}}}`;
    });
  }

  // Analytics OS integration
  private async actionTrackAnalyticsMetric(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; timezone?: string }
  ) {
    const { analyticsOSService } = await import("./analytics-os");
    const metricType = (config.metricType as string) || "custom";
    const value = (config.value as number) || 1;
    const dimensions = (config.dimensions as Record<string, unknown>) || {};

    const metric = await analyticsOSService.trackMetric(
      metricType, 
      value, 
      { ...dimensions, ...payload },
      context?.countryCode,
      context?.language,
      context?.currency
    );
    return { type: "TRACK_ANALYTICS_METRIC", metricId: metric.id };
  }

  // Document OS integration
  private async actionGenerateDocument(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; timezone?: string }
  ) {
    const { documentOSService } = await import("./document-os");
    const templateId = config.templateId as string;
    const variables = (config.variables as Record<string, unknown>) || payload;

    if (!templateId) return { type: "GENERATE_DOCUMENT", skipped: true, reason: "no_template_id" };

    const document = await documentOSService.createFromTemplate(templateId, variables, rule.orgId);
    return { type: "GENERATE_DOCUMENT", documentId: document.id };
  }

  private async actionRequestSignature(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
  ) {
    const { documentOSService } = await import("./document-os");
    const documentId = (config.documentId as string) || (payload.documentId as string);
    const signers = (config.signers as Array<{ email: string; name: string }>) || [];

    if (!documentId || signers.length === 0) {
      return { type: "REQUEST_SIGNATURE", skipped: true, reason: "missing_document_or_signers" };
    }

    const signatureRequests = await documentOSService.requestSignature(documentId, signers);
    return { type: "REQUEST_SIGNATURE", signatureRequestIds: signatureRequests.map((sr: any) => sr.id) };
  }

  // Notification OS integration
  private async actionSendNotificationOS(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ) {
    const { notificationOSService } = await import("./notification-os");
    const userId = (config.userId as string) || (payload.userId as string);
    const type = (config.type as string) || "automation";
    const title = this.interpolate((config.title as string) || "Notification", payload);
    const body = this.interpolate((config.body as string) || "", payload);
    const channel = (config.channel as any) || "in_app";

    if (!userId) return { type: "SEND_NOTIFICATION_OS", skipped: true, reason: "no_user_id" };

    const notification = await notificationOSService.send({ 
      userId, 
      type, 
      title, 
      body, 
      channel,
      countryCode: context?.countryCode,
      language: context?.language,
      timezone: context?.timezone,
    });
    return { type: "SEND_NOTIFICATION_OS", notificationId: notification?.id };
  }

  // Identity OS integration
  private async actionUpdateUserPermissions(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
  ) {
    const { identityOSService } = await import("./identity-os");
    const userId = (config.userId as string) || (payload.userId as string);
    const roleId = (config.roleId as string) || (payload.roleId as string);

    if (!userId || !roleId) {
      return { type: "UPDATE_USER_PERMISSIONS", skipped: true, reason: "missing_user_or_role" };
    }

    const assignment = await identityOSService.assignRoleToUser(userId, roleId, rule.orgId);
    return { type: "UPDATE_USER_PERMISSIONS", assignmentId: assignment.id };
  }

  private async actionCreateAPIKey(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
  ) {
    const { identityOSService } = await import("./identity-os");
    const userId = (config.userId as string) || (payload.userId as string);
    const name = (config.name as string) || "Automation API Key";
    const scopes = (config.scopes as string[]) || ["read"];
    const expiresAt = config.expiresAt ? new Date(config.expiresAt as string) : undefined;

    if (!userId) return { type: "CREATE_API_KEY", skipped: true, reason: "no_user_id" };

    const { apiKey, key } = await identityOSService.createAPIKey({ name, userId, organizationId: rule.orgId, scopes, expiresAt });
    return { type: "CREATE_API_KEY", apiKeyId: apiKey.id, key };
  }

  // Localization OS integration
  private async actionTranslateContent(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>,
    context?: { countryCode?: string; language?: string; currency?: string; timezone?: string }
  ) {
    const { localizationOSService } = await import("./localization-os");
    const key = (config.key as string) || (payload.key as string);
    const targetLanguage = (config.targetLanguage as string) || context?.language || "en";
    const contextStr = (config.context as string) || undefined;

    if (!key) return { type: "TRANSLATE_CONTENT", skipped: true, reason: "no_key" };

    const translated = await localizationOSService.translateContent(key, targetLanguage, contextStr);
    return { type: "TRANSLATE_CONTENT", key, targetLanguage, translated };
  }

  private async actionUpdateCountryConfig(
    rule: { orgId: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
  ) {
    const { localizationOSService } = await import("./localization-os");
    const countryCode = (config.countryCode as string) || (payload.countryCode as string);
    const updates = (config.updates as Record<string, unknown>) || {};

    if (!countryCode) return { type: "UPDATE_COUNTRY_CONFIG", skipped: true, reason: "no_country_code" };

    const configData = await prisma.countryConfig.findUnique({ where: { code: countryCode } });
    if (!configData) return { type: "UPDATE_COUNTRY_CONFIG", skipped: true, reason: "country_not_found" };

    const updated = await prisma.countryConfig.update({
      where: { code: countryCode },
      data: updates,
    });
    return { type: "UPDATE_COUNTRY_CONFIG", countryCode, updated };
  }
}

export const triggerEngine = new TriggerEngine();
