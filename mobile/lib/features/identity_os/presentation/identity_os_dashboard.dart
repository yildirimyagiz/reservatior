import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/right_to_rent_check.dart';
import 'package:reservatior/shared/providers/contact_provider.dart';
import 'package:reservatior/shared/providers/right_to_rent_check_provider.dart';
import 'package:reservatior/shared/providers/tenant_application_provider.dart';

class IdentityOsDashboardPage extends ConsumerWidget {
  const IdentityOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncContacts = ref.watch(contactListProvider);
    final asyncChecks = ref.watch(rightToRentCheckListProvider);
    final asyncApplications = ref.watch(tenantApplicationListProvider);
    final checks = asyncChecks.value ?? <RightToRentCheck>[];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Identity OS',
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
                  'Identity verification, right-to-rent and applications.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                _KpiGrid(
                  items: [
                    (
                      'Identities',
                      '${asyncContacts.value?.length ?? 0}',
                      Icons.badge_outlined,
                      AppColors.primary,
                    ),
                    (
                      'R2R checks',
                      '${checks.length}',
                      Icons.verified_user_outlined,
                      AppColors.info,
                    ),
                    (
                      'Valid',
                      '${checks.where((c) => c.status.toUpperCase().contains('PASS') || c.status.toUpperCase().contains('VERIFIED')).length}',
                      Icons.check_circle_outline,
                      AppColors.success,
                    ),
                    (
                      'Applications',
                      '${asyncApplications.value?.length ?? 0}',
                      Icons.fact_check_outlined,
                      AppColors.warning,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Right-to-rent checks',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                const SizedBox(height: 12),
                asyncChecks.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load checks',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (checks) {
                    if (checks.isEmpty) {
                      return Text('No checks yet',
                          style: GoogleFonts.outfit(color: Colors.white38));
                    }
                    final sorted = [...checks]
                      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                    return Column(
                      children: sorted
                          .take(5)
                          .map((c) => _CheckTile(check: c))
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

class _CheckTile extends StatelessWidget {
  final RightToRentCheck check;
  const _CheckTile({required this.check});

  @override
  Widget build(BuildContext context) {
    final valid = check.status.toUpperCase().contains('PASS') ||
        check.status.toUpperCase().contains('VERIFIED');
    final color = valid ? AppColors.success : AppColors.warning;
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
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              valid ? Icons.verified : Icons.fact_check_outlined,
              color: color,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  check.contact.fullName,
                  style: GoogleFonts.outfit(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${check.checkType.replaceAll('_', ' ')} · ${check.reference}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Text(
              check.status,
              style: GoogleFonts.outfit(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
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
