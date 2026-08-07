import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/investor_portfolio.dart';
import 'package:reservatior/shared/providers/investor_portfolio_provider.dart';

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPortfolios = ref.watch(investorPortfolioListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Portfolio',
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
                  'Your investment portfolios and holdings.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                asyncPortfolios.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => _EmptyCard(
                    icon: Icons.cloud_off,
                    title: 'No portfolio data',
                    subtitle: '$e',
                  ),
                  data: (portfolios) {
                    if (portfolios.isEmpty) {
                      return _EmptyCard(
                        icon: Icons.workspaces_outline,
                        title: 'No portfolios yet',
                        subtitle: 'Create your first investor portfolio',
                      );
                    }
                    final totalInvested = portfolios.fold<double>(
                        0, (s, p) => s + p.totalInvested);
                    final totalValue = portfolios.fold<double>(
                        0, (s, p) => s + p.currentValue);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _KpiGrid(
                          items: [
                            (
                              'Invested',
                              NumberFormat.compactCurrency(symbol: '\$')
                                  .format(totalInvested),
                              Icons.account_balance_wallet,
                              AppColors.primary,
                            ),
                            (
                              'Current value',
                              NumberFormat.compactCurrency(symbol: '\$')
                                  .format(totalValue),
                              Icons.trending_up,
                              AppColors.success,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text('Portfolios',
                            style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        const SizedBox(height: 12),
                        ...portfolios.map(
                            (p) => _PortfolioTile(portfolio: p)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioTile extends StatelessWidget {
  final InvestorPortfolio portfolio;
  const _PortfolioTile({required this.portfolio});

  @override
  Widget build(BuildContext context) {
    final gain = portfolio.currentValue - portfolio.totalInvested;
    final gainPct = portfolio.totalInvested > 0
        ? (gain / portfolio.totalInvested) * 100
        : 0.0;
    final gainColor = gain >= 0 ? AppColors.success : AppColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.workspaces_outline,
                    color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      portfolio.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      '${portfolio.properties.length} holdings · '
                      '${portfolio.riskTolerance.name} risk',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: gainColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: gainColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  '${gainPct >= 0 ? '+' : ''}${gainPct.toStringAsFixed(1)}%',
                  style: GoogleFonts.outfit(
                      color: gainColor, fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'Invested',
                  value: NumberFormat.compactCurrency(symbol: '\$')
                      .format(portfolio.totalInvested),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Metric(
                  label: 'Value',
                  value: NumberFormat.compactCurrency(symbol: '\$')
                      .format(portfolio.currentValue),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Metric(
                  label: 'Returns',
                  value: NumberFormat.compactCurrency(symbol: '\$')
                      .format(portfolio.totalReturns),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Target IRR: ${portfolio.targetIrr?.toStringAsFixed(1) ?? '—'}%'
            '${portfolio.investmentHorizon != null ? ' · Horizon: ${portfolio.investmentHorizon}' : ''}',
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
          ),
        ],
      ).animate().fadeIn(),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.outfit(
                color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
          ),
        ],
      ),
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
      childAspectRatio: 1.7,
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

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _EmptyCard({required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white24, size: 32),
          const SizedBox(height: 10),
          Text(title,
              style: GoogleFonts.outfit(
                  color: Colors.white70, fontWeight: FontWeight.w600)),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
