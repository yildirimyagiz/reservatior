#!/usr/bin/env node
/**
 * generate-os-i18n.js
 * Generates i18n keys for all 21 OS modules
 * Usage: node scripts/generate-os-i18n.js
 */

const fs = require('fs');
const path = require('path');

const LOCALES_DIR = path.join(__dirname, '../client/src/locales');

// ─── OS Module Definitions ───────────────────────────────────────────────────
const OS_MODULES = {
  listingOs: {
    title: 'Listing OS',
    description: 'Property listings management',
    resources: {
      listing: { label: 'Listing', plural: 'Listings', create: 'Create Listing', update: 'Update Listing', delete: 'Delete Listing', detail: 'Listing Details' },
    },
    statuses: { active: 'Active', draft: 'Draft', pending: 'Pending', published: 'Published', archived: 'Archived' },
    actions: { publish: 'Publish', unpublish: 'Unpublish', import: 'Import Listings', export: 'Export Listings' },
  },
  agentOs: {
    title: 'Agent OS',
    description: 'Agent registration and network management',
    resources: {
      agent: { label: 'Agent', plural: 'Agents', create: 'Register Agent', update: 'Update Agent', delete: 'Remove Agent', detail: 'Agent Details' },
      networkSignal: { label: 'Network Signal', plural: 'Network Signals' },
    },
    statuses: { active: 'Active', inactive: 'Inactive', pending: 'Pending', verified: 'Verified', suspended: 'Suspended' },
    actions: { verify: 'Verify Agent', suspend: 'Suspend Agent', invite: 'Invite Agent' },
  },
  financeOs: {
    title: 'Finance OS',
    description: 'Escrow, payments, and financial records',
    resources: {
      escrow: { label: 'Escrow', plural: 'Escrows', create: 'Create Escrow', update: 'Update Escrow', detail: 'Escrow Details' },
      payment: { label: 'Payment', plural: 'Payments', create: 'Record Payment', detail: 'Payment Details' },
      financialRecord: { label: 'Financial Record', plural: 'Financial Records' },
    },
    statuses: { active: 'Active', completed: 'Completed', pending: 'Pending', disputed: 'Disputed', released: 'Released', refunded: 'Refunded' },
    actions: { release: 'Release Funds', refund: 'Refund', dispute: 'Raise Dispute' },
  },
  bookingOs: {
    title: 'Booking OS',
    description: 'Bookings and reservation management',
    resources: {
      booking: { label: 'Booking', plural: 'Bookings', create: 'Create Booking', update: 'Update Booking', cancel: 'Cancel Booking', detail: 'Booking Details' },
      reservation: { label: 'Reservation', plural: 'Reservations' },
    },
    statuses: { confirmed: 'Confirmed', pending: 'Pending', cancelled: 'Cancelled', checkedIn: 'Checked In', checkedOut: 'Checked Out', completed: 'Completed' },
    actions: { checkIn: 'Check In', checkOut: 'Check Out', confirm: 'Confirm', cancel: 'Cancel' },
    liveFeed: { title: 'Live Feed', subtitle: 'Real-time booking updates' },
    pricingEngine: { title: 'Pricing Engine', subtitle: 'Dynamic pricing optimization' },
  },
  investmentOs: {
    title: 'Investment OS',
    description: 'Investment deals, projections, and analysis',
    resources: {
      deal: { label: 'Deal', plural: 'Deals', create: 'Create Deal', update: 'Update Deal', delete: 'Delete Deal', detail: 'Deal Details', analyze: 'Analyze Deal', duplicate: 'Duplicate Deal' },
      projection: { label: 'Projection', plural: 'Projections', generate: 'Generate Projections', summary: 'Projection Summary' },
      comparable: { label: 'Comparable', plural: 'Comparables', add: 'Add Comparable', remove: 'Remove Comparable', adjustedPrice: 'Adjusted Price' },
      insight: { label: 'Market Insight', plural: 'Market Insights', generate: 'Generate Insight', trends: 'Market Trends' },
    },
    statuses: { active: 'Active', closed: 'Closed', pending: 'Pending', cancelled: 'Cancelled' },
    actions: { analyze: 'Analyze', duplicate: 'Duplicate', export: 'Export' },
  },
  operationsOs: {
    title: 'Operations OS',
    description: 'Maintenance, inspections, and vendor management',
    resources: {
      maintenance: { label: 'Maintenance', plural: 'Maintenance Schedules', create: 'Schedule Maintenance', complete: 'Complete Maintenance', overdue: 'Overdue Maintenance' },
      inspection: { label: 'Inspection', plural: 'Inspections', schedule: 'Schedule Inspection', complete: 'Complete Inspection', upcoming: 'Upcoming Inspections' },
      cleaning: { label: 'Cleaning', plural: 'Cleaning Schedules', schedule: 'Schedule Cleaning', upcoming: 'Upcoming Cleanings' },
      vendorRating: { label: 'Vendor Rating', plural: 'Vendor Ratings', rate: 'Rate Vendor', summary: 'Rating Summary' },
      serviceProvider: { label: 'Service Provider', plural: 'Service Providers', register: 'Register Provider' },
    },
    statuses: { scheduled: 'Scheduled', inProgress: 'In Progress', completed: 'Completed', overdue: 'Overdue', cancelled: 'Cancelled' },
    actions: { complete: 'Mark Complete', cancel: 'Cancel', reschedule: 'Reschedule' },
  },
  securityOs: {
    title: 'Security OS',
    description: 'KYC, fraud detection, and access audit',
    resources: {
      kyc: { label: 'KYC Verification', plural: 'KYC Verifications', submit: 'Submit KYC', approve: 'Approve KYC', reject: 'Reject KYC' },
      fraud: { label: 'Fraud Alert', plural: 'Fraud Alerts', flag: 'Flag Activity', resolve: 'Resolve Alert' },
      audit: { label: 'Access Log', plural: 'Access Logs', log: 'Log Access Event' },
      policy: { label: 'Security Policy', plural: 'Security Policies', create: 'Create Policy', toggle: 'Toggle Policy' },
    },
    statuses: { approved: 'Approved', pending: 'Pending', rejected: 'Rejected', resolved: 'Resolved', active: 'Active', inactive: 'Inactive' },
    actions: { approve: 'Approve', reject: 'Reject', flag: 'Flag', resolve: 'Resolve', toggle: 'Toggle' },
  },
  governanceOs: {
    title: 'Governance OS',
    description: 'Compliance, rules, and audit trail',
    resources: {
      rule: { label: 'Governance Rule', plural: 'Governance Rules' },
      compliance: { label: 'Compliance Record', plural: 'Compliance Records', create: 'Create Record', update: 'Update Status', stats: 'Compliance Statistics' },
      auditTrail: { label: 'Audit Trail', plural: 'Audit Trail Entries' },
      legal: { label: 'Legal Compliance', plural: 'Legal Compliance Records' },
    },
    statuses: { compliant: 'Compliant', nonCompliant: 'Non-Compliant', pending: 'Pending', underReview: 'Under Review' },
    actions: { create: 'Create Record', update: 'Update Status', review: 'Review' },
  },
  partnerOs: {
    title: 'Partner OS',
    description: 'Partners, agreements, and supplier management',
    resources: {
      partner: { label: 'Partner', plural: 'Partners', create: 'Add Partner', detail: 'Partner Details' },
      agreement: { label: 'Agreement', plural: 'Agreements', create: 'Create Agreement', stats: 'Agreement Statistics' },
      supplier: { label: 'Supplier', plural: 'Suppliers' },
      review: { label: 'Vendor Review', plural: 'Vendor Reviews' },
    },
    statuses: { active: 'Active', inactive: 'Inactive', pending: 'Pending', expired: 'Expired' },
    actions: { create: 'Create', renew: 'Renew', terminate: 'Terminate' },
  },
  developerOs: {
    title: 'Developer API OS',
    description: 'API keys, webhooks, and integrations',
    resources: {
      apiKey: { label: 'API Key', plural: 'API Keys', create: 'Create API Key', revoke: 'Revoke Key' },
      integration: { label: 'Integration', plural: 'Integrations', stats: 'Integration Statistics' },
      webhook: { label: 'Webhook', plural: 'Webhooks', create: 'Create Webhook', deliveries: 'Webhook Deliveries' },
      log: { label: 'Integration Log', plural: 'Integration Logs' },
    },
    statuses: { connected: 'Connected', disconnected: 'Disconnected', active: 'Active', failed: 'Failed' },
    actions: { connect: 'Connect', disconnect: 'Disconnect', test: 'Test', revoke: 'Revoke' },
  },
  analyticsOs: {
    title: 'Analytics OS',
    description: 'Reports, dashboards, and metrics',
    resources: {
      analytics: { label: 'Analytics Record', plural: 'Analytics Records', create: 'Create Record', stats: 'Analytics Statistics' },
      report: { label: 'Report', plural: 'Reports', create: 'Create Report', executions: 'Report Executions' },
      dashboard: { label: 'Dashboard', plural: 'Dashboards' },
      metric: { label: 'Metric', plural: 'Metrics' },
      alert: { label: 'Performance Alert', plural: 'Performance Alerts' },
      health: { label: 'Health Check', plural: 'Health Checks' },
    },
    statuses: { healthy: 'Healthy', degraded: 'Degraded', failed: 'Failed', active: 'Active' },
    actions: { generate: 'Generate', refresh: 'Refresh', export: 'Export' },
  },
  documentOs: {
    title: 'Document OS',
    description: 'Documents, contracts, and signatures',
    resources: {
      document: { label: 'Document', plural: 'Documents', create: 'Upload Document', stats: 'Document Statistics' },
      contract: { label: 'Contract', plural: 'Contracts', create: 'Create Contract', stats: 'Contract Statistics', versions: 'Contract Versions' },
      signature: { label: 'Signature Request', plural: 'Signature Requests', stats: 'Signature Statistics' },
      template: { label: 'Document Template', plural: 'Document Templates' },
    },
    statuses: { draft: 'Draft', active: 'Active', signed: 'Signed', expired: 'Expired', archived: 'Archived' },
    actions: { upload: 'Upload', sign: 'Sign', archive: 'Archive', download: 'Download' },
  },
  notificationOs: {
    title: 'Notification OS',
    description: 'Notifications, messages, and channels',
    resources: {
      notification: { label: 'Notification', plural: 'Notifications', create: 'Create Notification', stats: 'Notification Statistics', markRead: 'Mark as Read' },
      message: { label: 'Message', plural: 'Messages', send: 'Send Message', stats: 'Message Statistics' },
      log: { label: 'Communication Log', plural: 'Communication Logs' },
      template: { label: 'Communication Template', plural: 'Templates' },
      channel: { label: 'Communication Channel', plural: 'Channels' },
    },
    statuses: { sent: 'Sent', delivered: 'Delivered', read: 'Read', failed: 'Failed', pending: 'Pending' },
    actions: { send: 'Send', markRead: 'Mark Read', archive: 'Archive' },
  },
  userOs: {
    title: 'User OS',
    description: 'User profiles, preferences, and journey',
    resources: {
      profile: { label: 'User Profile', plural: 'User Profiles', update: 'Update Profile' },
      identity: { label: 'Identity Provider', plural: 'Identity Providers', link: 'Link Provider', unlink: 'Unlink Provider' },
      session: { label: 'Session', plural: 'Sessions', revokeAll: 'Revoke All Sessions' },
      consent: { label: 'Consent', plural: 'Consents', grant: 'Grant Consent', withdraw: 'Withdraw Consent', bulk: 'Bulk Grant' },
      journey: { label: 'User Journey', plural: 'Journey Stages', advance: 'Advance Stage', stats: 'Journey Statistics' },
      activity: { label: 'Activity', plural: 'Activity Logs', log: 'Log Activity' },
      interest: { label: 'Interest', plural: 'Interests', add: 'Add Interest', remove: 'Remove Interest' },
      preference: { label: 'Category Preference', plural: 'Preferences', set: 'Set Preference' },
      savedSearch: { label: 'Saved Search', plural: 'Saved Searches', create: 'Create Saved Search', delete: 'Delete Saved Search' },
      recommendation: { label: 'Recommendation', plural: 'Recommendations', track: 'Track Interaction' },
      relationship: { label: 'User Relationship', plural: 'Relationships' },
    },
    statuses: { active: 'Active', inactive: 'Inactive', verified: 'Verified', pending: 'Pending' },
    actions: { update: 'Update', revoke: 'Revoke', grant: 'Grant', withdraw: 'Withdraw', dismiss: 'Dismiss' },
  },
  adsOs: {
    title: 'Ads OS',
    description: 'Campaigns, creatives, and audiences',
    resources: {
      campaign: { label: 'Campaign', plural: 'Campaigns', create: 'Create Campaign', activate: 'Activate', pause: 'Pause', complete: 'Complete', duplicate: 'Duplicate' },
      creative: { label: 'Creative', plural: 'Creatives', create: 'Create Creative' },
      segment: { label: 'Audience Segment', plural: 'Segments', create: 'Create Segment', aiGenerate: 'AI Generate Segment' },
      channel: { label: 'Channel Connection', plural: 'Channels', connect: 'Connect Channel', disconnect: 'Disconnect Channel' },
      budget: { label: 'Campaign Budget', plural: 'Budgets', set: 'Set Budget' },
      event: { label: 'Campaign Event', plural: 'Events', track: 'Track Event', stats: 'Event Statistics' },
      attribution: { label: 'Channel Attribution', plural: 'Attributions', track: 'Track Attribution' },
      conversion: { label: 'Conversion', plural: 'Conversions', funnel: 'Conversion Funnel', roas: 'Return on Ad Spend' },
    },
    statuses: { active: 'Active', paused: 'Paused', completed: 'Completed', draft: 'Draft' },
    actions: { activate: 'Activate', pause: 'Pause', complete: 'Complete', duplicate: 'Duplicate', track: 'Track' },
  },
  identityOs: {
    title: 'Identity OS',
    description: 'Users, sessions, roles, and SSO',
    resources: {
      user: { label: 'User', plural: 'Users', stats: 'User Statistics' },
      session: { label: 'Active Session', plural: 'Sessions', revoke: 'Revoke Session' },
      role: { label: 'Role', plural: 'Roles' },
      permission: { label: 'Permission', plural: 'Permissions' },
      account: { label: 'SSO Provider', plural: 'SSO Providers' },
      member: { label: 'Organization Member', plural: 'Members' },
      apiKey: { label: 'API Key', plural: 'API Keys' },
    },
    statuses: { active: 'Active', inactive: 'Inactive', verified: 'Verified', suspended: 'Suspended' },
    actions: { revoke: 'Revoke', assign: 'Assign Role', remove: 'Remove' },
  },
  localizationOs: {
    title: 'Localization OS',
    description: 'Countries, currencies, and languages',
    resources: {
      country: { label: 'Country', plural: 'Countries', config: 'Country Configuration', states: 'States' },
      currency: { label: 'Currency', plural: 'Currencies' },
      exchangeRate: { label: 'Exchange Rate', plural: 'Exchange Rates', create: 'Create Exchange Rate' },
      language: { label: 'Language', plural: 'Languages' },
      compliance: { label: 'Legal Compliance', plural: 'Compliance Records', stats: 'Compliance Statistics' },
      taxRegulation: { label: 'Tax Regulation', plural: 'Tax Regulations', stats: 'Tax Regulation Statistics' },
    },
    statuses: { active: 'Active', inactive: 'Inactive', pending: 'Pending' },
    actions: { configure: 'Configure', activate: 'Activate', deactivate: 'Deactivate' },
  },
  commerceOs: {
    title: 'Commerce OS',
    description: 'Products, orders, bundles, and campaigns',
    resources: {
      product: { label: 'Product', plural: 'Products' },
      order: { label: 'Order', plural: 'Orders', updateStatus: 'Update Order Status' },
      campaign: { label: 'Commerce Campaign', plural: 'Campaigns' },
      supplier: { label: 'Supplier', plural: 'Suppliers' },
      revenue: { label: 'Revenue Analytics', plural: 'Revenue Reports' },
    },
    statuses: { active: 'Active', pending: 'Pending', paid: 'Paid', fulfilled: 'Fulfilled', cancelled: 'Cancelled', refunded: 'Refunded' },
    actions: { create: 'Create', update: 'Update', cancel: 'Cancel', refund: 'Refund' },
    analytics: { revenue: 'Revenue Analytics', avgOrderValue: 'Avg Order Value', conversionRate: 'Conversion Rate' },
  },
  crmOs: {
    title: 'CRM OS',
    description: 'Contacts, leads, and client relationships',
    resources: {
      contact: { label: 'Contact', plural: 'Contacts', search: 'Search Contacts' },
      lead: { label: 'Lead', plural: 'Leads', qualify: 'Qualify Lead', disqualify: 'Disqualify Lead' },
      deal: { label: 'Deal', plural: 'Deals', updateStage: 'Update Deal Stage' },
      interaction: { label: 'Interaction', plural: 'Interactions' },
      segment: { label: 'Lead Segment', plural: 'Segments' },
      pipeline: { label: 'Deal Pipeline', plural: 'Pipelines' },
    },
    statuses: { new: 'New', qualified: 'Qualified', unqualified: 'Unqualified', converted: 'Converted', won: 'Won', lost: 'Lost' },
    actions: { qualify: 'Qualify', disqualify: 'Disqualify', convert: 'Convert', updateStage: 'Update Stage' },
    pipeline: { title: 'Deal Pipeline', totalValue: 'Total Pipeline Value' },
  },
  portfolioOs: {
    title: 'Portfolio OS',
    description: 'Investor portfolios, REO assets, and valuations',
    resources: {
      portfolio: { label: 'Portfolio', plural: 'Portfolios' },
      holding: { label: 'Holding', plural: 'Holdings', add: 'Add Holding', remove: 'Remove Holding' },
      reo: { label: 'REO Property', plural: 'REO Properties', updateStatus: 'Update REO Status' },
      valuation: { label: 'Valuation', plural: 'Valuations', request: 'Request Valuation', completed: 'Valuation Completed' },
    },
    statuses: { active: 'Active', listed: 'Listed', sold: 'Sold', writeoff: 'Written Off', pending: 'Pending' },
    actions: { add: 'Add Holding', remove: 'Remove Holding', rebalance: 'Rebalance', requestValuation: 'Request Valuation' },
    analytics: { totalValue: 'Total Investment Value', reoCount: 'REO Assets', holdingsByType: 'Holdings by Type' },
  },
  platformOs: {
    title: 'Platform OS',
    description: 'Config, tenants, feature flags, and system health',
    resources: {
      tenant: { label: 'Tenant', plural: 'Tenants', updateStatus: 'Update Tenant Status' },
      featureFlag: { label: 'Feature Flag', plural: 'Feature Flags', toggle: 'Toggle Feature Flag' },
      health: { label: 'Health Check', plural: 'Health Checks', summary: 'Health Summary' },
      metric: { label: 'System Metric', plural: 'Metrics' },
      deploy: { label: 'Deploy Event', plural: 'Deploys', history: 'Deploy History' },
      maintenance: { label: 'Maintenance Window', plural: 'Maintenance Windows', upcoming: 'Upcoming Maintenance' },
      auditTrail: { label: 'Audit Trail', plural: 'Audit Trail Entries' },
    },
    statuses: { active: 'Active', suspended: 'Suspended', healthy: 'Healthy', failed: 'Failed', degraded: 'Degraded', completed: 'Completed' },
    actions: { suspend: 'Suspend', reactivate: 'Reactivate', toggle: 'Toggle', trigger: 'Trigger Deploy' },
    config: { title: 'Platform Configuration', updated: 'Configuration updated' },
  },
};

