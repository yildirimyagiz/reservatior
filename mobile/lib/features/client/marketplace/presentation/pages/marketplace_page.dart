import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:ui' as ui;
import 'package:sizer/sizer.dart';
import 'package:reservatior/shared/widgets/app_widgets.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          Colors.grey[50], // Light neutral background for modern SaaS feel
      appBar: AppBar(
        title: Text('mobile.auto.infrastructure_store'.tr(),
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.indigo),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: Colors.indigo),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(theme),
            SizedBox(height: 3.h),
            SectionHeader(title: 'mobile.auto.available_add_ons'.tr()),
            SizedBox(height: 2.h),
            _buildAddOnGrid(theme),
            SizedBox(height: 4.h),
            _buildActiveSubscriptionSection(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: Colors.indigo[900],
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1558223175-0e1948842e43?auto=format&fit=crop&w=800&q=80',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.indigo[900]!.withOpacity(0.85),
            BlendMode.srcIn,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text('mobile.auto.pro_infrastructure'.tr(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'mobile.leftovers.optimize_your_nrevenue_stream'.tr(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ),
          SizedBox(height: 1.h),
          Text('mobile.auto.upgrade_your_listings_with_global_verification_and_ai_driven_insights'.tr(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOnGrid(ThemeData theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 2.h,
      crossAxisSpacing: 4.w,
      childAspectRatio: 0.8,
      children: [
        _buildAddOnCard(
          theme,
          'mobile.leftovers.smart_lock_pro'.tr(),
          'mobile.leftovers.cloud_managed_remote_key_entry_for_prope'.tr(),
          '\$24.99/mo',
          Icons.vpn_key_rounded,
          Colors.indigo,
        ),
        _buildAddOnCard(
          theme,
          'mobile.leftovers.ai_valuation'.tr(),
          'mobile.leftovers.real_time_market_analysis_and_pricing_su'.tr(),
          '\$4.99/val',
          Icons.auto_awesome_rounded,
          Colors.amber[800]!,
        ),
        _buildAddOnCard(
          theme,
          'mobile.leftovers.gov_reporting'.tr(),
          'mobile.leftovers.automatic_police_tax_reporting_integrati'.tr(),
          '\$14.99/mo',
          Icons.gavel_rounded,
          Colors.blueGrey,
        ),
        _buildAddOnCard(
          theme,
          'mobile.leftovers.video_boost'.tr(),
          'mobile.leftovers.enhanced_4k_video_compression_cdn_storag'.tr(),
          '\$9.99/mo',
          Icons.videocam_rounded,
          Colors.deepOrange,
        ),
      ],
    );
  }

  Widget _buildAddOnCard(
    ThemeData theme,
    String title,
    String description,
    String price,
    IconData icon,
    Color accentColor,
  ) {
    return PremiumCard(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          SizedBox(height: 0.5.h),
          Expanded(
            child: Text(
              description,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: accentColor,
                  fontSize: 14,
                ),
              ),
              const Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.indigo,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSubscriptionSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'mobile.auto.active_infrastructure'.tr()),
        SizedBox(height: 2.h),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.h,
            ),
            leading: const CircleAvatar(
              backgroundColor: Colors.teal,
              child: Icon(Icons.verified_user_rounded, color: Colors.white),
            ),
            title: Text('mobile.auto.identity_verification_pro'.tr(),
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            subtitle: Text('mobile.auto.feature_marketplace_title'.tr()),
            trailing: TextButton(
              onPressed: () {},
              child: Text('mobile.auto.manage'.tr(),
                style: TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
