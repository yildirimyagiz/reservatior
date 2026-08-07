import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/contact.dart';
import 'package:reservatior/shared/providers/contact_provider.dart';
import 'package:reservatior/shared/providers/deal_provider.dart';
import 'package:reservatior/shared/providers/lead_provider.dart';

class CrmOsDashboardPage extends ConsumerWidget {
  const CrmOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncContacts = ref.watch(contactListProvider);
    final asyncDeals = ref.watch(dealListProvider);
    final asyncLeads = ref.watch(leadListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'CRM OS',
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
                  'Contacts, leads and deal pipeline at a glance.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                _KpiGrid(
                  items: [
                    (
                      'Contacts',
                      '${asyncContacts.value?.length ?? 0}',
                      Icons.contacts,
                      AppColors.info,
                    ),
                    (
                      'Leads',
                      '${asyncLeads.value?.length ?? 0}',
                      Icons.filter_alt_outlined,
                      AppColors.warning,
                    ),
                    (
                      'Active deals',
                      '${asyncDeals.value?.where((d) => d.salePrice != null || d.closingDate != null).length ?? 0}',
                      Icons.handshake_outlined,
                      AppColors.primary,
                    ),
                    (
                      'Pipeline value',
                      NumberFormat.compactCurrency(symbol: '').format(
                          asyncDeals.value
                                  ?.fold(0.0, (s, d) => s + (d.offerPrice ?? 0)) ??
                              0),
                      Icons.account_balance_wallet,
                      AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _ModuleCard(
                  title: 'Leads',
                  subtitle: 'Live list with status filters',
                  icon: Icons.filter_alt_outlined,
                  color: AppColors.warning,
                  route: '/leads',
                ),
                const SizedBox(height: 12),
                _ModuleCard(
                  title: 'Deals',
                  subtitle: 'Pipeline by deal stage',
                  icon: Icons.handshake_outlined,
                  color: AppColors.primary,
                  route: '/deals',
                ),
                const SizedBox(height: 24),
                Text('Recent contacts',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                const SizedBox(height: 12),
                asyncContacts.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load contacts',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (contacts) {
                    if (contacts.isEmpty) {
                      return Text('No contacts yet',
                          style: GoogleFonts.outfit(color: Colors.white38));
                    }
                    final sorted = [...contacts]
                      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
                    return Column(
                      children: sorted
                          .take(5)
                          .map((c) => _ContactTile(contact: c))
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

class _ContactTile extends StatelessWidget {
  final Contact contact;
  const _ContactTile({required this.contact});

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
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            child: Text(
              contact.fullName.isNotEmpty
                  ? contact.fullName.substring(0, 1).toUpperCase()
                  : '?',
              style: GoogleFonts.outfit(
                  color: AppColors.primary, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contact.fullName,
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14)),
                if (contact.email != null)
                  Text(contact.email!,
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Text(DateFormat.yMMMd().format(contact.createdAt),
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
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