// ─── Generate Keys ───────────────────────────────────────────────────────────
function generateOSKeys(osName, config) {
  const keys = {};

  // Dashboard
  keys[`${osName}.dashboard`] = {
    title: `${config.title} Dashboard`,
    description: config.description,
  };

  // Resources
  for (const [resKey, res] of Object.entries(config.resources)) {
    keys[`${osName}.${resKey}`] = {};
    for (const [action, label] of Object.entries(res)) {
      keys[`${osName}.${resKey}`][action] = label;
    }
  }

  // Statuses
  keys[`${osName}.status`] = config.statuses;

  // Actions
  keys[`${osName}.actions`] = config.actions;

  // Messages
  keys[`${osName}.messages`] = {
    success: `${config.title} operation successful`,
    error: `${config.title} operation failed`,
    confirm: `Are you sure you want to perform this ${config.title} action?`,
    loading: `Processing ${config.title} request...`,
  };

  // Common UI
  keys[`${osName}.ui`] = {
    search: `Search ${config.description}`,
    filter: 'Filter',
    sort: 'Sort',
    export: 'Export',
    import: 'Import',
    refresh: 'Refresh',
    noData: `No ${config.description} data found`,
    loading: `Loading ${config.description}...`,
    title: config.title,
  };

  return keys;
}

