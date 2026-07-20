/**
 * Scaling Manager
 * Manages horizontal scaling of platform instances
 */

import { getScalingConfig, defaultScalingPolicies, ScalingPolicy } from './scaling-config';
import { telemetry } from '../observability/telemetry';

export interface Instance {
  id: string;
  address: string;
  port: number;
  status: 'healthy' | 'unhealthy' | 'starting' | 'stopping';
  cpuUsage: number;
  memoryUsage: number;
  lastHealthCheck: Date;
  createdAt: Date;
}

export interface ScalingDecision {
  action: 'scale_up' | 'scale_down' | 'none';
  reason: string;
  targetInstances: number;
  currentInstances: number;
  timestamp: Date;
}

class ScalingManager {
  private config = getScalingConfig();
  private policies = defaultScalingPolicies;
  private instances: Map<string, Instance> = new Map();
  private currentInstances = this.config.minInstances;
  private lastScaleAction: Date = new Date();
  private metrics: Map<string, number> = new Map();

  constructor() {
    this.initialize();
  }

  /**
   * Initialize scaling manager
   */
  private initialize() {
    console.log('[ScalingManager] Initializing scaling manager');
    
    if (!this.config.enabled) {
      console.log('[ScalingManager] Scaling is disabled');
      return;
    }

    // Start health check interval
    setInterval(() => this.performHealthChecks(), this.config.healthCheckInterval * 1000);
    
    // Start scaling evaluation interval
    setInterval(() => this.evaluateScaling(), 60000); // Every minute
    
    // Initialize minimum instances
    this.scaleTo(this.config.minInstances);
    
    console.log('[ScalingManager] Scaling manager initialized');
  }

  /**
   * Evaluate scaling conditions
   */
  private async evaluateScaling(): Promise<ScalingDecision> {
    const decision: ScalingDecision = {
      action: 'none',
      reason: 'No scaling action needed',
      targetInstances: this.currentInstances,
      currentInstances: this.currentInstances,
      timestamp: new Date()
    };

    // Check cooldown period
    const timeSinceLastScale = Date.now() - this.lastScaleAction.getTime();
    const cooldown = this.lastScaleAction < new Date(Date.now() - this.config.scaleUpCooldown * 1000);

    if (!cooldown) {
      decision.reason = 'Cooldown period active';
      return decision;
    }

    // Evaluate each policy
    for (const policy of this.policies) {
      if (await this.evaluatePolicy(policy)) {
        const action = policy.actions[0];
        
        if (action.type === 'scale_up') {
          if (this.currentInstances < this.config.maxInstances) {
            decision.action = 'scale_up';
            decision.reason = `Policy '${policy.name}' triggered`;
            decision.targetInstances = Math.min(
              this.currentInstances + (action.value || 1),
              this.config.maxInstances
            );
            break;
          }
        } else if (action.type === 'scale_down') {
          if (this.currentInstances > this.config.minInstances) {
            decision.action = 'scale_down';
            decision.reason = `Policy '${policy.name}' triggered`;
            decision.targetInstances = Math.max(
              this.currentInstances - (action.value || 1),
              this.config.minInstances
            );
            break;
          }
        } else if (action.type === 'alert') {
          this.sendAlert(policy.name, action.target);
        }
      }
    }

    // Execute scaling decision
    if (decision.action !== 'none') {
      await this.executeScaling(decision);
    }

    return decision;
  }

  /**
   * Evaluate a scaling policy
   */
  private async evaluatePolicy(policy: ScalingPolicy): Promise<boolean> {
    for (const condition of policy.conditions) {
      const value = await this.getMetricValue(condition.metric);
      
      if (value === null) continue;

      let conditionMet = false;
      
      switch (condition.operator) {
        case '>':
          conditionMet = value > condition.threshold;
          break;
        case '<':
          conditionMet = value < condition.threshold;
          break;
        case '>=':
          conditionMet = value >= condition.threshold;
          break;
        case '<=':
          conditionMet = value <= condition.threshold;
          break;
        case '==':
          conditionMet = value === condition.threshold;
          break;
        case '!=':
          conditionMet = value !== condition.threshold;
          break;
      }

      if (conditionMet) {
        // Check duration
        // In production, this would check if condition has been met for the specified duration
        return true;
      }
    }

    return false;
  }

  /**
   * Get metric value
   */
  private async getMetricValue(metric: string): Promise<number | null> {
    // Map metric names to actual values
    switch (metric) {
      case 'cpu_usage':
        return this.getAverageCPU();
      case 'memory_usage':
        return this.getAverageMemory();
      case 'queue_size':
        return this.getQueueSize();
      case 'error_rate':
        return this.getErrorRate();
      default:
        return this.metrics.get(metric) || null;
    }
  }

  /**
   * Get average CPU usage across instances
   */
  private getAverageCPU(): number {
    const instances = Array.from(this.instances.values());
    if (instances.length === 0) return 0;

    const totalCPU = instances.reduce((sum, instance) => sum + instance.cpuUsage, 0);
    return totalCPU / instances.length;
  }

  /**
   * Get average memory usage across instances
   */
  private getAverageMemory(): number {
    const instances = Array.from(this.instances.values());
    if (instances.length === 0) return 0;

    const totalMemory = instances.reduce((sum, instance) => sum + instance.memoryUsage, 0);
    return totalMemory / instances.length;
  }

  /**
   * Get queue size
   */
  private getQueueSize(): number {
    // In production, this would query the actual queue
    return this.metrics.get('queue_size') || 0;
  }

