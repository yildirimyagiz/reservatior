import 'package:reservatior/features/admin/dynamic/dynamic_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/features/client/property/presentation/pages/search_and_filters_page.dart';


// Batch 1: Financial


// Batch 2: Security & Compliance

// Batch 3: AI


// Batch 4: Operational

import 'package:reservatior/features/admin/property/vacation_rentals_screen.dart';

// Batch 5: Organization

// Batch 6: System

// Generated Missing Features
import 'package:reservatior/features/admin/account/account_management_screen.dart';
import 'package:reservatior/features/admin/dashboard/dashboard_management_screen.dart';
import 'package:reservatior/features/admin/favorite/favorite_management_screen.dart';
import 'package:reservatior/features/admin/guest/guest_management_screen.dart';
import 'package:reservatior/features/admin/guest_profile/guest_profile_management_screen.dart';
import 'package:reservatior/features/admin/home/home_management_screen.dart';
import 'package:reservatior/features/admin/listing/listing_management_screen.dart';
import 'package:reservatior/features/admin/location/location_management_screen.dart';
import 'package:reservatior/features/admin/marketplace/marketplace_management_screen.dart';
import 'package:reservatior/features/admin/message/message_management_screen.dart';
import 'package:reservatior/features/admin/notification/notification_management_screen.dart';
import 'package:reservatior/features/admin/photo/photo_management_screen.dart';
import 'package:reservatior/features/admin/review/review_management_screen.dart';
import 'package:reservatior/features/admin/user/user_management_screen.dart';
import 'package:reservatior/features/admin/video_content/video_content_management_screen.dart';

import 'package:reservatior/features/admin/property/property_management_screen.dart';
import 'package:reservatior/features/admin/reservation/reservation_management_screen.dart';
import 'package:reservatior/features/admin/payment/payment_management_screen.dart';

// Note: api_key is already imported, but we make sure the screen exists in our folder structure.





