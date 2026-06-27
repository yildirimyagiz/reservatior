import 'package:reservatior/features/client/neighborhood/presentation/pages/neighborhood_page.dart';

import 'package:reservatior/features/client/presentation/screens/client_dashboard_screen.dart';
import 'package:reservatior/core/routing/feature_router.dart';
import 'package:reservatior/shared/enums/member_role_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RoleBasedRouter {
  static bool isAdminRole(MemberRoleKey role) {
    return [
      MemberRoleKey.OWNER,
      MemberRoleKey.AGENCY_ADMIN,
      MemberRoleKey.ORG_ADMIN,
      MemberRoleKey.VENDOR_MANAGER,
      MemberRoleKey.ACCOUNTANT,
      MemberRoleKey.MAINTENANCE,
    ].contains(role);
  }

  static bool isClientRole(MemberRoleKey role) {
    return [
      MemberRoleKey.AGENT,
      MemberRoleKey.TENANT_GUEST,
      MemberRoleKey.READ_ONLY,
    ].contains(role);
  }

  static List<String> getAdminFeatures() {
    return [
      'dashboard',
      'analytics',
      'users',
      'organizations',
      'system_settings',
      'ai_config',
      'financial_management',
      'reports',
      'compliance',
      'integrations',
      'properties',
      'budgets',
      'expenses',
      'payouts',
      'agencies',
      'agents',
      'tasks',
      'roles',
      'documents',
      'tenants',
      'leases',
      'vendors',
      'contacts',
      'facilities',
      'maintenance',
      'marketing',
      'cloud',
      'company',
      'account',
      'achievement',
      'ambassador_contract',
      'amenity',
      'analysis_job',
      'analytics',
      'api_integration',
      'api_key',
      'appointment',
      'attachment',
      'attorney_management',
      'automation_execution',
      'automation_rule',
      'booking',
      'brand_ambassador',
      'calendar_event',
      'channel',
      'client_relationship',
      'contract',
      'contract_version',
      'coupons',
      'currency',
      'dashboard',
      'dashboard_configuration',
      'dashboard_widget',
      'deal',
      'deposit_protection',
      'discount',
      'earning',
      'event',
      'event_attendee',
      'exchange_rate',
      'export_file',
      'export_job',
      'external_rental_listing',
      'extra_charge',
      'favorite',
      'filters',
      'floor_plan',
      'gift_card',
      'government_integration',
      'guest',
      'guest_profile',
      'guest_review',
      'hashtag',
      'health_check',
      'home',
      'home_information_pack',
      'immigration_status_check',
      'included_service',
      'increase',
      'integration_log',
      'investor_portfolio',
      'job',
      'key_management',
      'lead',
      'lead_source',
      'ledger_entry',
      'listing',
      'listing_channel',
      'listing_status_history',
      'listing_tag',
      'location',
      'loyalty_account',
      'map_data',
      'map_layer',
      'marketplace',
      'mention',
      'message',
      'ml_configuration',
      'ml_model',
      'mls_connection',
      'mls_data_mapping',
      'mls_external_listing',
      'mls_listing_enhancement',
      'mls_sync_job',
      'mobile_device',
      'more',
      'negotiation_offer',
      'neighborhood',
      'notification',
      'offer',
      'offline_sync_queue',
      'org_subscription',
      'performance_alert',
      'permission',
      'photo',
      'plan',
      'post',
      'predictive_model',
      'pricing_rule',
      'project',
      'project_alert',
      'project_analytics',
      'project_report',
      'queue_configuration',
      'queue_message',
      'quote',
      'recommendation_result',
      'reference_source',
      'referral',
      'rent_arrears',
      'rent_schedule',
      'rental_sync_job',
      'report',
      'report_execution',
      'review',
      'right_to_rent_check',
      'route',
      'scraping_job',
      'session',
      'shared_amenity',
      'signature_request',
      'signature_signer',
      'social_impact_counter',
      'social_impact_record',
      'solicitor_management',
      'subscription',
      'tag',
      'ticket',
      'user',
      'user_activity_log',
      'user_preference',
      'vacation_rental',
      'vacation_rental_platform',
      'verification',
      'video_content',
      'virtual_tour',
      'webhook',
      'webhook_delivery',
      'welcome',
    ];
  }

  static List<String> getClientFeatures() {
    return [
      'home',
      'property_search',
      'bookings',
      'profile',
      'communications',
      'documents',
      'tasks',
      'financial_overview',
      'neighborhood_dna',
    ];
  }

  static Widget getRoleBasedPage(String feature, MemberRoleKey role) {
    if (feature == 'dashboard') {
      return isAdminRole(role)
          ? Container()
          : const ClientDashboardScreen();
    }

    if (feature == 'neighborhood_dna' && isClientRole(role)) {
      return const NeighborhoodPage();
    }

    if (isAdminRole(role) && getAdminFeatures().contains(feature)) {
      return FeatureRouter.getAdminPage(feature);
    } else if (isClientRole(role) && getClientFeatures().contains(feature)) {
      return FeatureRouter.getClientPage(feature);
    } else {
      return _UnauthorizedPage(feature: feature, role: role);
    }
  }
}

class _UnauthorizedPage extends StatelessWidget {
  final String feature;
  final MemberRoleKey role;

  const _UnauthorizedPage({required this.feature, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('mobile.auto.unauthorized'.tr())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'mobile.auto.access_denied'.tr(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8),
            Text(
              'You need ${role.name} role to access $feature',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
