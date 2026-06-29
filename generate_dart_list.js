const fs = require('fs');
const dirs = fs.readFileSync('sorted_dirs.txt', 'utf8').trim().split('\n');

const categories = {
  system: ['cloud', 'integrations', 'system_metrics', 'ai_model', 'analytics', 'dashboard', 'dashboard_configuration', 'dashboard_widget', 'ml_configuration', 'ml_model', 'predictive_model', 'analysis_job', 'recommendation_result', 'system', 'api_integration', 'api_key', 'integration_log', 'government_integration', 'webhook', 'webhook_delivery', 'mobile_device', 'offline_sync_queue', 'queue_configuration', 'queue_message', 'scraping_job', 'export_job', 'export_file', 'plan', 'subscription', 'org_subscription', 'filters', 'tag', 'photo', 'video_content', 'virtual_tour', 'map_data', 'map_layer', 'performance_alert', 'health_check', 'report', 'reports', 'report_execution', 'project', 'project_alert', 'project_analytics', 'project_report', 'more', 'welcome'],
  users: ['agents', 'agent_team', 'roles', 'audit_log', 'contacts', 'communication', 'marketing', 'marketing_campaign', 'tenants', 'membership', 'user', 'user_preference', 'user_activity_log', 'permission', 'session', 'lead', 'lead_source', 'deal', 'offer', 'negotiation_offer', 'client_relationship', 'message', 'notification', 'mention', 'guest', 'guest_profile', 'guest_review', 'review', 'post', 'hashtag', 'loyalty_account', 'referral', 'gift_card', 'brand_ambassador', 'ambassador_contract', 'social_impact_counter', 'social_impact_record', 'account', 'achievement'],
  properties: ['property', 'facilities', 'facility', 'listing', 'listing_channel', 'listing_status_history', 'listing_tag', 'external_rental_listing', 'mls_connection', 'mls_data_mapping', 'mls_external_listing', 'mls_listing_enhancement', 'mls_sync_job', 'rental_sync_job', 'home', 'home_information_pack', 'amenity', 'shared_amenity', 'floor_plan', 'location', 'neighborhood', 'channel', 'marketplace', 'vacation_rental', 'vacation_rental_platform', 'investor_portfolio'],
  financials: ['billing', 'invoices', 'payment', 'escrow_account', 'agencies', 'agency', 'company', 'vendors', 'organization', 'organizations', 'document', 'documents', 'lease', 'leases', 'compliance', 'security', 'solicitor', 'solicitor_management', 'financial', 'escrow', 'contract', 'contract_version', 'dynamic_contracts', 'signature_request', 'signature_signer', 'earning', 'exchange_rate', 'currency', 'rent_arrears', 'rent_schedule', 'deposit_protection', 'right_to_rent_check', 'immigration_status_check', 'attorney_management', 'discount', 'coupons', 'extra_charge', 'pricing_rule', 'quote', 'ledger_entry', 'reference_source', 'verification'],
  operations: ['maintenance', 'reservation', 'reservations', 'task', 'tasks', 'shared', 'booking', 'ticket', 'job', 'calendar_event', 'event', 'event_attendee', 'included_service', 'key_management', 'increase', 'route', 'favorite']
};

let output = 'final List<Map<String, dynamic>> _allModules = [\n';

dirs.forEach(dir => {
  const title = dir.split('_').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ');
  const route = '/admin/' + dir.replace(/_/g, '-');
  
  let category = 'System';
  if (categories.users.includes(dir)) category = 'Users';
  else if (categories.properties.includes(dir)) category = 'Properties';
  else if (categories.financials.includes(dir)) category = 'Financials';
  else if (categories.operations.includes(dir)) category = 'Operations';
  
  output += `  {'title': '${title}', 'route': '${route}', 'category': '${category}'},\n`;
});

output += '];';
console.log(output);
