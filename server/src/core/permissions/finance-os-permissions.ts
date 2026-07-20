/**
 * Finance OS Permission Model
 * Defines granular permissions for financial operations
 */

export const FinanceOSPermissions = {
  // Deal Management
  DEAL_CREATE: 'deal.create',
  DEAL_READ: 'deal.read',
  DEAL_UPDATE: 'deal.update',
  DEAL_DELETE: 'deal.delete',
  DEAL_CLOSE: 'deal.close',
  DEAL_CANCEL: 'deal.cancel',
  
  // Commission Management
  COMMISSION_CREATE: 'commission.create',
  COMMISSION_READ: 'commission.read',
  COMMISSION_UPDATE: 'commission.update',
  COMMISSION_DELETE: 'commission.delete',
  COMMISSION_APPROVE: 'commission.approve',
  COMMISSION_CALCULATE: 'commission.calculate',
  
  // Installment Management
  INSTALLMENT_CREATE: 'installment.create',
  INSTALLMENT_READ: 'installment.read',
  INSTALLMENT_UPDATE: 'installment.update',
  INSTALLMENT_DELETE: 'installment.delete',
  INSTALLMENT_APPROVE: 'installment.approve',
  INSTALLMENT_PROCESS: 'installment.process',
  
  // Payment Management
  PAYMENT_CREATE: 'payment.create',
  PAYMENT_READ: 'payment.read',
  PAYMENT_PROCESS: 'payment.process',
  PAYMENT_REFUND: 'payment.refund',
  PAYMENT_CANCEL: 'payment.cancel',
  PAYMENT_VIEW: 'payment.view',
  
  // Invoice Management
  INVOICE_CREATE: 'invoice.create',
  INVOICE_READ: 'invoice.read',
  INVOICE_UPDATE: 'invoice.update',
  INVOICE_DELETE: 'invoice.delete',
  INVOICE_SEND: 'invoice.send',
  INVOICE_MARK_PAID: 'invoice.mark_paid',
  
  // Revenue Management
  REVENUE_RECOGNIZE: 'revenue.recognize',
  REVENUE_READ: 'revenue.read',
  REVENUE_ADJUST: 'revenue.adjust',
  REVENUE_FORECAST: 'revenue.forecast',
  
  // Expense Management
  EXPENSE_CREATE: 'expense.create',
  EXPENSE_READ: 'expense.read',
  EXPENSE_UPDATE: 'expense.update',
  EXPENSE_DELETE: 'expense.delete',
  EXPENSE_APPROVE: 'expense.approve',
  
  // Financial Reporting
  REPORT_VIEW: 'report.view',
  REPORT_CREATE: 'report.create',
  REPORT_EXPORT: 'report.export',
  REPORT_SCHEDULE: 'report.schedule',
  
  // Analytics Operations
  ANALYTICS_VIEW: 'analytics.view',
  ANALYTICS_ADVANCED: 'analytics.advanced',
  ANALYTICS_EXPORT: 'analytics.export',
  
  // Tax Operations
  TAX_CALCULATE: 'tax.calculate',
  TAX_FILE: 'tax.file',
  TAX_VIEW: 'tax.view',
  
  // Compliance Operations
  COMPLIANCE_VIEW: 'compliance.view',
  COMPLIANCE_MANAGE: 'compliance.manage',
  COMPLIANCE_AUDIT: 'compliance.audit',
  
  // Integration Operations
  INTEGRATION_MANAGE: 'integration.manage',
  INTEGRATION_WEBHOOK: 'integration.webhook',
  
  // Admin Operations
  FINANCE_ADMIN_ALL: 'finance.admin.all',
  FINANCE_ADMIN_OVERRIDE: 'finance.admin.override',
  FINANCE_ADMIN_AUDIT: 'finance.admin.audit',
} as const;

export type FinanceOSPermission = typeof FinanceOSPermissions[keyof typeof FinanceOSPermissions];

/**
 * Role-based permission mappings
 */
