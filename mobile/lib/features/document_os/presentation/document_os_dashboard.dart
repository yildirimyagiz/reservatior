import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/signature_status.dart';
import 'package:reservatior/shared/models/document.dart';
import 'package:reservatior/shared/models/signature_request.dart';
import 'package:reservatior/shared/providers/document_provider.dart';
import 'package:reservatior/shared/providers/signature_request_provider.dart';

class DocumentOsDashboardPage extends ConsumerWidget {
  const DocumentOsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDocs = ref.watch(documentListProvider);
    final asyncSignatures = ref.watch(signatureRequestListProvider);
    final docs = asyncDocs.value ?? <Document>[];
    final pendingSign = asyncSignatures.value
            ?.where((s) => s.status == SignatureStatus.PENDING)
            .length ??
        0;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Document OS',
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
                  'Documents, contracts and e-signature workflow.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                _KpiGrid(
                  items: [
                    (
                      'Documents',
                      '${docs.length}',
                      Icons.folder_open,
                      AppColors.primary,
                    ),
                    (
                      'Signed',
                      '${docs.where((d) => d.isSigned).length}',
                      Icons.verified,
                      AppColors.success,
                    ),
                    (
                      'Pending sign',
                      '$pendingSign',
                      Icons.pending_actions,
                      AppColors.warning,
                    ),
                    (
                      'Requests',
                      '${asyncSignatures.value?.length ?? 0}',
                      Icons.draw_outlined,
                      AppColors.info,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _ModuleCard(
                  title: 'Documents',
                  subtitle: 'Contracts & filings',
                  icon: Icons.folder_open,
                  color: AppColors.primary,
                  route: '/documents',
                ),
                const SizedBox(height: 12),
                _ModuleCard(
                  title: 'Contract Generator',
                  subtitle: '23 countries · localized',
                  icon: Icons.description_outlined,
                  color: AppColors.success,
                  route: '/contract-generator',
                ),
                const SizedBox(height: 12),
                _ModuleCard(
                  title: 'Signatures',
                  subtitle: 'e-signature requests',
                  icon: Icons.draw_outlined,
                  color: AppColors.info,
                  route: '/signatures',
                ),
                const SizedBox(height: 24),
                Text('Pending signatures',
                    style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                const SizedBox(height: 12),
                asyncSignatures.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load signatures',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (requests) {
                    final pending = requests
                        .where((s) => s.status == SignatureStatus.PENDING)
                        .toList();
                    if (pending.isEmpty) {
                      return Text('Nothing pending',
                          style: GoogleFonts.outfit(color: Colors.white38));
                    }
                    return Column(
                      children: pending
                          .take(5)
                          .map((s) => _SignatureTile(request: s))
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

class _SignatureTile extends StatelessWidget {
  final SignatureRequest request;
  const _SignatureTile({required this.request});

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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                Icon(Icons.pending_actions, color: AppColors.warning, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.contract.title ?? request.contractId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${request.signers.length} signer'
                  '${request.signers.length == 1 ? '' : 's'}'
                  '${request.expiresAt != null ? ' · expires ${DateFormat.yMMMd().format(request.expiresAt!)}' : ''}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
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
