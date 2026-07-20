export const PartnerOSPermissions = {
  PARTNER_CREATE: 'partner.create',
  PARTNER_READ: 'partner.read',
  PARTNER_UPDATE: 'partner.update',
  PARTNER_DELETE: 'partner.delete',
  RELATIONSHIP_CREATE: 'relationship.create',
  RELATIONSHIP_READ: 'relationship.read',
  RELATIONSHIP_UPDATE: 'relationship.update',
  AGREEMENT_SIGN: 'agreement.sign',
  PERFORMANCE_REVIEW: 'performance.review',
  PARTNER_ADMIN_ALL: 'partner.admin.all',
} as const;

export type PartnerOSPermission = typeof PartnerOSPermissions[keyof typeof PartnerOSPermissions];

export const PartnerOSRolePermissions: Record<string, PartnerOSPermission[]> = {
  user: [PartnerOSPermissions.PARTNER_READ, PartnerOSPermissions.RELATIONSHIP_READ],
  manager: [PartnerOSPermissions.PARTNER_CREATE, PartnerOSPermissions.PARTNER_READ, PartnerOSPermissions.PARTNER_UPDATE, PartnerOSPermissions.RELATIONSHIP_CREATE, PartnerOSPermissions.RELATIONSHIP_READ, PartnerOSPermissions.RELATIONSHIP_UPDATE, PartnerOSPermissions.AGREEMENT_SIGN, PartnerOSPermissions.PERFORMANCE_REVIEW],
  admin: [PartnerOSPermissions.PARTNER_ADMIN_ALL],
};

export function hasPartnerPermission(userPermissions: string[], requiredPermission: PartnerOSPermission): boolean {
  return userPermissions.includes(PartnerOSPermissions.PARTNER_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
