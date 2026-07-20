/**
 * Document OS Permission Model
 * Defines granular permissions for document operations
 */

export const DocumentOSPermissions = {
  // Document Management
  DOCUMENT_CREATE: 'document.create',
  DOCUMENT_READ: 'document.read',
  DOCUMENT_UPDATE: 'document.update',
  DOCUMENT_DELETE: 'document.delete',
  DOCUMENT_UPLOAD: 'document.upload',
  DOCUMENT_DOWNLOAD: 'document.download',
  
  // Document Operations
  DOCUMENT_SIGN: 'document.sign',
  DOCUMENT_APPROVE: 'document.approve',
  DOCUMENT_REJECT: 'document.reject',
  DOCUMENT_ARCHIVE: 'document.archive',
  DOCUMENT_RESTORE: 'document.restore',
  
  // Signature Management
  SIGNATURE_REQUEST: 'signature.request',
  SIGNATURE_VIEW: 'signature.view',
  SIGNATURE_MANAGE: 'signature.manage',
  SIGNATURE_VERIFY: 'signature.verify',
  
  // Version Management
  VERSION_CREATE: 'version.create',
  VERSION_VIEW: 'version.view',
  VERSION_COMPARE: 'version.compare',
  VERSION_RESTORE: 'version.restore',
  
  // Template Management
  TEMPLATE_CREATE: 'template.create',
  TEMPLATE_READ: 'template.read',
  TEMPLATE_UPDATE: 'template.update',
  TEMPLATE_DELETE: 'template.delete',
  TEMPLATE_USE: 'template.use',
  
  // Search Operations
  DOCUMENT_SEARCH: 'document.search',
  DOCUMENT_FILTER: 'document.filter',
  DOCUMENT_EXPORT: 'document.export',
  
  // Compliance Operations
  COMPLIANCE_VIEW: 'compliance.view',
  COMPLIANCE_MANAGE: 'compliance.manage',
  COMPLIANCE_AUDIT: 'compliance.audit',
  
  // Integration Operations
  INTEGRATION_MANAGE: 'integration.manage',
  WEBHOOK_MANAGE: 'webhook.manage',
  
  // Admin Operations
  DOCUMENT_ADMIN_ALL: 'document.admin.all',
  DOCUMENT_ADMIN_OVERRIDE: 'document.admin.override',
  DOCUMENT_ADMIN_AUDIT: 'document.admin.audit',
} as const;

export type DocumentOSPermission = typeof DocumentOSPermissions[keyof typeof DocumentOSPermissions];

/**
 * Role-based permission mappings
 */