// ─── Main ────────────────────────────────────────────────────────────────────
function main() {
  const enPath = path.join(LOCALES_DIR, 'en.json');
  const enData = JSON.parse(fs.readFileSync(enPath, 'utf8'));

  let totalKeysAdded = 0;

  for (const [osName, config] of Object.entries(OS_MODULES)) {
    const osKeys = generateOSKeys(osName, config);

    // Merge into en.json
    for (const [key, value] of Object.entries(osKeys)) {
      if (!enData[key]) {
        enData[key] = value;
        totalKeysAdded++;
      }
    }
  }

  // Write back
  fs.writeFileSync(enPath, JSON.stringify(enData, null, 2) + '\n', 'utf8');

  console.log(`\n✅ en.json updated successfully!`);
  console.log(`   Total OS modules: ${Object.keys(OS_MODULES).length}`);
  console.log(`   New keys added: ${totalKeysAdded}`);
  console.log(`   Total keys in en.json: ${Object.keys(enData).length}`);

  // Generate TR translations
  generateTR();
}

// ─── Turkish Translations ────────────────────────────────────────────────────
const TR_TRANSLATIONS = {
  listingOs: {
    title: 'İlan OS', description: 'Emlak ilanları yönetimi',
    dashboard: { title: 'İlan OS Paneli', description: 'İlan yönetimi genel bakış' },
  },
  agentOs: {
    title: 'Agent OS', description: 'Agent kaydı ve ağ yönetimi',
    dashboard: { title: 'Agent OS Paneli', description: 'Agent yönetimi genel bakış' },
  },
  financeOs: {
    title: 'Finans OS', description: 'Emanet, ödemeler ve finansal kayıtlar',
    dashboard: { title: 'Finans OS Paneli', description: 'Finansal genel bakış' },
  },
  bookingOs: {
    title: 'Rezervasyon OS', description: 'Rezervasyon ve randevu yönetimi',
    dashboard: { title: 'Rezervasyon OS Paneli', description: 'Rezervasyon genel bakış' },
  },
  investmentOs: {
    title: 'Yatırım OS', description: 'Yatırım anlaşmaları, projeksiyonlar ve analiz',
    dashboard: { title: 'Yatırım OS Paneli', description: 'Yatırım genel bakış' },
  },
  operationsOs: {
    title: 'Operasyon OS', description: 'Bakım, denetim ve tedarikçi yönetimi',
    dashboard: { title: 'Operasyon OS Paneli', description: 'Operasyon genel bakış' },
  },
  securityOs: {
    title: 'Güvenlik OS', description: 'KYC, dolandırıcılık tespiti ve erişim denetimi',
    dashboard: { title: 'Güvenlik OS Paneli', description: 'Güvenlik genel bakış' },
  },
  governanceOs: {
    title: 'Yönetişim OS', description: 'Uyumluluk, kurallar ve denetim izi',
    dashboard: { title: 'Yönetişim OS Paneli', description: 'Yönetişim genel bakış' },
  },
  partnerOs: {
    title: 'Partner OS', description: 'Partnerler, anlaşmalar ve tedarikçi yönetimi',
    dashboard: { title: 'Partner OS Paneli', description: 'Partner genel bakış' },
  },
  developerOs: {
    title: 'Geliştirici API OS', description: 'API anahtarları, webhook\'lar ve entegrasyonlar',
    dashboard: { title: 'Geliştirici API OS Paneli', description: 'API genel bakış' },
  },
  analyticsOs: {
    title: 'Analitik OS', description: 'Raporlar, panolar ve metrikler',
    dashboard: { title: 'Analitik OS Paneli', description: 'Analitik genel bakış' },
  },
  documentOs: {
    title: 'Doküman OS', description: 'Dokümanlar, sözleşmeler ve imzalar',
    dashboard: { title: 'Doküman OS Paneli', description: 'Doküman genel bakış' },
  },
  notificationOs: {
    title: 'Bildirim OS', description: 'Bildirimler, mesajlar ve kanallar',
    dashboard: { title: 'Bildirim OS Paneli', description: 'Bildirim genel bakış' },
  },
  userOs: {
    title: 'Kullanıcı OS', description: 'Kullanıcı profilleri, tercihleri ve yolculuğu',
    dashboard: { title: 'Kullanıcı OS Paneli', description: 'Kullanıcı genel bakış' },
  },
  adsOs: {
    title: 'Reklam OS', description: 'Kampanyalar, yaratıcılar ve kitleler',
    dashboard: { title: 'Reklam OS Paneli', description: 'Reklam genel bakış' },
  },
  identityOs: {
    title: 'Kimlik OS', description: 'Kullanıcılar, oturumlar, roller ve SSO',
    dashboard: { title: 'Kimlik OS Paneli', description: 'Kimlik genel bakış' },
  },
  localizationOs: {
    title: 'Yerelleştirme OS', description: 'Ülkeler, para birimleri ve diller',
    dashboard: { title: 'Yerelleştirme OS Paneli', description: 'Yerelleştirme genel bakış' },
  },
  commerceOs: {
    title: 'Ticaret OS', description: 'Ürünler, siparişler, demetler ve kampanyalar',
    dashboard: { title: 'Ticaret OS Paneli', description: 'Ticaret genel bakış' },
  },
  crmOs: {
    title: 'CRM OS', description: 'Kişiler, liderler ve müşteri ilişkileri',
    dashboard: { title: 'CRM OS Paneli', description: 'CRM genel bakış' },
  },
  portfolioOs: {
    title: 'Portföy OS', description: 'Yatırımcı portföyleri, REO varlıkları ve değerlemeler',
    dashboard: { title: 'Portföy OS Paneli', description: 'Portföy genel bakış' },
  },
  platformOs: {
    title: 'Platform OS', description: 'Yapılandırma, kiracılar, özellik bayrakları ve sistem sağlığı',
    dashboard: { title: 'Platform OS Paneli', description: 'Platform genel bakış' },
  },
};

