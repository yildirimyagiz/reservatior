import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class DealsScreen extends ConsumerStatefulWidget {
  const DealsScreen({super.key});
  @override
  ConsumerState<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends ConsumerState<DealsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'mobile.deal.title'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          tabs: [
            Tab(text: 'mobile.deal.tabNew'.tr()),
            Tab(text: 'mobile.deal.tabActive'.tr()),
            Tab(text: 'mobile.deal.tabClosing'.tr()),
            Tab(text: 'mobile.deal.tabWon'.tr()),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildPipelineSummary(colors),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDealsList(_newDeals, colors),
                _buildDealsList(_activeDeals, colors),
                _buildDealsList(_closingDeals, colors),
                _buildDealsList(_wonDeals, colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineSummary(ThemeAwareColors colors) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSumStat('mobile.deal.totalValue'.tr(), '\$12.5M', Colors.blue, colors),
          Container(width: 1, height: 36, color: colors.border),
          _buildSumStat('mobile.deal.active'.tr(), '8', Colors.green, colors),
          Container(width: 1, height: 36, color: colors.border),
          _buildSumStat('mobile.deal.winRate'.tr(), '68%', AppColors.primary, colors),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.05);
  }

  Widget _buildSumStat(
    String label,
    String value,
    Color color,
    ThemeAwareColors colors,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: colors.textSecondary, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildDealsList(
    List<Map<String, dynamic>> deals,
    ThemeAwareColors colors,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: deals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) => _buildDealCard(deals[i], colors, i),
    );
  }

  Widget _buildDealCard(
    Map<String, dynamic> deal,
    ThemeAwareColors colors,
    int idx,
  ) {
    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      deal['title'] as String,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      deal['value'] as String,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 14,
                    color: colors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    deal['client'] as String,
                    style: TextStyle(color: colors.textSecondary, fontSize: 12),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 13,
                    color: colors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    deal['date'] as String,
                    style: TextStyle(color: colors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: deal['progress'] as double,
                  backgroundColor: colors.border,
                  color: AppColors.primary,
                  minHeight: 4,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 60 * idx))
        .slideX(begin: 0.03);
  }

  static final _newDeals = [
    {
      'title': 'mobile.deal.deal1Title'.tr(),
      'client': 'mobile.leftovers.john_smith'.tr(),
      'value': '\$8.5M',
      'date': 'mobile.leftovers.apr_15'.tr(),
      'progress': 0.15,
    },
    {
      'title': 'mobile.deal.deal2Title'.tr(),
      'client': 'mobile.leftovers.sarah_johnson'.tr(),
      'value': '\$2.2M',
      'date': 'mobile.leftovers.apr_18'.tr(),
      'progress': 0.1,
    },
  ];
  static final _activeDeals = [
    {
      'title': 'mobile.deal.deal3Title'.tr(),
      'client': 'mobile.leftovers.michael_brown'.tr(),
      'value': '\$1.8M',
      'date': 'mobile.leftovers.apr_10'.tr(),
      'progress': 0.45,
    },
    {
      'title': 'mobile.deal.deal4Title'.tr(),
      'client': 'mobile.leftovers.emma_davis'.tr(),
      'value': '\$3.1M',
      'date': 'mobile.leftovers.apr_8'.tr(),
      'progress': 0.6,
    },
  ];
  static final _closingDeals = [
    {
      'title': 'mobile.deal.deal5Title'.tr(),
      'client': 'mobile.leftovers.robert_wilson'.tr(),
      'value': '\$5.4M',
      'date': 'mobile.leftovers.apr_5'.tr(),
      'progress': 0.85,
    },
  ];
  static final _wonDeals = [
    {
      'title': 'mobile.deal.deal6Title'.tr(),
      'client': 'mobile.leftovers.lisa_taylor'.tr(),
      'value': '\$1.2M',
      'date': 'mobile.leftovers.mar_28'.tr(),
      'progress': 1.0,
    },
    {
      'title': 'mobile.deal.deal7Title'.tr(),
      'client': 'mobile.leftovers.david_lee'.tr(),
      'value': '\$950K',
      'date': 'mobile.leftovers.mar_25'.tr(),
      'progress': 1.0,
    },
  ];
}
