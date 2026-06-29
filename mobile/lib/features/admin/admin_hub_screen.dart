import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class AdminHubScreen extends ConsumerStatefulWidget {
  const AdminHubScreen({super.key});

  @override
  ConsumerState<AdminHubScreen> createState() => _AdminHubScreenState();
}

class _AdminHubScreenState extends ConsumerState<AdminHubScreen> {
  int _currentIndex = 0;
  String _searchQuery = '';
final List<Map<String, dynamic>> _allModules = [
  {'title': 'mobile.admin.modules.account'.tr(), 'route': '/admin/account', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.achievement'.tr(), 'route': '/admin/achievement', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.agencies'.tr(), 'route': '/admin/agencies', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.agency'.tr(), 'route': '/admin/agency', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.agent_team'.tr(), 'route': '/admin/agent-team', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.agents'.tr(), 'route': '/admin/agents', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.ai'.tr(), 'route': '/admin/ai', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.ai_model'.tr(), 'route': '/admin/ai-model', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.ambassador_contract'.tr(), 'route': '/admin/ambassador-contract', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.amenity'.tr(), 'route': '/admin/amenity', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.analysis_job'.tr(), 'route': '/admin/analysis-job', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.analytics'.tr(), 'route': '/admin/analytics', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.api_integration'.tr(), 'route': '/admin/api-integration', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.api_key'.tr(), 'route': '/admin/api-key', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.appointment'.tr(), 'route': '/admin/appointment', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.attachment'.tr(), 'route': '/admin/attachment', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.attorney_management'.tr(), 'route': '/admin/attorney-management', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.audit_log'.tr(), 'route': '/admin/audit-log', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.automation_execution'.tr(), 'route': '/admin/automation-execution', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.automation_rule'.tr(), 'route': '/admin/automation-rule', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.billing'.tr(), 'route': '/admin/billing', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.booking'.tr(), 'route': '/admin/booking', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.brand_ambassador'.tr(), 'route': '/admin/brand-ambassador', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.calendar_event'.tr(), 'route': '/admin/calendar-event', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.channel'.tr(), 'route': '/admin/channel', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.client_relationship'.tr(), 'route': '/admin/client-relationship', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.cloud'.tr(), 'route': '/admin/cloud', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.communication'.tr(), 'route': '/admin/communication', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.company'.tr(), 'route': '/admin/company', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.compliance'.tr(), 'route': '/admin/compliance', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.contacts'.tr(), 'route': '/admin/contacts', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.contract'.tr(), 'route': '/admin/contract', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.contract_version'.tr(), 'route': '/admin/contract-version', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.coupons'.tr(), 'route': '/admin/coupons', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.currency'.tr(), 'route': '/admin/currency', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.dashboard'.tr(), 'route': '/admin/dashboard', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.dashboard_configuration'.tr(), 'route': '/admin/dashboard-configuration', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.dashboard_widget'.tr(), 'route': '/admin/dashboard-widget', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.deal'.tr(), 'route': '/admin/deal', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.deposit_protection'.tr(), 'route': '/admin/deposit-protection', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.discount'.tr(), 'route': '/admin/discount', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.document'.tr(), 'route': '/admin/document', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.documents'.tr(), 'route': '/admin/documents', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.earning'.tr(), 'route': '/admin/earning', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.escrow'.tr(), 'route': '/admin/escrow', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.escrow_account'.tr(), 'route': '/admin/escrow-account', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.event'.tr(), 'route': '/admin/event', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.event_attendee'.tr(), 'route': '/admin/event-attendee', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.exchange_rate'.tr(), 'route': '/admin/exchange-rate', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.export_file'.tr(), 'route': '/admin/export-file', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.export_job'.tr(), 'route': '/admin/export-job', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.external_rental_listing'.tr(), 'route': '/admin/external-rental-listing', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.extra_charge'.tr(), 'route': '/admin/extra-charge', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.facilities'.tr(), 'route': '/admin/facilities', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.facility'.tr(), 'route': '/admin/facility', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.favorite'.tr(), 'route': '/admin/favorite', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.filters'.tr(), 'route': '/admin/filters', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.financial'.tr(), 'route': '/admin/financial', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.floor_plan'.tr(), 'route': '/admin/floor-plan', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.gift_card'.tr(), 'route': '/admin/gift-card', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.government_integration'.tr(), 'route': '/admin/government-integration', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.guest'.tr(), 'route': '/admin/guest', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.guest_profile'.tr(), 'route': '/admin/guest-profile', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.guest_review'.tr(), 'route': '/admin/guest-review', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.hashtag'.tr(), 'route': '/admin/hashtag', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.health_check'.tr(), 'route': '/admin/health-check', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.home'.tr(), 'route': '/admin/home', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.home_information_pack'.tr(), 'route': '/admin/home-information-pack', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.immigration_status_check'.tr(), 'route': '/admin/immigration-status-check', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.included_service'.tr(), 'route': '/admin/included-service', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.increase'.tr(), 'route': '/admin/increase', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.integration_log'.tr(), 'route': '/admin/integration-log', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.integrations'.tr(), 'route': '/admin/integrations', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.investor_portfolio'.tr(), 'route': '/admin/investor-portfolio', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.invoices'.tr(), 'route': '/admin/invoices', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.job'.tr(), 'route': '/admin/job', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.key_management'.tr(), 'route': '/admin/key-management', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.lead'.tr(), 'route': '/admin/lead', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.lead_source'.tr(), 'route': '/admin/lead-source', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.lease'.tr(), 'route': '/admin/lease', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.leases'.tr(), 'route': '/admin/leases', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.ledger_entry'.tr(), 'route': '/admin/ledger-entry', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.listing'.tr(), 'route': '/admin/listing', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.listing_channel'.tr(), 'route': '/admin/listing-channel', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.listing_status_history'.tr(), 'route': '/admin/listing-status-history', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.listing_tag'.tr(), 'route': '/admin/listing-tag', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.location'.tr(), 'route': '/admin/location', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.loyalty_account'.tr(), 'route': '/admin/loyalty-account', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.maintenance'.tr(), 'route': '/admin/maintenance', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.map_data'.tr(), 'route': '/admin/map-data', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.map_layer'.tr(), 'route': '/admin/map-layer', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.marketing'.tr(), 'route': '/admin/marketing', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.marketing_campaign'.tr(), 'route': '/admin/marketing-campaign', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.marketplace'.tr(), 'route': '/admin/marketplace', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.membership'.tr(), 'route': '/admin/membership', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.mention'.tr(), 'route': '/admin/mention', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.message'.tr(), 'route': '/admin/message', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.ml_configuration'.tr(), 'route': '/admin/ml-configuration', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.ml_model'.tr(), 'route': '/admin/ml-model', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.mls_connection'.tr(), 'route': '/admin/mls-connection', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.mls_data_mapping'.tr(), 'route': '/admin/mls-data-mapping', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.mls_external_listing'.tr(), 'route': '/admin/mls-external-listing', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.mls_listing_enhancement'.tr(), 'route': '/admin/mls-listing-enhancement', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.mls_sync_job'.tr(), 'route': '/admin/mls-sync-job', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.mobile_device'.tr(), 'route': '/admin/mobile-device', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.more'.tr(), 'route': '/admin/more', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.negotiation_offer'.tr(), 'route': '/admin/negotiation-offer', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.neighborhood'.tr(), 'route': '/admin/neighborhood', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.notification'.tr(), 'route': '/admin/notification', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.offer'.tr(), 'route': '/admin/offer', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.offline_sync_queue'.tr(), 'route': '/admin/offline-sync-queue', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.org_subscription'.tr(), 'route': '/admin/org-subscription', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.organization'.tr(), 'route': '/admin/organization', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.payment'.tr(), 'route': '/admin/payment', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.performance_alert'.tr(), 'route': '/admin/performance-alert', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.permission'.tr(), 'route': '/admin/permission', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.photo'.tr(), 'route': '/admin/photo', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.plan'.tr(), 'route': '/admin/plan', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.post'.tr(), 'route': '/admin/post', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.predictive_model'.tr(), 'route': '/admin/predictive-model', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.pricing_rule'.tr(), 'route': '/admin/pricing-rule', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.project'.tr(), 'route': '/admin/project', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.project_alert'.tr(), 'route': '/admin/project-alert', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.project_analytics'.tr(), 'route': '/admin/project-analytics', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.project_report'.tr(), 'route': '/admin/project-report', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.property'.tr(), 'route': '/admin/property', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.queue_configuration'.tr(), 'route': '/admin/queue-configuration', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.queue_message'.tr(), 'route': '/admin/queue-message', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.quote'.tr(), 'route': '/admin/quote', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.recommendation_result'.tr(), 'route': '/admin/recommendation-result', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.reference_source'.tr(), 'route': '/admin/reference-source', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.referral'.tr(), 'route': '/admin/referral', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.rent_arrears'.tr(), 'route': '/admin/rent-arrears', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.rent_schedule'.tr(), 'route': '/admin/rent-schedule', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.rental_sync_job'.tr(), 'route': '/admin/rental-sync-job', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.report'.tr(), 'route': '/admin/report', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.report_execution'.tr(), 'route': '/admin/report-execution', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.reservation'.tr(), 'route': '/admin/reservation', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.reservations'.tr(), 'route': '/admin/reservations', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.review'.tr(), 'route': '/admin/review', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.right_to_rent_check'.tr(), 'route': '/admin/right-to-rent-check', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.roles'.tr(), 'route': '/admin/roles', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.route'.tr(), 'route': '/admin/route', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.scraping_job'.tr(), 'route': '/admin/scraping-job', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.security'.tr(), 'route': '/admin/security', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.session'.tr(), 'route': '/admin/session', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.shared'.tr(), 'route': '/admin/shared', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.shared_amenity'.tr(), 'route': '/admin/shared-amenity', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.signature_request'.tr(), 'route': '/admin/signature-request', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.signature_signer'.tr(), 'route': '/admin/signature-signer', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.social_impact_counter'.tr(), 'route': '/admin/social-impact-counter', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.social_impact_record'.tr(), 'route': '/admin/social-impact-record', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.solicitor'.tr(), 'route': '/admin/solicitor', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.solicitor_management'.tr(), 'route': '/admin/solicitor-management', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.subscription'.tr(), 'route': '/admin/subscription', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.system'.tr(), 'route': '/admin/system', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.system_metrics'.tr(), 'route': '/admin/system-metrics', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.tag'.tr(), 'route': '/admin/tag', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.task'.tr(), 'route': '/admin/task', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.tasks'.tr(), 'route': '/admin/tasks', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.tenants'.tr(), 'route': '/admin/tenants', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.ticket'.tr(), 'route': '/admin/ticket', 'category': 'mobile.admin.categories.operations'.tr()},
  {'title': 'mobile.admin.modules.user'.tr(), 'route': '/admin/user', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.user_activity_log'.tr(), 'route': '/admin/user-activity-log', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.user_preference'.tr(), 'route': '/admin/user-preference', 'category': 'mobile.admin.categories.users'.tr()},
  {'title': 'mobile.admin.modules.vacation_rental'.tr(), 'route': '/admin/vacation-rental', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.vacation_rental_platform'.tr(), 'route': '/admin/vacation-rental-platform', 'category': 'mobile.admin.categories.properties'.tr()},
  {'title': 'mobile.admin.modules.vendors'.tr(), 'route': '/admin/vendors', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.verification'.tr(), 'route': '/admin/verification', 'category': 'mobile.admin.categories.financials'.tr()},
  {'title': 'mobile.admin.modules.video_content'.tr(), 'route': '/admin/video-content', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.virtual_tour'.tr(), 'route': '/admin/virtual-tour', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.webhook'.tr(), 'route': '/admin/webhook', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.webhook_delivery'.tr(), 'route': '/admin/webhook-delivery', 'category': 'mobile.admin.categories.system'.tr()},
  {'title': 'mobile.admin.modules.welcome'.tr(), 'route': '/admin/welcome', 'category': 'mobile.admin.categories.system'.tr()},
  // Moat Strategic Modules
  {'title': 'Contract State Machine', 'route': '/contract-state-machine', 'category': 'Financials'},
  {'title': 'Revenue DAG', 'route': '/revenue-dag', 'category': 'Financials'},
  {'title': 'Escrow Vault', 'route': '/finance-escrow', 'category': 'Financials'},
  {'title': 'General Ledger', 'route': '/finance-ledger', 'category': 'Financials'},
  {'title': 'Payouts', 'route': '/finance-payouts', 'category': 'Financials'},
  {'title': 'Settlements', 'route': '/finance-settlements', 'category': 'Financials'},
  {'title': 'Payment Routing', 'route': '/payment-routing', 'category': 'Financials'},
  {'title': 'Failover Engine', 'route': '/failover-engine', 'category': 'Operations'},
  {'title': 'Agent OS Dashboard', 'route': '/agent-os', 'category': 'Users'},
  {'title': 'Agent Compliance', 'route': '/agent-compliance', 'category': 'Users'},
  {'title': 'Agent Verification', 'route': '/agent-verification', 'category': 'Users'},
  {'title': 'Behavioral Scoring', 'route': '/agent-scoring', 'category': 'Users'},
];

  final List<String> _categories = [
    'System',
    'Users',
    'Properties',
    'Financials',
    'Operations'
  ];

  final List<IconData> _categoryIcons = [
    Icons.dashboard,
    Icons.people,
    Icons.apartment,
    Icons.account_balance,
    Icons.work_history
  ];

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final currentCategory = _categories[_currentIndex];

    final filteredModules = _allModules.where((m) {
      final matchesSearch = m['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _searchQuery.isNotEmpty || m['category'] == currentCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        title: Text(
          _searchQuery.isNotEmpty ? 'Arama Sonuçları' : 'Admin: $currentCategory',
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                hintText: 'Search modules...',
                hintStyle: TextStyle(color: colors.textSecondary.withValues(alpha: 0.5)),
                prefixIcon: Icon(Icons.search, color: colors.textSecondary),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: filteredModules.length,
              itemBuilder: (context, index) {
                final module = filteredModules[index];
                return InkWell(
                  onTap: () => context.push(module['route']),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.admin_panel_settings, color: AppColors.primary, size: 28),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          module['title'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            color: colors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _searchQuery = ''; // Clear search when switching tabs
          });
        },
        backgroundColor: colors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: List.generate(_categories.length, (index) {
          return BottomNavigationBarItem(
            icon: Icon(_categoryIcons[index]),
            label: _categories[index],
          );
        }),
      ),
    );
  }
}