// Shared status translations
const TR_STATUSES = {
  active: 'Aktif', inactive: 'Pasif', pending: 'Beklemede', completed: 'Tamamlandı',
  draft: 'Taslak', published: 'Yayında', archived: 'Arşivlendi',
  confirmed: 'Onaylandı', cancelled: 'İptal', checkedIn: 'Giriş Yapıldı', checkedOut: 'Çıkış Yapıldı',
  approved: 'Onaylandı', rejected: 'Reddedildi', resolved: 'Çözüldü',
  connected: 'Bağlı', disconnected: 'Bağlantı Kesildi', failed: 'Başarısız',
  healthy: 'Sağlıklı', degraded: 'Bozulmuş', active: 'Aktif',
  signed: 'İmzalandı', expired: 'Süresi Doldu', archived: 'Arşivlendi',
  sent: 'Gönderildi', delivered: 'Teslim Edildi', read: 'Okundu',
  qualified: 'Nitelikli', unqualified: 'Niteliksiz', converted: 'Dönüştürüldü', won: 'Kazanıldı', lost: 'Kaybedildi',
  listed: 'Listelendi', sold: 'Satıldı', writeoff: 'Silindi',
  suspended: 'Askıya Alındı', verified: 'Doğrulandı',
};

function generateTR() {
  const trPath = path.join(LOCALES_DIR, 'tr.json');
  const trData = JSON.parse(fs.readFileSync(trPath, 'utf8'));

  let totalKeysAdded = 0;

  for (const [osName, config] of Object.entries(OS_MODULES)) {
    const trConfig = TR_TRANSLATIONS[osName] || { title: config.title, description: config.description };

    // Dashboard
    if (!trData[`${osName}.dashboard`]) {
      trData[`${osName}.dashboard`] = {
        title: trConfig.dashboard?.title || `${trConfig.title} Paneli`,
        description: trConfig.dashboard?.description || trConfig.description,
      };
      totalKeysAdded++;
    }

    // Statuses
    if (!trData[`${osName}.status`]) {
      trData[`${osName}.status`] = {};
      for (const [key, value] of Object.entries(config.statuses)) {
        trData[`${osName}.status`][key] = TR_STATUSES[key] || value;
      }
      totalKeysAdded++;
    }

    // Messages
    if (!trData[`${osName}.messages`]) {
      trData[`${osName}.messages`] = {
        success: `${trConfig.title} işlemi başarılı`,
        error: `${trConfig.title} işlemi başarısız`,
        confirm: `Bu ${trConfig.title} işlemini yapmak istediğinizden emin misiniz?`,
        loading: `${trConfig.title} isteği işleniyor...`,
      };
      totalKeysAdded++;
    }
  }

  fs.writeFileSync(trPath, JSON.stringify(trData, null, 2) + '\n', 'utf8');
  console.log(`\n✅ tr.json updated successfully!`);
  console.log(`   New keys added: ${totalKeysAdded}`);
  console.log(`   Total keys in tr.json: ${Object.keys(trData).length}`);
}

// Run
main();
