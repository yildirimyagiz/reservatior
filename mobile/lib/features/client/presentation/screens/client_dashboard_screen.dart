import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/core/navigation/feature_groups.dart';
import 'package:reservatior/features/client/presentation/widgets/dashboard_stats_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/revenue_chart_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/quick_actions_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/ai_insights_widget.dart';
import 'package:reservatior/features/client/presentation/widgets/recent_activity_widget.dart';

class ClientDashboardScreen extends ConsumerWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Neural Gradient Background
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gold.withOpacity(0.03),
              ),
            ),
          ),

          CustomScrollView(
            slivers: [
              // Premium Client Header
              SliverAppBar(
                expandedHeight: 140,
                floating: true,
                pinned: true,
                backgroundColor: AppColors.darkBg.withOpacity(0.8),
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(left: 24, bottom: 20),
                  title: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.gold, width: 1.5),
                        ),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: AppColors.darkSurface,
                          child: Icon(
                            Icons.person_rounded,
                            size: 14,
                            color: AppColors.gold,
                          ),
                        ),
                      ).animate().scale(delay: 200.ms),
                      SizedBox(width: 12),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('mobile.auto.neural_investor'.tr(),
                            style: GoogleFonts.outfit(
                              color: AppColors.gold,
                              fontWeight: FontWeight.w900,
                              fontSize: 10,
                              letterSpacing: 2,
                            ),
                          ),
                          Text('mobile.auto.user_experience'.tr(), // This will be dynamic in real app
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.hub_rounded, color: AppColors.gold),
                    onPressed: () => _showNotifications(context),
                  ),
                  SizedBox(width: 12),
                ],
              ),

              // Stats Segment (Glass Cards)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: const DashboardStatsWidget()
                      .animate()
                      .fadeIn(delay: 400.ms)
                      .slideY(begin: 0.1),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Tactical Nodes (Quick Actions)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('mobile.auto.discovery_nodes'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.white24,
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 16),
                      const QuickActionsWidget().animate().fadeIn(
                        delay: 500.ms,
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // AI Insights Engine
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: const AIInsightsWidget().animate().shimmer(
                    duration: 3.seconds,
                    color: Colors.white10,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // Revenue/Investment Chart
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: const RevenueChartWidget().animate().fadeIn(
                    delay: 700.ms,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('mobile.auto.notifications_coming_soon'.tr())));
  }

  void _openSettings(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('mobile.auto.settings_coming_soon'.tr())));
  }
}
