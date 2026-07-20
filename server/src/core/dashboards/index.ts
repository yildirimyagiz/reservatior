/**
 * Dashboard Registration Index
 * Registers all OS module dashboards
 */

import { registerAnalyticsDashboards } from './analytics-dashboards';
import { registerDocumentDashboards } from './document-dashboards';
import { registerNotificationDashboards } from './notification-dashboards';
import { registerIdentityDashboards } from './identity-dashboards';
import { registerLocalizationDashboards } from './localization-dashboards';

/**
 * Register all platform dashboards
 */
export function registerAllDashboards() {
  console.log('[Dashboards] Registering all platform dashboards...');
  
  registerAnalyticsDashboards();
  registerDocumentDashboards();
  registerNotificationDashboards();
  registerIdentityDashboards();
  registerLocalizationDashboards();
  
  console.log('[Dashboards] All dashboards registered successfully');
}
