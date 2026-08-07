import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/loyalty_tier.dart';
import 'package:reservatior/shared/models/loyalty_account.dart';
import 'package:reservatior/shared/providers/loyalty_account_provider.dart';

class LoyaltyScreen extends ConsumerWidget {
  const LoyaltyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAccounts = ref.watch(loyaltyAccountListProvider);
    final accounts = asyncAccounts.value ?? <LoyaltyAccount>[];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Loyalty & Membership',
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
                asyncAccounts.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load loyalty accounts',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (accounts.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.redeem, color: Colors.white24, size: 32),
                            const SizedBox(height: 10),
                            Text('No loyalty accounts here',
                                style: GoogleFonts.outfit(
                                    color: Colors.white38, fontSize: 13)),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: accounts
                          .map((a) => _AccountTile(account: a))
                          .toList(),
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

class _AccountTile extends StatelessWidget {
  final LoyaltyAccount account;
  const _AccountTile({required this.account});

  @override
  Widget build(BuildContext context) {
    final tierColor = _tierColor(account.currentTier);
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
                  color: tierColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.military_tech_outlined,
                    color: tierColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.user.name ?? account.user.email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      account.name,
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tierColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: tierColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  account.currentTier.name,
                  style: GoogleFonts.outfit(
                      color: tierColor, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _Metric(
                icon: Icons.stars_outlined,
                value: '${account.currentPoints}',
                label: 'Current points',
                color: AppColors.gold,
              ),
              _Metric(
                icon: Icons.trending_up,
                value: '${account.totalEarned}',
                label: 'Total earned',
                color: AppColors.success,
              ),
              _Metric(
                icon: Icons.point_of_sale,
                value: '${account.pointsPerDollar.toStringAsFixed(1)}',
                label: 'Points / \$',
                color: AppColors.info,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Next tier · ${_nextTier(account.currentTier)}',
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
          ),
          if (!account.isActive) ...[
            const SizedBox(height: 8),
            Text(
              'Inactive account',
              style: GoogleFonts.outfit(
                  color: AppColors.error,
                  fontSize: 11,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ],
      ).animate().fadeIn(),
    );
  }

  Color _tierColor(LoyaltyTier tier) {
    switch (tier) {
      case LoyaltyTier.BRONZE:
        return Colors.brown.shade300;
      case LoyaltyTier.SILVER:
        return Colors.blueGrey.shade200;
      case LoyaltyTier.GOLD:
        return AppColors.gold;
      case LoyaltyTier.PLATINUM:
        return AppColors.info;
      case LoyaltyTier.DIAMOND:
        return AppColors.primary;
    }
  }

  String _nextTier(LoyaltyTier tier) {
    switch (tier) {
      case LoyaltyTier.BRONZE:
        return 'SILVER';
      case LoyaltyTier.SILVER:
        return 'GOLD';
      case LoyaltyTier.GOLD:
        return 'PLATINUM';
      case LoyaltyTier.PLATINUM:
        return 'DIAMOND';
      case LoyaltyTier.DIAMOND:
        return 'MAX';
    }
  }
}

class _Metric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  const _Metric({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800),
            ),
            Text(
              label,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }
}
