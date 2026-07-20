export const InvestmentOSPermissions = {
  INVESTMENT_CREATE: 'investment.create',
  INVESTMENT_READ: 'investment.read',
  INVESTMENT_UPDATE: 'investment.update',
  INVESTMENT_DELETE: 'investment.delete',
  INVESTMENT_APPROVE: 'investment.approve',
  INVESTMENT_FUND: 'investment.fund',
  INVESTMENT_RETURN: 'investment.return',
  DIVIDEND_DISTRIBUTE: 'dividend.distribute',
  INVESTMENT_ADMIN_ALL: 'investment.admin.all',
} as const;

export type InvestmentOSPermission = typeof InvestmentOSPermissions[keyof typeof InvestmentOSPermissions];

export const InvestmentOSRolePermissions: Record<string, InvestmentOSPermission[]> = {
  user: [InvestmentOSPermissions.INVESTMENT_READ],
  investor: [InvestmentOSPermissions.INVESTMENT_CREATE, InvestmentOSPermissions.INVESTMENT_READ, InvestmentOSPermissions.INVESTMENT_UPDATE],
  manager: [InvestmentOSPermissions.INVESTMENT_CREATE, InvestmentOSPermissions.INVESTMENT_READ, InvestmentOSPermissions.INVESTMENT_UPDATE, InvestmentOSPermissions.INVESTMENT_APPROVE, InvestmentOSPermissions.INVESTMENT_FUND, InvestmentOSPermissions.INVESTMENT_RETURN, InvestmentOSPermissions.DIVIDEND_DISTRIBUTE],
  admin: [InvestmentOSPermissions.INVESTMENT_ADMIN_ALL],
};

export function hasInvestmentPermission(userPermissions: string[], requiredPermission: InvestmentOSPermission): boolean {
  return userPermissions.includes(InvestmentOSPermissions.INVESTMENT_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
