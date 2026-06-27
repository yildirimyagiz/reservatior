import 'package:flutter/material.dart';
import 'package:reservatior/features/client/property/presentation/pages/search_and_filters_page.dart';

import 'package:reservatior/features/admin/financial/expense_admin_page.dart';
import 'package:reservatior/features/admin/financial/payout_admin_page.dart';
import 'package:reservatior/features/client/agent/presentation/pages/agent_admin_page.dart';
import 'package:reservatior/features/admin/roles/roles_admin_page.dart';
import 'package:reservatior/features/admin/cloud/cloud_admin_page.dart';
import 'package:reservatior/features/admin/company/company_admin_page.dart';

// Batch 1: Financial
import 'package:reservatior/features/admin/financial/escrow_management_screen.dart';
import 'package:reservatior/features/admin/financial/commissions_screen.dart';
import 'package:reservatior/features/admin/financial/commission_rules_screen.dart';
import 'package:reservatior/features/admin/financial/invoices_screen.dart';
import 'package:reservatior/features/admin/financial/tax_records_screen.dart';

import 'package:reservatior/features/admin/financial/mortgages_screen.dart';
import 'package:reservatior/features/admin/financial/financial_reports_screen.dart';
import 'package:reservatior/features/admin/financial/extra_charges_screen.dart';
import 'package:reservatior/features/admin/financial/transactions_screen.dart';

// Batch 2: Security & Compliance
import 'package:reservatior/features/admin/security/advanced_security_screen.dart';
import 'package:reservatior/features/admin/compliance/compliance_dashboard_screen.dart';

// Batch 3: AI
import 'package:reservatior/features/admin/ai/fraud_detection_screen.dart';
import 'package:reservatior/features/admin/ai/sentiment_analysis_screen.dart';
import 'package:reservatior/features/admin/ai/predictive_maintenance_screen.dart';


// Batch 4: Operational
import 'package:reservatior/features/admin/agencies/agencies_management_screen.dart';
import 'package:reservatior/features/admin/invoices/customer_invoices_screen.dart';

import 'package:reservatior/features/admin/property/vacation_rentals_screen.dart';

// Batch 5: Organization
import 'package:reservatior/features/admin/organization/departments_screen.dart';
import 'package:reservatior/features/admin/organization/teams_screen.dart';
import 'package:reservatior/features/admin/organization/subscription_screen.dart';
import 'package:reservatior/features/admin/membership/membership_screen.dart';
import 'package:reservatior/features/admin/billing/billing_screen.dart';

// Batch 6: System
import 'package:reservatior/features/admin/system/system_monitoring_screen.dart';
import 'package:reservatior/features/admin/integrations/mls_integration_screen.dart';
import 'package:reservatior/features/admin/integrations/export_jobs_screen.dart';
import 'package:reservatior/features/admin/communication/comm_templates_screen.dart';

