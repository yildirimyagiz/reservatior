import jsonLogic from 'json-logic-js';

export interface PolicyRule {
  id: string;
  name: string;
  type: string;
  condition: any; // JSON Logic condition
  result: any;    // JSON Logic result or static value
  priority: number;
}

export class RuleEngine {
  private rules: PolicyRule[] = [];

  constructor(initialRules: PolicyRule[] = []) {
    this.rules = initialRules;
  }

  /**
   * Evaluates a set of rules against the given context and returns the matching result.
   * If multiple rules match, the one with the highest priority wins.
   */
  public evaluate(context: Record<string, any>, ruleType: string): any | null {
    const applicableRules = this.rules
      .filter(r => r.type === ruleType)
      .sort((a, b) => b.priority - a.priority); // Highest priority first

    for (const rule of applicableRules) {
      if (jsonLogic.apply(rule.condition, context)) {
        // If result itself is a logic expression that needs context, evaluate it.
        // For simplicity, we just return the result value directly here,
        // but it could be expanded to support dynamic results.
        return rule.result;
      }
    }

    return null; // No rule matched
  }

  public addRule(rule: PolicyRule) {
    this.rules.push(rule);
  }

  public getRules() {
    return this.rules;
  }
}