export const FinanceOSRolePermissions: Record<string, FinanceOSPermission[]> = {
  // Agent - Basic financial operations
  agent: [
    FinanceOSPermissions.DEAL_READ,
    FinanceOSPermissions.COMMISSION_READ,
    FinanceOSPermissions.INSTALLMENT_READ,
    FinanceOSPermissions.PAYMENT_VIEW,
    FinanceOSPermissions.INVOICE_READ,
    FinanceOSPermissions.REVENUE_READ,
  ],
  
  // Finance Manager - Full financial operations
  finance_manager: [
    FinanceOSPermissions.DEAL_CREATE,
    FinanceOSPermissions.DEAL_READ,
    FinanceOSPermissions.DEAL_UPDATE,
    FinanceOSPermissions.DEAL_CLOSE,
    FinanceOSPermissions.COMMISSION_CREATE,
    FinanceOSPermissions.COMMISSION_READ,
    FinanceOSPermissions.COMMISSION_UPDATE,
    FinanceOSPermissions.COMMISSION_APPROVE,
    FinanceOSPermissions.COMMISSION_CALCULATE,
    FinanceOSPermissions.INSTALLMENT_CREATE,
    FinanceOSPermissions.INSTALLMENT_READ,
    FinanceOSPermissions.INSTALLMENT_UPDATE,
    FinanceOSPermissions.INSTALLMENT_APPROVE,
    FinanceOSPermissions.INSTALLMENT_PROCESS,
    FinanceOSPermissions.PAYMENT_CREATE,
    FinanceOSPermissions.PAYMENT_READ,
    FinanceOSPermissions.PAYMENT_PROCESS,
    FinanceOSPermissions.PAYMENT_REFUND,
    FinanceOSPermissions.INVOICE_CREATE,
    FinanceOSPermissions.INVOICE_READ,
    FinanceOSPermissions.INVOICE_UPDATE,
    FinanceOSPermissions.INVOICE_SEND,
    FinanceOSPermissions.INVOICE_MARK_PAID,
    FinanceOSPermissions.REVENUE_RECOGNIZE,
    FinanceOSPermissions.REVENUE_READ,
    FinanceOSPermissions.REVENUE_ADJUST,
    FinanceOSPermissions.REVENUE_FORECAST,
    FinanceOSPermissions.EXPENSE_CREATE,
    FinanceOSPermissions.EXPENSE_READ,
    FinanceOSPermissions.EXPENSE_UPDATE,
    FinanceOSPermissions.EXPENSE_APPROVE,
    FinanceOSPermissions.REPORT_VIEW,
    FinanceOSPermissions.REPORT_CREATE,
    FinanceOSPermissions.REPORT_EXPORT,
    FinanceOSPermissions.ANALYTICS_VIEW,
    FinanceOSPermissions.ANALYTICS_ADVANCED,
    FinanceOSPermissions.TAX_CALCULATE,
    FinanceOSPermissions.TAX_VIEW,
    FinanceOSPermissions.COMPLIANCE_VIEW,
    FinanceOSPermissions.COMPLIANCE_MANAGE,
  ],
  
  // Accountant - Focus on transactions and reporting
  accountant: [
    FinanceOSPermissions.DEAL_READ,
    FinanceOSPermissions.COMMISSION_READ,
    FinanceOSPermissions.PAYMENT_READ,
    FinanceOSPermissions.PAYMENT_PROCESS,
    FinanceOSPermissions.INVOICE_CREATE,
    FinanceOSPermissions.INVOICE_READ,
    FinanceOSPermissions.INVOICE_UPDATE,
    FinanceOSPermissions.INVOICE_SEND,
    FinanceOSPermissions.INVOICE_MARK_PAID,
    FinanceOSPermissions.REVENUE_RECOGNIZE,
    FinanceOSPermissions.REVENUE_READ,
    FinanceOSPermissions.EXPENSE_CREATE,
    FinanceOSPermissions.EXPENSE_READ,
    FinanceOSPermissions.EXPENSE_UPDATE,
    FinanceOSPermissions.REPORT_VIEW,
    FinanceOSPermissions.REPORT_CREATE,
    FinanceOSPermissions.REPORT_EXPORT,
    FinanceOSPermissions.ANALYTICS_VIEW,
    FinanceOSPermissions.TAX_CALCULATE,
    FinanceOSPermissions.TAX_FILE,
    FinanceOSPermissions.TAX_VIEW,
    FinanceOSPermissions.COMPLIANCE_VIEW,
  ],
  
  // Sales Manager - Deal and commission focus
  sales_manager: [
    FinanceOSPermissions.DEAL_CREATE,
    FinanceOSPermissions.DEAL_READ,
    FinanceOSPermissions.DEAL_UPDATE,
    FinanceOSPermissions.DEAL_CLOSE,
    FinanceOSPermissions.COMMISSION_READ,
    FinanceOSPermissions.COMMISSION_CALCULATE,
    FinanceOSPermissions.INSTALLMENT_READ,
    FinanceOSPermissions.PAYMENT_VIEW,
    FinanceOSPermissions.REVENUE_READ,
    FinanceOSPermissions.REVENUE_FORECAST,
    FinanceOSPermissions.REPORT_VIEW,
    FinanceOSPermissions.ANALYTICS_VIEW,
  ],
  
  // Auditor - Compliance and audit focus
  auditor: [
    FinanceOSPermissions.DEAL_READ,
    FinanceOSPermissions.COMMISSION_READ,
    FinanceOSPermissions.INSTALLMENT_READ,
    FinanceOSPermissions.PAYMENT_READ,
    FinanceOSPermissions.INVOICE_READ,
    FinanceOSPermissions.REVENUE_READ,
    FinanceOSPermissions.EXPENSE_READ,
    FinanceOSPermissions.REPORT_VIEW,
    FinanceOSPermissions.REPORT_EXPORT,
    FinanceOSPermissions.ANALYTICS_VIEW,
    FinanceOSPermissions.ANALYTICS_ADVANCED,
    FinanceOSPermissions.COMPLIANCE_VIEW,
    FinanceOSPermissions.COMPLIANCE_AUDIT,
    FinanceOSPermissions.FINANCE_ADMIN_AUDIT,
  ],
  
  // Admin - Full access
  admin: [
    FinanceOSPermissions.FINANCE_ADMIN_ALL,
    FinanceOSPermissions.FINANCE_ADMIN_OVERRIDE,
    FinanceOSPermissions.FINANCE_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasFinancePermission(
  userPermissions: string[],
  requiredPermission: FinanceOSPermission
): boolean {
  if (userPermissions.includes(FinanceOSPermissions.FINANCE_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasFinancePermissions(
  userPermissions: string[],
  requiredPermissions: FinanceOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasFinancePermission(userPermissions, permission)
  );
}
