import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/investor_portfolio.dart';
import 'package:reservatior/shared/providers/investor_portfolio_provider.dart';

class InvestmentOsDashboardPage extends ConsumerWidget {
  const InvestmentOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPortfolios = ref.watch(investorPortfolioListProvider);
    final portfolios = asyncPortfolios.value ?? <InvestorPortfolio>[];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'investment.os_title'.tr(defaultValue: 'Investment OS'),
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'investment.os_description'.tr(defaultValue: 'Manage investments, projects and portfolio returns.'),
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                asyncPortfolios.when(
                  loading: () => const _LoadingCard(),
                  error: (e, _) => _EmptyCard(
                    icon: Icons.cloud_off,
                    title: 'investment.no_data'.tr(defaultValue: 'No portfolio data'),
                    subtitle: 'investment.no_data_desc'.tr(defaultValue: 'Investor portfolios will appear here'),
                  ),
                  data: (portfolios) => _KpiGrid(
                    items: [
                      (
                        'Total invested',
                        NumberFormat.compactCurrency(symbol: '').format(
                            portfolios.fold(0.0, (s, p) => s + p.totalInvested)),
                        Icons.account_balance_wallet,
                        AppColors.primary,
                      ),
                      (
                        'Current value',
                        NumberFormat.compactCurrency(symbol: '').format(
                            portfolios.fold(0.0, (s, p) => s + p.currentValue)),
                        Icons.trending_up,
                        AppColors.success,
                      ),
                      (
                        'Portfolios',
                        '${portfolios.length}',
                        Icons.workspaces_outline,
                        AppColors.info,
                      ),
                      (
                        'Avg IRR',
                        '${_avgIrr(portfolios)}%',
                        Icons.percent,
                        AppColors.gold,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _ModuleCard(
                  title: 'investment.roi_calculator'.tr(defaultValue: 'ROI Calculator'),
                  subtitle: 'investment.calculate_net_payback'.tr(defaultValue: 'Full mortgage & return model'),
                  icon: Icons.calculate_outlined,
                  color: AppColors.primary,
                  route: '/invest/roi',
                ),
                const SizedBox(height: 12),
                _ModuleCard(
                  title: 'investment.rental_yield'.tr(defaultValue: 'Rental Yield'),
                  subtitle: 'investment.compare_districts'.tr(defaultValue: 'Gross / net / cash-on-cash'),
                  icon: Icons.trending_up,
                  color: AppColors.success,
                  route: '/invest/yield',
                ),
                const SizedBox(height: 12),
                _ModuleCard(
                  title: 'investment.compare'.tr(defaultValue: 'Compare'),
                  subtitle: 'investment.compare_desc'.tr(defaultValue: 'Properties & global cities'),
                  icon: Icons.compare_arrows,
                  color: AppColors.warning,
                  route: '/invest/compare',
                ),
                const SizedBox(height: 24),
                Text('investment.portfolios'.tr(defaultValue: 'Portfolios'),
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                const SizedBox(height: 12),
                if (portfolios.isEmpty)
                  _EmptyCard(
                    icon: Icons.workspaces_outline,
                    title: 'investment.no_portfolios_yet'.tr(defaultValue: 'No portfolios yet'),
                  )
                else
                  for (final p in portfolios)
                    _PortfolioTile(portfolio: p).animate().fadeIn(),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  double _avgIrr(List<InvestorPortfolio> portfolios) {
    if (portfolios.isEmpty) return 0;
    final sum = portfolios.fold(0.0, (s, p) => s + (p.targetIrr ?? 0));
    return (sum / portfolios.length).toStringAsFixed(0) == '0'
        ? 0
        : double.parse((sum / portfolios.length).toStringAsFixed(1));
  }
}

class _PortfolioTile extends StatelessWidget {
  final InvestorPortfolio portfolio;
  const _PortfolioTile({required this.portfolio});

  @override
  Widget build(BuildContext context) {
    final returnPct = portfolio.totalInvested > 0
        ? (portfolio.totalReturns / portfolio.totalInvested) * 100
        : 0.0;
    final positive = returnPct >= 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  portfolio.name,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (positive ? AppColors.success : AppColors.error)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: (positive ? AppColors.success : AppColors.error)
                          .withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${positive ? '+' : ''}${returnPct.toStringAsFixed(1)}%',
                  style: GoogleFonts.outfit(
                    color: positive ? AppColors.success : AppColors.error,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _metric('Invested',
                  NumberFormat.compactCurrency(symbol: '').format(portfolio.totalInvested)),
              _metric('Value',
                  NumberFormat.compactCurrency(symbol: '').format(portfolio.currentValue)),
              _metric('Returns',
                  NumberFormat.compactCurrency(symbol: '').format(portfolio.totalReturns)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${portfolio.properties.length} properties · '
            '${portfolio.riskTolerance.name} risk'
            '${portfolio.targetIrr != null ? ' · target IRR ${portfolio.targetIrr!.toStringAsFixed(1)}%' : ''}',
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        Text(label,
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
      ],
    );
  }
}

class _KpiGrid extends StatelessWidget {
  final List<(String, String, IconData, Color)> items;
  const _KpiGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: items
          .map((e) => Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(e.$3, color: e.$4, size: 20),
                    const SizedBox(height: 8),
                    Text(
                      e.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    Text(e.$1,
                        style: GoogleFonts.outfit(
                            color: Colors.white38, fontSize: 11)),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String route;
  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)),
                  Text(subtitle,
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _EmptyCard({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white24, size: 36),
          const SizedBox(height: 8),
          Text(title,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                  color: Colors.white54, fontWeight: FontWeight.w600)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                    color: Colors.white38, fontSize: 12)),
          ],
        ],
      ),
    );
  }
}
