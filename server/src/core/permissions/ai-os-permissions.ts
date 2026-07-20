export const AIOSPermissions = {
  MODEL_CREATE: 'model.create',
  MODEL_READ: 'model.read',
  MODEL_UPDATE: 'model.update',
  MODEL_DELETE: 'model.delete',
  MODEL_TRAIN: 'model.train',
  MODEL_DEPLOY: 'model.deploy',
  PREDICTION_MAKE: 'prediction.make',
  PREDICTION_READ: 'prediction.read',
  INSIGHT_GENERATE: 'insight.generate',
  INSIGHT_READ: 'insight.read',
  AI_ADMIN_ALL: 'ai.admin.all',
} as const;

export type AIOSPermission = typeof AIOSPermissions[keyof typeof AIOSPermissions];

export const AIOSRolePermissions: Record<string, AIOSPermission[]> = {
  user: [AIOSPermissions.PREDICTION_READ, AIOSPermissions.INSIGHT_READ],
  developer: [AIOSPermissions.MODEL_CREATE, AIOSPermissions.MODEL_READ, AIOSPermissions.MODEL_TRAIN, AIOSPermissions.PREDICTION_MAKE, AIOSPermissions.INSIGHT_GENERATE],
  admin: [AIOSPermissions.AI_ADMIN_ALL],
};

export function hasAIPermission(userPermissions: string[], requiredPermission: AIOSPermission): boolean {
  return userPermissions.includes(AIOSPermissions.AI_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
