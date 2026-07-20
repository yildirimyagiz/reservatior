/**
 * Horizontal Scaling Configuration
 * Provides configuration for scaling the platform across multiple instances
 */

export interface ScalingConfig {
  enabled: boolean;
  mode: 'horizontal' | 'vertical' | 'auto';
  minInstances: number;
  maxInstances: number;
  targetCPU: number;
  targetMemory: number;
  scaleUpCooldown: number; // seconds
  scaleDownCooldown: number; // seconds
  healthCheckInterval: number; // seconds
  healthCheckPath: string;
  healthCheckTimeout: number; // seconds
  loadBalancer: LoadBalancerConfig;
  queueScaling: QueueScalingConfig;
}

export interface LoadBalancerConfig {
  enabled: boolean;
  algorithm: 'round_robin' | 'least_connections' | 'ip_hash' | 'weighted';
  healthCheck: boolean;
  stickySessions: boolean;
  sessionAffinity: 'cookie' | 'ip' | 'none';
}

export interface QueueScalingConfig {
  enabled: boolean;
  threshold: number; // queue size threshold
  scaleUpFactor: number; // multiplier for scaling up
  scaleDownFactor: number; // multiplier for scaling down
  maxWorkersPerInstance: number;
}

export interface ScalingPolicy {
  name: string;
  conditions: ScalingCondition[];
  actions: ScalingAction[];
  cooldown: number;
}

export interface ScalingCondition {
  metric: string;
  operator: '>' | '<' | '>=' | '<=' | '==' | '!=';
  threshold: number;
  duration: number; // seconds
}

export interface ScalingAction {
  type: 'scale_up' | 'scale_down' | 'restart' | 'alert';
  value?: number;
  target?: string;
}

export const defaultScalingConfig: ScalingConfig = {
  enabled: true,
  mode: 'auto',
  minInstances: 2,
  maxInstances: 10,
  targetCPU: 70,
  targetMemory: 80,
  scaleUpCooldown: 300,
  scaleDownCooldown: 600,
  healthCheckInterval: 30,
  healthCheckPath: '/health',
  healthCheckTimeout: 5,
  loadBalancer: {
    enabled: true,
    algorithm: 'least_connections',
    healthCheck: true,
    stickySessions: false,
    sessionAffinity: 'none'
  },
  queueScaling: {
    enabled: true,
    threshold: 1000,
    scaleUpFactor: 2,
    scaleDownFactor: 0.5,
    maxWorkersPerInstance: 10
  }
};

export const defaultScalingPolicies: ScalingPolicy[] = [
  {
    name: 'cpu_scale_up',
    conditions: [
      { metric: 'cpu_usage', operator: '>', threshold: 80, duration: 300 }
    ],
    actions: [
      { type: 'scale_up', value: 1 }
    ],
    cooldown: 300
  },
  {
    name: 'cpu_scale_down',
    conditions: [
      { metric: 'cpu_usage', operator: '<', threshold: 30, duration: 600 }
    ],
    actions: [
      { type: 'scale_down', value: 1 }
    ],
    cooldown: 600
  },
  {
    name: 'memory_scale_up',
    conditions: [
      { metric: 'memory_usage', operator: '>', threshold: 85, duration: 300 }
    ],
    actions: [
      { type: 'scale_up', value: 1 }
    ],
    cooldown: 300
  },
  {
    name: 'queue_scale_up',
    conditions: [
      { metric: 'queue_size', operator: '>', threshold: 1000, duration: 60 }
    ],
    actions: [
      { type: 'scale_up', value: 2 }
    ],
    cooldown: 180
  },
  {
    name: 'error_rate_alert',
    conditions: [
      { metric: 'error_rate', operator: '>', threshold: 5, duration: 60 }
    ],
    actions: [
      { type: 'alert', target: 'ops_team' }
    ],
    cooldown: 300
  }
];

/**
 * Get scaling config from environment
 */
export function getScalingConfig(): ScalingConfig {
  return {
    enabled: process.env.SCALING_ENABLED !== 'false',
    mode: (process.env.SCALING_MODE as any) || 'auto',
    minInstances: parseInt(process.env.MIN_INSTANCES || '2'),
    maxInstances: parseInt(process.env.MAX_INSTANCES || '10'),
    targetCPU: parseInt(process.env.TARGET_CPU || '70'),
    targetMemory: parseInt(process.env.TARGET_MEMORY || '80'),
    scaleUpCooldown: parseInt(process.env.SCALE_UP_COOLDOWN || '300'),
    scaleDownCooldown: parseInt(process.env.SCALE_DOWN_COOLDOWN || '600'),
    healthCheckInterval: parseInt(process.env.HEALTH_CHECK_INTERVAL || '30'),
    healthCheckPath: process.env.HEALTH_CHECK_PATH || '/health',
    healthCheckTimeout: parseInt(process.env.HEALTH_CHECK_TIMEOUT || '5'),
    loadBalancer: {
      enabled: process.env.LB_ENABLED !== 'false',
      algorithm: (process.env.LB_ALGORITHM as any) || 'least_connections',
      healthCheck: process.env.LB_HEALTH_CHECK !== 'false',
      stickySessions: process.env.LB_STICKY_SESSIONS === 'true',
      sessionAffinity: (process.env.LB_SESSION_AFFINITY as any) || 'none'
    },
    queueScaling: {
      enabled: process.env.QUEUE_SCALING_ENABLED !== 'false',
      threshold: parseInt(process.env.QUEUE_THRESHOLD || '1000'),
      scaleUpFactor: parseFloat(process.env.QUEUE_SCALE_UP_FACTOR || '2'),
      scaleDownFactor: parseFloat(process.env.QUEUE_SCALE_DOWN_FACTOR || '0.5'),
      maxWorkersPerInstance: parseInt(process.env.MAX_WORKERS || '10')
    }
  };
}