// Generated Missing Features
import 'package:reservatior/features/admin/account/account_management_screen.dart';
import 'package:reservatior/features/admin/achievement/achievement_management_screen.dart';
import 'package:reservatior/features/admin/ambassador_contract/ambassador_contract_management_screen.dart';
import 'package:reservatior/features/admin/amenity/amenity_management_screen.dart';
import 'package:reservatior/features/admin/analysis_job/analysis_job_management_screen.dart';
import 'package:reservatior/features/admin/analytics/analytics_management_screen.dart';
import 'package:reservatior/features/admin/api_integration/api_integration_management_screen.dart';
import 'package:reservatior/features/admin/api_key/api_key_management_screen.dart';
import 'package:reservatior/features/admin/appointment/appointment_management_screen.dart';
import 'package:reservatior/features/admin/attachment/attachment_management_screen.dart';
import 'package:reservatior/features/admin/attorney_management/attorney_management_management_screen.dart';
import 'package:reservatior/features/admin/automation_execution/automation_execution_management_screen.dart';
import 'package:reservatior/features/admin/automation_rule/automation_rule_management_screen.dart';
import 'package:reservatior/features/admin/brand_ambassador/brand_ambassador_management_screen.dart';
import 'package:reservatior/features/admin/calendar_event/calendar_event_management_screen.dart';
import 'package:reservatior/features/admin/channel/channel_management_screen.dart';
import 'package:reservatior/features/admin/client_relationship/client_relationship_management_screen.dart';
import 'package:reservatior/features/admin/contract_version/contract_version_management_screen.dart';
import 'package:reservatior/features/admin/coupons/coupons_management_screen.dart';
import 'package:reservatior/features/admin/currency/currency_management_screen.dart';
import 'package:reservatior/features/admin/dashboard/dashboard_management_screen.dart';
import 'package:reservatior/features/admin/dashboard_configuration/dashboard_configuration_management_screen.dart';
import 'package:reservatior/features/admin/dashboard_widget/dashboard_widget_management_screen.dart';
import 'package:reservatior/features/admin/deposit_protection/deposit_protection_management_screen.dart';
import 'package:reservatior/features/admin/discount/discount_management_screen.dart';
import 'package:reservatior/features/admin/earning/earning_management_screen.dart';
import 'package:reservatior/features/admin/event/event_management_screen.dart';
import 'package:reservatior/features/admin/event_attendee/event_attendee_management_screen.dart';
import 'package:reservatior/features/admin/exchange_rate/exchange_rate_management_screen.dart';
import 'package:reservatior/features/admin/export_file/export_file_management_screen.dart';
import 'package:reservatior/features/admin/export_job/export_job_management_screen.dart';
import 'package:reservatior/features/admin/external_rental_listing/external_rental_listing_management_screen.dart';
import 'package:reservatior/features/admin/extra_charge/extra_charge_management_screen.dart';
import 'package:reservatior/features/admin/favorite/favorite_management_screen.dart';
import 'package:reservatior/features/admin/filters/filters_management_screen.dart';
import 'package:reservatior/features/admin/floor_plan/floor_plan_management_screen.dart';
import 'package:reservatior/features/admin/gift_card/gift_card_management_screen.dart';
import 'package:reservatior/features/admin/government_integration/government_integration_management_screen.dart';
import 'package:reservatior/features/admin/guest/guest_management_screen.dart';
import 'package:reservatior/features/admin/guest_profile/guest_profile_management_screen.dart';
import 'package:reservatior/features/admin/guest_review/guest_review_management_screen.dart';
import 'package:reservatior/features/admin/hashtag/hashtag_management_screen.dart';
import 'package:reservatior/features/admin/health_check/health_check_management_screen.dart';
import 'package:reservatior/features/admin/home/home_management_screen.dart';
import 'package:reservatior/features/admin/home_information_pack/home_information_pack_management_screen.dart';
import 'package:reservatior/features/admin/immigration_status_check/immigration_status_check_management_screen.dart';
import 'package:reservatior/features/admin/included_service/included_service_management_screen.dart';
import 'package:reservatior/features/admin/increase/increase_management_screen.dart';
import 'package:reservatior/features/admin/integration_log/integration_log_management_screen.dart';
import 'package:reservatior/features/admin/investor_portfolio/investor_portfolio_management_screen.dart';
import 'package:reservatior/features/admin/job/job_management_screen.dart';
import 'package:reservatior/features/admin/key_management/key_management_management_screen.dart';
import 'package:reservatior/features/admin/lead_source/lead_source_management_screen.dart';
import 'package:reservatior/features/admin/ledger_entry/ledger_entry_management_screen.dart';
import 'package:reservatior/features/admin/listing/listing_management_screen.dart';
import 'package:reservatior/features/admin/listing_channel/listing_channel_management_screen.dart';
import 'package:reservatior/features/admin/listing_status_history/listing_status_history_management_screen.dart';
import 'package:reservatior/features/admin/listing_tag/listing_tag_management_screen.dart';
import 'package:reservatior/features/admin/location/location_management_screen.dart';
import 'package:reservatior/features/admin/loyalty_account/loyalty_account_management_screen.dart';
import 'package:reservatior/features/admin/map_data/map_data_management_screen.dart';
import 'package:reservatior/features/admin/map_layer/map_layer_management_screen.dart';
import 'package:reservatior/features/admin/marketplace/marketplace_management_screen.dart';
import 'package:reservatior/features/admin/mention/mention_management_screen.dart';
import 'package:reservatior/features/admin/message/message_management_screen.dart';
import 'package:reservatior/features/admin/ml_configuration/ml_configuration_management_screen.dart';
import 'package:reservatior/features/admin/ml_model/ml_model_management_screen.dart';
import 'package:reservatior/features/admin/mls_connection/mls_connection_management_screen.dart';
import 'package:reservatior/features/admin/mls_data_mapping/mls_data_mapping_management_screen.dart';
import 'package:reservatior/features/admin/mls_external_listing/mls_external_listing_management_screen.dart';
import 'package:reservatior/features/admin/mls_listing_enhancement/mls_listing_enhancement_management_screen.dart';
import 'package:reservatior/features/admin/mls_sync_job/mls_sync_job_management_screen.dart';
import 'package:reservatior/features/admin/mobile_device/mobile_device_management_screen.dart';
import 'package:reservatior/features/admin/more/more_management_screen.dart';
import 'package:reservatior/features/admin/negotiation_offer/negotiation_offer_management_screen.dart';
import 'package:reservatior/features/admin/neighborhood/neighborhood_management_screen.dart';
import 'package:reservatior/features/admin/notification/notification_management_screen.dart';
import 'package:reservatior/features/admin/offer/offer_management_screen.dart';
import 'package:reservatior/features/admin/offline_sync_queue/offline_sync_queue_management_screen.dart';
import 'package:reservatior/features/admin/org_subscription/org_subscription_management_screen.dart';
import 'package:reservatior/features/admin/performance_alert/performance_alert_management_screen.dart';
import 'package:reservatior/features/admin/permission/permission_management_screen.dart';
import 'package:reservatior/features/admin/photo/photo_management_screen.dart';
import 'package:reservatior/features/admin/plan/plan_management_screen.dart';
import 'package:reservatior/features/admin/post/post_management_screen.dart';
import 'package:reservatior/features/admin/predictive_model/predictive_model_management_screen.dart';
import 'package:reservatior/features/admin/pricing_rule/pricing_rule_management_screen.dart';
import 'package:reservatior/features/admin/project_alert/project_alert_management_screen.dart';
import 'package:reservatior/features/admin/project_analytics/project_analytics_management_screen.dart';
import 'package:reservatior/features/admin/project_report/project_report_management_screen.dart';
import 'package:reservatior/features/admin/queue_configuration/queue_configuration_management_screen.dart';
import 'package:reservatior/features/admin/queue_message/queue_message_management_screen.dart';
import 'package:reservatior/features/admin/quote/quote_management_screen.dart';
import 'package:reservatior/features/admin/recommendation_result/recommendation_result_management_screen.dart';
import 'package:reservatior/features/admin/reference_source/reference_source_management_screen.dart';
import 'package:reservatior/features/admin/referral/referral_management_screen.dart';
import 'package:reservatior/features/admin/rent_arrears/rent_arrears_management_screen.dart';
import 'package:reservatior/features/admin/rent_schedule/rent_schedule_management_screen.dart';
import 'package:reservatior/features/admin/rental_sync_job/rental_sync_job_management_screen.dart';
import 'package:reservatior/features/admin/report/report_management_screen.dart';
import 'package:reservatior/features/admin/report_execution/report_execution_management_screen.dart';
import 'package:reservatior/features/admin/review/review_management_screen.dart';
import 'package:reservatior/features/admin/right_to_rent_check/right_to_rent_check_management_screen.dart';
import 'package:reservatior/features/admin/route/route_management_screen.dart';
import 'package:reservatior/features/admin/scraping_job/scraping_job_management_screen.dart';
import 'package:reservatior/features/admin/session/session_management_screen.dart';
import 'package:reservatior/features/admin/shared_amenity/shared_amenity_management_screen.dart';
import 'package:reservatior/features/admin/signature_request/signature_request_management_screen.dart';
import 'package:reservatior/features/admin/signature_signer/signature_signer_management_screen.dart';
import 'package:reservatior/features/admin/social_impact_counter/social_impact_counter_management_screen.dart';
import 'package:reservatior/features/admin/social_impact_record/social_impact_record_management_screen.dart';
import 'package:reservatior/features/admin/tag/tag_management_screen.dart';
import 'package:reservatior/features/admin/ticket/ticket_management_screen.dart';
import 'package:reservatior/features/admin/user/user_management_screen.dart';
import 'package:reservatior/features/admin/user_activity_log/user_activity_log_management_screen.dart';
import 'package:reservatior/features/admin/user_preference/user_preference_management_screen.dart';
import 'package:reservatior/features/admin/vacation_rental/vacation_rental_management_screen.dart';
import 'package:reservatior/features/admin/vacation_rental_platform/vacation_rental_platform_management_screen.dart';
import 'package:reservatior/features/admin/verification/verification_management_screen.dart';
import 'package:reservatior/features/admin/video_content/video_content_management_screen.dart';
import 'package:reservatior/features/admin/virtual_tour/virtual_tour_management_screen.dart';
import 'package:reservatior/features/admin/webhook/webhook_management_screen.dart';
import 'package:reservatior/features/admin/webhook_delivery/webhook_delivery_management_screen.dart';
import 'package:reservatior/features/admin/welcome/welcome_management_screen.dart';

