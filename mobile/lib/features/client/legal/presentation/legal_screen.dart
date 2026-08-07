import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/signature_status.dart';
import 'package:reservatior/shared/models/document.dart';
import 'package:reservatior/shared/models/signature_request.dart';
import 'package:reservatior/shared/providers/document_provider.dart';
import 'package:reservatior/shared/providers/signature_request_provider.dart';

class LegalScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const LegalScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends ConsumerState<LegalScreen> {
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
              'Legal & Documents',
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
                    label: Text('Documents'),
                    icon: Icon(Icons.folder_open),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Signatures'),
                    icon: Icon(Icons.draw),
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
          if (_tab == 0) const _DocumentsPanel() else const _SignaturesPanel(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _DocumentsPanel extends ConsumerWidget {
  const _DocumentsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDocs = ref.watch(documentListProvider);

    return asyncDocs.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load documents'),
      ),
      data: (docs) {
        if (docs.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.folder_open,
              title: 'No documents yet',
              subtitle: 'Contracts and filings will appear here',
            ),
          );
        }
        final pending = docs.where((d) => d.signatureRequired && !d.isSigned).length;
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.pending_actions,
                        color: AppColors.warning, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$pending document${pending == 1 ? '' : 's'} pending signature',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < docs.length; i++)
                _DocumentTile(document: docs[i]).animate().fadeIn(delay: (40 * i).ms),
            ]),
          ),
        );
      },
    );
  }
}

class _DocumentTile extends StatelessWidget {
  final Document document;
  const _DocumentTile({required this.document});

  @override
  Widget build(BuildContext context) {
    final needsSign = document.signatureRequired && !document.isSigned;
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
              color: (document.isSigned ? AppColors.success : AppColors.primary)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              document.isSigned ? Icons.verified : Icons.description_outlined,
              color: document.isSigned ? AppColors.success : AppColors.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.title,
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
                  '${document.documentType.name.replaceAll('_', ' ')} · v${document.version}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          if (needsSign)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
              ),
              child: Text(
                'NEEDS SIGN',
                style: GoogleFonts.outfit(
                  color: AppColors.warning,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          else
            Icon(Icons.check_circle,
                size: 18,
                color: document.isSigned
                    ? AppColors.success
                    : Colors.white24),
        ],
      ),
    );
  }
}

class _SignaturesPanel extends ConsumerWidget {
  const _SignaturesPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncSignatures = ref.watch(signatureRequestListProvider);

    return asyncSignatures.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load signatures'),
      ),
      data: (requests) {
        if (requests.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.draw,
              title: 'No signature requests',
              subtitle: 'Requests will appear here',
            ),
          );
        }
        final pending = requests
            .where((r) => r.status == SignatureStatus.PENDING)
            .length;
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.pending_actions,
                        color: AppColors.warning, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$pending pending request${pending == 1 ? '' : 's'}',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < requests.length; i++)
                _SignatureTile(request: requests[i])
                    .animate()
                    .fadeIn(delay: (40 * i).ms),
            ]),
          ),
        );
      },
    );
  }
}

class _SignatureTile extends StatelessWidget {
  final SignatureRequest request;
  const _SignatureTile({required this.request});

  Color get _color => switch (request.status) {
        SignatureStatus.SIGNED => AppColors.success,
        SignatureStatus.DECLINED => AppColors.error,
        SignatureStatus.EXPIRED => AppColors.warning,
        _ => AppColors.primary,
      };

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
              color: _color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              request.status == SignatureStatus.SIGNED
                  ? Icons.verified
                  : Icons.draw_outlined,
              color: _color,
              size: 18,
            ),
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
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  request.signers.isEmpty
                      ? '${request.signUrl == null ? 'e-signature' : 'via ${request.provider}'}'
                      : '${request.signers.length} signer${request.signers.length == 1 ? '' : 's'}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
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
              request.status.name,
              style: GoogleFonts.outfit(
                color: _color,
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
