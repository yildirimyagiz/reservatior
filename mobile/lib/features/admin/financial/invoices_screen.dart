import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          _buildBackGlow(Colors.tealAccent),
          CustomScrollView(
            slivers: [
              _buildSliverHeader('admin.financial.invoices'.tr()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildKpiCard(
                          'admin.financial.total'.tr(),
                          '0',
                          Icons.receipt_long,
                          Colors.tealAccent,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildKpiCard(
                          'admin.financial.overdue'.tr(),
                          '0',
                          Icons.warning,
                          Colors.redAccent,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildKpiCard(
                          'admin.financial.paid'.tr(),
                          '0',
                          Icons.check,
                          Colors.greenAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    'mobile.auto.admin_financial_noinvoices'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.white30,
                      fontSize: 14,
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
        backgroundColor: Colors.tealAccent.shade700,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'mobile.auto.admin_financial_newinvoice'.tr(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
  Widget _buildKpiCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) => Container(
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
