/**
 * Dashboard Registration Index
 * Registers all OS module dashboards
 */

import { registerAnalyticsDashboards } from './analytics-dashboards';
import { registerDocumentDashboards } from './document-dashboards';
import { registerNotificationDashboards } from './notification-dashboards';
import { registerIdentityDashboards } from './identity-dashboards';
import { registerLocalizationDashboards } from './localization-dashboards';
import { registerAgentDashboards } from './agent-dashboards';
import { registerBookingDashboards } from './booking-dashboards';
import { registerFinanceDashboards } from './finance-dashboards';
import { registerListingDashboards } from './listing-dashboards';
import { registerTrustDashboards } from './trust-dashboards';
import { registerAdsDashboards } from './ads-dashboards';
import { registerAIDashboards } from './ai-dashboards';
import { registerCommerceDashboards } from './commerce-dashboards';
import { registerCRMDashboards } from './crm-dashboards';
import { registerDevAPIDashboards } from './devapi-dashboards';
import { registerGovernanceDashboards } from './governance-dashboards';
import { registerInvestmentDashboards } from './investment-dashboards';
import { registerOperationsDashboards } from './operations-dashboards';
import { registerPartnerDashboards } from './partner-dashboards';
import { registerSecurityDashboards } from './security-dashboards';
import { registerUserDashboards } from './user-dashboards';

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
  registerAgentDashboards();
  registerBookingDashboards();
  registerFinanceDashboards();
  registerListingDashboards();
  registerTrustDashboards();
  registerAdsDashboards();
  registerAIDashboards();
  registerCommerceDashboards();
  registerCRMDashboards();
  registerDevAPIDashboards();
  registerGovernanceDashboards();
  registerInvestmentDashboards();
  registerOperationsDashboards();
  registerPartnerDashboards();
  registerSecurityDashboards();
  registerUserDashboards();
  
  console.log('[Dashboards] All dashboards registered successfully');
}