class FeatureRouter {
  static final Map<String, Widget Function()> adminPages = {
    'properties': () => DynamicAdminScreen(modelName: 'Property'),
    'budgets': () => DynamicAdminScreen(modelName: 'Container'),
    'expenses': () => DynamicAdminScreen(modelName: 'Expense'),
    'payouts': () => DynamicAdminScreen(modelName: 'Payout'),
    'agencies': () => DynamicAdminScreen(modelName: 'Agency'),
    'tasks': () => DynamicAdminScreen(modelName: 'Task'),
    'roles': () => DynamicAdminScreen(modelName: 'Roles'),
    'documents': () => DynamicAdminScreen(modelName: 'Document'),
    'tenants': () => DynamicAdminScreen(modelName: 'Tenant'),
    'leases': () => DynamicAdminScreen(modelName: 'Lease'),
    'vendors': () => DynamicAdminScreen(modelName: 'VendorProfile'),
    'contacts': () => DynamicAdminScreen(modelName: 'Contact'),
    'maintenance': () => DynamicAdminScreen(modelName: 'MaintenanceWorkOrder'),
    'marketing': () => DynamicAdminScreen(modelName: 'MarketingCampaign'),
    'cloud': () => DynamicAdminScreen(modelName: 'Cloud'),
    'company': () => DynamicAdminScreen(modelName: 'Company'),

    // Financial Additions
    'escrow_screen': () => DynamicAdminScreen(modelName: 'Escrow'),
    'commissions': () => DynamicAdminScreen(modelName: 'Commissions'),
    'commission_rules': () => DynamicAdminScreen(modelName: 'CommissionRules'),
    'invoices': () => DynamicAdminScreen(modelName: 'Invoices'),
    'tax_records': () => DynamicAdminScreen(modelName: 'TaxRecords'),
    'global_tax': () => DynamicAdminScreen(modelName: 'Container'),
    'mortgages': () => DynamicAdminScreen(modelName: 'Mortgages'),
    'financial_reports': () => DynamicAdminScreen(modelName: 'FinancialReports'),
    'extra_charges': () => DynamicAdminScreen(modelName: 'ExtraCharges'),
    'transactions': () => DynamicAdminScreen(modelName: 'Transactions'),
    'payments': () => DynamicAdminScreen(modelName: 'Payment'),

    // Security
    'audit_logs': () => DynamicAdminScreen(modelName: 'AuditLog'),
    'advanced_security': () => DynamicAdminScreen(modelName: 'AdvancedSecurity'),
    'api_tokens': () => DynamicAdminScreen(modelName: 'ApiKey'),
    'compliance': () => DynamicAdminScreen(modelName: 'ComplianceDashboard'),

    // AI
    'ai_config': () => DynamicAdminScreen(modelName: 'AiModel'),
    'fraud_detection': () => DynamicAdminScreen(modelName: 'FraudDetection'),
    'sentiment_analysis': () => DynamicAdminScreen(modelName: 'SentimentAnalysis'),
    'predictive_maintenance': () => DynamicAdminScreen(modelName: 'PredictiveMaintenance'),

    // Operational
    'agencies_manage': () => DynamicAdminScreen(modelName: 'Agencies'),
    'customer_invoices': () => DynamicAdminScreen(modelName: 'CustomerInvoices'),
    'reservations': () => DynamicAdminScreen(modelName: 'Reservation'),
    'tasks_manage': () => DynamicAdminScreen(modelName: 'Task'),
    'vacation_rentals': () => DynamicAdminScreen(modelName: 'VacationRentals'),

    // Organization
    'facilities': () => DynamicAdminScreen(modelName: 'Facility'),
    'agents': () => DynamicAdminScreen(modelName: 'AgentTeam'),
    'organizations': () => DynamicAdminScreen(modelName: 'Organization'),
    'departments': () => DynamicAdminScreen(modelName: 'Departments'),
    'teams': () => DynamicAdminScreen(modelName: 'Teams'),
    'subscription': () => DynamicAdminScreen(modelName: 'Subscription'),
    'membership': () => DynamicAdminScreen(modelName: 'Membership'),
    'billing': () => DynamicAdminScreen(modelName: 'Billing'),

    // System
    'system_metrics': () => DynamicAdminScreen(modelName: 'SystemMetrics'),
    'system_monitoring': () => DynamicAdminScreen(modelName: 'SystemMonitoring'),
    'mls_integration': () => DynamicAdminScreen(modelName: 'MlsIntegration'),
    'export_jobs': () => DynamicAdminScreen(modelName: 'ExportJobs'),
    'comm_templates': () => DynamicAdminScreen(modelName: 'CommTemplates'),
    'documents_manage': () => DynamicAdminScreen(modelName: 'Document'),

    'financial_record': () => DynamicAdminScreen(modelName: 'Financial'),
    // Generated Missing Features
    'account': () => DynamicAdminScreen(modelName: 'Account'),
    'achievement': () => DynamicAdminScreen(modelName: 'Achievement'),
    'ambassador_contract': () => DynamicAdminScreen(modelName: 'AmbassadorContract'),
    'amenity': () => DynamicAdminScreen(modelName: 'Amenity'),
    'analysis_job': () => DynamicAdminScreen(modelName: 'AnalysisJob'),
    'analytics': () => DynamicAdminScreen(modelName: 'Analytics'),
    'api_integration': () => DynamicAdminScreen(modelName: 'ApiIntegration'),
    'api_key': () => DynamicAdminScreen(modelName: 'ApiKey'),
    'appointment': () => DynamicAdminScreen(modelName: 'Appointment'),
    'attachment': () => DynamicAdminScreen(modelName: 'Attachment'),
    'attorney_management': () => DynamicAdminScreen(modelName: 'AttorneyManagement'),
    'automation_execution': () => DynamicAdminScreen(modelName: 'AutomationExecution'),
    'automation_rule': () => DynamicAdminScreen(modelName: 'AutomationRule'),
    'booking': () => DynamicAdminScreen(modelName: 'Reservation'),
    'brand_ambassador': () => DynamicAdminScreen(modelName: 'BrandAmbassador'),
    'calendar_event': () => DynamicAdminScreen(modelName: 'CalendarEvent'),
    'channel': () => DynamicAdminScreen(modelName: 'Channel'),
    'client_relationship': () => DynamicAdminScreen(modelName: 'ClientRelationship'),
    'contract': () => DynamicAdminScreen(modelName: 'Contract'),
    'contract_version': () => DynamicAdminScreen(modelName: 'ContractVersion'),
    'coupons': () => DynamicAdminScreen(modelName: 'Coupons'),
    'currency': () => DynamicAdminScreen(modelName: 'Currency'),
    'dashboard': () => DynamicAdminScreen(modelName: 'Dashboard'),
    'dashboard_configuration': () =>
        DynamicAdminScreen(modelName: 'DashboardConfiguration'),
    'dashboard_widget': () => DynamicAdminScreen(modelName: 'DashboardWidget'),
    'deal': () => DynamicAdminScreen(modelName: 'Deal'),
    'deposit_protection': () => DynamicAdminScreen(modelName: 'DepositProtection'),
    'discount': () => DynamicAdminScreen(modelName: 'Discount'),
    'earning': () => DynamicAdminScreen(modelName: 'Earning'),
    'event': () => DynamicAdminScreen(modelName: 'Event'),
    'event_attendee': () => DynamicAdminScreen(modelName: 'EventAttendee'),
    'exchange_rate': () => DynamicAdminScreen(modelName: 'ExchangeRate'),
    'export_file': () => DynamicAdminScreen(modelName: 'ExportFile'),
    'export_job': () => DynamicAdminScreen(modelName: 'ExportJob'),
    'external_rental_listing': () =>
        DynamicAdminScreen(modelName: 'ExternalRentalListing'),
    'extra_charge': () => DynamicAdminScreen(modelName: 'ExtraCharge'),
    'favorite': () => DynamicAdminScreen(modelName: 'Favorite'),
    'filters': () => DynamicAdminScreen(modelName: 'Filters'),
    'floor_plan': () => DynamicAdminScreen(modelName: 'FloorPlan'),
    'gift_card': () => DynamicAdminScreen(modelName: 'GiftCard'),
    'government_integration': () =>
        DynamicAdminScreen(modelName: 'GovernmentIntegration'),
    'guest': () => DynamicAdminScreen(modelName: 'Guest'),
    'guest_profile': () => DynamicAdminScreen(modelName: 'GuestProfile'),
    'guest_review': () => DynamicAdminScreen(modelName: 'GuestReview'),
    'hashtag': () => DynamicAdminScreen(modelName: 'Hashtag'),
    'health_check': () => DynamicAdminScreen(modelName: 'HealthCheck'),
    'home': () => DynamicAdminScreen(modelName: 'Home'),
    'home_information_pack': () => DynamicAdminScreen(modelName: 'HomeInformationPack'),
    'immigration_status_check': () =>
        DynamicAdminScreen(modelName: 'ImmigrationStatusCheck'),
    'included_service': () => DynamicAdminScreen(modelName: 'IncludedService'),
    'increase': () => DynamicAdminScreen(modelName: 'Increase'),
    'integration_log': () => DynamicAdminScreen(modelName: 'IntegrationLog'),
    'investor_portfolio': () => DynamicAdminScreen(modelName: 'InvestorPortfolio'),
    'job': () => DynamicAdminScreen(modelName: 'Job'),
    'key_management': () => DynamicAdminScreen(modelName: 'KeyManagement'),
    'lead': () => DynamicAdminScreen(modelName: 'Lead'),
    'lead_source': () => DynamicAdminScreen(modelName: 'LeadSource'),
    'ledger_entry': () => DynamicAdminScreen(modelName: 'LedgerEntry'),
    'listing': () => DynamicAdminScreen(modelName: 'Listing'),
    'listing_channel': () => DynamicAdminScreen(modelName: 'ListingChannel'),
    'listing_status_history': () =>
        DynamicAdminScreen(modelName: 'ListingStatusHistory'),
    'listing_tag': () => DynamicAdminScreen(modelName: 'ListingTag'),
    'location': () => DynamicAdminScreen(modelName: 'Location'),
    'loyalty_account': () => DynamicAdminScreen(modelName: 'LoyaltyAccount'),
    'map_data': () => DynamicAdminScreen(modelName: 'MapData'),
    'map_layer': () => DynamicAdminScreen(modelName: 'MapLayer'),
    'marketplace': () => DynamicAdminScreen(modelName: 'Marketplace'),
    'mention': () => DynamicAdminScreen(modelName: 'Mention'),
    'message': () => DynamicAdminScreen(modelName: 'Message'),
    'ml_configuration': () => DynamicAdminScreen(modelName: 'MlConfiguration'),
    'ml_model': () => DynamicAdminScreen(modelName: 'MlModel'),
    'mls_connection': () => DynamicAdminScreen(modelName: 'MlsConnection'),
    'mls_data_mapping': () => DynamicAdminScreen(modelName: 'MlsDataMapping'),
    'mls_external_listing': () => DynamicAdminScreen(modelName: 'MlsExternalListing'),
    'mls_listing_enhancement': () =>
        DynamicAdminScreen(modelName: 'MlsListingEnhancement'),
    'mls_sync_job': () => DynamicAdminScreen(modelName: 'MlsSyncJob'),
    'mobile_device': () => DynamicAdminScreen(modelName: 'MobileDevice'),
    'more': () => DynamicAdminScreen(modelName: 'More'),
    'negotiation_offer': () => DynamicAdminScreen(modelName: 'NegotiationOffer'),
    'neighborhood': () => DynamicAdminScreen(modelName: 'Neighborhood'),
    'notification': () => DynamicAdminScreen(modelName: 'Notification'),
    'offer': () => DynamicAdminScreen(modelName: 'Offer'),
    'offline_sync_queue': () => DynamicAdminScreen(modelName: 'OfflineSyncQueue'),
    'org_subscription': () => DynamicAdminScreen(modelName: 'OrgSubscription'),
    'performance_alert': () => DynamicAdminScreen(modelName: 'PerformanceAlert'),
    'permission': () => DynamicAdminScreen(modelName: 'Permission'),
    'photo': () => DynamicAdminScreen(modelName: 'Photo'),
    'plan': () => DynamicAdminScreen(modelName: 'Plan'),
    'post': () => DynamicAdminScreen(modelName: 'Post'),
    'predictive_model': () => DynamicAdminScreen(modelName: 'PredictiveModel'),
    'pricing_rule': () => DynamicAdminScreen(modelName: 'PricingRule'),
    'project': () => DynamicAdminScreen(modelName: 'Project'),
    'project_alert': () => DynamicAdminScreen(modelName: 'ProjectAlert'),
    'project_analytics': () => DynamicAdminScreen(modelName: 'ProjectAnalytics'),
    'project_report': () => DynamicAdminScreen(modelName: 'ProjectReport'),
    'queue_configuration': () => DynamicAdminScreen(modelName: 'QueueConfiguration'),
    'queue_message': () => DynamicAdminScreen(modelName: 'QueueMessage'),
    'quote': () => DynamicAdminScreen(modelName: 'Quote'),
    'recommendation_result': () => DynamicAdminScreen(modelName: 'RecommendationResult'),
    'reference_source': () => DynamicAdminScreen(modelName: 'ReferenceSource'),
    'referral': () => DynamicAdminScreen(modelName: 'Referral'),
    'rent_arrears': () => DynamicAdminScreen(modelName: 'RentArrears'),
    'rent_schedule': () => DynamicAdminScreen(modelName: 'RentSchedule'),
    'rental_sync_job': () => DynamicAdminScreen(modelName: 'RentalSyncJob'),
    'report': () => DynamicAdminScreen(modelName: 'Report'),
    'report_execution': () => DynamicAdminScreen(modelName: 'ReportExecution'),
    'review': () => DynamicAdminScreen(modelName: 'Review'),
    'right_to_rent_check': () => DynamicAdminScreen(modelName: 'RightToRentCheck'),
    'route': () => DynamicAdminScreen(modelName: 'Route'),
    'scraping_job': () => DynamicAdminScreen(modelName: 'ScrapingJob'),
    'session': () => DynamicAdminScreen(modelName: 'Session'),
    'shared_amenity': () => DynamicAdminScreen(modelName: 'SharedAmenity'),
    'signature_request': () => DynamicAdminScreen(modelName: 'SignatureRequest'),
    'signature_signer': () => DynamicAdminScreen(modelName: 'SignatureSigner'),
    'social_impact_counter': () => DynamicAdminScreen(modelName: 'SocialImpactCounter'),
    'social_impact_record': () => DynamicAdminScreen(modelName: 'SocialImpactRecord'),
    'solicitor_management': () => DynamicAdminScreen(modelName: 'Solicitor'),
    'tag': () => DynamicAdminScreen(modelName: 'Tag'),
    'ticket': () => DynamicAdminScreen(modelName: 'Ticket'),
    'user': () => DynamicAdminScreen(modelName: 'User'),
    'user_activity_log': () => DynamicAdminScreen(modelName: 'UserActivityLog'),
    'user_preference': () => DynamicAdminScreen(modelName: 'UserPreference'),
    'vacation_rental': () => DynamicAdminScreen(modelName: 'VacationRental'),
    'vacation_rental_platform': () =>
        DynamicAdminScreen(modelName: 'VacationRentalPlatform'),
    'verification': () => DynamicAdminScreen(modelName: 'Verification'),
    'video_content': () => DynamicAdminScreen(modelName: 'VideoContent'),
    'virtual_tour': () => DynamicAdminScreen(modelName: 'VirtualTour'),
    'webhook': () => DynamicAdminScreen(modelName: 'Webhook'),
    'webhook_delivery': () => DynamicAdminScreen(modelName: 'WebhookDelivery'),
    'welcome': () => DynamicAdminScreen(modelName: 'Welcome'),
  };
  static final Map<String, Widget Function()> clientPages = {
    'property_search': () => DynamicAdminScreen(modelName: 'SearchAndFiltersPage'),
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
