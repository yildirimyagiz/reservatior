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
  String _searchQuery = '';

  final List<Map<String, String>> _allModules = [
    {'title': 'A I', 'route': '/admin/ai'},
    {'title': 'Account', 'route': '/admin/account'},
    {'title': 'Achievement', 'route': '/admin/achievement'},
    {'title': 'Ambassador Contract', 'route': '/admin/ambassador-contract'},
    {'title': 'Amenity', 'route': '/admin/amenity'},
    {'title': 'Analysis Job', 'route': '/admin/analysis-job'},
    {'title': 'Analytics', 'route': '/admin/analytics'},
    {'title': 'Api Integration', 'route': '/admin/api-integration'},
    {'title': 'Api Key', 'route': '/admin/api-key'},
    {'title': 'Appointment', 'route': '/admin/appointment'},
    {'title': 'Attachment', 'route': '/admin/attachment'},
    {'title': 'Attorney Management', 'route': '/admin/attorney-management'},
    {'title': 'Automation Execution', 'route': '/admin/automation-execution'},
    {'title': 'Automation Rule', 'route': '/admin/automation-rule'},
    {'title': 'Booking', 'route': '/admin/booking'},
    {'title': 'Brand Ambassador', 'route': '/admin/brand-ambassador'},
    {'title': 'Calendar Event', 'route': '/admin/calendar-event'},
    {'title': 'Channel', 'route': '/admin/channel'},
    {'title': 'Client Relationship', 'route': '/admin/client-relationship'},
    {'title': 'Contract', 'route': '/admin/contract'},
    {'title': 'Contract Version', 'route': '/admin/contract-version'},
    {'title': 'Coupons', 'route': '/admin/coupons'},
    {'title': 'Currency', 'route': '/admin/currency'},
    {'title': 'Dashboard', 'route': '/admin/dashboard'},
    {'title': 'Dashboard Configuration', 'route': '/admin/dashboard-configuration'},
    {'title': 'Dashboard Widget', 'route': '/admin/dashboard-widget'},
    {'title': 'Deal', 'route': '/admin/deal'},
    {'title': 'Deposit Protection', 'route': '/admin/deposit-protection'},
    {'title': 'Discount', 'route': '/admin/discount'},
    {'title': 'Earning', 'route': '/admin/earning'},
    {'title': 'Event', 'route': '/admin/event'},
    {'title': 'Event Attendee', 'route': '/admin/event-attendee'},
    {'title': 'Exchange Rate', 'route': '/admin/exchange-rate'},
    {'title': 'Escrow Havuzu', 'route': '/admin/escrow'},
    {'title': 'Export File', 'route': '/admin/export-file'},
    {'title': 'Export Job', 'route': '/admin/export-job'},
    {'title': 'External Rental Listing', 'route': '/admin/external-rental-listing'},
    {'title': 'Extra Charge', 'route': '/admin/extra-charge'},
    {'title': 'Favorite', 'route': '/admin/favorite'},
    {'title': 'Filters', 'route': '/admin/filters'},
    {'title': 'Financial', 'route': '/admin/financial'},
    {'title': 'Floor Plan', 'route': '/admin/floor-plan'},
    {'title': 'Gift Card', 'route': '/admin/gift-card'},
    {'title': 'Government Integration', 'route': '/admin/government-integration'},
    {'title': 'Guest', 'route': '/admin/guest'},
    {'title': 'Guest Profile', 'route': '/admin/guest-profile'},
    {'title': 'Guest Review', 'route': '/admin/guest-review'},
    {'title': 'Hashtag', 'route': '/admin/hashtag'},
    {'title': 'Health Check', 'route': '/admin/health-check'},
    {'title': 'Home', 'route': '/admin/home'},
    {'title': 'Home Information Pack', 'route': '/admin/home-information-pack'},
    {'title': 'Immigration Status Check', 'route': '/admin/immigration-status-check'},
    {'title': 'Included Service', 'route': '/admin/included-service'},
    {'title': 'Increase', 'route': '/admin/increase'},
    {'title': 'Integration Log', 'route': '/admin/integration-log'},
    {'title': 'Investor Portfolio', 'route': '/admin/investor-portfolio'},
    {'title': 'Job', 'route': '/admin/job'},
    {'title': 'Key Management', 'route': '/admin/key-management'},
    {'title': 'Lead', 'route': '/admin/lead'},
    {'title': 'Lead Source', 'route': '/admin/lead-source'},
    {'title': 'Ledger Entry', 'route': '/admin/ledger-entry'},
    {'title': 'Listing', 'route': '/admin/listing'},
    {'title': 'Listing Channel', 'route': '/admin/listing-channel'},
    {'title': 'Listing Status History', 'route': '/admin/listing-status-history'},
    {'title': 'Listing Tag', 'route': '/admin/listing-tag'},
    {'title': 'Location', 'route': '/admin/location'},
    {'title': 'Loyalty Account', 'route': '/admin/loyalty-account'},
    {'title': 'Map Data', 'route': '/admin/map-data'},
    {'title': 'Map Layer', 'route': '/admin/map-layer'},
    {'title': 'Marketplace', 'route': '/admin/marketplace'},
    {'title': 'Mention', 'route': '/admin/mention'},
    {'title': 'Message', 'route': '/admin/message'},
    {'title': 'Ml Configuration', 'route': '/admin/ml-configuration'},
    {'title': 'Ml Model', 'route': '/admin/ml-model'},
    {'title': 'Mls Connection', 'route': '/admin/mls-connection'},
    {'title': 'Mls Data Mapping', 'route': '/admin/mls-data-mapping'},
    {'title': 'Mls External Listing', 'route': '/admin/mls-external-listing'},
    {'title': 'Mls Listing Enhancement', 'route': '/admin/mls-listing-enhancement'},
    {'title': 'Mls Sync Job', 'route': '/admin/mls-sync-job'},
    {'title': 'Mobile Device', 'route': '/admin/mobile-device'},
    {'title': 'More', 'route': '/admin/more'},
    {'title': 'Negotiation Offer', 'route': '/admin/negotiation-offer'},
    {'title': 'Neighborhood', 'route': '/admin/neighborhood'},
    {'title': 'Notification', 'route': '/admin/notification'},
    {'title': 'Offer', 'route': '/admin/offer'},
    {'title': 'Offline Sync Queue', 'route': '/admin/offline-sync-queue'},
    {'title': 'Org Subscription', 'route': '/admin/org-subscription'},
    {'title': 'Organizations', 'route': '/admin/organizations'},
    {'title': 'Performance Alert', 'route': '/admin/performance-alert'},
    {'title': 'Permission', 'route': '/admin/permission'},
    {'title': 'Photo', 'route': '/admin/photo'},
    {'title': 'Plan', 'route': '/admin/plan'},
    {'title': 'Post', 'route': '/admin/post'},
    {'title': 'Predictive Model', 'route': '/admin/predictive-model'},
    {'title': 'Pricing Rule', 'route': '/admin/pricing-rule'},
    {'title': 'Project', 'route': '/admin/project'},
    {'title': 'Project Alert', 'route': '/admin/project-alert'},
    {'title': 'Project Analytics', 'route': '/admin/project-analytics'},
    {'title': 'Project Report', 'route': '/admin/project-report'},
    {'title': 'Queue Configuration', 'route': '/admin/queue-configuration'},
    {'title': 'Queue Message', 'route': '/admin/queue-message'},
    {'title': 'Quote', 'route': '/admin/quote'},
    {'title': 'Recommendation Result', 'route': '/admin/recommendation-result'},
    {'title': 'Reference Source', 'route': '/admin/reference-source'},
    {'title': 'Referral', 'route': '/admin/referral'},
    {'title': 'Rent Arrears', 'route': '/admin/rent-arrears'},
    {'title': 'Rent Schedule', 'route': '/admin/rent-schedule'},
    {'title': 'Rental Sync Job', 'route': '/admin/rental-sync-job'},
    {'title': 'Report', 'route': '/admin/report'},
    {'title': 'Report Execution', 'route': '/admin/report-execution'},
    {'title': 'Reports', 'route': '/admin/reports'},
    {'title': 'Review', 'route': '/admin/review'},
    {'title': 'Right To Rent Check', 'route': '/admin/right-to-rent-check'},
    {'title': 'Route', 'route': '/admin/route'},
    {'title': 'Scraping Job', 'route': '/admin/scraping-job'},
    {'title': 'Session', 'route': '/admin/session'},
    {'title': 'Shared Amenity', 'route': '/admin/shared-amenity'},
    {'title': 'Signature Request', 'route': '/admin/signature-request'},
    {'title': 'Signature Signer', 'route': '/admin/signature-signer'},
    {'title': 'Social Impact Counter', 'route': '/admin/social-impact-counter'},
    {'title': 'Social Impact Record', 'route': '/admin/social-impact-record'},
    {'title': 'Solicitor Management', 'route': '/admin/solicitor-management'},
    {'title': 'Subscription', 'route': '/admin/subscription'},
    {'title': 'System', 'route': '/admin/system'},
    {'title': 'Tag', 'route': '/admin/tag'},
    {'title': 'Ticket', 'route': '/admin/ticket'},
    {'title': 'User', 'route': '/admin/user'},
    {'title': 'User Activity Log', 'route': '/admin/user-activity-log'},
    {'title': 'User Preference', 'route': '/admin/user-preference'},
    {'title': 'Users', 'route': '/admin/users'},
    {'title': 'Vacation Rental', 'route': '/admin/vacation-rental'},
    {'title': 'Vacation Rental Platform', 'route': '/admin/vacation-rental-platform'},
    {'title': 'Verification', 'route': '/admin/verification'},
    {'title': 'Video Content', 'route': '/admin/video-content'},
    {'title': 'Virtual Tour', 'route': '/admin/virtual-tour'},
    {'title': 'Webhook', 'route': '/admin/webhook'},
    {'title': 'Webhook Delivery', 'route': '/admin/webhook-delivery'},
    {'title': 'Welcome', 'route': '/admin/welcome'},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);

    final filteredModules = _allModules
        .where((m) => m['title']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        title: Text(
          'Admin Modules',
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
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredModules.length,
              itemBuilder: (context, index) {
                final module = filteredModules[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: () => context.push(module['route']!),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.admin_panel_settings, color: AppColors.primary, size: 20),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              module['title']!,
                              style: GoogleFonts.outfit(
                                color: colors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right, color: colors.textSecondary.withValues(alpha: 0.5)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