  /**
   * Get error rate
   */
  private getErrorRate(): number {
    // In production, this would calculate from telemetry
    return this.metrics.get('error_rate') || 0;
  }

  /**
   * Execute scaling decision
   */
  private async executeScaling(decision: ScalingDecision) {
    console.log(`[ScalingManager] Executing scaling: ${decision.action} from ${decision.currentInstances} to ${decision.targetInstances}`);
    
    if (decision.action === 'scale_up') {
      await this.scaleTo(decision.targetInstances);
    } else if (decision.action === 'scale_down') {
      await this.scaleTo(decision.targetInstances);
    }

    this.lastScaleAction = new Date();
    
    // Record scaling event
    telemetry.recordMetric('scaling_actions', 1, {
      action: decision.action,
      reason: decision.reason
    });
  }

  /**
   * Scale to specific number of instances
   */
  private async scaleTo(targetInstances: number) {
    const diff = targetInstances - this.currentInstances;

    if (diff > 0) {
      // Scale up
      for (let i = 0; i < diff; i++) {
        await this.addInstance();
      }
    } else if (diff < 0) {
      // Scale down
      for (let i = 0; i < Math.abs(diff); i++) {
        await this.removeInstance();
      }
    }

    this.currentInstances = targetInstances;
  }

  /**
   * Add a new instance
   */
  private async addInstance(): Promise<Instance> {
    const instanceId = crypto.randomUUID();
    const instance: Instance = {
      id: instanceId,
      address: `instance-${instanceId}`,
      port: 3000,
      status: 'starting',
      cpuUsage: 0,
      memoryUsage: 0,
      lastHealthCheck: new Date(),
      createdAt: new Date()
    };

    this.instances.set(instanceId, instance);
    
    // In production, this would actually provision a new instance
    console.log(`[ScalingManager] Added instance ${instanceId}`);
    
    // Simulate instance startup
    setTimeout(() => {
      instance.status = 'healthy';
      console.log(`[ScalingManager] Instance ${instanceId} is now healthy`);
    }, 5000);

    return instance;
  }

  /**
   * Remove an instance
   */
  private async removeInstance(): Promise<void> {
    // Find the least loaded instance
    const instances = Array.from(this.instances.values())
      .filter(i => i.status === 'healthy')
      .sort((a, b) => a.cpuUsage - b.cpuUsage);

    if (instances.length === 0) {
      console.warn('[ScalingManager] No healthy instances to remove');
      return;
    }

    const instance = instances[0];
    instance.status = 'stopping';
    
    // In production, this would gracefully shut down the instance
    console.log(`[ScalingManager] Removing instance ${instance.id}`);
    
    setTimeout(() => {
      this.instances.delete(instance.id);
      console.log(`[ScalingManager] Instance ${instance.id} removed`);
    }, 5000);
  }

  /**
   * Perform health checks on all instances
   */
  private async performHealthChecks() {
    for (const instance of this.instances.values()) {
      try {
        // In production, this would make an actual HTTP request
        const isHealthy = await this.checkInstanceHealth(instance);
        
        if (isHealthy) {
          instance.status = 'healthy';
          instance.lastHealthCheck = new Date();
        } else {
          instance.status = 'unhealthy';
          console.warn(`[ScalingManager] Instance ${instance.id} is unhealthy`);
        }
      } catch (error) {
        instance.status = 'unhealthy';
        console.error(`[ScalingManager] Health check failed for instance ${instance.id}:`, error);
      }
    }
  }

  /**
   * Check individual instance health
   */
  private async checkInstanceHealth(instance: Instance): Promise<boolean> {
    // In production, this would make an HTTP request to the health check endpoint
    // For now, simulate health check
    return true;
  }

  /**
   * Update metric value
   */
  updateMetric(metric: string, value: number) {
    this.metrics.set(metric, value);
  }

  /**
   * Update instance metrics
   */
  updateInstanceMetrics(instanceId: string, cpuUsage: number, memoryUsage: number) {
    const instance = this.instances.get(instanceId);
    if (instance) {
      instance.cpuUsage = cpuUsage;
      instance.memoryUsage = memoryUsage;
    }
  }

  /**
   * Send alert
   */
  private sendAlert(policyName: string, target?: string) {
    console.log(`[ScalingManager] Alert: Policy '${policyName}' triggered. Target: ${target || 'default'}`);
    // In production, this would send to alerting system (PagerDuty, Slack, etc.)
  }

  /**
   * Get current scaling status
   */
  getStatus() {
    return {
      config: this.config,
      currentInstances: this.currentInstances,
      instances: Array.from(this.instances.values()),
      lastScaleAction: this.lastScaleAction,
      metrics: Object.fromEntries(this.metrics)
    };
  }

  /**
   * Add custom scaling policy
   */
  addPolicy(policy: ScalingPolicy) {
    this.policies.push(policy);
    console.log(`[ScalingManager] Added policy: ${policy.name}`);
  }

  /**
   * Remove scaling policy
   */
  removePolicy(policyName: string) {
    this.policies = this.policies.filter(p => p.name !== policyName);
    console.log(`[ScalingManager] Removed policy: ${policyName}`);
  }

  /**
   * Force scale to specific number of instances
   */
  async forceScale(targetInstances: number) {
    console.log(`[ScalingManager] Force scaling to ${targetInstances} instances`);
    await this.scaleTo(targetInstances);
  }
}

// Initialize scaling manager
export const scalingManager = new ScalingManager();
