export const TrustOSPermissions = {
  TRUST_SCORE_READ: 'trust.score.read',
  TRUST_SCORE_UPDATE: 'trust.score.update',
  VERIFICATION_REQUEST: 'verification.request',
  VERIFICATION_READ: 'verification.read',
  VERIFICATION_APPROVE: 'verification.approve',
  VERIFICATION_REJECT: 'verification.reject',
  REVIEW_SUBMIT: 'review.submit',
  REVIEW_READ: 'review.read',
  TRUST_ADMIN_ALL: 'trust.admin.all',
} as const;

export type TrustOSPermission = typeof TrustOSPermissions[keyof typeof TrustOSPermissions];

export const TrustOSRolePermissions: Record<string, TrustOSPermission[]> = {
  user: [TrustOSPermissions.TRUST_SCORE_READ, TrustOSPermissions.VERIFICATION_READ, TrustOSPermissions.REVIEW_SUBMIT],
  manager: [TrustOSPermissions.TRUST_SCORE_READ, TrustOSPermissions.TRUST_SCORE_UPDATE, TrustOSPermissions.VERIFICATION_REQUEST, TrustOSPermissions.VERIFICATION_APPROVE, TrustOSPermissions.VERIFICATION_REJECT],
  admin: [TrustOSPermissions.TRUST_ADMIN_ALL],
};

export function hasTrustPermission(userPermissions: string[], requiredPermission: TrustOSPermission): boolean {
  return userPermissions.includes(TrustOSPermissions.TRUST_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
