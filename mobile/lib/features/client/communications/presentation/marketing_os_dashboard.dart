import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/marketing_campaign.dart';
import 'package:reservatior/shared/providers/marketing_campaign_provider.dart';
import 'package:reservatior/shared/providers/communication_template_provider.dart';

class MarketingOsDashboardPage extends ConsumerWidget {
  const MarketingOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCampaigns = ref.watch(marketingCampaignListProvider);
    final asyncTemplates = ref.watch(communicationTemplateListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Marketing OS',
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
                  'Campaigns, reach and channel performance.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                _KpiGrid(
                  items: [
                    (
                      'Campaigns',
                      '${asyncCampaigns.value?.length ?? 0}',
                      Icons.campaign_outlined,
                      AppColors.primary,
                    ),
                    (
                      'Templates',
                      '${asyncTemplates.value?.length ?? 0}',
                      Icons.library_books,
                      AppColors.info,
                    ),
                    (
                      'Sent',
                      '${_sum(asyncCampaigns.value, (c) => c.sentCount)}',
                      Icons.send_outlined,
                      AppColors.success,
                    ),
                    (
                      'Opens',
                      '${_sum(asyncCampaigns.value, (c) => c.openCount)}',
                      Icons.visibility_outlined,
                      AppColors.warning,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _ModuleCard(
                  title: 'Templates',
                  subtitle: 'Reusable message library',
                  icon: Icons.library_books,
                  color: AppColors.info,
                  route: '/communications',
                ),
                const SizedBox(height: 12),
                _ModuleCard(
                  title: 'Communication Log',
                  subtitle: 'Sent message history',
                  icon: Icons.forum_outlined,
                  color: AppColors.primary,
                  route: '/communication-templates',
                ),
                const SizedBox(height: 24),
                Text('Recent campaigns',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                const SizedBox(height: 12),
                asyncCampaigns.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load campaigns',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (campaigns) {
                    if (campaigns.isEmpty) {
                      return Text('No campaigns yet',
                          style: GoogleFonts.outfit(color: Colors.white38));
                    }
                    final sorted = [...campaigns]
                      ..sort((a, b) => (b.sentAt ?? b.createdAt)
                          .compareTo(a.sentAt ?? a.createdAt));
                    return Column(
                      children: sorted
                          .take(5)
                          .map((c) => _CampaignTile(campaign: c))
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

  int _sum(List<MarketingCampaign>? campaigns, int Function(MarketingCampaign) f) {
    if (campaigns == null) return 0;
    return campaigns.fold(0, (s, c) => s + f(c));
  }
}

class _CampaignTile extends StatelessWidget {
  final MarketingCampaign campaign;
  const _CampaignTile({required this.campaign});

  Color get _color => switch (campaign.status.name) {
        'COMPLETED' => AppColors.success,
        'RUNNING' => AppColors.primary,
        'DRAFT' => Colors.white54,
        'CANCELLED' => AppColors.error,
        _ => AppColors.warning,
      };

  @override
  Widget build(BuildContext context) {
    final openRate = campaign.sentCount > 0
        ? (campaign.openCount / campaign.sentCount * 100).toStringAsFixed(0)
        : '0';
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
                child: Text(
                  campaign.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _color.withValues(alpha: 0.4)),
                ),
                child: Text(
                  campaign.status.name,
                  style: GoogleFonts.outfit(
                    color: _color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _metric('Sent', '${campaign.sentCount}'),
              _metric('Opens', '${campaign.openCount}'),
              _metric('Clicks', '${campaign.clickCount}'),
              _metric('Open rate', '$openRate%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metric(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            )),
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
