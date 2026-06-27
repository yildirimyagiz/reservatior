import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/commission_rule_provider.dart';

class CommissionRulesScreen extends ConsumerWidget {
  const CommissionRulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(commissionRuleListProvider);
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          _buildBackGlow(Colors.deepOrange),
          CustomScrollView(
            slivers: [
              _buildSliverHeader('admin.financial.commissionRules'.tr()),
              itemsAsync.when(
                data: (data) => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => _buildRuleCard(data[i], i),
                      childCount: data.length,
                    ),
                  ),
                ),
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, s) => SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Error: $e',
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('admin.common.coming_soon'.tr()),
      backgroundColor: Colors.orange,
    ),
  );
},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSliverHeader(String title) => SliverAppBar(
    expandedHeight: 140,
    pinned: true,
    backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
      title: Text(
        title,
        style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 22),
      ),
    ),
  );

  Widget _buildRuleCard(dynamic item, int index) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.darkSurface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.id.substring(0, 8).toUpperCase(),
              style: GoogleFonts.outfit(
                color: Colors.white30,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${item.percentage ?? 0}%',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const Icon(Icons.rule, color: Colors.deepOrange),
      ],
    ),
  ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1, end: 0);

  Widget _buildBackGlow(Color c) => Positioned(
    top: 200,
    right: -100,
    child: Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: c.withValues(alpha: 0.04),
      ),
    ),
  );
}
