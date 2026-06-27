import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class LeaseCareScreen extends ConsumerWidget {
  const LeaseCareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    final benefits = [
      _Benefit(Icons.verified_user_rounded, 'mobile.leasecare.guarantee'.tr(), 'mobile.leasecare.guaranteeDesc'.tr(), Colors.greenAccent),
      _Benefit(Icons.build_circle_rounded, 'mobile.leasecare.maintenance'.tr(), 'mobile.leasecare.maintenanceDesc'.tr(), Colors.orangeAccent),
      _Benefit(Icons.gavel_rounded, 'mobile.leasecare.legal'.tr(), 'mobile.leasecare.legalDesc'.tr(), Colors.cyanAccent),
      _Benefit(Icons.auto_awesome_rounded, 'mobile.leasecare.ai'.tr(), 'mobile.leasecare.aiDesc'.tr(), AppColors.primary),
      _Benefit(Icons.support_agent_rounded, 'mobile.leasecare.support247'.tr(), 'mobile.leasecare.support247Desc'.tr(), Colors.purpleAccent),
      _Benefit(Icons.payment_rounded, 'mobile.leasecare.rentProtect'.tr(), 'mobile.leasecare.rentProtectDesc'.tr(), Colors.tealAccent),
    ];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.darkBg,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.greenAccent.withOpacity(0.15), AppColors.darkBg],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50, right: -50,
                    child: Container(width: 200, height: 200, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent.withOpacity(0.05))),
                  ),
                  Positioned(
                    bottom: 30, left: 24, right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shield_rounded, color: Colors.greenAccent, size: 14),
                              SizedBox(width: 6),
                              Text('mobile.auto.pro'.tr(), style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.greenAccent, letterSpacing: 2)),
                            ],
                          ),
                        ).animate().fadeIn(delay: 200.ms),
                        SizedBox(height: 12),
                        Text('mobile.auto.leasecare'.tr(), style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1)),
                        SizedBox(height: 4),
                        Text(
                          'mobile.leasecare.tagline'.tr(),
                          style: GoogleFonts.outfit(fontSize: 13, color: Colors.white38, height: 1.4),
                        ).animate().fadeIn(delay: 300.ms),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stats
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('98%', 'mobile.leasecare.resolution'.tr()),
                  Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                  _buildStat('24/7', 'mobile.leasecare.availability'.tr()),
                  Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
                  _buildStat('4.9★', 'mobile.leasecare.satisfaction'.tr()),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
          ),

          // Benefits
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Container(width: 3, height: 14, decoration: BoxDecoration(color: Colors.greenAccent, borderRadius: BorderRadius.circular(2))),
                  SizedBox(width: 10),
                  Text('mobile.leasecare.benefits'.tr(), style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.white38, letterSpacing: 1.5)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final b = benefits[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.03)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50, height: 50,
                          decoration: BoxDecoration(color: b.color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
                          child: Icon(b.icon, color: b.color, size: 24),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(b.title, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                              SizedBox(height: 4),
                              Text(b.desc, style: GoogleFonts.outfit(fontSize: 12, color: Colors.white38, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (500 + index * 80).ms).slideX(begin: 0.05);
                },
                childCount: benefits.length,
              ),
            ),
          ),

          // CTA
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 120),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent.shade700,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 0,
                  ),
                  child: Text('mobile.leasecare.activate'.tr(), style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 1)),
                ),
              ),
            ).animate().fadeIn(delay: 800.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.greenAccent)),
        SizedBox(height: 4),
        Text(label, style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white38, letterSpacing: 1)),
      ],
    );
  }
}

class _Benefit {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;
  _Benefit(this.icon, this.title, this.desc, this.color);
}
