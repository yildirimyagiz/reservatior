export const CRMOSPermissions = {
  LEAD_CREATE: 'lead.create',
  LEAD_READ: 'lead.read',
  LEAD_UPDATE: 'lead.update',
  LEAD_DELETE: 'lead.delete',
  LEAD_QUALIFY: 'lead.qualify',
  LEAD_CONVERT: 'lead.convert',
  CONTACT_CREATE: 'contact.create',
  CONTACT_READ: 'contact.read',
  CONTACT_UPDATE: 'contact.update',
  CONTACT_DELETE: 'contact.delete',
  OPPORTUNITY_CREATE: 'opportunity.create',
  OPPORTUNITY_READ: 'opportunity.read',
  OPPORTUNITY_UPDATE: 'opportunity.update',
  CRM_ADMIN_ALL: 'crm.admin.all',
} as const;

export type CRMOSPermission = typeof CRMOSPermissions[keyof typeof CRMOSPermissions];

export const CRMOSRolePermissions: Record<string, CRMOSPermission[]> = {
  user: [CRMOSPermissions.LEAD_READ, CRMOSPermissions.CONTACT_READ, CRMOSPermissions.OPPORTUNITY_READ],
  sales: [CRMOSPermissions.LEAD_CREATE, CRMOSPermissions.LEAD_READ, CRMOSPermissions.LEAD_UPDATE, CRMOSPermissions.LEAD_QUALIFY, CRMOSPermissions.LEAD_CONVERT, CRMOSPermissions.CONTACT_CREATE, CRMOSPermissions.CONTACT_READ, CRMOSPermissions.OPPORTUNITY_CREATE, CRMOSPermissions.OPPORTUNITY_READ, CRMOSPermissions.OPPORTUNITY_UPDATE],
  admin: [CRMOSPermissions.CRM_ADMIN_ALL],
};

export function hasCRMPermission(userPermissions: string[], requiredPermission: CRMOSPermission): boolean {
  return userPermissions.includes(CRMOSPermissions.CRM_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
