export const OperationsOSPermissions = {
  TASK_CREATE: 'task.create',
  TASK_READ: 'task.read',
  TASK_UPDATE: 'task.update',
  TASK_DELETE: 'task.delete',
  TASK_ASSIGN: 'task.assign',
  TASK_COMPLETE: 'task.complete',
  WORKFLOW_CREATE: 'workflow.create',
  WORKFLOW_READ: 'workflow.read',
  WORKFLOW_UPDATE: 'workflow.update',
  WORKFLOW_DELETE: 'workflow.delete',
  OPERATIONS_ADMIN_ALL: 'operations.admin.all',
} as const;

export type OperationsOSPermission = typeof OperationsOSPermissions[keyof typeof OperationsOSPermissions];

export const OperationsOSRolePermissions: Record<string, OperationsOSPermission[]> = {
  user: [OperationsOSPermissions.TASK_READ, OperationsOSPermissions.WORKFLOW_READ],
  manager: [OperationsOSPermissions.TASK_CREATE, OperationsOSPermissions.TASK_READ, OperationsOSPermissions.TASK_UPDATE, OperationsOSPermissions.TASK_ASSIGN, OperationsOSPermissions.TASK_COMPLETE, OperationsOSPermissions.WORKFLOW_CREATE, OperationsOSPermissions.WORKFLOW_READ, OperationsOSPermissions.WORKFLOW_UPDATE],
  admin: [OperationsOSPermissions.OPERATIONS_ADMIN_ALL],
};

export function hasOperationsPermission(userPermissions: string[], requiredPermission: OperationsOSPermission): boolean {
  return userPermissions.includes(OperationsOSPermissions.OPERATIONS_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