import 'package:reservatior/features/admin/property/property_management_screen.dart';
import 'package:reservatior/features/admin/reservation/reservation_management_screen.dart';
import 'package:reservatior/features/admin/contract/contract_management_screen.dart';
import 'package:reservatior/features/admin/payment/payment_management_screen.dart';
import 'package:reservatior/features/admin/financial/financial_management_screen.dart';

import 'package:reservatior/features/admin/ai_model/ai_model_management_screen.dart';
import 'package:reservatior/features/admin/audit_log/audit_log_management_screen.dart';
import 'package:reservatior/features/admin/organization/organization_management_screen.dart';
import 'package:reservatior/features/admin/system_metrics/system_metrics_management_screen.dart';
// Note: api_key is already imported, but we make sure the screen exists in our folder structure.

import 'package:reservatior/features/admin/marketing_campaign/marketing_campaign_management_screen.dart';
import 'package:reservatior/features/admin/task/task_management_screen.dart';
import 'package:reservatior/features/admin/document/document_management_screen.dart';
import 'package:reservatior/features/admin/agent_team/agent_team_management_screen.dart';
import 'package:reservatior/features/admin/facility/facility_management_screen.dart';

import 'package:reservatior/features/admin/solicitor/solicitor_management_screen.dart';
import 'package:reservatior/features/admin/maintenance/maintenance_work_order_management_screen.dart';

