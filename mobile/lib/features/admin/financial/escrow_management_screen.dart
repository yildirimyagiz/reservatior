import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/escrow_account_provider.dart';

class EscrowManagementScreen extends ConsumerWidget {
  const EscrowManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(escrowAccountListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          _buildBackGlow(Colors.blueAccent),
          CustomScrollView(
            slivers: [
              _buildSliverHeader('admin.financial.escrowTitle'.tr()),

              // KPI Cards
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildKpiCard(
                          'admin.financial.total'.tr(),
                          '\$0',
                          Icons.account_balance,
                          Colors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildKpiCard(
                          'mobile.leftovers.zero_deposit'.tr(),
                          '\$0',
                          Icons.shield,
                          Colors.blueAccent,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildKpiCard(
                          'admin.financial.disputes'.tr(),
                          '0',
                          Icons.warning_amber,
                          Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Tabs
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildTabChip('admin.financial.accounts'.tr(), true),
                      SizedBox(width: 8),
                      _buildTabChip('admin.financial.releases'.tr(), false),
                      SizedBox(width: 8),
                      _buildTabChip('admin.financial.disputes'.tr(), false),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Account List
              accountsAsync.when(
                data: (data) => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildEscrowCard(data[index], index),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('admin.common.coming_soon'.tr()),
      backgroundColor: Colors.orange,
    ),
  );
},
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'mobile.auto.admin_financial_newescrow'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSliverHeader(String title) {
    return SliverAppBar(
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
  }

  Widget _buildKpiCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color.withValues(alpha: 0.6), size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white30,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95));
  }

  Widget _buildTabChip(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.blueAccent : AppColors.darkSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEscrowCard(dynamic item, int index) {
    final isZeroDeposit = item.metadata?['isZeroDeposit'] == true;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
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
                const SizedBox(height: 4),
                Text(
                  '\$${item.totalAmount ?? 0}',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isZeroDeposit
                  ? Colors.blueAccent.withValues(alpha: 0.2)
                  : Colors.greenAccent.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              isZeroDeposit ? 'mobile.leftovers.surety_bond'.tr() : 'Cash',
              style: GoogleFonts.outfit(
                color: isZeroDeposit ? Colors.blueAccent : Colors.greenAccent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildBackGlow(Color color) {
    return Positioned(
      top: 200,
      right: -100,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.04),
        ),
      ),
    );
  }
}
