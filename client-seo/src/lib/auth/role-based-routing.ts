export enum MemberRoleKey {
  OWNER = "OWNER",
  VENDOR_MANAGER = "VENDOR_MANAGER",
  AGENCY_ADMIN = "AGENCY_ADMIN",
  AGENT = "AGENT",
  ACCOUNTANT = "ACCOUNTANT",
  MAINTENANCE = "MAINTENANCE",
  TENANT_GUEST = "TENANT_GUEST",
  ORG_ADMIN = "ORG_ADMIN",
  READ_ONLY = "READ_ONLY",
}

export const ROLE_PERMISSIONS: Record<MemberRoleKey, string[]> = {
  OWNER: ["*"], // Full access
  VENDOR_MANAGER: [
    "view:finance-os",
    "view:commerce-os",
    "view:booking-os",
    "view:listing-os",
    "view:document-os",
  ],
  AGENCY_ADMIN: [
    "view:agent-os",
    "view:crm-os",
    "view:marketing-os",
    "view:ads-os",
    "view:analytics-os",
    "view:finance-os",
  ],
  AGENT: [
    "view:agent-os",
    "view:booking-os",
    "view:listing-os",
    "view:crm-os",
  ],
  ACCOUNTANT: [
    "view:finance-os",
    "view:document-os",
    "view:commission-payouts",
  ],
  MAINTENANCE: [
    "view:operations-os",
    "view:security-os",
    "view:devapi-os",
  ],
  TENANT_GUEST: [
    "view:booking-os",
    "view:listing-os",
  ],
  ORG_ADMIN: ["*"], // Full access within org
  READ_ONLY: [
    "view:analytics-os",
    "view:reports",
  ],
};

export function hasRole(user: any, role: MemberRoleKey): boolean {
  if (!user?.roles) return false;
  return user.roles.includes(role);
}

export function hasPermission(user: any, permission: string): boolean {
  if (!user?.roles) return false;
  
  // Check if user has any role with full access
  if (user.roles.includes(MemberRoleKey.OWNER) || user.roles.includes(MemberRoleKey.ORG_ADMIN)) {
    return true;
  }
  
  // Check specific permissions for each role
  for (const role of user.roles) {
    const permissions = ROLE_PERMISSIONS[role as MemberRoleKey];
    if (permissions.includes("*") || permissions.includes(permission)) {
      return true;
    }
  }
  
  return false;
}

export function canAccessOSModule(user: any, osModule: string): boolean {
  return hasPermission(user, `view:${osModule}`);
}
