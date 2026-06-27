const fs = require("fs");
const path = require("path");

const apiEndpointsDart = fs.readFileSync("../mobile/lib/core/network/api_endpoints.dart", "utf8");
const expectedPrefixes = {};

// Parse API Endpoints from dart
const lines = apiEndpointsDart.split("\n");
for (const line of lines) {
  const match = line.match(/static String get (\w+)\s*=>\s*'(\$_apiPrefix|\$baseUrl)\/([^']+)';/);
  if (match) {
    const key = match[1];
    let route = match[3];
    if (match[2] === "$baseUrl" && route.startsWith("api/v1/")) {
      route = route.substring(7);
    }
    expectedPrefixes[key] = "/" + route;
  }
}

// Custom manual mappings for AI endpoints and others where names don't map trivially:
const manualMappings = {
  "aimodel.ts": "/ai-models",
  "aichatbot-session.ts": "/ai-chatbot-sessions",
  "aichat-handoffs.ts": "/ai-chat-handoffs",
  "aichat-message.ts": "/ai-chat-messages",
  "aifraud-detection.ts": "/ai-fraud-detections",
  "aiimage-analysis.ts": "/ai-ext/image-analyses",
  "aiinvestment-analysis.ts": "/ai-investment-analyses",
  "ailead-scoring.ts": "/ai-lead-scores",
  "aimarket-analysis.ts": "/ai-market-analyses",
  "aimodel-deployment.ts": "/ai-model-deployments",
  "aiprediction.ts": "/ai-predictions",
  "aipredictive-maintenance.ts": "/ai-predictive-maintenances",
  "aiprice-optimization.ts": "/ai-price-optimizations",
  "aiproperty-description.ts": "/ai-property-descriptions",
  "aiproperty-valuation.ts": "/ai-property-valuations",
  "airecommendation.ts": "/ai-recommendations",
  "aisentiment-analysis.ts": "/ai-sentiment-analyses",
  "aitenant-screening.ts": "/ai-tenant-screenings",
  "aivaluation-model.ts": "/ai-valuation-models",
  // and other pluralized stuff
  "account.ts": "/accounts",
  "role.ts": "/roles",
  "amenity.ts": "/amenities",
  "category.ts": "/categories",
  "valuation.ts": "/valuations",
  "ownership-verification.ts": "/ownership-verifications",
  "agency.ts": "/agencies",
  "agent-assignment.ts": "/agent-assignments",
  "agent-team.ts": "/agent-teams",
  "video-content.ts": "/video-contents",
  "virtual-tour.ts": "/virtual-tours",
  "webhook.ts": "/webhooks",
  "webhook-delivery.ts": "/webhook-deliveries",
  "ticket.ts": "/tickets",
  "user-activity-log.ts": "/user-activity-logs",
  "user-financial-profile.ts": "/user-financial-profiles",
  "user-preference.ts": "/user-preferences",
  "vacation-rental-platform.ts": "/vacation-rental-platforms",
  "vacation-rental.ts": "/vacation-rentals",
  "vendor-profile.ts": "/vendor-profiles",
  "tax-depreciation.ts": "/tax-depreciations",
  "tax-record.ts": "/tax-record",
  "tenant.ts": "/tenants",
  "tenant-application.ts": "/tenant-applications",
  "tax1099-form.ts": "/tax-1099-forms",
  "communication.ts": "/communications",
  "channel.ts": "/communications/channels",
  "achievement.ts": "/achievements",
  "ambassador-campaign.ts": "/ambassador-campaigns",
  "ambassador-contract.ts": "/ambassador-contracts",
  "commission-rule.ts": "/financials/commission-rules",
  "earning.ts": "/financials/earnings",
  "payment.ts": "/payments",
  "signer.ts": "/legal/signers",
  "solicitor.ts": "/legal/solicitors",
  "document.ts": "/legal/documents",
  "automation-execution.ts": "/system/automation-executions",
  "automation-task.ts": "/system/automation-tasks",
  "language.ts": "/system/languages",
  "audit-log.ts": "/audit-logs",
  "system-metric.ts": "/system-metrics",
  "exchange-rate.ts": "/exchange-rates",
  "document-analysis.ts": "/document-analyses",
  "plan.ts": "/plans",
  "rent-schedule.ts": "/rent-schedules",
  "rent-arrear.ts": "/rent-arrears",
  "rental-sync-job.ts": "/rental-sync-jobs",
  "referral.ts": "/referrals",
  "reference-source.ts": "/reference-sources",
  "recommendation-result.ts": "/recommendation-results",
  "quote.ts": "/quotes",
  "queue-message.ts": "/queue-messages",
  "queue-configuration.ts": "/queue-configurations",
  "property-viewing.ts": "/property-viewing",
  "property-promotion.ts": "/property-promotion",
  "property-photo.ts": "/property-photo",
  "property-offer.ts": "/property-offer",
  "property-inventory.ts": "/property-inventory",
  "property-disclosure.ts": "/property-disclosure",
  "property-compliance.ts": "/property-compliance",
  "property-amenity.ts": "/property-amenity",
  "project.ts": "/projects",
  "project-report.ts": "/project-reports",
  "project-analytics.ts": "/project-analyticses",
  "project-alert.ts": "/project-alerts",
  "pricing-rule.ts": "/pricing-rules",
  "predictive-model.ts": "/predictive-models",
  "post.ts": "/posts",
  "photo.ts": "/photos",
  "permission.ts": "/permissions",
  "performance-alert.ts": "/performance-alerts",
  "payout.ts": "/payout",
  "payment-negotiation.ts": "/payment-negotiations",
  "payment-installment.ts": "/payment-installments",
  "org-subscription.ts": "/org-subscriptions",
  "offline-sync-queue.ts": "/offline-sync-queues",
  "offer.ts": "/offers",
  "neighborhood.ts": "/neighborhoods",
  "negotiation-offer.ts": "/negotiation-offers",
  "mortgage.ts": "/mortgages",
  "mortgage-pre-approval.ts": "/mortgage-pre-approvals",
  "mortgage-offer.ts": "/mortgage-offers",
  "mobile-device.ts": "/mobile-devices",
  "mls-sync-job.ts": "/mls-sync-jobs",
  "mls-listing-enhancement.ts": "/mls-listing-enhancements",
  "mls-external-listing.ts": "/mls-external-listings",
  "mls-data-mapping.ts": "/mls-data-mappings",
  "mls-connection.ts": "/mls-connections",
  "ml-model.ts": "/ml-models",
  "ml-configuration.ts": "/ml-configurations",
  "mention.ts": "/mentions",
  "marketing-campaign.ts": "/marketing-campaigns",
  "map-layer.ts": "/map-layers",
  "map-data.ts": "/map-datas",
  "maintenance-work-order.ts": "/maintenance-work-orders",
  "maintenance-block.ts": "/maintenance-blocks",
  "loyalty-account.ts": "/loyalty-accounts",
  "location.ts": "/locations",
  "listing-status-history.ts": "/listing-status-histories",
  "ledger-entry.ts": "/ledger-entries",
  "lease-renewal.ts": "/lease-renewals",
  "lead-source.ts": "/lead-sources",
  "key-management.ts": "/key-managements",
  "job.ts": "/jobs",
  "investor-property.ts": "/investor-properties",
  "investor-portfolio.ts": "/investor-portfolios",
  "integration-log.ts": "/integration-logs",
  "increase.ts": "/increases",
  "included-service.ts": "/included-services",
  "immigration-status-check.ts": "/immigration-status-checks",
  "home-information-pack.ts": "/home-information-pack",
  "health-check.ts": "/health-checks",
  "hashtag.ts": "/hashtags",
  "guest.ts": "/guests",
  "guest-review.ts": "/guest-reviews",
  "guest-profile.ts": "/guest-profiles",
  "government-integration.ts": "/government-integrations",
  "gift-card.ts": "/gift-cards",
  "floor-plan.ts": "/floor-plan",
  "financial-record.ts": "/financial-record",
  "favorite.ts": "/favorites",
  "facility-block.ts": "/facility-block",
  "facility.ts": "/facility",
  "extra-charge.ts": "/extra-charge",
  "external-rental-listing.ts": "/external-rental-listings",
  "export-job.ts": "/export-jobs",
  "export-file.ts": "/export-files",
  "expense.ts": "/expense",
  "event.ts": "/events",
  "event-attendee.ts": "/event-attendees",
  "document-template.ts": "/document-templates",
  "discount.ts": "/discounts",
  "deposit-protection.ts": "/deposit-protections",
  "dashboard-widget.ts": "/dashboard-widgets",
  "dashboard-configuration.ts": "/dashboard-configurations",
  "currency.ts": "/currencies",
  "contract-version.ts": "/contract-versions",
  "compliance-record.ts": "/compliance-record",
  "communication-template.ts": "/communication-templates",
  "communication-log.ts": "/communication-logs",
  "calendar-event.ts": "/calendar-events",
  "budget.ts": "/budget",
  "brand-ambassador.ts": "/brand-ambassadors",
  "availability.ts": "/availabilities",
  "automation-rule.ts": "/automation-rules",
  "attorney-management.ts": "/attorney-managements",
  "appointment.ts": "/appointments",
  "api-token.ts": "/api-tokens",
  "api-key.ts": "/api-keys",
  "analysis-job.ts": "/analysis-jobs",
  "agent-team-member.ts": "/agent-team-members",
  "review.ts": "/reviews",
  "report.ts": "/reports",
  "report-execution.ts": "/report-executions",
  "shared-amenity.ts": "/shared-amenities",
  "session.ts": "/sessions",
  "security-deposit-protection.ts": "/security-deposit-protections",
  "scraping-job.ts": "/scraping-jobs",
  "role-permission.ts": "/role-permissions",
  "right-to-rent-check.ts": "/right-to-rent-checks",
  "signature-signer.ts": "/signature-signers",
  "signature-request.ts": "/signature-requests",
  "social-impact-record.ts": "/social-impact-records",
  "social-impact-counter.ts": "/social-impact-counters",
  "solicitor-management.ts": "/solicitor-managements"
};

const routesDir = "src/routes";
const files = fs.readdirSync(routesDir).filter(f => f.endsWith(".ts"));

let modifiedCount = 0;
for (const file of files) {
  const filePath = path.join(routesDir, file);
  let content = fs.readFileSync(filePath, "utf8");
  
  const expectedPath = manualMappings[file];
  if (expectedPath) {
    const newContent = content.replace(/prefix:\s*"([^"]+)"/, `prefix: "${expectedPath}"`);
    if (newContent !== content) {
      fs.writeFileSync(filePath, newContent, "utf8");
      modifiedCount++;
      console.log(`Updated ${file} -> ${expectedPath}`);
    }
  }
}
console.log(`Total files updated: ${modifiedCount}`);
