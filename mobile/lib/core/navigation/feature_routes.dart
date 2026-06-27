import 'package:go_router/go_router.dart';
import 'package:reservatior/features/client/account/presentation/pages/account_admin_page.dart';
import 'package:reservatior/features/client/achievement/presentation/pages/achievement_admin_page.dart';
import 'package:reservatior/features/client/agency/presentation/pages/agency_admin_page.dart';
import 'package:reservatior/features/client/agent/presentation/pages/agent_admin_page.dart';
import 'package:reservatior/features/client/agent_assignment/presentation/pages/agent_assignment_admin_page.dart';
import 'package:reservatior/features/client/agent_performance/presentation/pages/agent_performance_admin_page.dart';
import 'package:reservatior/features/client/agent_team/presentation/pages/agent_team_admin_page.dart';
import 'package:reservatior/features/client/agent_team_member/presentation/pages/agent_team_member_admin_page.dart';
import 'package:reservatior/features/client/ai_chat_handoff/presentation/pages/ai_chat_handoff_admin_page.dart';
import 'package:reservatior/features/client/ai_chat_message/presentation/pages/ai_chat_message_admin_page.dart';
import 'package:reservatior/features/client/ai_chatbot_session/presentation/pages/ai_chatbot_session_admin_page.dart';
// ai_lead_score removed: duplicate of ai_lead_scoring
import 'package:reservatior/features/client/ai_model/presentation/pages/ai_model_admin_page.dart';
import 'package:reservatior/features/client/ai_recommendation/presentation/pages/ai_recommendation_admin_page.dart';
import 'package:reservatior/features/client/ambassador_campaign/presentation/pages/ambassador_campaign_admin_page.dart';
import 'package:reservatior/features/client/ambassador_contract/presentation/pages/ambassador_contract_admin_page.dart';
import 'package:reservatior/features/client/amenity/presentation/pages/amenity_admin_page.dart';
import 'package:reservatior/features/client/analysis_job/presentation/pages/analysis_job_admin_page.dart';
import 'package:reservatior/features/client/analytics/presentation/pages/analytics_admin_page.dart';
import 'package:reservatior/features/client/api_integration/presentation/pages/api_integration_admin_page.dart';
import 'package:reservatior/features/client/api_key/presentation/pages/api_key_admin_page.dart';
import 'package:reservatior/features/client/api_token/presentation/pages/api_token_admin_page.dart';
import 'package:reservatior/features/client/appointment/presentation/pages/appointment_admin_page.dart';
import 'package:reservatior/features/client/attachment/presentation/pages/attachment_admin_page.dart';
import 'package:reservatior/features/client/attorney_management/presentation/pages/attorney_management_admin_page.dart';
import 'package:reservatior/features/client/audit_log/presentation/pages/audit_log_admin_page.dart';
import 'package:reservatior/features/client/automation_execution/presentation/pages/automation_execution_admin_page.dart';
import 'package:reservatior/features/client/automation_rule/presentation/pages/automation_rule_admin_page.dart';
import 'package:reservatior/features/client/automation_task/presentation/pages/automation_task_admin_page.dart';
import 'package:reservatior/features/client/availability/presentation/pages/availability_admin_page.dart';
import 'package:reservatior/features/client/booking/presentation/pages/booking_admin_page.dart';
import 'package:reservatior/features/client/brand_ambassador/presentation/pages/brand_ambassador_admin_page.dart';
import 'package:reservatior/features/client/budget/presentation/pages/budget_admin_page.dart';
import 'package:reservatior/features/client/calendar_event/presentation/pages/calendar_event_admin_page.dart';
import 'package:reservatior/features/client/channel/presentation/pages/channel_admin_page.dart';
import 'package:reservatior/features/client/client_relationship/presentation/pages/client_relationship_admin_page.dart';
import 'package:reservatior/features/client/commission/presentation/pages/commission_admin_page.dart';
import 'package:reservatior/features/client/commission_rule/presentation/pages/commission_rule_admin_page.dart';
import 'package:reservatior/features/client/communication_log/presentation/pages/communication_log_admin_page.dart';
import 'package:reservatior/features/client/communication_template/presentation/pages/communication_template_admin_page.dart';
import 'package:reservatior/features/client/compliance_record/presentation/pages/compliance_record_admin_page.dart';
import 'package:reservatior/features/client/contact/presentation/pages/contact_admin_page.dart';
import 'package:reservatior/features/client/contract/presentation/pages/contract_admin_page.dart';
import 'package:reservatior/features/client/contract_version/presentation/pages/contract_version_admin_page.dart';
import 'package:reservatior/features/client/currency/presentation/pages/currency_admin_page.dart';
import 'package:reservatior/features/client/dashboard_configuration/presentation/pages/dashboard_configuration_admin_page.dart';
import 'package:reservatior/features/client/dashboard_widget/presentation/pages/dashboard_widget_admin_page.dart';
import 'package:reservatior/features/client/deal/presentation/pages/deal_admin_page.dart';
import 'package:reservatior/features/client/deposit_protection/presentation/pages/deposit_protection_admin_page.dart';
import 'package:reservatior/features/client/discount/presentation/pages/discount_admin_page.dart';
import 'package:reservatior/features/client/document/presentation/pages/document_admin_page.dart';
import 'package:reservatior/features/client/document_analysis/presentation/pages/document_analysis_admin_page.dart';
import 'package:reservatior/features/client/document_template/presentation/pages/document_template_admin_page.dart';
import 'package:reservatior/features/client/earning/presentation/pages/earning_admin_page.dart';
import 'package:reservatior/features/client/escrow_account/presentation/pages/escrow_account_admin_page.dart';
import 'package:reservatior/features/client/escrow_dispute/presentation/pages/escrow_dispute_admin_page.dart';
import 'package:reservatior/features/client/escrow_release/presentation/pages/escrow_release_admin_page.dart';
import 'package:reservatior/features/client/escrow_status_history/presentation/pages/escrow_status_history_admin_page.dart';
import 'package:reservatior/features/client/event/presentation/pages/event_admin_page.dart';
import 'package:reservatior/features/client/event_attendee/presentation/pages/event_attendee_admin_page.dart';
import 'package:reservatior/features/client/exchange_rate/presentation/pages/exchange_rate_admin_page.dart';
import 'package:reservatior/features/client/expense/presentation/pages/expense_admin_page.dart';
import 'package:reservatior/features/client/export_file/presentation/pages/export_file_admin_page.dart';
import 'package:reservatior/features/client/export_job/presentation/pages/export_job_admin_page.dart';
import 'package:reservatior/features/client/external_rental_listing/presentation/pages/external_rental_listing_admin_page.dart';
import 'package:reservatior/features/client/extra_charge/presentation/pages/extra_charge_admin_page.dart';
import 'package:reservatior/features/client/facility/presentation/pages/facility_admin_page.dart';
import 'package:reservatior/features/client/facility_block/presentation/pages/facility_block_admin_page.dart';
import 'package:reservatior/features/client/favorite/presentation/pages/favorite_admin_page.dart';
import 'package:reservatior/features/client/financial_record/presentation/pages/financial_record_admin_page.dart';
import 'package:reservatior/features/client/floor_plan/presentation/pages/floor_plan_admin_page.dart';
import 'package:reservatior/features/client/gift_card/presentation/pages/gift_card_admin_page.dart';
import 'package:reservatior/features/client/government_integration/presentation/pages/government_integration_admin_page.dart';
import 'package:reservatior/features/client/guest/presentation/pages/guest_admin_page.dart';
import 'package:reservatior/features/client/guest_profile/presentation/pages/guest_profile_admin_page.dart';
import 'package:reservatior/features/client/guest_review/presentation/pages/guest_review_admin_page.dart';
import 'package:reservatior/features/client/hashtag/presentation/pages/hashtag_admin_page.dart';
import 'package:reservatior/features/client/health_check/presentation/pages/health_check_admin_page.dart';
import 'package:reservatior/features/client/home_information_pack/presentation/pages/home_information_pack_admin_page.dart';
import 'package:reservatior/features/client/immigration_status_check/presentation/pages/immigration_status_check_admin_page.dart';
import 'package:reservatior/features/client/included_service/presentation/pages/included_service_admin_page.dart';
import 'package:reservatior/features/client/increase/presentation/pages/increase_admin_page.dart';
import 'package:reservatior/features/client/integration_log/presentation/pages/integration_log_admin_page.dart';
import 'package:reservatior/features/client/investor_portfolio/presentation/pages/investor_portfolio_admin_page.dart';
import 'package:reservatior/features/client/investor_property/presentation/pages/investor_property_admin_page.dart';
import 'package:reservatior/features/client/job/presentation/pages/job_admin_page.dart';
import 'package:reservatior/features/client/key_management/presentation/pages/key_management_admin_page.dart';
import 'package:reservatior/features/language/presentation/pages/language_admin_page.dart';
import 'package:reservatior/features/client/lead/presentation/pages/lead_admin_page.dart';
import 'package:reservatior/features/client/lead_source/presentation/pages/lead_source_admin_page.dart';
import 'package:reservatior/features/client/lease/presentation/pages/lease_admin_page.dart';
import 'package:reservatior/features/client/lease_renewal/presentation/pages/lease_renewal_admin_page.dart';
import 'package:reservatior/features/client/ledger_entry/presentation/pages/ledger_entry_admin_page.dart';
import 'package:reservatior/features/client/listing/presentation/pages/listing_admin_page.dart';
import 'package:reservatior/features/client/listing_channel/presentation/pages/listing_channel_admin_page.dart';
import 'package:reservatior/features/client/listing_status_history/presentation/pages/listing_status_history_admin_page.dart';
import 'package:reservatior/features/client/listing_tag/presentation/pages/listing_tag_admin_page.dart';
import 'package:reservatior/features/client/location/presentation/pages/location_admin_page.dart';
import 'package:reservatior/features/client/loyalty_account/presentation/pages/loyalty_account_admin_page.dart';
import 'package:reservatior/features/client/maintenance_block/presentation/pages/maintenance_block_admin_page.dart';
import 'package:reservatior/features/client/maintenance_work_order/presentation/pages/maintenance_work_order_admin_page.dart';
import 'package:reservatior/features/client/map_data/presentation/pages/map_data_admin_page.dart';
import 'package:reservatior/features/client/map_layer/presentation/pages/map_layer_admin_page.dart';
import 'package:reservatior/features/client/marketing_campaign/presentation/pages/marketing_campaign_admin_page.dart';
import 'package:reservatior/features/client/mention/presentation/pages/mention_admin_page.dart';
import 'package:reservatior/features/client/message/presentation/pages/message_admin_page.dart';
import 'package:reservatior/features/client/ml_configuration/presentation/pages/ml_configuration_admin_page.dart';
import 'package:reservatior/features/client/ml_model/presentation/pages/ml_model_admin_page.dart';
import 'package:reservatior/features/client/mls_connection/presentation/pages/mls_connection_admin_page.dart';
import 'package:reservatior/features/client/mls_data_mapping/presentation/pages/mls_data_mapping_admin_page.dart';
import 'package:reservatior/features/client/mls_external_listing/presentation/pages/mls_external_listing_admin_page.dart';
import 'package:reservatior/features/client/mls_listing_enhancement/presentation/pages/mls_listing_enhancement_admin_page.dart';
import 'package:reservatior/features/client/mls_sync_job/presentation/pages/mls_sync_job_admin_page.dart';
import 'package:reservatior/features/client/mobile_device/presentation/pages/mobile_device_admin_page.dart';
import 'package:reservatior/features/client/mortgage/presentation/pages/mortgage_admin_page.dart';
import 'package:reservatior/features/client/mortgage_offer/presentation/pages/mortgage_offer_admin_page.dart';
import 'package:reservatior/features/client/mortgage_pre_approval/presentation/pages/mortgage_pre_approval_admin_page.dart';
import 'package:reservatior/features/client/negotiation_offer/presentation/pages/negotiation_offer_admin_page.dart';
import 'package:reservatior/features/client/neighborhood/presentation/pages/neighborhood_admin_page.dart';
import 'package:reservatior/features/client/notification/presentation/pages/notification_admin_page.dart';
import 'package:reservatior/features/client/offer/presentation/pages/offer_admin_page.dart';
import 'package:reservatior/features/client/offline_sync_queue/presentation/pages/offline_sync_queue_admin_page.dart';
import 'package:reservatior/features/client/org_subscription/presentation/pages/org_subscription_admin_page.dart';
import 'package:reservatior/features/client/organization/presentation/pages/organization_admin_page.dart';
import 'package:reservatior/features/client/payment/presentation/pages/payment_admin_page.dart';
import 'package:reservatior/features/client/payment_installment/presentation/pages/payment_installment_admin_page.dart';
import 'package:reservatior/features/client/payment_negotiation/presentation/pages/payment_negotiation_admin_page.dart';
import 'package:reservatior/features/client/payout/presentation/pages/payout_admin_page.dart';
import 'package:reservatior/features/client/performance_alert/presentation/pages/performance_alert_admin_page.dart';
import 'package:reservatior/features/client/permission/presentation/pages/permission_admin_page.dart';
import 'package:reservatior/features/client/photo/presentation/pages/photo_admin_page.dart';
import 'package:reservatior/features/client/plan/presentation/pages/plan_admin_page.dart';
import 'package:reservatior/features/client/post/presentation/pages/post_admin_page.dart';
import 'package:reservatior/features/client/predictive_model/presentation/pages/predictive_model_admin_page.dart';
import 'package:reservatior/features/client/pricing_rule/presentation/pages/pricing_rule_admin_page.dart';
import 'package:reservatior/features/client/project/presentation/pages/project_admin_page.dart';
import 'package:reservatior/features/client/project_alert/presentation/pages/project_alert_admin_page.dart';
import 'package:reservatior/features/client/project_analytics/presentation/pages/project_analytics_admin_page.dart';
import 'package:reservatior/features/client/project_report/presentation/pages/project_report_admin_page.dart';
import 'package:reservatior/features/client/property/presentation/pages/property_admin_page.dart';
import 'package:reservatior/features/client/property_amenity/presentation/pages/property_amenity_admin_page.dart';
import 'package:reservatior/features/client/property_compliance/presentation/pages/property_compliance_admin_page.dart';
import 'package:reservatior/features/client/property_disclosure/presentation/pages/property_disclosure_admin_page.dart';
import 'package:reservatior/features/client/property_document/presentation/pages/property_document_admin_page.dart';
import 'package:reservatior/features/client/property_inventory/presentation/pages/property_inventory_admin_page.dart';
import 'package:reservatior/features/client/property_offer/presentation/pages/property_offer_admin_page.dart';
import 'package:reservatior/features/client/property_photo/presentation/pages/property_photo_admin_page.dart';
import 'package:reservatior/features/client/property_promotion/presentation/pages/property_promotion_admin_page.dart';
import 'package:reservatior/features/client/property_valuation/presentation/pages/property_valuation_admin_page.dart';
import 'package:reservatior/features/client/property_viewing/presentation/pages/property_viewing_admin_page.dart';
import 'package:reservatior/features/client/queue_configuration/presentation/pages/queue_configuration_admin_page.dart';
import 'package:reservatior/features/client/queue_message/presentation/pages/queue_message_admin_page.dart';
import 'package:reservatior/features/client/quote/presentation/pages/quote_admin_page.dart';
import 'package:reservatior/features/client/recommendation_result/presentation/pages/recommendation_result_admin_page.dart';
import 'package:reservatior/features/client/reference_source/presentation/pages/reference_source_admin_page.dart';
import 'package:reservatior/features/client/referral/presentation/pages/referral_admin_page.dart';
import 'package:reservatior/features/client/rent_arrears/presentation/pages/rent_arrears_admin_page.dart';
import 'package:reservatior/features/client/rent_schedule/presentation/pages/rent_schedule_admin_page.dart';
import 'package:reservatior/features/client/rental_sync_job/presentation/pages/rental_sync_job_admin_page.dart';
import 'package:reservatior/features/client/report/presentation/pages/report_admin_page.dart';
import 'package:reservatior/features/client/report_execution/presentation/pages/report_execution_admin_page.dart';
import 'package:reservatior/features/client/reservation/presentation/pages/reservation_admin_page.dart';
import 'package:reservatior/features/client/review/presentation/pages/review_admin_page.dart';
import 'package:reservatior/features/client/right_to_rent_check/presentation/pages/right_to_rent_check_admin_page.dart';
import 'package:reservatior/features/client/role/presentation/pages/role_admin_page.dart';
import 'package:reservatior/features/client/role_permission/presentation/pages/role_permission_admin_page.dart';
import 'package:reservatior/features/client/route/presentation/pages/route_admin_page.dart';
import 'package:reservatior/features/client/scraping_job/presentation/pages/scraping_job_admin_page.dart';
import 'package:reservatior/features/client/security_deposit_protection/presentation/pages/security_deposit_protection_admin_page.dart';
import 'package:reservatior/features/client/session/presentation/pages/session_admin_page.dart';
import 'package:reservatior/features/client/shared_amenity/presentation/pages/shared_amenity_admin_page.dart';
import 'package:reservatior/features/client/signature_request/presentation/pages/signature_request_admin_page.dart';
import 'package:reservatior/features/client/signature_signer/presentation/pages/signature_signer_admin_page.dart';
import 'package:reservatior/features/client/social_impact_counter/presentation/pages/social_impact_counter_admin_page.dart';
import 'package:reservatior/features/client/social_impact_record/presentation/pages/social_impact_record_admin_page.dart';
import 'package:reservatior/features/client/solicitor_management/presentation/pages/solicitor_management_admin_page.dart';
import 'package:reservatior/features/client/subscription/presentation/pages/subscription_admin_page.dart';
import 'package:reservatior/features/client/system_metrics/presentation/pages/system_metrics_admin_page.dart';
import 'package:reservatior/features/client/tag/presentation/pages/tag_admin_page.dart';
import 'package:reservatior/features/client/task/presentation/pages/task_admin_page.dart';
import 'package:reservatior/features/client/tax1099_form/presentation/pages/tax1099_form_admin_page.dart';
import 'package:reservatior/features/client/tax_depreciation/presentation/pages/tax_depreciation_admin_page.dart';
import 'package:reservatior/features/client/tax_record/presentation/pages/tax_record_admin_page.dart';
import 'package:reservatior/features/client/tenant/presentation/pages/tenant_admin_page.dart';
import 'package:reservatior/features/client/tenant_application/presentation/pages/tenant_application_admin_page.dart';
import 'package:reservatior/features/client/ticket/presentation/pages/ticket_admin_page.dart';
import 'package:reservatior/features/client/user/presentation/pages/user_admin_page.dart';
import 'package:reservatior/features/client/user_activity_log/presentation/pages/user_activity_log_admin_page.dart';
import 'package:reservatior/features/client/user_financial_profile/presentation/pages/user_financial_profile_admin_page.dart';
import 'package:reservatior/features/client/user_preference/presentation/pages/user_preference_admin_page.dart';
import 'package:reservatior/features/client/vacation_rental/presentation/pages/vacation_rental_admin_page.dart';
import 'package:reservatior/features/client/vacation_rental_platform/presentation/pages/vacation_rental_platform_admin_page.dart';
import 'package:reservatior/features/client/vendor_profile/presentation/pages/vendor_profile_admin_page.dart';
import 'package:reservatior/features/client/verification/presentation/pages/verification_admin_page.dart';
import 'package:reservatior/features/client/video_content/presentation/pages/video_content_admin_page.dart';
import 'package:reservatior/features/client/virtual_tour/presentation/pages/virtual_tour_admin_page.dart';
import 'package:reservatior/features/client/webhook/presentation/pages/webhook_admin_page.dart';
import 'package:reservatior/features/client/webhook_delivery/presentation/pages/webhook_delivery_admin_page.dart';