import 'package:reservatior/features/admin/lead/lead_management_screen.dart';
import 'package:reservatior/features/admin/project/project_management_screen.dart';
import 'package:reservatior/features/admin/deal/deal_management_screen.dart';
import 'package:reservatior/features/admin/solicitor/solicitor_management_screen.dart';
import 'package:reservatior/features/admin/maintenance/maintenance_work_order_management_screen.dart';

import 'package:reservatior/features/admin/agency/agency_management_screen.dart';
import 'package:reservatior/features/admin/tenants/tenant_management_screen.dart';
import 'package:reservatior/features/admin/leases/lease_management_screen.dart';
import 'package:reservatior/features/admin/vendors/vendor_profile_management_screen.dart';
import 'package:reservatior/features/admin/contacts/contact_management_screen.dart';

class FeatureRouter {
  static final Map<String, Widget Function()> adminPages = {
    'properties': () => const PropertyManagementScreen(),
    'budgets': () => Container(),
    'expenses': () => const ExpenseAdminPage(),
    'payouts': () => const PayoutAdminPage(),
    'agencies': () => const AgencyManagementScreen(),
    'tasks': () => const TaskManagementScreen(),
    'roles': () => const RolesAdminPage(),
    'documents': () => const DocumentManagementScreen(),
    'tenants': () => const TenantManagementScreen(),
    'leases': () => const LeaseManagementScreen(),
    'vendors': () => const VendorProfileManagementScreen(),
    'contacts': () => const ContactManagementScreen(),
    'maintenance': () => const MaintenanceWorkOrderManagementScreen(),
    'marketing': () => const MarketingCampaignManagementScreen(),
    'cloud': () => const CloudAdminPage(),
    'company': () => const CompanyAdminPage(),

    // Financial Additions
    'escrow_screen': () => const EscrowManagementScreen(),
    'commissions': () => const CommissionsScreen(),
    'commission_rules': () => const CommissionRulesScreen(),
    'invoices': () => const InvoicesScreen(),
    'tax_records': () => const TaxRecordsScreen(),
    'global_tax': () => Container(),
    'mortgages': () => const MortgagesScreen(),
    'financial_reports': () => const FinancialReportsScreen(),
    'extra_charges': () => const ExtraChargesScreen(),
    'transactions': () => const TransactionsScreen(),
    'payments': () => const PaymentManagementScreen(),

    // Security
    'audit_logs': () => const AuditLogManagementScreen(),
    'advanced_security': () => const AdvancedSecurityScreen(),
    'api_tokens': () => const ApiKeyManagementScreen(),
    'compliance': () => const ComplianceDashboardScreen(),

    // AI
    'ai_config': () => const AiModelManagementScreen(),
    'fraud_detection': () => const FraudDetectionScreen(),
    'sentiment_analysis': () => const SentimentAnalysisScreen(),
    'predictive_maintenance': () => const PredictiveMaintenanceScreen(),
    'predictive_analytics': () => const Scaffold(body: Center(child: Text('Predictive Analytics'))),

    // Operational
    'agencies_manage': () => const AgenciesManagementScreen(),
    'customer_invoices': () => const CustomerInvoicesScreen(),
    'reservations': () => const ReservationManagementScreen(),
    'tasks_manage': () => const TaskManagementScreen(),
    'property_analytics': () => const Scaffold(body: Center(child: Text('Property Analytics'))),
    'vacation_rentals': () => const VacationRentalsScreen(),

    // Organization
    'facilities': () => const FacilityManagementScreen(),
    'agents': () => const AgentTeamManagementScreen(),
    'organizations': () => const OrganizationManagementScreen(),
    'departments': () => const DepartmentsScreen(),
    'teams': () => const TeamsScreen(),
    'subscription': () => const SubscriptionScreen(),
    'membership': () => const MembershipScreen(),
    'billing': () => const BillingScreen(),

    // System
    'system_metrics': () => const SystemMetricsManagementScreen(),
    'system_monitoring': () => const SystemMonitoringScreen(),
    'mls_integration': () => const MlsIntegrationScreen(),
    'export_jobs': () => const ExportJobsScreen(),
    'comm_templates': () => const CommTemplatesScreen(),
    'documents_manage': () => const DocumentManagementScreen(),

    'financial_record': () => const FinancialManagementScreen(),
    // Generated Missing Features
    'account': () => const AccountManagementScreen(),
    'achievement': () => const AchievementManagementScreen(),
    'ambassador_contract': () => const AmbassadorContractManagementScreen(),
    'amenity': () => const AmenityManagementScreen(),
    'analysis_job': () => const AnalysisJobManagementScreen(),
    'analytics': () => const AnalyticsManagementScreen(),
    'api_integration': () => const ApiIntegrationManagementScreen(),
    'api_key': () => const ApiKeyManagementScreen(),
    'appointment': () => const AppointmentManagementScreen(),
    'attachment': () => const AttachmentManagementScreen(),
    'attorney_management': () => const AttorneyManagementManagementScreen(),
    'automation_execution': () => const AutomationExecutionManagementScreen(),
    'automation_rule': () => const AutomationRuleManagementScreen(),
    'booking': () => const ReservationManagementScreen(),
    'brand_ambassador': () => const BrandAmbassadorManagementScreen(),
    'calendar_event': () => const CalendarEventManagementScreen(),
    'channel': () => const ChannelManagementScreen(),
    'client_relationship': () => const ClientRelationshipManagementScreen(),
    'contract': () => const ContractManagementScreen(),
    'contract_version': () => const ContractVersionManagementScreen(),
    'coupons': () => const CouponsManagementScreen(),
    'currency': () => const CurrencyManagementScreen(),
    'dashboard': () => const DashboardManagementScreen(),
    'dashboard_configuration': () =>
        const DashboardConfigurationManagementScreen(),
    'dashboard_widget': () => const DashboardWidgetManagementScreen(),
    'deal': () => const DealManagementScreen(),
    'deposit_protection': () => const DepositProtectionManagementScreen(),
    'discount': () => const DiscountManagementScreen(),
    'earning': () => const EarningManagementScreen(),
    'event': () => const EventManagementScreen(),
    'event_attendee': () => const EventAttendeeManagementScreen(),
    'exchange_rate': () => const ExchangeRateManagementScreen(),
    'export_file': () => const ExportFileManagementScreen(),
    'export_job': () => const ExportJobManagementScreen(),
    'external_rental_listing': () =>
        const ExternalRentalListingManagementScreen(),
    'extra_charge': () => const ExtraChargeManagementScreen(),
    'favorite': () => const FavoriteManagementScreen(),
    'filters': () => const FiltersManagementScreen(),
    'floor_plan': () => const FloorPlanManagementScreen(),
    'gift_card': () => const GiftCardManagementScreen(),
    'government_integration': () =>
        const GovernmentIntegrationManagementScreen(),
    'guest': () => const GuestManagementScreen(),
    'guest_profile': () => const GuestProfileManagementScreen(),
    'guest_review': () => const GuestReviewManagementScreen(),
    'hashtag': () => const HashtagManagementScreen(),
    'health_check': () => const HealthCheckManagementScreen(),
    'home': () => const HomeManagementScreen(),
    'home_information_pack': () => const HomeInformationPackManagementScreen(),
    'immigration_status_check': () =>
        const ImmigrationStatusCheckManagementScreen(),
    'included_service': () => const IncludedServiceManagementScreen(),
    'increase': () => const IncreaseManagementScreen(),
    'integration_log': () => const IntegrationLogManagementScreen(),
    'investor_portfolio': () => const InvestorPortfolioManagementScreen(),
    'job': () => const JobManagementScreen(),
    'key_management': () => const KeyManagementManagementScreen(),
    'lead': () => const LeadManagementScreen(),
    'lead_source': () => const LeadSourceManagementScreen(),
    'ledger_entry': () => const LedgerEntryManagementScreen(),
    'listing': () => const ListingManagementScreen(),
    'listing_channel': () => const ListingChannelManagementScreen(),
    'listing_status_history': () =>
        const ListingStatusHistoryManagementScreen(),
    'listing_tag': () => const ListingTagManagementScreen(),
    'location': () => const LocationManagementScreen(),
    'loyalty_account': () => const LoyaltyAccountManagementScreen(),
    'map_data': () => const MapDataManagementScreen(),
    'map_layer': () => const MapLayerManagementScreen(),
    'marketplace': () => const MarketplaceManagementScreen(),
    'mention': () => const MentionManagementScreen(),
    'message': () => const MessageManagementScreen(),
    'ml_configuration': () => const MlConfigurationManagementScreen(),
    'ml_model': () => const MlModelManagementScreen(),
    'mls_connection': () => const MlsConnectionManagementScreen(),
    'mls_data_mapping': () => const MlsDataMappingManagementScreen(),
    'mls_external_listing': () => const MlsExternalListingManagementScreen(),
    'mls_listing_enhancement': () =>
        const MlsListingEnhancementManagementScreen(),
    'mls_sync_job': () => const MlsSyncJobManagementScreen(),
    'mobile_device': () => const MobileDeviceManagementScreen(),
    'more': () => const MoreManagementScreen(),
    'negotiation_offer': () => const NegotiationOfferManagementScreen(),
    'neighborhood': () => const NeighborhoodManagementScreen(),
    'notification': () => const NotificationManagementScreen(),
    'offer': () => const OfferManagementScreen(),
    'offline_sync_queue': () => const OfflineSyncQueueManagementScreen(),
    'org_subscription': () => const OrgSubscriptionManagementScreen(),
    'performance_alert': () => const PerformanceAlertManagementScreen(),
    'permission': () => const PermissionManagementScreen(),
    'photo': () => const PhotoManagementScreen(),
    'plan': () => const PlanManagementScreen(),
    'post': () => const PostManagementScreen(),
    'predictive_model': () => const PredictiveModelManagementScreen(),
    'pricing_rule': () => const PricingRuleManagementScreen(),
    'project': () => const ProjectManagementScreen(),
    'project_alert': () => const ProjectAlertManagementScreen(),
    'project_analytics': () => const ProjectAnalyticsManagementScreen(),
    'project_report': () => const ProjectReportManagementScreen(),
    'queue_configuration': () => const QueueConfigurationManagementScreen(),
    'queue_message': () => const QueueMessageManagementScreen(),
    'quote': () => const QuoteManagementScreen(),
    'recommendation_result': () => const RecommendationResultManagementScreen(),
    'reference_source': () => const ReferenceSourceManagementScreen(),
    'referral': () => const ReferralManagementScreen(),
    'rent_arrears': () => const RentArrearsManagementScreen(),
    'rent_schedule': () => const RentScheduleManagementScreen(),
    'rental_sync_job': () => const RentalSyncJobManagementScreen(),
    'report': () => const ReportManagementScreen(),
    'report_execution': () => const ReportExecutionManagementScreen(),
    'review': () => const ReviewManagementScreen(),
    'right_to_rent_check': () => const RightToRentCheckManagementScreen(),
    'route': () => const RouteManagementScreen(),
    'scraping_job': () => const ScrapingJobManagementScreen(),
    'session': () => const SessionManagementScreen(),
    'shared_amenity': () => const SharedAmenityManagementScreen(),
    'signature_request': () => const SignatureRequestManagementScreen(),
    'signature_signer': () => const SignatureSignerManagementScreen(),
    'social_impact_counter': () => const SocialImpactCounterManagementScreen(),
    'social_impact_record': () => const SocialImpactRecordManagementScreen(),
    'solicitor_management': () => const SolicitorManagementScreen(),
    'tag': () => const TagManagementScreen(),
    'ticket': () => const TicketManagementScreen(),
    'user': () => const UserManagementScreen(),
    'user_activity_log': () => const UserActivityLogManagementScreen(),
    'user_preference': () => const UserPreferenceManagementScreen(),
    'vacation_rental': () => const VacationRentalManagementScreen(),
    'vacation_rental_platform': () =>
        const VacationRentalPlatformManagementScreen(),
    'verification': () => const VerificationManagementScreen(),
    'video_content': () => const VideoContentManagementScreen(),
    'virtual_tour': () => const VirtualTourManagementScreen(),
    'webhook': () => const WebhookManagementScreen(),
    'webhook_delivery': () => const WebhookDeliveryManagementScreen(),
    'welcome': () => const WelcomeManagementScreen(),
  };
  static final Map<String, Widget Function()> clientPages = {
    'property_search': () => const SearchAndFiltersPage(),
  };

  static Widget getAdminPage(String feature) {
    if (adminPages.containsKey(feature)) {
      return adminPages[feature]!();
    }
    return _PlaceholderPage(feature: feature, type: 'admin');
  }

  static Widget getClientPage(String feature) {
    if (clientPages.containsKey(feature)) {
      return clientPages[feature]!();
    }
    return _PlaceholderPage(feature: feature, type: 'client');
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String feature, type;
  const _PlaceholderPage({required this.feature, required this.type});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(feature)),
    body: Center(child: Text('Under Construction: $feature $type')),
  );
}
