export const AdsOSPermissions = {
  CAMPAIGN_CREATE: 'campaign.create',
  CAMPAIGN_READ: 'campaign.read',
  CAMPAIGN_UPDATE: 'campaign.update',
  CAMPAIGN_DELETE: 'campaign.delete',
  CAMPAIGN_PAUSE: 'campaign.pause',
  CAMPAIGN_RESUME: 'campaign.resume',
  BUDGET_UPDATE: 'budget.update',
  AD_CREATE: 'ad.create',
  AD_READ: 'ad.read',
  ADS_ADMIN_ALL: 'ads.admin.all',
} as const;

export type AdsOSPermission = typeof AdsOSPermissions[keyof typeof AdsOSPermissions];

export const AdsOSRolePermissions: Record<string, AdsOSPermission[]> = {
  user: [AdsOSPermissions.CAMPAIGN_READ, AdsOSPermissions.AD_READ],
  marketer: [AdsOSPermissions.CAMPAIGN_CREATE, AdsOSPermissions.CAMPAIGN_READ, AdsOSPermissions.CAMPAIGN_UPDATE, AdsOSPermissions.CAMPAIGN_PAUSE, AdsOSPermissions.CAMPAIGN_RESUME, AdsOSPermissions.AD_CREATE, AdsOSPermissions.BUDGET_UPDATE],
  admin: [AdsOSPermissions.ADS_ADMIN_ALL],
};

export function hasAdsPermission(userPermissions: string[], requiredPermission: AdsOSPermission): boolean {
  return userPermissions.includes(AdsOSPermissions.ADS_ADMIN_ALL) || userPermissions.includes(requiredPermission);
}
