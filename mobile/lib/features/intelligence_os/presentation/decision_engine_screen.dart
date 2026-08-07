import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DecisionEngineScreen extends ConsumerWidget {
  const DecisionEngineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Decision Engine',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Autonomous pricing, occupancy & acceptance decisions',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildKpiGrid(),
                const SizedBox(height: 20),
                _sectionHeader('Recent Decisions', Icons.lightbulb_outline, AppColors.warning),
                const SizedBox(height: 12),
                ..._buildDecisions(),
                const SizedBox(height: 20),
                _sectionHeader('Decision Lifecycle', Icons.account_tree_outlined, AppColors.primaryLight),
                const SizedBox(height: 12),
                _buildLifecycle(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildKpiGrid() {
    final kpis = [
      ('Total Decisions', '5', Icons.psychology_outlined, AppColors.primaryLight, 0),
      ('Accepted', '2', Icons.thumb_up_outlined, AppColors.info, 60),
      ('Pending', '1', Icons.schedule_outlined, AppColors.warning, 120),
      ('Avg Confidence', '89%', Icons.ads_click, AppColors.info, 180),
      ('Success Rate', '84%', Icons.trending_up, AppColors.primaryLight, 240),
      ('Revenue Impact', '\$124.5K', Icons.payments_outlined, AppColors.success, 300),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.9,
      ),
      itemCount: kpis.length,
      itemBuilder: (context, index) {
        final (title, value, icon, color, delay) = kpis[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkCard.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.05, end: 0);
      },
    );
  }

  List<Widget> _buildDecisions() {
    final decisions = [
      ('PRICE REDUCTION', 'Kensington 3BR Flat', 'Reduce price by 5%', 92, 'ACCEPTED', '+23% views', '2h ago'),
      ('MARKETING BOOST', 'Chelsea Penthouse', 'Boost Instagram campaign', 87, 'PENDING', 'Predicted +15% leads', '4h ago'),
      ('LISTING REFRESH', 'Canary Wharf Studio', 'Refresh listing photos', 78, 'ACCEPTED', '+18% engagement', '1d ago'),
      ('AGENT REASSIGNMENT', 'Notting Hill Townhouse', 'Assign to Agent Sarah M.', 91, 'REJECTED', 'N/A', '1d ago'),
      ('INVESTMENT RECOMMENDATION', 'Manchester Waterfront', 'Strong Buy — 8.2% yield', 95, 'MONITORING', 'Tracking outcomes…', '3d ago'),
    ];

    final statusColor = <String, Color>{
      'ACCEPTED': AppColors.success,
      'PENDING': AppColors.warning,
      'REJECTED': AppColors.error,
      'MONITORING': AppColors.info,
    };

    return decisions.map((d) {
      final (type, prop, rec, conf, status, impact, time) = d;
      final color = statusColor[status] ?? AppColors.info;
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    type.replaceAll('_', ' '),
                    style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.info, letterSpacing: 0.4),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(prop, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
            const SizedBox(height: 4),
            Text(rec, style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: conf / 100,
                      minHeight: 6,
                      backgroundColor: AppColors.darkMuted,
                      color: conf >= 85 ? AppColors.info : conf >= 70 ? AppColors.warning : AppColors.error,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('$conf%', style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondaryDark)),
                const SizedBox(width: 12),
                Text(impact, style: GoogleFonts.outfit(fontSize: 11, color: AppColors.success)),
                const Spacer(),
                Text(time, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildLifecycle() {
    final steps = ['AI Proposes', 'Owner Notified', 'Accept/Reject', 'Action Executed', 'Outcome Monitored', 'Learning Updated'];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (i) {
              return Column(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i <= 3 ? AppColors.primary : AppColors.darkMuted,
                    ),
                    child: Center(
                      child: Text('${i + 1}', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 14)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 52,
                    child: Text(
                      steps[i],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(fontSize: 9, color: AppColors.textSecondaryDark),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
