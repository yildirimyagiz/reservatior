import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class PricingScreen extends ConsumerWidget {
  const PricingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.darkBg.withOpacity(0.95),
            elevation: 0,
            toolbarHeight: 80,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mobile.pricing.premium'.tr(),
                  style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary, letterSpacing: 2),
                ),
                Text(
                  'mobile.pricing.title'.tr(),
                  style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ],
            ).animate().fadeIn(delay: 100.ms),
          ),

          // Description
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Text(
                'mobile.pricing.desc'.tr(),
                style: GoogleFonts.outfit(fontSize: 13, color: Colors.white38, height: 1.5),
              ),
            ).animate().fadeIn(delay: 200.ms),
          ),

          // Plans
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildPlanCard(
                  name: 'ESSENTIAL',
                  price: '\$49',
                  period: 'mobile.pricing.monthly'.tr(),
                  features: [
                    'mobile.pricing.feat.properties50'.tr(),
                    'mobile.pricing.feat.basicReports'.tr(),
                    'mobile.pricing.feat.contracts'.tr(),
                    'mobile.pricing.feat.emailSupport'.tr(),
                  ],
                  isPopular: false,
                  index: 0,
                ),
                _buildPlanCard(
                  name: 'PROFESSIONAL',
                  price: '\$149',
                  period: 'mobile.pricing.monthly'.tr(),
                  features: [
                    'mobile.pricing.feat.unlimitedProperties'.tr(),
                    'mobile.pricing.feat.aiValuation'.tr(),
                    'mobile.pricing.feat.autoRent'.tr(),
                    'mobile.pricing.feat.digitalTwin'.tr(),
                    'mobile.pricing.feat.prioritySupport'.tr(),
                  ],
                  isPopular: true,
                  index: 1,
                ),
                _buildPlanCard(
                  name: 'ENTERPRISE',
                  price: 'mobile.pricing.custom'.tr(),
                  period: '',
                  features: [
                    'mobile.pricing.feat.erp'.tr(),
                    'mobile.pricing.feat.aiModel'.tr(),
                    'mobile.pricing.feat.whiteLabel'.tr(),
                    'mobile.pricing.feat.csm'.tr(),
                    'mobile.pricing.feat.sla'.tr(),
                  ],
                  isPopular: false,
                  index: 2,
                ),
              ]),
            ),
          ),

          // Security banner
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 24, 20, 120),
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  Icon(Icons.shield_rounded, color: AppColors.primary, size: 32),
                  SizedBox(height: 12),
                  Text('mobile.pricing.security'.tr(), style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                  SizedBox(height: 8),
                  Text(
                    'mobile.pricing.securityDesc'.tr(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(fontSize: 12, color: Colors.white38, height: 1.4),
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: ['mobile.leftovers.aes_256'.tr(), 'mobile.leftovers.sha_512'.tr(), 'mobile.leftovers.tls_1_3'.tr(), 'RBAC', 'mobile.leftovers.iso_27001'.tr()]
                        .map((auth) => Text(auth, style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.white24, letterSpacing: 1)))
                        .toList(),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String name,
    required String price,
    required String period,
    required List<String> features,
    required bool isPopular,
    required int index,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isPopular ? AppColors.primary.withOpacity(0.4) : Colors.white.withOpacity(0.05),
          width: isPopular ? 1.5 : 1,
        ),
        boxShadow: isPopular
            ? [BoxShadow(color: AppColors.primary.withOpacity(0.1), blurRadius: 20, spreadRadius: 2)]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white38, letterSpacing: 2)),
              if (isPopular)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('mobile.pricing.most_popular'.tr(), style: GoogleFonts.outfit(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
                ),
            ],
          ),
          SizedBox(height: 12),
          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: GoogleFonts.outfit(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white)),
              if (period.isNotEmpty) ...[
                SizedBox(width: 6),
                Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('/ $period', style: GoogleFonts.outfit(fontSize: 12, color: Colors.white30, fontWeight: FontWeight.w600)),
                ),
              ],
            ],
          ),
          SizedBox(height: 20),
          // Features
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Icon(Icons.check_rounded, color: AppColors.primary, size: 14),
                ),
                SizedBox(width: 12),
                Expanded(child: Text(f, style: GoogleFonts.outfit(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w600))),
              ],
            ),
          )),
          SizedBox(height: 16),
          // CTA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPopular ? AppColors.primary : Colors.white.withOpacity(0.05),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text(
                price.startsWith('\$') ? 'mobile.pricing.getStarted'.tr() : 'mobile.pricing.contactSales'.tr(),
                style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (300 + index * 100).ms).slideY(begin: 0.08);
  }
}