List<RouteBase> getFeatureRoutes() {
  return [
    GoRoute(path: '/admin/account', builder: (_, __) => const AccountAdminPage()),
    GoRoute(path: '/admin/achievement', builder: (_, __) => const AchievementAdminPage()),
    GoRoute(path: '/admin/agency', builder: (_, __) => const AgencyAdminPage()),
    GoRoute(path: '/admin/agent', builder: (_, __) => const AgentAdminPage()),
    GoRoute(path: '/admin/agent_assignment', builder: (_, __) => const AgentAssignmentAdminPage()),
    GoRoute(path: '/admin/agent_performance', builder: (_, __) => const AgentPerformanceAdminPage()),
    GoRoute(path: '/admin/agent_team', builder: (_, __) => const AgentTeamAdminPage()),
    GoRoute(path: '/admin/agent_team_member', builder: (_, __) => const AgentTeamMemberAdminPage()),
    GoRoute(path: '/admin/ai_chat_handoff', builder: (_, __) => const AiChatHandoffAdminPage()),
    GoRoute(path: '/admin/ai_chat_message', builder: (_, __) => const AiChatMessageAdminPage()),
    GoRoute(path: '/admin/ai_chatbot_session', builder: (_, __) => const AiChatbotSessionAdminPage()),
    GoRoute(path: '/admin/ai_model', builder: (_, __) => const AiModelAdminPage()),
    GoRoute(path: '/admin/ai_recommendation', builder: (_, __) => const AiRecommendationAdminPage()),
    GoRoute(path: '/admin/ambassador_campaign', builder: (_, __) => const AmbassadorCampaignAdminPage()),
    GoRoute(path: '/admin/ambassador_contract', builder: (_, __) => const AmbassadorContractAdminPage()),
    GoRoute(path: '/admin/amenity', builder: (_, __) => const AmenityAdminPage()),
    GoRoute(path: '/admin/analysis_job', builder: (_, __) => const AnalysisJobAdminPage()),
    GoRoute(path: '/admin/analytics', builder: (_, __) => const AnalyticsAdminPage()),
    GoRoute(path: '/admin/api_integration', builder: (_, __) => const ApiIntegrationAdminPage()),
    GoRoute(path: '/admin/api_key', builder: (_, __) => const ApiKeyAdminPage()),
    GoRoute(path: '/admin/api_token', builder: (_, __) => const ApiTokenAdminPage()),
    GoRoute(path: '/admin/appointment', builder: (_, __) => const AppointmentAdminPage()),
    GoRoute(path: '/admin/attachment', builder: (_, __) => const AttachmentAdminPage()),
    GoRoute(path: '/admin/attorney_management', builder: (_, __) => const AttorneyManagementAdminPage()),
    GoRoute(path: '/admin/audit_log', builder: (_, __) => const AuditLogAdminPage()),
    GoRoute(path: '/admin/automation_execution', builder: (_, __) => const AutomationExecutionAdminPage()),
    GoRoute(path: '/admin/automation_rule', builder: (_, __) => const AutomationRuleAdminPage()),
    GoRoute(path: '/admin/automation_task', builder: (_, __) => const AutomationTaskAdminPage()),
    GoRoute(path: '/admin/availability', builder: (_, __) => const AvailabilityAdminPage()),
    GoRoute(path: '/admin/booking', builder: (_, __) => const BookingAdminPage()),
    GoRoute(path: '/admin/brand_ambassador', builder: (_, __) => const BrandAmbassadorAdminPage()),
    GoRoute(path: '/admin/budget', builder: (_, __) => const BudgetAdminPage()),
    GoRoute(path: '/admin/calendar_event', builder: (_, __) => const CalendarEventAdminPage()),
    GoRoute(path: '/admin/channel', builder: (_, __) => const ChannelAdminPage()),
    GoRoute(path: '/admin/client_relationship', builder: (_, __) => const ClientRelationshipAdminPage()),
    GoRoute(path: '/admin/commission', builder: (_, __) => const CommissionAdminPage()),
    GoRoute(path: '/admin/commission_rule', builder: (_, __) => const CommissionRuleAdminPage()),
    GoRoute(path: '/admin/communication_log', builder: (_, __) => const CommunicationLogAdminPage()),
    GoRoute(path: '/admin/communication_template', builder: (_, __) => const CommunicationTemplateAdminPage()),
    GoRoute(path: '/admin/compliance_record', builder: (_, __) => const ComplianceRecordAdminPage()),
    GoRoute(path: '/admin/contact', builder: (_, __) => const ContactAdminPage()),
    GoRoute(path: '/admin/contract', builder: (_, __) => const ContractAdminPage()),
    GoRoute(path: '/admin/contract_version', builder: (_, __) => const ContractVersionAdminPage()),
    GoRoute(path: '/admin/currency', builder: (_, __) => const CurrencyAdminPage()),
    GoRoute(path: '/admin/dashboard_configuration', builder: (_, __) => const DashboardConfigurationAdminPage()),
    GoRoute(path: '/admin/dashboard_widget', builder: (_, __) => const DashboardWidgetAdminPage()),
    GoRoute(path: '/admin/deal', builder: (_, __) => const DealAdminPage()),
    GoRoute(path: '/admin/deposit_protection', builder: (_, __) => const DepositProtectionAdminPage()),
    GoRoute(path: '/admin/discount', builder: (_, __) => const DiscountAdminPage()),
    GoRoute(path: '/admin/document', builder: (_, __) => const DocumentAdminPage()),
    GoRoute(path: '/admin/document_analysis', builder: (_, __) => const DocumentAnalysisAdminPage()),
    GoRoute(path: '/admin/document_template', builder: (_, __) => const DocumentTemplateAdminPage()),
    GoRoute(path: '/admin/earning', builder: (_, __) => const EarningAdminPage()),
    GoRoute(path: '/admin/escrow_account', builder: (_, __) => const EscrowAccountAdminPage()),
    GoRoute(path: '/admin/escrow_dispute', builder: (_, __) => const EscrowDisputeAdminPage()),
    GoRoute(path: '/admin/escrow_release', builder: (_, __) => const EscrowReleaseAdminPage()),
    GoRoute(path: '/admin/escrow_status_history', builder: (_, __) => const EscrowStatusHistoryAdminPage()),
    GoRoute(path: '/admin/event', builder: (_, __) => const EventAdminPage()),
    GoRoute(path: '/admin/event_attendee', builder: (_, __) => const EventAttendeeAdminPage()),
    GoRoute(path: '/admin/exchange_rate', builder: (_, __) => const ExchangeRateAdminPage()),
    GoRoute(path: '/admin/expense', builder: (_, __) => const ExpenseAdminPage()),
    GoRoute(path: '/admin/export_file', builder: (_, __) => const ExportFileAdminPage()),
    GoRoute(path: '/admin/export_job', builder: (_, __) => const ExportJobAdminPage()),
    GoRoute(path: '/admin/external_rental_listing', builder: (_, __) => const ExternalRentalListingAdminPage()),
    GoRoute(path: '/admin/extra_charge', builder: (_, __) => const ExtraChargeAdminPage()),
    GoRoute(path: '/admin/facility', builder: (_, __) => const FacilityAdminPage()),
    GoRoute(path: '/admin/facility_block', builder: (_, __) => const FacilityBlockAdminPage()),
    GoRoute(path: '/admin/favorite', builder: (_, __) => const FavoriteAdminPage()),
    GoRoute(path: '/admin/financial_record', builder: (_, __) => const FinancialRecordAdminPage()),
    GoRoute(path: '/admin/floor_plan', builder: (_, __) => const FloorPlanAdminPage()),
    GoRoute(path: '/admin/gift_card', builder: (_, __) => const GiftCardAdminPage()),
    GoRoute(path: '/admin/government_integration', builder: (_, __) => const GovernmentIntegrationAdminPage()),
    GoRoute(path: '/admin/guest', builder: (_, __) => const GuestAdminPage()),
    GoRoute(path: '/admin/guest_profile', builder: (_, __) => const GuestProfileAdminPage()),
    GoRoute(path: '/admin/guest_review', builder: (_, __) => const GuestReviewAdminPage()),
    GoRoute(path: '/admin/hashtag', builder: (_, __) => const HashtagAdminPage()),
    GoRoute(path: '/admin/health_check', builder: (_, __) => const HealthCheckAdminPage()),
    GoRoute(path: '/admin/home_information_pack', builder: (_, __) => const HomeInformationPackAdminPage()),
    GoRoute(path: '/admin/immigration_status_check', builder: (_, __) => const ImmigrationStatusCheckAdminPage()),
    GoRoute(path: '/admin/included_service', builder: (_, __) => const IncludedServiceAdminPage()),
    GoRoute(path: '/admin/increase', builder: (_, __) => const IncreaseAdminPage()),
    GoRoute(path: '/admin/integration_log', builder: (_, __) => const IntegrationLogAdminPage()),
    GoRoute(path: '/admin/investor_portfolio', builder: (_, __) => const InvestorPortfolioAdminPage()),
    GoRoute(path: '/admin/investor_property', builder: (_, __) => const InvestorPropertyAdminPage()),
    GoRoute(path: '/admin/job', builder: (_, __) => const JobAdminPage()),
    GoRoute(path: '/admin/key_management', builder: (_, __) => const KeyManagementAdminPage()),
    GoRoute(path: '/admin/language', builder: (_, __) => const LanguageAdminPage()),
    GoRoute(path: '/admin/lead', builder: (_, __) => const LeadAdminPage()),
    GoRoute(path: '/admin/lead_source', builder: (_, __) => const LeadSourceAdminPage()),
    GoRoute(path: '/admin/lease', builder: (_, __) => const LeaseAdminPage()),
    GoRoute(path: '/admin/lease_renewal', builder: (_, __) => const LeaseRenewalAdminPage()),
    GoRoute(path: '/admin/ledger_entry', builder: (_, __) => const LedgerEntryAdminPage()),
    GoRoute(path: '/admin/listing', builder: (_, __) => const ListingAdminPage()),
    GoRoute(path: '/admin/listing_channel', builder: (_, __) => const ListingChannelAdminPage()),
    GoRoute(path: '/admin/listing_status_history', builder: (_, __) => const ListingStatusHistoryAdminPage()),
    GoRoute(path: '/admin/listing_tag', builder: (_, __) => const ListingTagAdminPage()),
    GoRoute(path: '/admin/location', builder: (_, __) => const LocationAdminPage()),
    GoRoute(path: '/admin/loyalty_account', builder: (_, __) => const LoyaltyAccountAdminPage()),
    GoRoute(path: '/admin/maintenance_block', builder: (_, __) => const MaintenanceBlockAdminPage()),
    GoRoute(path: '/admin/maintenance_work_order', builder: (_, __) => const MaintenanceWorkOrderAdminPage()),
    GoRoute(path: '/admin/map_data', builder: (_, __) => const MapDataAdminPage()),
    GoRoute(path: '/admin/map_layer', builder: (_, __) => const MapLayerAdminPage()),
    GoRoute(path: '/admin/marketing_campaign', builder: (_, __) => const MarketingCampaignAdminPage()),
    GoRoute(path: '/admin/mention', builder: (_, __) => const MentionAdminPage()),
    GoRoute(path: '/admin/message', builder: (_, __) => const MessageAdminPage()),
    GoRoute(path: '/admin/ml_configuration', builder: (_, __) => const MlConfigurationAdminPage()),
    GoRoute(path: '/admin/ml_model', builder: (_, __) => const MlModelAdminPage()),
    GoRoute(path: '/admin/mls_connection', builder: (_, __) => const MlsConnectionAdminPage()),
    GoRoute(path: '/admin/mls_data_mapping', builder: (_, __) => const MlsDataMappingAdminPage()),
    GoRoute(path: '/admin/mls_external_listing', builder: (_, __) => const MlsExternalListingAdminPage()),
    GoRoute(path: '/admin/mls_listing_enhancement', builder: (_, __) => const MlsListingEnhancementAdminPage()),
    GoRoute(path: '/admin/mls_sync_job', builder: (_, __) => const MlsSyncJobAdminPage()),
    GoRoute(path: '/admin/mobile_device', builder: (_, __) => const MobileDeviceAdminPage()),
    GoRoute(path: '/admin/mortgage', builder: (_, __) => const MortgageAdminPage()),
    GoRoute(path: '/admin/mortgage_offer', builder: (_, __) => const MortgageOfferAdminPage()),
    GoRoute(path: '/admin/mortgage_pre_approval', builder: (_, __) => const MortgagePreApprovalAdminPage()),
    GoRoute(path: '/admin/negotiation_offer', builder: (_, __) => const NegotiationOfferAdminPage()),
    GoRoute(path: '/admin/neighborhood', builder: (_, __) => const NeighborhoodAdminPage()),
    GoRoute(path: '/admin/notification', builder: (_, __) => const NotificationAdminPage()),
    GoRoute(path: '/admin/offer', builder: (_, __) => const OfferAdminPage()),
    GoRoute(path: '/admin/offline_sync_queue', builder: (_, __) => const OfflineSyncQueueAdminPage()),
    GoRoute(path: '/admin/org_subscription', builder: (_, __) => const OrgSubscriptionAdminPage()),
    GoRoute(path: '/admin/organization', builder: (_, __) => const OrganizationAdminPage()),
    GoRoute(path: '/admin/payment', builder: (_, __) => const PaymentAdminPage()),
    GoRoute(path: '/admin/payment_installment', builder: (_, __) => const PaymentInstallmentAdminPage()),
    GoRoute(path: '/admin/payment_negotiation', builder: (_, __) => const PaymentNegotiationAdminPage()),
    GoRoute(path: '/admin/payout', builder: (_, __) => const PayoutAdminPage()),
    GoRoute(path: '/admin/performance_alert', builder: (_, __) => const PerformanceAlertAdminPage()),
    GoRoute(path: '/admin/permission', builder: (_, __) => const PermissionAdminPage()),
    GoRoute(path: '/admin/photo', builder: (_, __) => const PhotoAdminPage()),
    GoRoute(path: '/admin/plan', builder: (_, __) => const PlanAdminPage()),
    GoRoute(path: '/admin/post', builder: (_, __) => const PostAdminPage()),
    GoRoute(path: '/admin/predictive_model', builder: (_, __) => const PredictiveModelAdminPage()),
    GoRoute(path: '/admin/pricing_rule', builder: (_, __) => const PricingRuleAdminPage()),
    GoRoute(path: '/admin/project', builder: (_, __) => const ProjectAdminPage()),
    GoRoute(path: '/admin/project_alert', builder: (_, __) => const ProjectAlertAdminPage()),
    GoRoute(path: '/admin/project_analytics', builder: (_, __) => const ProjectAnalyticsAdminPage()),
    GoRoute(path: '/admin/project_report', builder: (_, __) => const ProjectReportAdminPage()),
    GoRoute(path: '/admin/property', builder: (_, __) => const PropertyAdminPage()),
    GoRoute(path: '/admin/property_amenity', builder: (_, __) => const PropertyAmenityAdminPage()),
    GoRoute(path: '/admin/property_compliance', builder: (_, __) => const PropertyComplianceAdminPage()),
    GoRoute(path: '/admin/property_disclosure', builder: (_, __) => const PropertyDisclosureAdminPage()),
    GoRoute(path: '/admin/property_document', builder: (_, __) => const PropertyDocumentAdminPage()),
    GoRoute(path: '/admin/property_inventory', builder: (_, __) => const PropertyInventoryAdminPage()),
    GoRoute(path: '/admin/property_offer', builder: (_, __) => const PropertyOfferAdminPage()),
    GoRoute(path: '/admin/property_photo', builder: (_, __) => const PropertyPhotoAdminPage()),
    GoRoute(path: '/admin/property_promotion', builder: (_, __) => const PropertyPromotionAdminPage()),
    GoRoute(path: '/admin/property_valuation', builder: (_, __) => const PropertyValuationAdminPage()),
    GoRoute(path: '/admin/property_viewing', builder: (_, __) => const PropertyViewingAdminPage()),
    GoRoute(path: '/admin/queue_configuration', builder: (_, __) => const QueueConfigurationAdminPage()),
    GoRoute(path: '/admin/queue_message', builder: (_, __) => const QueueMessageAdminPage()),
    GoRoute(path: '/admin/quote', builder: (_, __) => const QuoteAdminPage()),
    GoRoute(path: '/admin/recommendation_result', builder: (_, __) => const RecommendationResultAdminPage()),
    GoRoute(path: '/admin/reference_source', builder: (_, __) => const ReferenceSourceAdminPage()),
    GoRoute(path: '/admin/referral', builder: (_, __) => const ReferralAdminPage()),
    GoRoute(path: '/admin/rent_arrears', builder: (_, __) => const RentArrearsAdminPage()),
    GoRoute(path: '/admin/rent_schedule', builder: (_, __) => const RentScheduleAdminPage()),
    GoRoute(path: '/admin/rental_sync_job', builder: (_, __) => const RentalSyncJobAdminPage()),
    GoRoute(path: '/admin/report', builder: (_, __) => const ReportAdminPage()),
    GoRoute(path: '/admin/report_execution', builder: (_, __) => const ReportExecutionAdminPage()),
    GoRoute(path: '/admin/reservation', builder: (_, __) => const ReservationAdminPage()),
    GoRoute(path: '/admin/review', builder: (_, __) => const ReviewAdminPage()),
    GoRoute(path: '/admin/right_to_rent_check', builder: (_, __) => const RightToRentCheckAdminPage()),
    GoRoute(path: '/admin/role', builder: (_, __) => const RoleAdminPage()),
    GoRoute(path: '/admin/role_permission', builder: (_, __) => const RolePermissionAdminPage()),
    GoRoute(path: '/admin/route', builder: (_, __) => const RouteAdminPage()),
    GoRoute(path: '/admin/scraping_job', builder: (_, __) => const ScrapingJobAdminPage()),
    GoRoute(path: '/admin/security_deposit_protection', builder: (_, __) => const SecurityDepositProtectionAdminPage()),
    GoRoute(path: '/admin/session', builder: (_, __) => const SessionAdminPage()),
    GoRoute(path: '/admin/shared_amenity', builder: (_, __) => const SharedAmenityAdminPage()),
    GoRoute(path: '/admin/signature_request', builder: (_, __) => const SignatureRequestAdminPage()),
    GoRoute(path: '/admin/signature_signer', builder: (_, __) => const SignatureSignerAdminPage()),
    GoRoute(path: '/admin/social_impact_counter', builder: (_, __) => const SocialImpactCounterAdminPage()),
    GoRoute(path: '/admin/social_impact_record', builder: (_, __) => const SocialImpactRecordAdminPage()),
    GoRoute(path: '/admin/solicitor_management', builder: (_, __) => const SolicitorManagementAdminPage()),
    GoRoute(path: '/admin/subscription', builder: (_, __) => const SubscriptionAdminPage()),
    GoRoute(path: '/admin/system_metrics', builder: (_, __) => const SystemMetricsAdminPage()),
    GoRoute(path: '/admin/tag', builder: (_, __) => const TagAdminPage()),
    GoRoute(path: '/admin/task', builder: (_, __) => const TaskAdminPage()),
    GoRoute(path: '/admin/tax1099_form', builder: (_, __) => const Tax1099FormAdminPage()),
    GoRoute(path: '/admin/tax_depreciation', builder: (_, __) => const TaxDepreciationAdminPage()),
    GoRoute(path: '/admin/tax_record', builder: (_, __) => const TaxRecordAdminPage()),
    GoRoute(path: '/admin/tenant', builder: (_, __) => const TenantAdminPage()),
    GoRoute(path: '/admin/tenant_application', builder: (_, __) => const TenantApplicationAdminPage()),
    GoRoute(path: '/admin/ticket', builder: (_, __) => const TicketAdminPage()),
    GoRoute(path: '/admin/user', builder: (_, __) => const UserAdminPage()),
    GoRoute(path: '/admin/user_activity_log', builder: (_, __) => const UserActivityLogAdminPage()),
    GoRoute(path: '/admin/user_financial_profile', builder: (_, __) => const UserFinancialProfileAdminPage()),
    GoRoute(path: '/admin/user_preference', builder: (_, __) => const UserPreferenceAdminPage()),
    GoRoute(path: '/admin/vacation_rental', builder: (_, __) => const VacationRentalAdminPage()),
    GoRoute(path: '/admin/vacation_rental_platform', builder: (_, __) => const VacationRentalPlatformAdminPage()),
    GoRoute(path: '/admin/vendor_profile', builder: (_, __) => const VendorProfileAdminPage()),
    GoRoute(path: '/admin/verification', builder: (_, __) => const VerificationAdminPage()),
    GoRoute(path: '/admin/video_content', builder: (_, __) => const VideoContentAdminPage()),
    GoRoute(path: '/admin/virtual_tour', builder: (_, __) => const VirtualTourAdminPage()),
    GoRoute(path: '/admin/webhook', builder: (_, __) => const WebhookAdminPage()),
    GoRoute(path: '/admin/webhook_delivery', builder: (_, __) => const WebhookDeliveryAdminPage()),
  ];
}
