import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/escrow_status.dart';
import 'package:reservatior/shared/enums/payment_status.dart';
import 'package:reservatior/shared/enums/transaction_type.dart';
import 'package:reservatior/shared/models/escrow_account.dart';
import 'package:reservatior/shared/models/financial_record.dart';
import 'package:reservatior/shared/providers/escrow_account_provider.dart';
import 'package:reservatior/shared/providers/financial_record_provider.dart';

class FinancialScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const FinancialScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends ConsumerState<FinancialScreen> {
  late int _tab;

  @override
  void initState() {
    super.initState();
    _tab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Financial',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Transactions'),
                    icon: Icon(Icons.receipt_long),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Escrow'),
                    icon: Icon(Icons.account_balance),
                  ),
                ],
                selected: {_tab},
                onSelectionChanged: (s) => setState(() => _tab = s.first),
                style: SegmentedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  foregroundColor: Colors.white70,
                  selectedBackgroundColor: AppColors.primary,
                  selectedForegroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.darkBorder),
                ),
              ),
            ),
          ),
          if (_tab == 0) const _TransactionsPanel() else const _EscrowPanel(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _TransactionsPanel extends ConsumerWidget {
  const _TransactionsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRecords = ref.watch(financialRecordListProvider);

    return asyncRecords.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load transactions'),
      ),
      data: (records) {
        if (records.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.receipt_long,
              title: 'No transactions yet',
              subtitle: 'Income and expense records will appear here',
            ),
          );
        }
        final sorted = [...records]
          ..sort((a, b) => (b.occurredAt ?? b.createdAt).compareTo(a.occurredAt ?? a.createdAt));
        final income = sorted
            .where((r) => r.recordType == TransactionType.INCOME)
            .fold(0.0, (s, r) => s + r.amount);
        final expense = sorted
            .where((r) => r.recordType == TransactionType.EXPENSE)
            .fold(0.0, (s, r) => s + r.amount);

        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      label: 'Income',
                      value: NumberFormat.compactCurrency(symbol: '').format(income),
                      color: AppColors.success,
                      icon: Icons.arrow_upward,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      label: 'Expenses',
                      value: NumberFormat.compactCurrency(symbol: '').format(expense),
                      color: AppColors.error,
                      icon: Icons.arrow_downward,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              for (var i = 0; i < sorted.length; i++)
                _TransactionTile(record: sorted[i]).animate().fadeIn(delay: (40 * i).ms),
            ]),
          ),
        );
      },
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final FinancialRecord record;
  const _TransactionTile({required this.record});

  @override
  Widget build(BuildContext context) {
    final income = record.recordType == TransactionType.INCOME;
    final date = record.occurredAt ?? record.createdAt;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
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
              color: (income ? AppColors.success : AppColors.error)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              income ? Icons.south_west : Icons.north_east,
              color: income ? AppColors.success : AppColors.error,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.description ?? record.category ?? record.type,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${record.property.name} · ${DateFormat.yMMMd().format(date)}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${income ? '+' : '-'}${NumberFormat.compactCurrency(symbol: '').format(record.amount)}',
                style: GoogleFonts.outfit(
                  color: income ? AppColors.success : Colors.white70,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                record.paymentStatus.name,
                style: GoogleFonts.outfit(
                  color: _statusColor(record.paymentStatus),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _statusColor(PaymentStatus s) => switch (s) {
        PaymentStatus.PAID => AppColors.success,
        PaymentStatus.OVERDUE => AppColors.error,
        PaymentStatus.PARTIAL => AppColors.warning,
        PaymentStatus.UNPAID => Colors.white54,
        _ => Colors.white38,
      };
}

class _EscrowPanel extends ConsumerWidget {
  const _EscrowPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAccounts = ref.watch(escrowAccountListProvider);

    return asyncAccounts.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load escrow'),
      ),
      data: (accounts) {
        if (accounts.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.account_balance,
              title: 'No escrow accounts',
              subtitle: 'Held deposits will appear here',
            ),
          );
        }
        final totalHeld = accounts
            .where((a) => a.status == EscrowStatus.HOLDING)
            .fold(0.0, (s, a) => s + a.totalAmount);
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _SummaryCard(
                label: 'Held in escrow',
                value: NumberFormat.compactCurrency(symbol: '').format(totalHeld),
                color: AppColors.primary,
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              for (var i = 0; i < accounts.length; i++)
                _EscrowTile(account: accounts[i]).animate().fadeIn(delay: (40 * i).ms),
            ]),
          ),
        );
      },
    );
  }
}

class _EscrowTile extends StatelessWidget {
  final EscrowAccount account;
  const _EscrowTile({required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
              Expanded(
                child:                 Text(
                  account.reservation.listing?.title ??
                      'Escrow ${account.id.substring(0, 8)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              _EscrowBadge(status: account.status),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _escrowMetric('Total', account.totalAmount),
              _escrowMetric('Deposit', account.depositAmount),
              _escrowMetric('Released', account.totalAmount - account.depositAmount),
            ],
          ),
        ],
      ),
    );
  }

  Widget _escrowMetric(String label, double amount) {
    return Column(
      children: [
        Text(
          NumberFormat.compactCurrency(symbol: '').format(amount),
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

class _EscrowBadge extends StatelessWidget {
  final EscrowStatus status;
  const _EscrowBadge({required this.status});

  Color get _color => switch (status) {
        EscrowStatus.HOLDING => AppColors.primary,
        EscrowStatus.FULLY_RELEASED => AppColors.success,
        EscrowStatus.PARTIALLY_RELEASED => AppColors.info,
        EscrowStatus.DISPUTED => AppColors.warning,
        EscrowStatus.REFUNDED => Colors.white54,
        EscrowStatus.CANCELLED => AppColors.error,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status.name,
        style: GoogleFonts.outfit(
          color: _color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 10),
          Text(label,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              )),
        ],
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _CenteredMessage({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white38, size: 40),
            const SizedBox(height: 12),
            Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                )),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                      color: Colors.white38, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }
}
