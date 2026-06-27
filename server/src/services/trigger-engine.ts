import { prisma } from "../lib/prisma";
import { SystemEventType, EventSeverity } from "@prisma/client";

type ActionType = "CREATE_TASK" | "SEND_NOTIFICATION" | "SEND_EMAIL" | "SEND_SMS" | "CALL_WEBHOOK" | "UPDATE_ENTITY" | "CREATE_LEAD" | "NOTIFY_AGENT" | "CHAIN_RULE" | "CUSTOM";

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
  }): Promise<{ event: unknown; executions: unknown[] }> {
    const event = await prisma.systemEvent.create({
      data: {
        orgId: params.orgId,
        eventType: params.eventType,
        severity: params.severity || "INFO",
        entityType: params.entityType || null,
        entityId: params.entityId || null,
        entityLabel: params.entityLabel || null,
        payload: params.payload || undefined,
        metadata: params.metadata || undefined,
        source: params.source || null,
      },
    });

    const matchedRules = await this.findMatchingRules(params.orgId, params.eventType);

    const executions: unknown[] = [];
    for (const rule of matchedRules) {
      try {
        const exec = await this.executeRule(rule, event, params.payload || {});
        executions.push(exec);
      } catch (err) {
        console.error(`[TriggerEngine] Rule ${rule.id} failed:`, err);
      }
    }

    return { event, executions };
  }

  private async findMatchingRules(orgId: string, eventType: SystemEventType) {
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
    return rules;
  }

  private async executeRule(
    rule: unknown,
    event: unknown,
    payload: Record<string, unknown>
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
        const result = await this.executeAction(action, r, ev, payload);
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
    payload: Record<string, unknown>
  ): Promise<unknown> {
    switch (action.type) {
      case "CREATE_TASK":
        return this.actionCreateTask(rule, action.config, payload);

      case "SEND_NOTIFICATION":
        return this.actionSendNotification(rule, action.config, payload);

      case "SEND_EMAIL":
        return this.actionSendEmail(rule, action.config, payload);

      case "CALL_WEBHOOK":
        return this.actionCallWebhook(rule, action.config, payload);

      case "NOTIFY_AGENT":
        return this.actionNotifyAgent(rule, action.config, payload);

      case "UPDATE_ENTITY":
        return this.actionUpdateEntity(rule, action.config, payload);

      case "CREATE_LEAD":
        return this.actionCreateLead(rule, action.config, payload);

      case "CUSTOM":
        return { type: "CUSTOM", config: action.config };

      default:
        return { type: "UNKNOWN", config: action.config };
    }
  }

  private async actionCreateTask(
    rule: { orgId: string; ruleName: string },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
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
      },
    });
    return { type: "CREATE_TASK", taskId: task.id };
  }

  private async actionSendNotification(
    rule: { orgId: string; notificationTemplateId: string | null },
    config: Record<string, unknown>,
    payload: Record<string, unknown>
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
    payload: Record<string, unknown>
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
    payload: Record<string, unknown>
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
    payload: Record<string, unknown>
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
      },
    });
    return { type: "CREATE_LEAD", leadId: lead.id };
  }

  private interpolate(template: string | null, payload: Record<string, unknown>): string {
    if (!template) return "";
    return template.replace(/\{\{(\w+(?:\.\w+)*)\}\}/g, (_, path) => {
      const value = getNestedValue(payload, path);
      return value !== undefined ? String(value) : `{{${path}}}`;
    });
  }
}

export const triggerEngine = new TriggerEngine();
