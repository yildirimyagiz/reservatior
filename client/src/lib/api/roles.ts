import { apiClient } from "./client";

export interface Roles {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  permissions: string[];
  status: "ACTIVE" | "INACTIVE";
  isSystem: boolean;
  createdAt: string;
  updatedAt: string;
}

export const rolesApi = {
  // Get all roles
  getAll: async (orgId: string): Promise<Roles[]> => {
    return await apiClient.get(`/organizations/${orgId}/roles`);
    
  },

  // Get role by ID
  getById: async (orgId: string, id: string): Promise<Roles> => {
    return await apiClient.get(`/organizations/${orgId}/roles/${id}`);
    
  },

  // Create new role
  create: async (orgId: string, data: Omit<Roles, 'id' | 'createdAt' | 'updatedAt'>): Promise<Roles> => {
    return await apiClient.post(`/organizations/${orgId}/roles`, data);
    
  },

  // Update role
  update: async (orgId: string, id: string, data: Partial<Roles>): Promise<Roles> => {
    return await apiClient.put(`/organizations/${orgId}/roles/${id}`, data);
    
  },

  // Delete role
  delete: async (orgId: string, id: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/roles/${id}`);
  },

  // Update role status
  updateStatus: async (orgId: string, id: string, status: Roles['status']): Promise<Roles> => {
    return await apiClient.patch(`/organizations/${orgId}/roles/${id}/status`, { status });
    
  },

  // Add permission to role
  addPermission: async (orgId: string, roleId: string, permissionId: string): Promise<Roles> => {
    return await apiClient.post(`/organizations/${orgId}/roles/${roleId}/permissions`, { permissionId });
    
  },

  // Remove permission from role
  removePermission: async (orgId: string, roleId: string, permissionId: string): Promise<Roles> => {
    return await apiClient.delete(`/organizations/${orgId}/roles/${roleId}/permissions/${permissionId}`);
    
  },

  // Get role permissions
  getPermissions: async (orgId: string, roleId: string): Promise<Array<{
    id: string;
    name: string;
    description: string;
    resource: string;
    action: string;
  }>> => {
    return await apiClient.get(`/organizations/${orgId}/roles/${roleId}/permissions`);
    
  },

  // Bulk assign permissions to role
  bulkAssignPermissions: async (orgId: string, roleId: string, permissionIds: string[]): Promise<Roles> => {
    return await apiClient.post(`/organizations/${orgId}/roles/${roleId}/permissions/bulk`, { permissionIds });
    
  },

  // Get available permissions
  getAvailablePermissions: async (orgId: string): Promise<Array<{
    id: string;
    name: string;
    description: string;
    resource: string;
    action: string;
    category: string;
  }>> => {
    return await apiClient.get(`/organizations/${orgId}/permissions`);
    
  },

  // Get users with role
  getUsersWithRole: async (orgId: string, roleId: string): Promise<Array<{
    id: string;
    firstName: string;
    lastName: string;
    email: string;
    status: string;
  }>> => {
    return await apiClient.get(`/organizations/${orgId}/roles/${roleId}/users`);
    
  },

  // Assign role to user
  assignToUser: async (orgId: string, roleId: string, userId: string): Promise<void> => {
    await apiClient.post(`/organizations/${orgId}/roles/${roleId}/assign`, { userId });
  },

  // Remove role from user
  removeFromUser: async (orgId: string, roleId: string, userId: string): Promise<void> => {
    await apiClient.delete(`/organizations/${orgId}/roles/${roleId}/users/${userId}`);
  },

  // Duplicate role
  duplicate: async (orgId: string, roleId: string, newName: string): Promise<Roles> => {
    return await apiClient.post(`/organizations/${orgId}/roles/${roleId}/duplicate`, { newName });
    
  },

  // Get role statistics
  getStatistics: async (orgId: string): Promise<{
    total: number;
    active: number;
    inactive: number;
    system: number;
    custom: number;
    averagePermissionsPerRole: number;
    usersPerRole: Array<{
      roleId: string;
      roleName: string;
      userCount: number;
    }>;
  }> => {
    return await apiClient.get(`/organizations/${orgId}/roles/statistics`);
    
  },

  // Export roles
  export: async (orgId: string, options: {
    format: "CSV" | "EXCEL" | "PDF";
    includePermissions: boolean;
    includeUsers: boolean;
  }): Promise<Blob> => {
    return await apiClient.post(`/organizations/${orgId}/roles/export`, options, {
      responseType: 'blob'
    });
    
  },
};
