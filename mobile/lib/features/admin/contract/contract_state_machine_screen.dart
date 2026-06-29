import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractStateMachineScreen extends ConsumerWidget {
  const ContractStateMachineScreen({super.key});

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
                  title: Text(
                    'contract.state.title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StateMachinePipeline(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'contract.state.active_contracts'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'contract.state.total_format'.tr(namedArgs: {'count': '24'}),
                      style: GoogleFonts.outfit(
                        color: AppColors.primary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(8, (i) => _ContractTile(
                  contractId: 'CT-${2024000 + i}',
                  tenantName: i.isEven ? 'Bodrum Luxury Villas' : 'Istanbul Property Management',
                  type: i % 3 == 0 ? 'Commission Agreement' : i % 3 == 1 ? 'Listing Contract' : 'Revenue Share',
                  state: ['Created', 'Pending', 'Active', 'Active', 'Active', 'Suspended', 'Settled', 'Archived'][i],
                  value: '\$${(245000 + i * 89000).toStringAsFixed(0)}',
                  date: '2026-0${(i % 9) + 1}-15',
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _StateMachinePipeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final states = [
      _StateDef('contract.state.created'.tr(), Icons.add_circle_outline, AppColors.info),
      _StateDef('contract.state.pending'.tr(), Icons.hourglass_empty, AppColors.warning),
      _StateDef('contract.state.active'.tr(), Icons.play_circle, AppColors.success),
      _StateDef('contract.state.suspended'.tr(), Icons.pause_circle, AppColors.error),
      _StateDef('contract.state.modified'.tr(), Icons.edit, AppColors.primary),
      _StateDef('contract.state.settled'.tr(), Icons.check_circle, AppColors.success),
      _StateDef('contract.state.archived'.tr(), Icons.archive, AppColors.textSecondaryDark),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.account_tree, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'contract.state.lifecycle'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'contract.state.description'.tr(),
                    style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 140,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(states.length, (i) {
                    final s = states[i];
                    final isLast = i == states.length - 1;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: s.color.withValues(alpha: 0.12),
                                border: Border.all(color: s.color.withValues(alpha: 0.4), width: 2),
                              ),
                              child: Icon(s.icon, color: s.color, size: 22),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              s.label,
                              style: GoogleFonts.outfit(
                                color: s.color,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (!isLast)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20),
                                Icon(Icons.arrow_forward, color: AppColors.darkBorder, size: 16),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.darkBorder.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.info, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'contract.state.audit_info'.tr(),
                    style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _StateDef {
  final String label;
  final IconData icon;
  final Color color;
  const _StateDef(this.label, this.icon, this.color);
}

class _ContractTile extends StatelessWidget {
  final String contractId;
  final String tenantName;
  final String type;
  final String state;
  final String value;
  final String date;

  const _ContractTile({
    required this.contractId,
    required this.tenantName,
    required this.type,
    required this.state,
    required this.value,
    required this.date,
  });

  Color _stateColor() {
    switch (state) {
      case 'Active':
        return AppColors.success;
      case 'Pending':
        return AppColors.warning;
      case 'Created':
        return AppColors.info;
      case 'Suspended':
        return AppColors.error;
      case 'Settled':
        return AppColors.success;
      case 'Archived':
        return AppColors.textSecondaryDark;
      default:
        return AppColors.primary;
    }
  }

  IconData _stateIcon() {
    switch (state) {
      case 'Active':
        return Icons.play_circle;
      case 'Pending':
        return Icons.hourglass_empty;
      case 'Created':
        return Icons.add_circle_outline;
      case 'Suspended':
        return Icons.pause_circle;
      case 'Settled':
        return Icons.check_circle;
      case 'Archived':
        return Icons.archive;
      default:
        return Icons.circle;
    }
  }

  String _translatedState() {
    switch (state) {
      case 'Created':
        return 'contract.state.created'.tr();
      case 'Pending':
        return 'contract.state.pending'.tr();
      case 'Active':
        return 'contract.state.active'.tr();
      case 'Suspended':
        return 'contract.state.suspended'.tr();
      case 'Modified':
        return 'contract.state.modified'.tr();
      case 'Settled':
        return 'contract.state.settled'.tr();
      case 'Archived':
        return 'contract.state.archived'.tr();
      default:
        return state;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: state == 'Active'
              ? AppColors.success.withValues(alpha: 0.15)
              : state == 'Suspended'
                  ? AppColors.error.withValues(alpha: 0.15)
                  : AppColors.darkBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _stateColor().withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_stateIcon(), color: _stateColor(), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tenantName,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '$contractId • $type',
                      style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    date,
                    style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _StateBadge(label: _translatedState(), color: _stateColor()),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  state == 'Active' ? 'contract.state.view_terms'.tr() : state == 'Pending' ? 'contract.state.activate'.tr() : state == 'Suspended' ? 'contract.state.resolve'.tr() : 'contract.state.details'.tr(),
                  style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 50));
  }
}

class _StateBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StateBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