export const DocumentOSRolePermissions: Record<string, DocumentOSPermission[]> = {
  // User - Basic document operations
  user: [
    DocumentOSPermissions.DOCUMENT_READ,
    DocumentOSPermissions.DOCUMENT_DOWNLOAD,
    DocumentOSPermissions.DOCUMENT_SEARCH,
    DocumentOSPermissions.DOCUMENT_FILTER,
    DocumentOSPermissions.SIGNATURE_VIEW,
    DocumentOSPermissions.VERSION_VIEW,
    DocumentOSPermissions.TEMPLATE_READ,
    DocumentOSPermissions.TEMPLATE_USE,
  ],
  
  // Agent - Extended document operations
  agent: [
    DocumentOSPermissions.DOCUMENT_CREATE,
    DocumentOSPermissions.DOCUMENT_READ,
    DocumentOSPermissions.DOCUMENT_UPDATE,
    DocumentOSPermissions.DOCUMENT_UPLOAD,
    DocumentOSPermissions.DOCUMENT_DOWNLOAD,
    DocumentOSPermissions.DOCUMENT_SIGN,
    DocumentOSPermissions.DOCUMENT_SEARCH,
    DocumentOSPermissions.DOCUMENT_FILTER,
    DocumentOSPermissions.DOCUMENT_EXPORT,
    DocumentOSPermissions.SIGNATURE_VIEW,
    DocumentOSPermissions.SIGNATURE_REQUEST,
    DocumentOSPermissions.VERSION_VIEW,
    DocumentOSPermissions.VERSION_CREATE,
    DocumentOSPermissions.TEMPLATE_READ,
    DocumentOSPermissions.TEMPLATE_USE,
  ],
  
  // Manager - Full document management
  manager: [
    DocumentOSPermissions.DOCUMENT_CREATE,
    DocumentOSPermissions.DOCUMENT_READ,
    DocumentOSPermissions.DOCUMENT_UPDATE,
    DocumentOSPermissions.DOCUMENT_DELETE,
    DocumentOSPermissions.DOCUMENT_UPLOAD,
    DocumentOSPermissions.DOCUMENT_DOWNLOAD,
    DocumentOSPermissions.DOCUMENT_SIGN,
    DocumentOSPermissions.DOCUMENT_APPROVE,
    DocumentOSPermissions.DOCUMENT_REJECT,
    DocumentOSPermissions.DOCUMENT_ARCHIVE,
    DocumentOSPermissions.DOCUMENT_RESTORE,
    DocumentOSPermissions.DOCUMENT_SEARCH,
    DocumentOSPermissions.DOCUMENT_FILTER,
    DocumentOSPermissions.DOCUMENT_EXPORT,
    DocumentOSPermissions.SIGNATURE_REQUEST,
    DocumentOSPermissions.SIGNATURE_VIEW,
    DocumentOSPermissions.SIGNATURE_MANAGE,
    DocumentOSPermissions.SIGNATURE_VERIFY,
    DocumentOSPermissions.VERSION_CREATE,
    DocumentOSPermissions.VERSION_VIEW,
    DocumentOSPermissions.VERSION_COMPARE,
    DocumentOSPermissions.VERSION_RESTORE,
    DocumentOSPermissions.TEMPLATE_CREATE,
    DocumentOSPermissions.TEMPLATE_READ,
    DocumentOSPermissions.TEMPLATE_UPDATE,
    DocumentOSPermissions.TEMPLATE_DELETE,
    DocumentOSPermissions.TEMPLATE_USE,
    DocumentOSPermissions.COMPLIANCE_VIEW,
    DocumentOSPermissions.INTEGRATION_MANAGE,
  ],
  
  // Compliance Officer - Focus on compliance
  compliance_officer: [
    DocumentOSPermissions.DOCUMENT_READ,
    DocumentOSPermissions.DOCUMENT_DOWNLOAD,
    DocumentOSPermissions.DOCUMENT_SEARCH,
    DocumentOSPermissions.DOCUMENT_FILTER,
    DocumentOSPermissions.DOCUMENT_EXPORT,
    DocumentOSPermissions.SIGNATURE_VIEW,
    DocumentOSPermissions.SIGNATURE_VERIFY,
    DocumentOSPermissions.VERSION_VIEW,
    DocumentOSPermissions.VERSION_COMPARE,
    DocumentOSPermissions.COMPLIANCE_VIEW,
    DocumentOSPermissions.COMPLIANCE_MANAGE,
    DocumentOSPermissions.COMPLIANCE_AUDIT,
  ],
  
  // Admin - Full access
  admin: [
    DocumentOSPermissions.DOCUMENT_ADMIN_ALL,
    DocumentOSPermissions.DOCUMENT_ADMIN_OVERRIDE,
    DocumentOSPermissions.DOCUMENT_ADMIN_AUDIT,
  ],
};

/**
 * Permission validation helper
 */
export function hasDocumentPermission(
  userPermissions: string[],
  requiredPermission: DocumentOSPermission
): boolean {
  if (userPermissions.includes(DocumentOSPermissions.DOCUMENT_ADMIN_ALL)) {
    return true;
  }
  return userPermissions.includes(requiredPermission);
}

/**
 * Batch permission validation
 */
export function hasDocumentPermissions(
  userPermissions: string[],
  requiredPermissions: DocumentOSPermission[]
): boolean {
  return requiredPermissions.every(permission => 
    hasDocumentPermission(userPermissions, permission)
  );
}
